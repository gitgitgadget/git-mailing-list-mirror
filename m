From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 09:14:55 -0400
Message-ID: <20111020131454.GB7464@thunk.org>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
 <20111020071356.GA14945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 15:15:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGsSl-0003bC-TM
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 15:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab1JTNPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 09:15:03 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:53129 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab1JTNPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 09:15:00 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RGsSW-0004qw-FW; Thu, 20 Oct 2011 13:14:56 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RGsSV-00038n-1L; Thu, 20 Oct 2011 09:14:55 -0400
Content-Disposition: inline
In-Reply-To: <20111020071356.GA14945@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184020>

On Thu, Oct 20, 2011 at 03:13:56AM -0400, Jeff King wrote:
> It's not that the commit is bad or the source of problems. My point is
> that the assumption that commit messages are NUL-terminated has been
> there for a really long time, so there are lots of spots in the code
> that sloppily run string functions on them. Every one of those needs to
> be found and fixed (e.g., I remember seeing this in
> for-each-ref.c:find_subpos recently).

Another possibility is to warn if the commit messages are not NULL
terminated.  Note though that if we're really worried about a bad guy
trying to attack us with a hash collision, he/she could always use
"invisible" non-printing characters in the commit message, and/or just
mess with one or both of the timestamps.  The more bits and more
degrees of flexibility the attacker has, the easier it would be, of
course.  In the grand scheme of things it's not clear to me how big of
a deal this would be.

If people were really concerned it would probably be easier to use
backup crypto checksum using something stronger (say, SHA-2 or the
eventual SHA-3).  Just store the backup checksums of the parent
commitments in some backwardly compatible place that old git
implementations wouldn't look (say, after the NULL in the commit
message if there isn't a better place :-), and new implementations
would know to generate the checksums, and old implementations would
ignore it.

That way, if anyone *does* figure out a way to generate real hash
collisions with SHA1 of objects that look almost completely identical
to the original objects, new implementations that would gradually make
their way out to the field could verify the SHA-2 (or SHA-3, when it
is announced, assuming that we the tag the checksums with a type
identifier) checksums and notice that they are not correct.

Maybe someone's already thought of this, but the cool thing about this
idea is it's a way that we can upgrade to a stronger hash algorithm
without needing a flag day due to some kind of incompatible format
change; we keep using SHA1 for the user-visible hash, since it's fine
modulo intentional attacks, and then use a hidden, backup checksum
which can be checked either all the time, or if that turns out to be a
computational burden, at some configurable random percent of the time.

Anyway, just a thought....

	      	      	     		   	  - Ted
