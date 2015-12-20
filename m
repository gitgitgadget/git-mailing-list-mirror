From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Sat, 19 Dec 2015 20:28:35 -0500
Message-ID: <20151220012835.GA3013@thunk.org>
References: <20151216032639.GA1901@LykOS>
 <20151218231032.GA16904@thunk.org>
 <20151219173018.GA1178@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sun Dec 20 02:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aASoL-0001nD-40
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 02:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbLTB2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 20:28:40 -0500
Received: from imap.thunk.org ([74.207.234.97]:53211 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbbLTB2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 20:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KiR8U1FNO4WcH2UYEK0Zgi4w06DOGF2KJULbe2zMaU4=;
	b=aofAL5eJb92gS3KMIKyX/v1YczU4vDBNQof4cl5H+hkUXFtUpAhtWrZGi5vTlQipit5fJyrLB5gjcYcVSh8UseJvJm81m/RNTrUw8aFLrcYzgGaJZAU5B51HTcpOp3NfLRMD9bnNgShGUbdzdUx99L4vZhUAufo17KRSwODMcrE=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1aASnc-0003VN-SP; Sun, 20 Dec 2015 01:28:36 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 6E63D82D73D; Sat, 19 Dec 2015 20:28:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20151219173018.GA1178@LykOS>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282754>

On Sat, Dec 19, 2015 at 12:30:18PM -0500, Santiago Torres wrote:
> > Now, the crazy behavior where github users randomly and promiscuously
> > do pushes and pull without doing any kind of verification may very
> > well be dangerous. 
> 
> Yes, we were mostly familiar with this workflow before starting this
> research. I can see how the "github generation" is open to many attacks
> of this nature. Would git be interested in integrating a defense that
> covers users of this nature (which seems to be a growing userbase)?

One of the interesting challenges is that git is a pretty low-level
tool, and so people have built all sorts of different workflows on top
of it.

For example, at $WORK, we use gerrit, which is a code review tool, so
all git commits that are to be merged into the "upstream" repository
0gets pushed to a gerrit server, where it goes through a code review
process where a second engineer can review the code, request changes,
make comments, or ask questions, and where the git commits can go
through multiple rounds of review / revision before they are finally
accepted (at least one reviewer must give a +2 review, and there must
be no -2 reviews; and there can be automated tools that do build or
regression tests that can give automated -1 or -2 reviews) --- and
where all of the information collected during the code review process
is saved as part of the audit trail for a Sarbanes-Oxley (SOX)
compliance regime.

Other people use github-style workflows, and others use signed tags
with e-mail code reviews, etc.  And I'm sure there must be many others.

So the challenge is that in order to accomodate many possible
workflows, some of which use third-party tools, changes to make git
more secure for one workflow must not get in the way of these other
workflows --- which means that enforcement of new controls for the
"github generation" probably will have to be optional.  But then
people belonging to the "github generation" can also easily turn off
these features.  And as the NSA learned the hard way in Vietnam, if
the tools cause any inconenience, or has the perception of
constraining legitmate users, security features can have a way of
getting turned off.[1]

[1] A History of US Communications Security, The David G. Boak
lectures, Volume II, "Nestor in Vietname".  pg 43-44.  (A declassified
version can be found at:
http://www.governmentattic.org/18docs/Hist_US_COMSEC_Boak_NSA_1973u.pdf)

> > But so is someone who saves a 80 patch series from
> > their inbox, and without reading or verifying all of the patches
> > applies them blindly to their tree using "git am" --- or if they were
> > using cvs or svn, bulk applied the patches without doing any
> > verification....
> 
> Just out of curiosity, are there known cases of projects in which this
> has happened (I've noticed that both Git and Linux are quite stringent
> in their review/merge process so this wouldn't be the case).

I can't point at specific instances, but given that in the "github
generation", people are fine with blindly pulling someone else's
Docker images and running it on their production servers or
workstations, and where software installation gets done with "wget
http://example.org | bash" or the equivalent, that it's probably more
often than we might be comfortable.

I also suspect that a bad guy would probably find inserting a
man-in-the-middle server into one of these installation flows is
probably a much more practical attack in terms of real world
considerations.  :-)

Cheers,

						- Ted
