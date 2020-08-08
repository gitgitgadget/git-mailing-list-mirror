Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA4C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0883820748
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="uvXbYqcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHHObo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHObo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 10:31:44 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D4DC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 07:31:43 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596897101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=TkZyTYAbOMUoEdaxsfqVddrWPsR+ZR8TZ2d2L89FiJs=;
        b=uvXbYqcdeVF5avC9206rdw83Sdc8NObnMNS0uQhALTRk3eG9yr4yH84qcZ0BymuRecvloM
        henfqL/Y0DB6QNnxCdjvRdrhTlACYmeJr9RG9ta+ShTyMN5Irs8Y/KiygyQmNz6Rbrn/wv
        agHWadX3MTnRlJjkBw6M7EkRdKRKJDI=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     <phillip.wood@dunelm.org.uk>, "Junio C Hamano" <gitster@pobox.com>
Date:   Sat, 08 Aug 2020 10:07:33 -0400
Message-Id: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
In-Reply-To: <db1c56f6-bcd2-bbd9-aa63-70d54215cd44@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat Aug 8, 2020 at 9:46 AM EDT, Phillip Wood wrote:
> > By definition, an intent-to-add index entry can never match the
> > worktree, because worktrees have no concept of intent-to-add entries.
> > Therefore, "apply --index" should always fail on intent-to-add paths.
>
> I'm not sure I understand the logic for this. If I run 'git add -N
> <path>' and <path> does not exist in the worktree what's the reason to
> stop a patch that creates <path> from applying?

"apply --index" requires the index and worktree to match, and applies
the same path to both to get the same result in both. I brainstormed the
logic a few emails upthread, and that's what's consistent with
everything else.

> I was relieved to see from the next patch that this does not affect
> --cached even though the documentation says it implies --index. It might
> be worth mentioning that in the commit message. Also it would be easier
> to follow if the tests were in the same patch (this is what we usually
> do).

--cached doesn't really imply --index - the docs are wrong and should be
changed. If anything, --index is closer to implying --cached - but
really, [no flags], --cached, and --index are three different modes with
different behavior. (Just removing "this implies --index" would be
sufficient to make the docs correct.)

> How this does it affect --check? `git add -p` uses --check to verify
> that hunks that the user has edited still apply. It does not let the
> user edit the hunk for a newly added file at the moment but that is
> something I'm thinking of adding.

--check goes through all the same code, it just doesn't actually touch
anything in the index or worktree. Splittable/editable new file patches
are a logical related feature, IMO. (This is just to squash an error
that shouldn't happen.)
