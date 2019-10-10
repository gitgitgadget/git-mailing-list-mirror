Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FD71F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 03:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfJJDet (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 23:34:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55332 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfJJDet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 23:34:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5FF21875E;
        Wed,  9 Oct 2019 23:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9a4Yni0EDaG+qVLPPOlhqGE4eM=; b=pUTkU9
        mEmRLBS1DJEQ2xN+JQxbCRbik6EwjkMmfzxP54mTvl2wQp59Vz9cCMCj35w5WWX4
        yx3S/6pAH1e7W93xs9XuYzm+FezIvpjyyMo6vG/vy5hOT2O4fIe8IAmsU7NCEc/b
        kUBLpBr9zcvRwcfXIaxJZX6vjPbIFhMG3HwEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DBLxCR2p1e6VfISELRmGouxFZ79vHIIG
        uAvIvgcnWOC1HPmgt17ocOpTw/wYkUcnGSN3pp0yLwPAb+POMrsfCzKEnKaSNwgw
        pX26UOpyIAznrmlyi51qmFEv9gwBAWoAXCagzI+RlVj9DPVC1zPxvTbV201R0sb0
        Dc510UzHCAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC43F1875D;
        Wed,  9 Oct 2019 23:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DACF1875C;
        Wed,  9 Oct 2019 23:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git@vger.kernel.org, kernel-usp@googlegroups.com,
        rcdailey.lists@gmail.com, me@ttaylorr.com, peff@peff.net,
        matheus.bernardino@usp.br,
        =?utf-8?Q?B=C3=A1rbara?= Fernandes <barbara.dcf@gmail.com>
Subject: Re: [RFC WIP PATCH 3/3] tag: add full support for --edit and --no-edit
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
        <20191008184727.14337-4-lucasseikioshiro@gmail.com>
Date:   Thu, 10 Oct 2019 12:34:44 +0900
In-Reply-To: <20191008184727.14337-4-lucasseikioshiro@gmail.com> (Lucas
        Oshiro's message of "Tue, 8 Oct 2019 15:47:27 -0300")
Message-ID: <xmqqk19djmsr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7BC301E-EB0E-11E9-B0D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Oshiro <lucasseikioshiro@gmail.com> writes:

>  struct create_tag_options {
>  	unsigned int message_given:1;
>  	unsigned int use_editor:1;
> +	unsigned int force_editor:1;
>  	unsigned int sign;

> -	if (!opt->message_given || opt->use_editor) {
> +	if (opt->force_editor && !opt->message_given && is_null_oid(prev) &&
> +	    !opt->use_editor) {
> +		die(_("no tag message?"));

If we didn't get a message from command line, and there is no
previous tag object to read the message from, there is nowhere but
editor to grab the message to be used, so !use_editor would trigger
an error if force_editor (i.e. the command line explicitly said
either --edit or --no-edit).  Makes sense, but I needed to cheat and
look at cmd_tag() to see how "force" is set to understand what is
going on.  I have to say "force" is not a good name for this field;
is this use similar to what we typically use an additional _given
field?

> +	} else if ((!opt->force_editor && !opt->message_given && is_null_oid(prev))
> +		  || (opt->force_editor && opt->use_editor)) {
> +		/* Editor must be opened */

If there is no --[no-]edit and there is no preexisting message, we
need to use the editor.  If the command line explicitly said --edit,
we also would use the editor.  OK.

But it starts to make me wonder if you rather want to replace the
single bit use_editor field with an enum with three possible values
(enum { EDITOR_UNSPECIFIED, EDITOR_YES, EDITOR_NO } use_editor).

>  		prepare_tag_template(buf, opt, prev, path, tag);
>  		if (launch_editor(path, buf, NULL)) {
>  			fprintf(stderr,
>  			_("Please supply the message using either -m or -F option.\n"));
>  			exit(1);
>  		}
> +	} else if (!opt->message_given) {
> +		/* Tag already exists and user doesn't want to change it */

Are we certain at this point in if/else cascade that prev is a valid
tag?  How?

> +		strbuf_addstr(buf, get_tag_body(prev, NULL));

This NULL tells us something about what I mentioned in my review on 1/3.


> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 80eb13d94e..bf43d2c750 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1313,7 +1313,7 @@ test_expect_success GPG,RFC1991 \
>  	'reediting a signed tag body omits signature' '
>  	echo "rfc1991" >gpghome/gpg.conf &&
>  	echo "RFC1991 signed tag" >expect &&
> -	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
> +	GIT_EDITOR=./fakeeditor git tag -f --edit -s rfc1991-signed-tag $commit &&
>  	test_cmp expect actual
>  '
>  
> @@ -1356,7 +1356,7 @@ test_expect_success GPG,RFC1991 \
>  test_expect_success GPG,RFC1991 \
>  	'reediting a signed tag body omits signature' '
>  	echo "RFC1991 signed tag" >expect &&
> -	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
> +	GIT_EDITOR=./fakeeditor git tag -f --edit -s rfc1991-signed-tag $commit &&
>  	test_cmp expect actual
>  '

Why do these two need explicit --edit option to invoke the editor?
That smells like an unnecessary backward incompatible change.

Thanks.
