From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/17] reset: Make hard reset remove the sequencer state
Date: Tue, 12 Jul 2011 15:15:32 -0500
Message-ID: <20110712201532.GE14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-15-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 22:15:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgjMz-00036w-Pt
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1GLUPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 16:15:44 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57956 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1GLUPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 16:15:42 -0400
Received: by yia27 with SMTP id 27so2107316yia.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OEhx1iK4EOEaPsLMyJvlncnF48UnSOSupPaMcyROs0I=;
        b=TjJfgEvm0kQYSuyjp7Bl59iPHWjqYCHr3lxHEeN1x4zThudjJWCRB7CvXFmotEhgjn
         YpZ45cIoXdBdOrBWe5xDP+mYFjdAP9W6j0G7V1ntDj06hvPOLxDfAFoKEBmXvCikb0rG
         E+MGPXogDswSKXlAcqa3T77DUkZOorG986c6w=
Received: by 10.236.136.226 with SMTP id w62mr579079yhi.93.1310501740984;
        Tue, 12 Jul 2011 13:15:40 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id p50sm5852576yhj.0.2011.07.12.13.15.38
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 13:15:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-15-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176977>

Hi,

Ramkumar Ramachandra wrote:

> Years of muscle memory have trained users to use "git reset --hard" to
> remove away the branch state after any sort of operation.  In
> retrospect, while this may not have been the best design decision, we
> are stuck with it for historical reasons.

Wait, wait!  If that was a bad design decision, we should try to find
a way to smoothly transition to a world without it, instead of
layering workarounds on top of it.

But actually I think it is good UI.  When you do "git merge", it works
like this:

	git merge <foo>; # conflicts!
	... hack hack hack ...
	# Oh, bother, let me go back to a state I know well and am
	# comfortable with.
	git reset --hard <bar>

And the same psychological effect applies in the cherry-pick case:

	git cherry-pick <foo>; # conflicts!
	... hack hack hack ...
	# Oh, bother, let me go back to a state I know well and am
	# comfortable with.
	git reset --hard <bar>

See, it's about the tool working with you.  When I abandon a merge,
I don't want to have to search through the owner's manual for the
button to get git to clear away this unpleasant and unfamiliar state.

Now, by contrast, sometimes one wants something less aggressive.
For example, to abandon a partial merge conflict resolution but
keep unrelated changes in the worktree:

	git reset --merge HEAD

Or to get out of the "mergy" state but leave the worktree alone:

	git reset

There's no porcelain or plumbing to abandon a rebase without
additional side-effects, but "git status" suggests a command for
it if I remember correctly.

	rm -fr .git/rebase-merge

[...]
> Additionally, this patch ensures that some existing tests don't break
> when features like "--reset" and "--continue" are introduced later in
> the series.

That's not "Additionally" --- it's the same problem.  One way to
phrase it would be "Noticed by running such-and-such test after
such-and-such change".

> +test_expect_success 'reset --hard cleans up sequencer state' '

Hoorah!  Thanks.

Why isn't the .git/sequencer removal in remove_branch_state() like
MERGE_MSG and other similar examples are?  (Not a rhetorical question;
it would be interesting to know.)
