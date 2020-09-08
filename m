Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA0C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5F42098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ibb9QQRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgIHTfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:35:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58428 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732323AbgIHTfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:35:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CF4DEE095;
        Tue,  8 Sep 2020 15:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/K55blwKNlUIu56Y4wjvsc4lolE=; b=Ibb9QQ
        RVYlnNyOs8GVzhgi8YLEvTfTDW4dpSIyHt05j1qK21sVcknDwTZBFELTU9CaZulE
        zMVmOK1g7XbiuskswVAn+mK7C1I7+QqUTGZ+oe8+0Jjwy8fTdB2wWMdqUAtaTvD9
        mol60atamRHmFkyBmWsjeNIUqV0sVUd0HbPSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F35FU8UcEUyj9xFN3MkzJ/e0+O1JF8v8
        w8ZoibupOcYAmcBjSalb5YbQOxE9ejq/dwryMp3PZCBebBvFxR13sDzVyDZuobde
        FiEQsDeWklWF+WTlp/SA1/zDO7ofNEGNj7FIlHvBMHY7ZVKu62Pfbd5AdaD+YLOg
        4eKY22j7clI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 450D5EE094;
        Tue,  8 Sep 2020 15:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7EE8AEE08F;
        Tue,  8 Sep 2020 15:34:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Sep 2020 12:34:57 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 7 Sep 2020 21:45:18 +0200 (CEST)")
Message-ID: <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61F607BC-F20A-11EA-831D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, to be honest, I thought that this mode would merit a new option
> rather than piggy-backing on top of `--force-with-lease`. The reason is
> that `--force-with-lease` targets a slightly different use case than mine:
> it makes sure that we do not overwrite remote refs unless we already had a
> chance to inspect them.
>
> In contrast, my workflow uses `git pull --rebase` in two or more separate
> worktrees, e.g. when developing a patch on two different Operating
> Systems, I frequently forget to pull (to my public repository) on one
> side, and I want to avoid force-pushing in that case, even if VS Code (or
> I, via `git remote update`) fetched the ref (but failing to rebase the
> local branch on top of it).
> ...
> So I think that the original `--force-with-lease` and the mode you
> implemented target subtly different use cases that are both valid, and
> therefore I would like to request a separate option for the latter.

I agree that the use case in the second paragraph above does not fit
what the "force with lease" option is meant to solve.  You do not
even want to be forcing in the workflow so "--force-with-anything"
is a bad name for the mode of operation, if I am reading you right.
