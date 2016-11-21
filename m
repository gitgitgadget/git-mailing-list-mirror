Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A4B1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbcKUU2y (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:28:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63681 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753003AbcKUU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:28:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6827E524F1;
        Mon, 21 Nov 2016 15:28:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cmpj6BApJFk3yfHJ0YouaUvf0iY=; b=ea/Viv
        +EkQZmzpaDGwmQTtFeXSt8Omxn/w7o2+Mf6Uc+H2caPu+8RLAc0tLKx1+CO6/Emu
        yziCgBJUU+TMt3oWTsVq5mdxraZRN+raeDZ/+28QWUdNQ/hI75QBjhWv3AAjVk4U
        c/hEFEQB/gvyvvwlt5J10/O6HkN+F2vqjDLX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z//83hTdFDbM+4GRm3kz84obyAnVnkCM
        tQywN3221Q/Ub2Kd7+KzYmr9jcFwwuG5fXUYK39Sk6FiiyW4xIj3FgjLDPqD139W
        WiUpEs1dOCjSNY0/cTyWECoFQu8Hb2qVqjWoH7T8h7zliRULeffHPwYA7d2/eGsI
        egiTP4eTp2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E9C8524F0;
        Mon, 21 Nov 2016 15:28:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2B5E524EF;
        Mon, 21 Nov 2016 15:28:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
        <20161121190514.18574-1-gitster@pobox.com>
        <20161121190514.18574-2-gitster@pobox.com>
Date:   Mon, 21 Nov 2016 12:28:50 -0800
In-Reply-To: <20161121190514.18574-2-gitster@pobox.com> (Junio C. Hamano's
        message of "Mon, 21 Nov 2016 11:05:13 -0800")
Message-ID: <xmqqlgwcinlp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DA3A938-B029-11E6-A9A9-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The way "git stripspace" reads the configuration was not quite
> correct, in that it forgot to probe for a possibly existing
> repository (note: stripspace is designed to be usable outside the
> repository as well) before doing so.  Due to this, .git/config was
> read only when the command was run from the top-level of the working
> tree.  
>
> A recent change b9605bc4f2 ("config: only read .git/config from
> configured repos", 2016-09-12) stopped reading the repository-local
> configuration file ".git/config" unless the repository discovery
> process is done, and ".git/config" is no longer read even when run
> from the top-level, which exposed the bug even more.

The above two paragraphs are rewritten from the original to explain
how this seemed to work (by accident) and its breakage surfaced in
"rebase -i" after b9605bc4f2 ("config: only read .git/config from
configured repos", 2016-09-12) better.  The use of stripspace in
"rebase-i" was done after cd_to_toplevel and it happened to work
before that commit.

Otherwise there is no change from the original.

> When rebasing interactively with a commentChar defined in the
> current repository's config, the help text at the bottom of the edit
> script potentially used an incorrect comment character. This was not
> only funny-looking, but also resulted in tons of warnings like this
> one:
>
> 	Warning: the command isn't recognized in the following line
> 	 - #
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/stripspace.c  | 4 +++-
>  t/t0030-stripspace.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 15e716ef43..1e62a008cb 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -44,8 +44,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  	if (argc)
>  		usage_with_options(stripspace_usage, options);
>  
> -	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
> +	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> +		setup_git_directory_gently(NULL);
>  		git_config(git_default_config, NULL);
> +	}
>  
>  	if (strbuf_read(&buf, 0, 1024) < 0)
>  		die_errno("could not read the input");
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index c1f6411eb2..bbf3e39e3d 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -432,7 +432,7 @@ test_expect_success '-c with changed comment char' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure '-c with comment char defined in .git/config' '
> +test_expect_success '-c with comment char defined in .git/config' '
>  	test_config core.commentchar = &&
>  	printf "= foo\n" >expect &&
>  	printf "foo" | (
