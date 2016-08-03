Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D261F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170AbcHCUab (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:30:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758172AbcHCUa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:30:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9807630BCC;
	Wed,  3 Aug 2016 16:29:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MaaSPYTSaWGTPGSSJ7wmC5Xaz8g=; b=xYDrjY
	F35DSk8jQg6vMES5qRJ1WlXwEPx6Bc/nqe0XWxmfuKxDqlnzXNfYZzjZoevKNTvW
	e9asz56tXD94UilP0KijCUN0VMC03LIbf47xO+DvKHINBoyk6OlojV3M9SnhA4L8
	vwHxP3gfBOtXLmWbVf6/4i5LkiVQyqxs+Orr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cljW87NYTvLKvcLdiYzgReUlBhEQ9dgF
	P2VMtQ3KQqVICiO7SosGzh4iCbxPJKzx+HFFk1rQcXPs8UY58lk7cvU5w+PfIiMg
	RKyO+vl92eYK3U+JduT1tc1EbDonoU9yLbP7Smt0uOE56ZmWnl99mLKkGNKszNkm
	FYLM8lKpwkY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90D1C30BCB;
	Wed,  3 Aug 2016 16:29:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A31F30BCA;
	Wed,  3 Aug 2016 16:29:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-12-larsxschneider@gmail.com>
Date:	Wed, 03 Aug 2016 13:29:18 -0700
In-Reply-To: <20160803164225.46355-12-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 3 Aug 2016 18:42:24
	+0200")
Message-ID: <xmqq8twd8uld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F511DA10-59B8-11E6-942D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> +#define FILTER_CAPABILITIES_CLEAN    (1u<<0)
> +#define FILTER_CAPABILITIES_SMUDGE   (1u<<1)
> +#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
> +#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)

I would expect a lot shorter names as these are file-local;
CAP_CLEAN and CAP_SMUDGE, perhaps, _WITHOUT_ "supports BLAH" macros?

	if (FILTER_SUPPORTS_CLEAN(type))

is not all that more readable than

	if (CAP_CLEAN & type)



> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	int supported_capabilities;
> +	const char *cmd;
> +	struct child_process process;
> +};
> +
> +static int cmd_process_map_initialized = 0;
> +static struct hashmap cmd_process_map;

Don't initialize statics to 0 or NULL.

> +static int cmd2process_cmp(const struct cmd2process *e1,
> +                           const struct cmd2process *e2,
> +                           const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}
> +
> +static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
> +{
> +	struct cmd2process key;
> +	hashmap_entry_init(&key, strhash(cmd));
> +	key.cmd = cmd;
> +	return hashmap_get(hashmap, &key, NULL);
> +}
> +
> +static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
> +{
> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);

I wonder if we want to diagnose failures from close(), which is a
lot more interesting than usual because these are connected to
pipes.

> +static int apply_multi_file_filter(const char *path, const char *src, size_t len,
> +                                   int fd, struct strbuf *dst, const char *cmd,
> +                                   const int wanted_capability)
> +{
> +	int ret = 1;
> + ...
> +	if (!(wanted_capability & entry->supported_capabilities))
> +		return 1;  // it is OK if the wanted capability is not supported

No // comment please.

> +	filter_result = packet_read_line(process->out, NULL);
> +	ret = !strcmp(filter_result, "result=success");
> +
> +done:
> +	if (ret) {
> +		strbuf_swap(dst, &nbuf);
> +	} else {
> +		if (!filter_result || strcmp(filter_result, "result=reject")) {
> +			// Something went wrong with the protocol filter. Force shutdown!
> +			error("external filter '%s' failed", cmd);
> +			kill_multi_file_filter(&cmd_process_map, entry);
> +		}
> +	}
> +	strbuf_release(&nbuf);
> +	return ret;
> +}

I think this was already pointed out in the previous review by Peff,
but a variable "ret" that says "0 is bad" somehow makes it hard to
follow the code.  Perhaps rename it to "int error", flip the meaning,
and if the caller wants this function to return non-zero on success
flip the polarity in the return statement itself, i.e. "return !errors",
may make it easier to follow?
