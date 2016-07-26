Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108C2203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcGZTsp (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:48:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbcGZTso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:48:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E423D2FB91;
	Tue, 26 Jul 2016 15:48:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CJlYvU1WqLhU10xKxSeAKnHJfXU=; b=YB7bfP
	xGHi1QhCYEyHqHacsVUOq9E59kpJRpcSEFIIEheyacTDCp8Jbcpqd60cj4MDmBMT
	xWGtbjBfbubtoaookD7ludtHLitMjVvjW1sHl0/gfEhW5kmU0X/OAsxyre1BreG2
	fqlQj9kB3t8IYwkWJPoXSOB7fBbbOF0aTKMmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G8paNIWVMNr2jCkRFwCj88suSIkxx8Fj
	IBxQm1Lacsoayhn7e944dzpYybvCSfmFx+tgli0vWB5pCDXp/QIJuuqzP4i9WMmK
	w6F7HQaMakZXphbCRD7xw/q493I8AWhVAUEn/g+y+6p7hShAlyFQ+SSQuTJMRrZF
	rTwwLY6h+V4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBA152FB8E;
	Tue, 26 Jul 2016 15:48:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 687AB2FB8D;
	Tue, 26 Jul 2016 15:48:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 40/41] builtin/am: use apply api in run_apply()
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-41-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 12:48:40 -0700
In-Reply-To: <20160627182429.31550-41-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:28 +0200")
Message-ID: <xmqq1t2g18pz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4CBD5F6-5369-11E6-A256-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>  static int run_apply(const struct am_state *state, const char *index_file)
>  {
> -	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct argv_array apply_paths = ARGV_ARRAY_INIT;
> +	struct argv_array apply_opts = ARGV_ARRAY_INIT;
> +	struct apply_state apply_state;
> +	int res, opts_left;
> +	char *save_index_file;
> +	static struct lock_file lock_file;
> +
> +	struct option am_apply_options[] = {
> +		{ OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
> +			N_("detect new or modified lines that have whitespace errors"),
> +			0, apply_option_parse_whitespace },
> +		{ OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
> +			N_("ignore changes in whitespace when finding context"),
> +			PARSE_OPT_NOARG, apply_option_parse_space_change },
> +		{ OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
> +			N_("ignore changes in whitespace when finding context"),
> +			PARSE_OPT_NOARG, apply_option_parse_space_change },
> +		{ OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
> +			N_("prepend <root> to all filenames"),
> +			0, apply_option_parse_directory },
> +		{ OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
> +			N_("don't apply changes matching the given path"),
> +			0, apply_option_parse_exclude },
> +		{ OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
> +			N_("apply changes matching the given path"),
> +			0, apply_option_parse_include },
> +		OPT_INTEGER('C', NULL, &apply_state.p_context,
> +				N_("ensure at least <n> lines of context match")),
> +		{ OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
> +			N_("remove <num> leading slashes from traditional diff paths"),
> +			0, apply_option_parse_p },
> +		OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
> +			N_("leave the rejected hunks in corresponding *.rej files")),
> +		OPT_END()
> +	};

Is this an indication that this step came too prematurely?

Can we avoid having to maintain semi-duplicated options array if
cmd_apply() is properly refactored before this step?  The resulting
code is unmaintainable as long as we have this duplication.


