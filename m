Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E91203E3
	for <e@80x24.org>; Sat, 23 Jul 2016 08:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcGWIOv (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 04:14:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46660 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbcGWIOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 04:14:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC5F203E1;
	Sat, 23 Jul 2016 08:14:47 +0000 (UTC)
Date:	Sat, 23 Jul 2016 08:14:47 +0000
From:	Eric Wong <e@80x24.org>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, peff@peff.net, jnareb@gmail.com, tboegi@web.de
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
Message-ID: <20160723081447.GA24318@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722154900.19477-4-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com wrote:
> Please note that the protocol filters do not support stream processing
> with this implemenatation because the filter needs to know the length of
> the result in advance. A protocol version 2 could address this in a
> future patch.

Would it be prudent to reuse pkt-line for this?

> +static void stop_protocol_filter(struct cmd2process *entry) {
> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);
> +	child_process_clear(&entry->process);
> +	hashmap_remove(&cmd_process_map, entry, NULL);
> +	free(entry);
> +}
> +
> +static struct cmd2process *start_protocol_filter(const char *cmd)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry = NULL;
> +	struct child_process *process = NULL;

These are unconditionally set below, so initializing to NULL
may hide future bugs.

> +	struct strbuf nbuf = STRBUF_INIT;
> +	struct string_list split = STRING_LIST_INIT_NODUP;
> +	const char *argv[] = { NULL, NULL };
> +	const char *header = "git-filter-protocol\nversion";

	static const char header[] = "git-filter-protocol\nversion";

...might be smaller by avoiding the extra pointer
(but compilers ought to be able to optimize it)

> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	process = &entry->process;

<snip>

> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;

starts_with() is probably more readable, here.

> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> +						int fd, struct strbuf *dst, const char *cmd,
> +						const char *filter_type)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry = NULL;
> +	struct child_process *process = NULL;

I would leave process initialized, here, since it should
always be set below:

> +	struct stat fileStat;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	size_t nbuf_len;
> +	char *strtol_end;
> +	char c;
> +
> +	if (!cmd || !*cmd)
> +		return 0;
> +
> +	if (!dst)
> +		return 1;
> +
> +	if (!cmd_process_map_init) {
> +		cmd_process_map_init = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +	} else {
> +		entry = find_protocol_filter_entry(cmd);
> +	}
> +
> +	if (!entry){
> +		entry = start_protocol_filter(cmd);
> +		if (!entry) {
> +			stop_protocol_filter(entry);

stop_protocol_filter is a no-op, here, since entry is NULL

> +			return 0;
> +		}
> +	}
> +	process = &entry->process;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	switch (entry->protocol) {
> +		case 1:
> +			if (fd >= 0 && !src) {
> +				ret &= fstat(fd, &fileStat) != -1;
> +				len = fileStat.st_size;

There's a truncation bug when sizeof(size_t) < sizeof(off_t)
(and mixedCase is inconsistent with our style)

> +    my $filelen  = <STDIN>;
> +    chomp $filelen;
> +    print $debug " $filelen";
> +
> +    $filelen = int($filelen);

Calling int() here is unnecessary and may hide bugs if you
forget to check $debug.   Perhaps a regexp check is safer:

	$filelen =~ /\A\d+\z/ or die "bad filelen: $filelen\n";
