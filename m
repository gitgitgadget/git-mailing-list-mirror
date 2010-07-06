From: tytso@mit.edu
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 13:21:09 -0400
Message-ID: <20100706172109.GM25518@thunk.org>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706080322.GA2856@burratino>
 <AANLkTinZ4UV9in60Y4myfUWv08Vx3OMvh-_YQl2BXSjC@mail.gmail.com>
 <20100706142921.GB6666@sigill.intra.peff.net>
 <AANLkTikWGzEq8wiVyu_xJ-tK92N1oRFOrawjOe9UQXkr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 06 19:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWBpg-0003M6-79
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0GFRVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 13:21:14 -0400
Received: from THUNK.ORG ([69.25.196.29]:57091 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab0GFRVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 13:21:13 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OWBpX-0000ur-HR; Tue, 06 Jul 2010 13:21:11 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OWBpV-0006pl-JZ; Tue, 06 Jul 2010 13:21:09 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikWGzEq8wiVyu_xJ-tK92N1oRFOrawjOe9UQXkr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150370>

On Tue, Jul 06, 2010 at 05:02:51PM +0200, Erik Faye-Lund wrote:
> But I can imagine it becoming a big deal when the skew is high. The
> again, perhaps this should constitute a "bad commit" and commit should
> error out if a parent commit was more than some number of minutes
> newer than the current time (or whatever)? That way, skewed commits
> would be caught early if a developer is working with other people, and
> a lot of the traversal could perhaps be faster (or more robust). If
> the developer with the skewed clock doesn't work with anyone, skew
> isn't really a problem, but perhaps he'd have to do some
> branch-filtering to un-skew commits when starting to work with others.
> And only if the skew is really high... like, multiple days... Which
> can't really be THAT common?

Guilt uses the modtime of the patch in a patch series for the
committer time and the author time.  The reasoning behind it doing
this is so that you can do "git pop -a" followed by "git push -a" and
if the patch files haven't changed, the commit id's don't change
either.

But if you change a commit in the middle of the series, you can end up
with clock skews that could be several days or weeks.  Becuase of my
ext4 workflow, the Linux kernel has a maximum skew of 100 days.  Mea
culpa; I stopped doing this as soon as I was told that git was
depending on committer time being roughly increasing, and so I at
least haven't introduced any such time skews since v2.6.34.  And part
of my making up for this has been to submit a patch to guilt to
prevent this from happening again in the future, by fixing up guilt so
that it won't request "git commit" to create timestamps that show very
wild clock skews within a single linear branch.

We could still get potentially screwed though.  Every so often I will
see someone sending e-mail from a client host whose time is years if
not decades in the past or in the future.  If they were to do a "git
commit", and then push that commit to a public repository, we could
easily introduce a large clock skew into a git repo.  Has that ever
happened to date?  Not to my knowledge.  Could it happen?  Very
clearly, yes.  Should we try to put in some safety checks to prevent
it, or at least issue warnings?  Maybe.

						- Ted
