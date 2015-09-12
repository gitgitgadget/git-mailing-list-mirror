From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri, 11 Sep 2015 22:33:34 -0400
Message-ID: <CANoM8SUhxLAUUAuH1PNRX-Fg09nNWzk2fX1TrggD5XDThaYc4w@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-3-git-send-email-rappazzo@gmail.com> <xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
 <CANoM8SUGmb=fSFqF4DTuW2F5oPVaim-=SP76rqwwqtzcsNQf=g@mail.gmail.com>
 <xmqqbnd8zks9.fsf@gitster.mtv.corp.google.com> <CAPig+cQ4BUbS0ZQ=NoDO9JZmWYRzX0vhoi-W9ahg3yaWM+pKQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 04:50:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaatA-0005na-F4
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 04:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbbILCmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 22:42:14 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35993 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbILCmN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 22:42:13 -0400
Received: by vkfp126 with SMTP id p126so34714565vkf.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ivnP/EgfnR+NdJWre4aRouo8UQ+2YHd8uD+bcfQjK8A=;
        b=PfhhMQg3IoULejh5mlWQ6VePRmt2hmn79YTglXYt2tZC6ZwaOXKrRLBFTzd1K88fw2
         l5JAozRMZmm4D1PeSZebl6IVnabcPyQIezSRiiq9qqyd4NGCOyhRqYZiqZAgytL+qUFm
         OuWXnXyk/3Ydx1pjTn+u52Upc1dPml3n5aJKu5HLdpL4wywFFnL78xU5+7jyE66Y0vE7
         S+2jczuphHXPkQkwE/XVH5R0Cc0TSTBuXqvdi5xpfcAsqGmIvGVwo+GqFv8fGWajJGRq
         xZzQb+EzKlpjGNxLBCxK1ZcrS2mDfeNS66eBOLad5w0Hze1Vru742s0ymvyYYawb5Neb
         Nj1g==
X-Received: by 10.31.56.79 with SMTP id f76mr1341364vka.16.1442025233792; Fri,
 11 Sep 2015 19:33:53 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Fri, 11 Sep 2015 19:33:34 -0700 (PDT)
In-Reply-To: <CAPig+cQ4BUbS0ZQ=NoDO9JZmWYRzX0vhoi-W9ahg3yaWM+pKQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277712>

On Fri, Sep 11, 2015 at 7:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Sep 11, 2015 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks for bringing this up. I haven't found a sufficient block of
> time yet to review these patches, however, I had the same thought upon
> a quick initial read, and is how I was hoping to see the patch series
> constructed based upon my earlier two reviews suggesting refactoring
> the existing branch.c functions into a new get_worktrees(). There are
> at least a couple important reasons for taking this approach.
>
> First, it keeps the "blame" trail intact, the full context of which
> can be helpful to someone trying to understand why the code is the way
> it is. The current approach of having get_worktree_list() materialize
> out of thin air (even though it may have been patterned after existing
> code) doesn't give the same benefit.
>
> Second, it's easier for reviewers to understand and check the code for
> correctness if it mutates to the final form in small increments than
> it is to have get_worktrees() come into existence fully matured.
>
> A final minor comment: Since all three branch.c functions,
> die_if_checked_out(), find_shared_symref(), and find_linked_symref(),
> ought to be moved to top-level worktree.c, I'd probably have patch 1
> do the relocation (with no functional changes), and subsequent patches
> refactor the moved code into a general purpose get_worktrees(). The
> final patch would then implement "git worktrees list".

I like the way this history works out, and I have reworked the history
to follow this idea.  The only thing
I didn't do was move the die_if_checked_out() function from branch.c,
as I feel that this function is more
of a branch feature than a worktree feature.
