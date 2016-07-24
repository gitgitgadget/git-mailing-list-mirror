Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2540203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 22:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcGXWgm (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 18:36:42 -0400
Received: from avasout08.plus.net ([212.159.14.20]:34812 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbcGXWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 18:36:26 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout08 with smtp
	id NmcN1t00123PrXV01mcPhN; Sun, 24 Jul 2016 23:36:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y6S6iVWN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8 a=iTZFxO3riMR52Sxq__4A:9
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH:	ramsayjones@:2500
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
 <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
Date:	Sun, 24 Jul 2016 23:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 24/07/16 18:16, Lars Schneider wrote:
> 
> On 23 Jul 2016, at 01:19, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
>> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> Git's clean/smudge mechanism invokes an external filter process for every
>>> single blob that is affected by a filter. If Git filters a lot of blobs
>>> then the startup time of the external filter processes can become a
>>> significant part of the overall Git execution time.
>>>
>>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>>> keeps the external filter process running and processes all blobs with
>>> the following protocol over stdin/stdout.
>>>
>>> 1. Git starts the filter on first usage and expects a welcome message
>>> with protocol version number:
>>> 	Git <-- Filter: "git-filter-protocol\n"
>>> 	Git <-- Filter: "version 1"
>>
>> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
>> interaction is fully defined, I guess it doesn't matter).
>>
>> [If you wanted to check for a version, you could add a "version" command
>> instead, just like "clean" and "smudge".]
> 
> It was a conscious decision to have the `filter` talk first. My reasoning was:
> 
> (1) I want a reliable way to distinguish the existing filter protocol ("single-shot 
> invocation") from the new one ("long running"). I don't think there would be a
> situation where the existing protocol would talk first. Therefore the users would
> not accidentally mix them with a possibly half working, undetermined, outcome.

If an 'single-shot' filter were incorrectly configured, instead of a new one, then
the interaction could last a little while - since it would result in deadlock! ;-)

[If Git talks first instead, configuring a 'single-shot' filter _may_ still result
in a deadlock - depending on pipe size, etc.]

> 
> (2) In the future we could extend the pipe protocol (see $gmane/297994, it's very
> interesting). A filter could check Git's version and then pick the most appropriate
> filter protocol on startup.
> 
> 
>> [...]
>>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>>> +{
>>> +	int ret = 1;
>>> +	struct cmd2process *entry = NULL;
>>> +	struct child_process *process = NULL;
>>> +	struct strbuf nbuf = STRBUF_INIT;
>>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>>> +	const char *argv[] = { NULL, NULL };
>>> +	const char *header = "git-filter-protocol\nversion";
>>> +
>>> +	entry = xmalloc(sizeof(*entry));
>>> +	hashmap_entry_init(entry, strhash(cmd));
>>> +	entry->cmd = cmd;
>>> +	process = &entry->process;
>>> +
>>> +	child_process_init(process);
>>> +	argv[0] = cmd;
>>> +	process->argv = argv;
>>> +	process->use_shell = 1;
>>> +	process->in = -1;
>>> +	process->out = -1;
>>> +
>>> +	if (start_command(process)) {
>>> +		error("cannot fork to run external persistent filter '%s'", cmd);
>>> +		return NULL;
>>> +	}
>>> +	strbuf_reset(&nbuf);
>>> +
>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
>>
>> Hmm, how much will be read into nbuf by this single call?
>> Since strbuf_read_once() makes a single call to xread(), with
>> a len argument that will probably be 8192, you can not really
>> tell how much it will read, in general. (xread() does not
>> guarantee how many bytes it will read.)
>>
>> In particular, it could be less than strlen(header).
> 
> As mentioned to Torsten in $gmane/300156, I will add a newline
> and then read until I find the second newline. That should solve
> the problem, right?
> 
> (You wrote in $gmane/300119 that I should ignore your email but
> I think you have a valid point here ;-)

Heh, as I said, it was late and I was trying to do several things
at once. (I am updating 3 installations of Linux Mint 17.3 to Linux
Mint 18 - I decided to do a complete re-install, since I needed to
change partition sizes anyway. I have only just got email back up ...)

I stopped commenting on the patch early but, after sending the first
email, I decided to scan the rest of your patch before going to bed
and noticed something which would invalidate my comments ...

> 
> 
>>> [...]
>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>> +	switch (entry->protocol) {
>>> +		case 1:
>>> +			if (fd >= 0 && !src) {
>>> +				ret &= fstat(fd, &fileStat) != -1;
>>> +				len = fileStat.st_size;
>>> +			}
>>> +			strbuf_reset(&nbuf);
>>> +			strbuf_addf(&nbuf, "%s\n%s\n%zu\n", filter_type, path, len);
>>> +			ret &= write_str_in_full(process->in, nbuf.buf) > 1;
>>
>> why not write_in_full(process->in, nbuf.buf, nbuf.len) ?
> OK, this would save a "strlen" call. Do you think such a function could be of general
> use? If yes, then I would add:
> 
> static inline ssize_t write_strbuf_in_full(int fd, struct strbuf *str)
> {
> 	return write_in_full(fd, str->buf, str->len);
> }

[I don't have strong feelings either way (but I suspect it's not worth it).]

> 
> 
>>> +			if (len > 0) {
>>> +				if (src)
>>> +					ret &= write_in_full(process->in, src, len) == len;
>>> +				else if (fd >= 0)
>>> +					ret &= copy_fd(fd, process->in) == 0;
>>> +				else
>>> +					ret &= 0;
>>> +			}
>>> +
>>> +			strbuf_reset(&nbuf);
>>> +			while (xread(process->out, &c, 1) == 1 && c != '\n')
>>> +				strbuf_addchars(&nbuf, c, 1);
>>> +			nbuf_len = (size_t)strtol(nbuf.buf, &strtol_end, 10);
>>> +			ret &= (strtol_end != nbuf.buf && errno != ERANGE);
>>> +			strbuf_reset(&nbuf);
>>> +			if (nbuf_len > 0)
>>> +				ret &= strbuf_read_once(&nbuf, process->out, nbuf_len) == nbuf_len;
>>
>> Again, how many bytes will be read?
>> Note, that in the default configuration, a _maximum_ of
>> MAX_IO_SIZE (8MB or SSIZE_MAX, whichever is smaller) bytes
>> will be read.

... In particular, your 2GB test case should not have worked, so
I assumed that I had missed a loop somewhere ...

> Would something like this be more appropriate?
> 
> strbuf_reset(&nbuf);
> if (nbuf_len > 0) {
>     strbuf_grow(&nbuf, nbuf_len);
>     ret &= read_in_full(process->out, nbuf.buf, nbuf_len) == nbuf_len;
> }

... and this looks better. [Note: this comment would apply equally to the
version message.]

[Hmm, now can I remember which packages I need to install ...]

ATB,
Ramsay Jones
