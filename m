Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E62C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54EE20675
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/t/xrU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgEKTK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:10:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgEKTK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:10:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CAA4D31D1;
        Mon, 11 May 2020 15:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ompE8tkd2ktCaNOq1vHJs2JDSR0=; b=F/t/xr
        U1dF7M9rgaFTzFU18gwWKvdmpZLYKUqpCl1NEmNh5NEjjuDK1iRfxs81ZLsJVVQN
        chrbGrNzlybKlejrUt8QpFVR9fBKubv5KR8uYSwj1Glg+uVU1etKWshNm8aFQouK
        QnCnRFMRmcRPS+O1oBubo0J6mnFgFB3QetgBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Swu7Y/mYxU7A5Ccm0MCswLFlInVtDogp
        BI/LHM+vHhiEvwUAZ2JqzXTjjLwbzO+vBzusR1W3L6+GMB23v9gWqvi9FW7+o1Op
        th+eYhqtwPjIPlqSOl6X8QF0Qcif7r88VyBBkr8gc/0SfHOJ1V6gsYwA+WF94zwO
        gftaZqAEXlY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05785D31D0;
        Mon, 11 May 2020 15:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29BEAD31C5;
        Mon, 11 May 2020 15:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [RFC PATCH v2 2/4] config: load the correct config.worktree file
References: <cover.1589058209.git.matheus.bernardino@usp.br>
        <882310b69fd3df0acc6823a2c73bbe1801d9f6c4.1589058209.git.matheus.bernardino@usp.br>
Date:   Mon, 11 May 2020 12:10:50 -0700
In-Reply-To: <882310b69fd3df0acc6823a2c73bbe1801d9f6c4.1589058209.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sat, 9 May 2020 21:41:28 -0300")
Message-ID: <xmqqlflyqocl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21B4A5DA-93BB-11EA-A66D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> One of the steps in do_git_config_sequence() is to load the
> worktree-specific config file. Although the function receives a git_dir
> string, it relies on git_pathdup(), which uses the_repository->git_dir,
> to make the path to the file. Thus, when a submodule has a worktree
> setting, a command executed in the superproject that recurses into the
> submodule won't find the said setting.

This has far wider ramifications than just "git grep" and it may be
an important fix.  Anything that wants to read from a per-worktree
configuration is not working as expected when run from a secondary
worktree, right?

Can we add a test or two to protect this fix from future breakages?


>  	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> -	if (!opts->ignore_worktree && repository_format_worktree_config) {
> -		char *path = git_pathdup("config.worktree");
> +	if (!opts->ignore_worktree && repository_format_worktree_config &&
> +	    opts->git_dir) {
> +		char *path = mkpathdup("%s/config.worktree", opts->git_dir);
>  		if (!access_or_die(path, R_OK, 0))
>  			ret += git_config_from_file(fn, path, data);
>  		free(path);
