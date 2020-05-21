Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA107C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F5320823
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgEUSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:12:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53532 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgEUSMW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:12:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id u1so6346315wmn.3
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKXWOrVDI/j4NttSYAEFKnH/+6mcSeYsId+PiRekrZc=;
        b=ttv+Vduay2R+D50oWvRZNr0V8N8yT8RZO3yboYuYw26O09SmNB0QaXZ6o6l2sL8j/0
         fZwKN9SHY5oheiqAmrGn2UeKbKxbWapj2AKUvTo1vqppRX34YJChG4LlIOIHq0XcTLaf
         g1JnWDvoxpiD6b1zlkzKhHctWJ3s0IQTUEYHHDv9lehKIRm6fj77tWyRya/VpkdA7qnx
         sljhVUsgHy5XA+myoNSxQQIAkVVaTKz+GT7ZKV8H+VhO65vjznBkF/Ve0ghWg0cDl/Cz
         M6zf43jqVs35P9fHPHPqKrwCxIA40K3YvuqtVUkwbOKXuuLe2T1ATAZLEusp5YISkiF0
         Tjfg==
X-Gm-Message-State: AOAM531D7+uozC7Q2zO3fSdzUYv/TIypvBEp3HhrjAPOx4xC0XZYKPQE
        w3L4++fGOrExl/L1DGN9QHF3PhFCIwEjzy+odgI=
X-Google-Smtp-Source: ABdhPJzul5B5V6KJMM0POYX+2T3k0sYFgKlTFjJEG2CAdzpMV8mXcsrrrztCWLmpg9Zs8VUtK8BwFHx9BhsMsxlcbdo=
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr9977357wmc.177.1590084740173;
 Thu, 21 May 2020 11:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
In-Reply-To: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 May 2020 14:12:09 -0400
Message-ID: <CAPig+cSQoWuVyrOMynPUueYPaij6wgq8owwk-U9wE=wmVMNyRQ@mail.gmail.com>
Subject: Re: Anyone know what is creating commits with bogus dates?
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 1:49 PM Elijah Newren <newren@gmail.com> wrote:
> I first discovered such a repository in the wild a while ago with
> rails.git.  It has a commit with a recorded timezone of "+051800" for
> both author and committer.  Everything else about the commit looks
> fine.  See https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734.
>
> Some google searches at the time turned up a few other examples, all
> with the same "+051800" issue.  I put a special workaround for it into
> filter-repo because I figured it was slightly prominent but probably
> limited to that special timezone.  The fact that it was six digits but
> the last two were zeros made it seem not quite as bad as it could be.

In git.git itself, there were a couple bugs fixed [1,2] in which the
author header lacked a NUL-terminator after the timezone and in which
an error condition wasn't checked which led to the last digit of the
timezone being duplicated, however, if I recall correctly, those only
cropped up with "git rebase -i --root" (and only the author date-stamp
was affected), which doesn't seem to correspond to the cases you're
fixing.

Perhaps those commits were created by tools other than git.git?

[1]: ca3e1826a0 (sequencer: fix "rebase -i --root" corrupting author
header, 2018-07-31)
[2]: 0f16c09aae (sequencer: fix "rebase -i --root" corrupting author
header timezone, 2018-07-31)
