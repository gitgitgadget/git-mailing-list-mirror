X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git-branch: add options and tests for branch renaming
Date: Tue, 28 Nov 2006 10:39:04 -0500
Message-ID: <20061128153904.GC28337@spearce.org>
References: <11647252603530-git-send-email-hjemli@gmail.com> <456C4FCE.6090306@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 15:39:31 +0000 (UTC)
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456C4FCE.6090306@shadowen.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32539>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp53O-0001aq-PK for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758689AbWK1PjM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758690AbWK1PjM
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:39:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:1411 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758689AbWK1PjL
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:39:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp52y-0008Rj-2r; Tue, 28 Nov 2006 10:39:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3C4F820FB7F; Tue, 28 Nov 2006 10:39:04 -0500 (EST)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
> Ok, I have been feeling uneasy about rename and reflogs for a while now.
>  About removing reflogs too for that matter.
> 
> In my mind the ref log is about tracking what a ref points to.  So I
> want to be able to say "what was next, yesterday".  Do I care if its not
> there now?  Perhaps I want a rename to just put a rename from in the top
> of the new reflog and leave the old there.
> 
> Yep, no idea how we would clean them up with this model.  But ...

You use a global reflog instead of a ref specific log.  There are
of course huge problems with that idea, but it is probably the
simplest way to solve what you want.

Though I'm not sure why you care that much.  To me a ref is just
as transient as the name of the working directory the repository is
housed in.  I could care less what I called that directory last week,
just that it exists and has the content I expect.  On the other
hand, once I'm in that directory I *do* want the history of it.
That's where git comes in.  Likewise for a ref once I am speaking
about a given ref, I want the history of it, and that's where git's
reflog comes in.


Although I just realized this paticular case:

	git branch -D next
	git fetch origin next:next
	...
	git fetch origin next:next
	git branch -M next bob
	...
	... 2 days go by  ...
	...
	git fetch origin next:next
	... arrgh next is no good! ...
	git log next@{2.days.ago}

and there's nothing there, as the log for next just started in
the last fetch.  Yet you had a next that you renamed to bob, and
that next has the log.

Though this can be easily dealt with by reading the RENAME_LOG.
If you scan both this ref's log and the RENAME_LOG and switch to
scanning another ref's log when you find that this ref was renamed
to another ref, then you get what you expect above.  Except if you
deleted the rename destination branch.

I can't say I would use that feature though, despite how handy I
find reflogs to be.

-- 
