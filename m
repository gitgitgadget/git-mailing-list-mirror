Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD8DC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5067020774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHNQXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:23:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNQXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:23:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id g8so7941993wmk.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 09:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7OMj0wb8d/zHLi2pZTnwG6nzyWq6wKKo4wE3tlu50w=;
        b=DCyhzvYiVCJqW5dpzEDgmtHkfX1I6xxcyoZQlkOHTy2JTGcJkH8jUPt0Jrxj3wI4cE
         qUp1SRATqYmTUSxaWbMX67cPuOQp0LiaTOfOHljgGU5/AQe/J7V/Jv/qSOqt/A3jLLig
         3+BTJbJi66eSqcfD/Cxlgs/YivO7jwq95kTjtMI4+YI56EOkf+fuhPf2bjzYfVQYJlOj
         gUhYMBD6ZikU1RteZ7f9+x0tWYLtRnFYyyYc68ZyNnWlMQR68swk4dmGZdUAQ/2/zaF/
         kwQVnEwLvwlxfkM3t8X8EFUH3cUM+UIUpJUmwyuPijBPv2MlJYE7UjV1iS3eIh4V5vUG
         p/MA==
X-Gm-Message-State: AOAM531GKSz6qXcyZNMNtPmlEYnOpY0e7Rb+t9yLFKT+yz04O9RkAe//
        jSWzi7I6YUqBWlrCEF3YDRO5lgE/HgMWvCfXwU/iVuiQhEA=
X-Google-Smtp-Source: ABdhPJx4sdBx2TbPfUdc7iINwyXAgf+6qhUamvSv2pz/Mcx0KiGQixrsqdI7Wdxnp+TCS4b0/non/29JkH1Xql8BDTA=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr3164766wmh.11.1597422219959;
 Fri, 14 Aug 2020 09:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200813155426.GA896769@coredump.intra.peff.net>
 <CAPig+cTOcQymWWtSY3UN73_fpaWUs3u66+EZWBp1SvXeUrgsQQ@mail.gmail.com> <20200814103451.GD3312240@coredump.intra.peff.net>
In-Reply-To: <20200814103451.GD3312240@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Aug 2020 12:23:28 -0400
Message-ID: <CAPig+cTRPMSEG1gZPkjKDv2qUuFALvtr71-fiqWAiJkrkYZQ0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] UNLEAK style fixes
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 6:35 AM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 13, 2020 at 03:32:56PM -0400, Eric Sunshine wrote:
> > That all represents a lot of cognitive overhead versus the common
> > practice of simply freeing resources when you're done with them, which
> > requires no extra cognitive load since it is something we think about
> > _always_ when working with a language like C with no built-in garbage
> > collection.
>
> In the meantime, I have a slight preference to leave UNLEAK() there as a
> potential tool for somebody digging into leak-checkers. But we almost
> certainly shouldn't be asking new authors to use it in reviews, etc.

I don't think it works that way in practice, though. There are enough
UNLEAK()'s sprinkled around that anyone working on or around code with
an existing UNLEAK() is compelled to understand/[re-]study it in order
to avoid breaking existing uses and/or to correctly mirror existing
uses when dealing with new resource allocations.

The same applies to patches. As a reviewer, I have two choices when I
see UNLEAK(): either I ignore it because I don't have the specialized
knowledge in my head (which makes me feel like my review is
ineffective), or I re-acquire the knowledge. And it's not just patches
like the ones in this series which are actively adjusting UNLEAK()
callers, but any patch which adds or removes an UNLEAK() corresponding
to the central meaty changes of the patch, or even a patch in which
UNLEAK() appears only in context lines, or even patches which don't
contains any UNLEAK() calls, but the source file to which the patch
applies does use UNLEAK(), if the reviewer consults the original
source code in addition to the patch.

> TBH, I'm not sure why people starting sprinkling UNLEAK() around in the
> first place. ;)

For the same reason that people are concerned about calling free() or
otherwise releasing or unlocking resources which they have acquired:
they're trying to be responsible. When a programmer sees UNLEAK()
being used in or around the code being changed, he or she will attempt
to maintain the fidelity of the existing code by being careful to
mimic existing nearby resource handling practices.
