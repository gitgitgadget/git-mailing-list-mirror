From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/17] revert: Introduce --reset to remove sequencer state
Date: Tue, 12 Jul 2011 15:30:11 -0500
Message-ID: <20110712203011.GF14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-17-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 22:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgjnE-0007ex-Q5
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 22:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab1GLUmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 16:42:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50402 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1GLUmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 16:42:51 -0400
Received: by iyb12 with SMTP id 12so4990310iyb.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AyFn8JHn/btBdkDbiPE4oulam43s6otwvs6KPln5Ycs=;
        b=oO4gGUFciMxB7DTVYXifQ9v1ZNIMfbRXDFz6VqrUDWmyLq7iEWDq2iLKr8eit/AHfl
         1r147e/OTKNIb8vWrpoe0wbELBJLEUKbV7Z+LD87gk6KNma3QKZEhdAOkh4sTamqm43i
         SjxyDoY0HfiPwB339c/qbxIHLfLOsQd8e8Uv4=
Received: by 10.231.82.197 with SMTP id c5mr261253ibl.131.1310502619506;
        Tue, 12 Jul 2011 13:30:19 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id s2sm8491893ibe.35.2011.07.12.13.30.17
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 13:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-17-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176978>

Ramkumar Ramachandra wrote:

> Protect the sequencer state from accidentally being stomped by a new
> cherry-pick or revert invocation by ensuring that an existing one
> isn't in progress.

I first read this as "an existing sequencer state isn't in progress".
But anyway, if I understand correctly the goal isn't to protect the
sequencer state from corruption but to protect the user from forgetting
about a pending cherry-pick.

> While this patch would normally be expected to
> break many tests, the earlier patches "reset: Make hard reset remove
> the sequencer state" and "revert: Remove sequencer state when no
> commits are pending" make sure that they don't.

Why would I expect a nice change to break tests?

I suppose you mean: "A naive version of this would break the following
established way of working:

	git cherry-pick X; # has conflicts
	git reset --hard; # no, no!
	git cherry-pick Y

Or even:

	git cherry-pick X; # has conflicts
	# ... resolve ...
	git commit
	git cherry-pick Y

But a previous patch takes care of that by making "git reset --hard"
cancel the pending cherry-pick and by making "git commit" clean up
after a pending cherry-pick when making the commit that would finish
it."

The above text quoted with ">" describes the main impact of the
change.  The subject line, on the other hand, describes a less
important part:

> [Subject: revert: Introduce --reset to remove sequencer state]

Is that fixable?  Maybe this could be split into two patches (since it
does two different things), or maybe the subject line could be tweaked
to describe both.

[...]
> Ensure that the "rebase -i" script which invokes cherry-pick or revert
> doesn't change its behavior by using '--reset' to to clear the state
> after every failed pick.

This should be avoidable by noticing that commands like "rebase -i"
use GIT_CHERRY_PICK_HELP to clobber our nice instructions about how to
resume a cherry-pick anyway and therefore are unlikely to need
cherry-pick --continue/--abort facilities, no?

Regards,
Jonathan
