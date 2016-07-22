Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C749203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 23:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcGVX2u (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 19:28:50 -0400
Received: from avasout08.plus.net ([212.159.14.20]:54054 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcGVX2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 19:28:49 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout08 with smtp
	id MzUm1t00923PrXV01zUn9t; Sat, 23 Jul 2016 00:28:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y6S6iVWN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=N659UExz7-8A:10 a=pGLkceISAAAA:8 a=F-V4SmREPvU3jH2wSX0A:9
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH:	ramsayjones@:2500
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
Cc:	peff@peff.net, jnareb@gmail.com, tboegi@web.de
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d32793ea-2b78-a16e-2d77-42e2b9d36ce8@ramsayjones.plus.com>
Date:	Sat, 23 Jul 2016 00:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Hi Lars,

On 23/07/16 00:19, Ramsay Jones wrote:
> 
> 
> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
>>
>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>> keeps the external filter process running and processes all blobs with
>> the following protocol over stdin/stdout.
>>
>> 1. Git starts the filter on first usage and expects a welcome message
>> with protocol version number:
>> 	Git <-- Filter: "git-filter-protocol\n"
>> 	Git <-- Filter: "version 1"
> 
> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
> interaction is fully defined, I guess it doesn't matter).
> 
> [If you wanted to check for a version, you could add a "version" command
> instead, just like "clean" and "smudge".]
> 
> [snip]
> 
>> diff --git a/convert.c b/convert.c
>> index 522e2c5..91ce86f 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -481,12 +481,188 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>>  	return ret;
>>  }
>>  
>> +static int cmd_process_map_init = 0;
>> +static struct hashmap cmd_process_map;
>> +
>> +struct cmd2process {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	const char *cmd;
>> +	long protocol;
>> +	struct child_process process;
>> +};
>> +
>> +static int cmd2process_cmp(const struct cmd2process *e1,
>> +							const struct cmd2process *e2,
>> +							const void *unused)
>> +{
>> +	return strcmp(e1->cmd, e2->cmd);
>> +}
>> +
>> +static struct cmd2process *find_protocol_filter_entry(const char *cmd)
>> +{
>> +	struct cmd2process k;
>> +	hashmap_entry_init(&k, strhash(cmd));
>> +	k.cmd = cmd;
>> +	return hashmap_get(&cmd_process_map, &k, NULL);
>> +}
>> +
>> +static void stop_protocol_filter(struct cmd2process *entry) {
>> +	if (!entry)
>> +		return;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	close(entry->process.in);
>> +	close(entry->process.out);
>> +	sigchain_pop(SIGPIPE);
>> +	finish_command(&entry->process);
>> +	child_process_clear(&entry->process);
>> +	hashmap_remove(&cmd_process_map, entry, NULL);
>> +	free(entry);
>> +}
>> +
>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry = NULL;
>> +	struct child_process *process = NULL;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>> +	const char *argv[] = { NULL, NULL };
>> +	const char *header = "git-filter-protocol\nversion";
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
>> +	argv[0] = cmd;
>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
>> +	process->out = -1;
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external persistent filter '%s'", cmd);
>> +		return NULL;
>> +	}
>> +	strbuf_reset(&nbuf);
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
> 
> Hmm, how much will be read into nbuf by this single call?
> Since strbuf_read_once() makes a single call to xread(), with
> a len argument that will probably be 8192, you can not really
> tell how much it will read, in general. (xread() does not
> guarantee how many bytes it will read.)
> 
> In particular, it could be less than strlen(header).

Please ignore this email, it's late ... ;-)

Sorry for the noise.

[Off to bed now]

ATB,
Ramsay Jones

