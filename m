Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3840C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 07:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBKHxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 02:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKHxg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 02:53:36 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDF305E9
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 23:53:34 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id ABC921F5A0;
        Sat, 11 Feb 2023 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676102014;
        bh=jCjHfMt8j3K7sD6PLVbL/mluoCE6NFZQfCBwfo8egbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7D6FCvpCT67SHeifnqYqSsBIFtehpu/sLX6C0MeedleB+TX8mFQzB+NiYVyXpo8o
         LfREOF/hZ/MNww4ZWT5byFQPCu+mpRWpV3/m0hJAUSze9BxfYzMFLwuV6DZRQQV6Xs
         3ELhdJrdzP5PoNxg3t8LC6r/yLohblXP0odeEYY4=
Date:   Sat, 11 Feb 2023 07:53:33 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] fetch: support hideRefs to speed up connectivity checks
Message-ID: <20230211075333.M933000@dcvr>
References: <20230209122857.M669733@dcvr>
 <xmqq1qmxgmed.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qmxgmed.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> I however notice error handling in the codepath that deals with
> "--exclude-hidden" is  a bit sloppy.
> 
> refs.c::parse_hide_refs_config() is nice enough to diagnose a
> malformed transfer.hiderefs configuration as an error by returning
> -1, and revision.c::hide_refs_config() propagates such an error up,
> but revision.c::exclude_hidden_refs() ignores the error from
> git_config(), and revision.c::handle_revision_pseudo_opt() ignores
> any error from exclude_hidden_refs() anyway.

Not sure I follow.  exclude_hidden_refs() either dies or calls
git_config().  git_config() calls repo_config(), then
configset_iter().  configset_iter() will git_die_config_linenr()
if `fn' (hide_refs_config() in this case) returns < 0.

> We may want to tighten it a bit before (ab)using the option in more
> contexts.
> 
> Thanks.
