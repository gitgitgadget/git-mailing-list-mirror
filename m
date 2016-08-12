Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338B51F859
	for <e@80x24.org>; Fri, 12 Aug 2016 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbcHLVe3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 17:34:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbcHLVe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 17:34:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 467DD335F6;
	Fri, 12 Aug 2016 17:34:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbitQ2icwffTbQAyABcxLByvqZM=; b=L4CbW7
	nQ4nTe+sV3wlEGPwxyCRgCueztSZd77IpDWyC8NdWqNwhAxihkWshrc5nMWCiIYF
	fvbik328GMlfxlwVhsgTZNAoAGgHWuG2jfjW+XCDusE/lhNPfq238sjeLVaJdQhg
	dg4veFMXSlZ2IWU6MBMxX1vD63Dgl+6wRE7o0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nxKI1OPV3TqzOy/XIdJ6sT7MF14y+Eyr
	o7elnNe6pVhqfcTXWGXNhOxtSwflzXxo8W6qgaSnGtHmeBhmnyNxF6YMgNTc0rpT
	sGmHcKSCnTOn5Ad1rRxNpnO+7zD7f5yVFyHLNzmanny85NssrAv4PBJMGPX2BSpr
	C49VAdUUjt8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E817335F3;
	Fri, 12 Aug 2016 17:34:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B93A8335F2;
	Fri, 12 Aug 2016 17:34:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ralf Thielow <ralf.thielow@gmail.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com
Subject: Re: [PATCH] help: make option --help open man pages only for Git commands
References: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
	<20160812201011.20233-1-ralf.thielow@gmail.com>
Date:	Fri, 12 Aug 2016 14:34:24 -0700
In-Reply-To: <20160812201011.20233-1-ralf.thielow@gmail.com> (Ralf Thielow's
	message of "Fri, 12 Aug 2016 22:10:11 +0200")
Message-ID: <xmqqk2flvfhb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B4B92EC-60D4-11E6-8DEA-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> If option --help is passed to a Git command, we try to open
> the man page of that command. However, we do it even for commands
> we don't know.  Make sure the command is known to Git before try
> to open the man page.  If we don't know the command, give the
> usual advice.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

I love it when I say "This shouldn't be too hard; somebody may want
to do a patch", with just a vague implemention idea in my head, and
a patch magically appears with even a better design than I had in
mind when I said it [*1*] ;-)

>  builtin/help.c  | 21 ++++++++++++++-------
>  t/t0012-help.sh | 15 +++++++++++++++
>  2 files changed, 29 insertions(+), 7 deletions(-)
>  create mode 100755 t/t0012-help.sh
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 8848013..55d45de 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -433,10 +433,22 @@ static void list_common_guides_help(void)
>  	putchar('\n');
>  }
>  
> +static void check_git_cmd(const char* cmd) {
> +	char *alias = alias_lookup(cmd);
> +
> +	if (!is_git_command(cmd)) {
> +		if (alias) {
> +			printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
> +			free(alias);
> +			exit(0);
> +		} else
> +			help_unknown_cmd(cmd);
> +	}
> +}

Looks quite reasonable to reuse help_unknown_cmd() there.

Thanks, will queue.


[Footnote]

*1* The vague thing I had in my mind was to use is_git_command() and
    alias_lookup() to prevent the "git foo --help" -> "git help foo" 
    magic from triggering for 'foo' that is not known.  Your solution
    is MUCH cleaner and more straight-forward.

