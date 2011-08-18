From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 14:18:12 -0500
Message-ID: <20110818191812.GG30436@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
 <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:18:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu86l-00018K-P5
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab1HRTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:18:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40648 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab1HRTSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:18:17 -0400
Received: by gya6 with SMTP id 6so1726542gya.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uDarr/17++ZwmQvpWL/t3rqb0kM043/CUY/M1De/DMM=;
        b=hsVzZYQ/aP4Km8aoyNVbmeKVkzeEJOsi6B0o7Zf9QO1HUo5Dg1ZcH3RBWqjC2bUwEj
         5tBrL5tKlV3QnXmVpi2nyQJv/mH2Zksk7PeMmebyLsNIbaha6pW1KcBlAl0TONyG82zW
         269Ew2nHJs1hZIBHkrBbq0FOfoQiRttsg6Slk=
Received: by 10.150.48.27 with SMTP id v27mr1252534ybv.95.1313695096710;
        Thu, 18 Aug 2011 12:18:16 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.ameritech.net [69.209.48.207])
        by mx.google.com with ESMTPS id z29sm152259yhn.16.2011.08.18.12.18.14
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 12:18:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179614>

Hi Ram,

Ramkumar Ramachandra wrote:

> Here are some comments from my end after extensive thought.

Could be briefer. :)

[...]
> 1. Introduce a 'merge --continue' to invoke 'git commit'.  MERGE_HEAD
> helps 'git commit' finish.  Modify tests to use '--continue' instead
> of the earlier commit-to-finish workflow, and advertise this feature
> everywhere.

Why modify tests?  I think "git merge --continue" is a nice idea,
and I don't see how it's inconsistent in any way with continuing to
allow old practice.

> 2. Make 'cherry-pick --continue' invoke 'git commit' as well.
> CHERRY_PICK_HEAD helps 'git commit' finish.  If the commit finishes
> successfully: (if there is one commit left, remove the sequencer
> state; otherwise, drop the first insn on top of the list and execute
> the next insn).

Sounds like a sensible thing to do.  I assume the "one" in the
parenthesis is supposed to be "zero", making the "if" not even part of
the user-visible description of what it does --- it's just the
termination condition of a loop.

"git cherry-pick --continue" in place of "git commit" does not handle
the following scenario.  Suppose my multiple-cherry-pick has run into
conflicts, and while fixing them I notice something related that needs
to be fixed.

	... resolve conflict, leaving extra change in worktree ...
	git stash -k
	... test test test ...
	git commit

	git stash pop
	git commit; # make a separate commit for extra change

	# ok, now continue.
	git sequencer --continue

In other words, in this sequence of commands, "git commit" is used to
single-step.  So if one wants to remove CHERRY_PICK_HEAD altogether, a
nice thing to do would be to introduce a "git sequencer --single-step"
command or something similar to handle such cases.

> Modify tests to use '--continue' instead of the
> earlier commit-to-finish workflow, and advertise this feature
> everywhere.  Unfortunately, if the user executes 'git commit' instead
> of the newer '--continue', we're screwed: a stray sequencer state will
> be left behind.

As Junio hinted, it could make a lot of sense for "git cherry-pick
<single commit>" to not create sequencer state in the first place.
"git cherry-pick --continue" does not need it --- it is enough to
commit with the conflict resolved.  "git cherry-pick --abort" does not
need it, either --- it is enough to "git reset --merge HEAD".

One part I'm handwaving is what to do about commands like "git
cherry-pick foo^..foo" which use a commit range that only happens to
contain one commit.  Either behavior seems fine for such commands.

What do you think?
