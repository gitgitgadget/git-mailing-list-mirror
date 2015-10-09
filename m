From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Fri, 09 Oct 2015 11:55:14 -0700
Message-ID: <xmqqzizroorx.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
	<CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
	<xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
	<xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkcp8-0006MW-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 20:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbbJISzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 14:55:18 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33210 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbbJISzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 14:55:16 -0400
Received: by pacex6 with SMTP id ex6so94124757pac.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tBU+2rPseAoRR6IVXCtf8qWOO5i/XES5seBN0cKme5E=;
        b=CVk3EgbdQ8qMywbaaBwIgWGfWun6GdIPgYD+reOjBB3dh1LDf/JUMuUGAL0uMTh5Cg
         YhV8WH/GOwJnnmtb9TojyTI3U8re0ispZjOrerBBqWdj7Q2RMtqszTQaTb2D8ueUeA7D
         U92z0Tmz1iMCVUGFdKJcHoVPVgUNtVfQhPXedKutC074R6a4XzM/ZENHgp8EnLagA2+2
         8htA2ON3ny3eRvOqkblGvqP7MPuy2V3LcUosLdcy5DxeYOJTsm1p3hMRgtLmtdwN7oXi
         bx5Tok87rJQpX6cmsso/eqYh5meSwVB1/9hUM7zTWBDTpp9VTevPbC+qruHDVP1/szKl
         2D+g==
X-Received: by 10.69.26.161 with SMTP id iz1mr17117989pbd.17.1444416915916;
        Fri, 09 Oct 2015 11:55:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id si10sm3867475pab.15.2015.10.09.11.55.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 11:55:15 -0700 (PDT)
In-Reply-To: <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 Oct 2015 11:40:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279315>

Junio C Hamano <gitster@pobox.com> writes:

> I looked at the codepath involved, and I do not think that is a
> feasible way forward in this case.  It is not about a "helpful
> message" at all.  You would have to do everything that is done in
> the error codepath in your custom die routine, which does not make
> much sense.
>
> I think the most sensible regression fix as the first step at this
> point is to call it as a separate process, just like the code calls
> "apply" as a separate process for each patch.  Optimization can come
> later when it is shown that it matters---we need to regain
> correctness first.

Don't get me wrong by the above, though.

I would prefer the endgame to be an efficient implementation of
merge_recursive_generic(), a function that you can call without you
having to worry about it dying.

But the patch in this thread is not that, if I am reading Johannes's
description correctly.  

And by calling merge_recursive_generic() instead of spawning
merge-recursive via run_command(), your GSoC series introduced a
regression to "am -3".  I'd like to see the regression fixed, and
spawning merge-recursive is an obviously correct way to do so.

That is how "am -3" did it before builtin/am.c after all.

Once that is done, the users will not have to worry about this
regression, and merge_recursive_generic() implementation can be
improved separately.  The patch in this thread may serve as a good
starting point for that.
