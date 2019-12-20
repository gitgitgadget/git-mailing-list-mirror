Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95288C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08221D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 15:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTP4m convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 20 Dec 2019 10:56:42 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:41001 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTP4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 10:56:42 -0500
Received: by mail-il1-f174.google.com with SMTP id f10so8328351ils.8
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 07:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivHv5dUoOI+p8VeNtZZ29znqLdKGkawwQ8TvAD7lSUc=;
        b=dDawh/6pcH8iWrHPY9BlBjliWDn1DPrcAyNJdus4XZm8HMrT5QkNL3ia07yhyr3s3o
         YfLGcF/VH8ykGMUvS/Vi0oXUOqFI2vrdCLWDryVFxBq32+ddII8mR+wg4RlDopVGHpwL
         OxNEzbteDlLrFTILUAXpm4VoZkVA7X9avqkjxJfEDwQ5ZleLJAOlA8Mis5RBfGmxGqOD
         sVqAptC/X7RkzGxkH/l0XHrbutE4J/S2Y1VyH0SqKvfpFEcG7VnJPytvdmHEJIRY95jy
         EzvgJ4TW28DWe9TOnJUFLcYNGE48O4VBO836QJ7XOPvuqO1D79lUcne4KhXZ7v1FkTlw
         o8Iw==
X-Gm-Message-State: APjAAAX8Kj+BeHLMKFle4OXEZYJIKBESyAJWu6rIPTzN3DsDAj79cY2i
        mQ1ThZBPIQx7PRW4b8JM1wpxRVKRRkp3UguEfuU=
X-Google-Smtp-Source: APXvYqxsyluS9dbiz1aWraHpe7i7UzJymzjnh5Z3+s20Qoktazrh/91K0JjjkhoYe5q38kxIwIgzgus4dAwkWHEZZkw=
X-Received: by 2002:a92:db4f:: with SMTP id w15mr12314969ilq.182.1576857401590;
 Fri, 20 Dec 2019 07:56:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com>
In-Reply-To: <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 20 Dec 2019 10:56:29 -0500
Message-ID: <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
To:     Tom Clarkson <tqclarkson@icloud.com>
Cc:     git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Dec 2019 at 19:57, Tom Clarkson <tqclarkson@icloud.com> wrote:
>
> > Overall I think your proposed algorithm is reasonable (even though I
> > think it won't address some of the cases in our repo). Will your
> > algorithm allow us to pass $dir to git rev-list, for the initial
> > split?
>
> Is this just for performance reasons? As I understand it that was left out because it would exclude relevant commits on an existing subtree, but it could make sense as an optimization for the first split of a large repo.

Yes, it's for performance reasons on a first split that I'd like to
see it. On the FreeBSD repo the difference is some 40 minutes vs. a
few seconds.

> So the process becomes something like
>
>  # clear the cache - shouldn't usually be necessary, but it's a universal debugging step.
> git subtree clear-cache --prefix=dir
>
> # ref and all its parents are before subtree add. Treat any children as inital commits.
> git subtree ignore --prefix=dir ref
>
> # ref and all its parents are known subtree commits to be included without transformation.
> git subtree existing --prefix=dir ref
>
> # Override an arbitrary mapping, either for performance or because that commit is problematic
> git subtree map --prefix=dir mainline-ref subtree-ref
>
> # Run the existing algorithm, but skipping anything defined manually
> git subtree split --prefix=dir

This sounds about perfect.

> > For a concrete example (from the repo at
> > https://github.com/freebsd/freebsd), 7f3a50b3b9f8 is a mainline commit
> > that added a new subtree, from 9ee787636908. I think that if I could
> > inform subtree split that 9ee787636908 is the root it would work for
> > me.
>
> Aside from the metadata, that one is a bit different from a standard subtree add in that it copies three folders from the subtree repo rather than the root - so the contents of contrib/elftoolchain will never exactly match the actual elftoolchain repo, and 9ee787636908 is neither mainline nor subtree as subtree split understands it.

Fair enough, and we have lots of examples of slightly strange history
in svn that svn2git represents in interesting ways.

> If you ignore 9ee787636908, the resulting subtree will be fairly clean, but won’t have much of a relationship to the external repo.
>
> If you treat 9ee787636908 as an existing subtree, the second commit on your subtree will be based on 7f3a50b3b9f8, which deletes most of the contents of the subtree. You should still be able to merge in updates from the external repo, but if you try to push changes upstream the deletion will break things.

I think this is fine - our main goal here is to be able to update
contrib/ code within FreeBSD as we do today with svn, and we may well
always have some changes that are never intended to be pushed
upstream.

Continuing the example from our repo, there is more history in the
"subtree" already, with 061ef1f9424f as the head. ca8624403626 is the
merge to mainline.
