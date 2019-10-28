Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152EA1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 01:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfJ1BvR (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 21:51:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58166 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfJ1BvR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 21:51:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC5A29CD16;
        Sun, 27 Oct 2019 21:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OlDYRF0D09pUSy7YBLil2gFEvpU=; b=D11iDc
        dHnCRjqQsnaKSMnvu+5kNbnTPPqbln3Ehex4e0Ky+Vt9UKnuev2uILs+ELaqDD0n
        D5yVtfC17qztHxxsACQtE3XkeD+AiO5Kt9nmYxGrNj3fCKN3cK6er7irxL2S0tAx
        oZiTRPcBOLa+XfZlnldfAAa3/jr7V3G6t/e/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bdUlqwFfZGA0QubEfPKMtSIWyn9RreBE
        1iE9xR3Pbe4SyQJRkj3yyEMGBHLTeY8gdnStNLWK8Xf1k3CeheFXE6JxXWqReVvY
        W3OVVOLhdDlEXhmwpkMO8C5tIOMi/8EG5RS6czNNiY4bqo042+w73FFjHPGV0vFc
        DssOygInZPo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E47949CD15;
        Sun, 27 Oct 2019 21:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20E059CD14;
        Sun, 27 Oct 2019 21:51:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     dev@kipras.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [FR] Allow `git stash create` to include untracked changes
References: <d02ddc0db596771820b0cfdfae5b1504@kipras.org>
Date:   Mon, 28 Oct 2019 10:51:09 +0900
In-Reply-To: <d02ddc0db596771820b0cfdfae5b1504@kipras.org> (dev@kipras.org's
        message of "Sat, 26 Oct 2019 17:38:34 +0300")
Message-ID: <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B571A64-F925-11E9-BD77-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dev@kipras.org writes:

> Would it be possible for `git stash create` to include untracked
> changes (probably the same way `git stash push --include-untracked`
> does)?

Doesn't the subcommand have -u/--include-untracked option?

... goes and looks git-stash.sh ...

create_stash () {

	prepare_fallback_ident

	stash_msg=
	untracked=
	while test $# != 0
	do
		case "$1" in
		-m|--message)
			...
			;;
		-u|--include-untracked)
			shift
			untracked=${1?"BUG: create_stash () -u requires an argument"}
			;;
		...
	done
	...

It is entirely possible that with recent push to rewrite scripted
Porcelain commands to builtin/, we may have lost a feature or two
by accident.

  ... goes and checks ...

And it does appear that builtin/stash.c::create_stash() lacks
support for command line arguments since d4788af8 ("stash: convert
create to builtin", 2019-02-25).

Would doing

	export GIT_TEST_STASH_USE_BUILTIN=no

or

	git config --global stash.usebuiltin no

help in the meantime???
