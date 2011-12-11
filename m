From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] some sequencer loose ends (Re: Fix revert
 --abort on Windows)
Date: Sun, 11 Dec 2011 13:58:36 -0600
Message-ID: <20111211195836.GA25482@elie.hsd1.il.comcast.net>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Dec 11 20:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZpXs-00008v-4l
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1LKT6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 14:58:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52887 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1LKT6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 14:58:43 -0500
Received: by yenm11 with SMTP id m11so3223593yen.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m+FLyZtE55RltKkLU5ABhAGQpfk6+UveX5E9hDmEbO8=;
        b=CTJBEbHHwdjWmQ7M/FO12VmZe8qRlLYg4o7kKKMrdqru0xwiHrn806gabS64R+r1fL
         3K7S93HxF3mnlAZJHzm1OUjuBpHAfsiq28H2AqvrgEXFopFSd/tHOrz+db3i4MEcTtgr
         EiQ8I2/U1yiyeDPOF/tqIN191hSR3ZTk3N+N0=
Received: by 10.236.128.138 with SMTP id f10mr23282028yhi.2.1323633522365;
        Sun, 11 Dec 2011 11:58:42 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v48sm26654187yhk.6.2011.12.11.11.58.40
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Dec 2011 11:58:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186811>

Jonathan Nieder wrote:

> Here are patches to address some UI warts
[... rambling cover letter snipped ...]

Let's try that again. :)

Current git has a somewhat odd behavior when cherry-picking multiple
commits and running into a conflict in the _last_ commit of the
series.  Imagine the following sequence of operations:

 1. git cherry-pick simplething simplethingtwo complexthing
 2. CONFLICT.
 3. git cherry-pick --abort

It would be most consistent for the entire cherry-pick sequence to be
rolled back, so the user can come up with some other sequence of
commits to try.  After all, that's what happens if a conflict is
encountered applying simplethingtwo and the user asks to abort.

Instead, by the time complexthing is being applied, git has forgotten
about the multi-pick sequence entirely.  And the --abort does not even
warn about this weird state --- it just cancels complexthing and
leaves the earlier commits applied.

This is an edge case, but I think it's worth fixing.  Patch 5/7 does
so.

In the same vein, now imagine a different sequence of operations:

 1. git cherry-pick simplething complexthing morecommits...
 2. CONFLICT.
 3. git reset --merge
 4. git cherry-pick --continue

It would be sensible for this to remove the conflicted patch and go
on with the remaining ones, right?  But instead, "git reset"
automagically removes the sequencer state, so you can't even use
git cherry-pick --abort any more.  Well, you can, if you say the
magic words "mv .git/sequencer-old .git/sequencer", but nobody
actually tells you that.

How did we ever let this in?  "git reset" already has well defined
semantics that have nothing to do with this.  Patches 6/7 and 7/7
would help us forget this UI mistake (and I believe it was a mistake)
ever happened.

Patch 2 makes cherry-pick --continue behave a little more like
rebase --continue, for people who like to learn by analogy.

Patches 1 and 3 are just code style things.

Patch 4 is the basic building block that makes patch 5 possible: it
teaches "git cherry-pick" to treat picks of a single commit named on
the command line differently from the more complex multi-picks
requested with general rev-list arguments.  Single-pick is all that
git cherry-pick originally supported, and in some details it has to
differ from multi-pick (for example, "git commit" after resolving
conflicts after a conflicted single-pick needs to be enough to clear
the state).  As a side-benefit, we get the ability to do a single-pick
in the middle of a multi-pick, which is kind of cool and handy from
time to time.

I am interested in sanity checking of the patches and testing.  It
would be pleasant to find comments like "yeah, that looks good" or
"what are you thinking?!  I ran into the following bug" arriving in my
inbox.

Incidentally, I'd like to apologize about not protesting more about
these things (and even having suggested some of them) as they
happened.  Instead of exercising careful oversight over the sanity of
patches that passed through my mailbox, I had some strange idea of
using the Socratic method to help others learn to explore the design
space and sanity-check findings themselves...

Thanks for reading.

Ciao,
Jonathan
