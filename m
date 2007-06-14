From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stupid quoting...
Date: Thu, 14 Jun 2007 01:49:27 -0700
Message-ID: <7vlkemapk8.fsf@assigned-by-dhcp.pobox.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0706131316390.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyl1H-0006B6-1x
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 10:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbXFNIt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 04:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbXFNIt3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 04:49:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48867 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbXFNIt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 04:49:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070614084927.UTJX4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Jun 2007 04:49:27 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BLpT1X0031kojtg0000000; Thu, 14 Jun 2007 04:49:27 -0400
In-Reply-To: <Pine.LNX.4.64.0706131316390.4059@racer.site> (Johannes
	Schindelin's message of "Wed, 13 Jun 2007 13:21:12 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50180>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 13 Jun 2007, David Kastrup wrote:
>
>> what is the point in quoting file names and their characters in
>> git-diff's output?  And what is the recommended way of undoing the
>> damage?
>
> The recommended way is not using spaces to begin with. I mean, does 
> "David" contain spaces? People seem not to see the problem, and fail to 
> blame Microsoft for all the damage they have done, introducing that 
> stupid, stupid concept of filenames containing spaces, and _enforcing_ it.

Why are you talking about spaces ;-)?

There are a few things to note, but the first thing is that mere
spaces do not trigger quoting.  A tab (HT) does, so do non ASCII
characters.  The second thing is that we do this quoting for
various good reasons, and it is not likely to change.

As Alex mentions, the most safe way for programs to read is to
read from the -z format.  However, even if you are capable to do
so, it may be inconvenient in some languages (mainstream
languages like C and Perl are not among them).  Not quoting SP
is a conscious decision, as SP in filenames are rather common,
more common than non ASCII and much more common than HT.

The "raw" formats "ls-files -s", "ls-tree" and "diff --raw"
produce are designed to put names at the end, and typically
delimited with a HT, so that "lazy" scripts can use cut (whose
default delimiter is a HT) to pick out pieces from its output.
And plumbing tools reading from the standard input (most
notably, "update-index --stdin") know how to unquote them.  In
practice, not many people use non ASCII in pathnames and expect
them work sanely for everybody, so loosely written scripts, as
long as they cut at HT to pick out the pathname part, "mostly"
work (I think traditional core git scripts are safe, I suspect
some contributed ones shipped with git core may not be, Cogito
used to be very unsafe but it was audited and became much safer
before it got discontinued).

The pathname quoting rules in textual output was chosen
primarily to make diff output safer, as one of the most
important workflow git supports is e-mailable patches.

GNU patch treats HT on "+++ name"/"--- name" lines as the end of
name (and after HT comes timestamp), but the timestamp part is
treated as optional, which introduces ambiguities and confusion.
The issue was discussed some time ago (check the list archive
for discussion among I, Linus and Paul Eggert -- the GNU diff
and patch maintainer) and the quoting rules we use now is
consistent with what the diff and patch plan to use.  The update
on the GNU side may have already happened, it may not have.

When a patch appears in an e-mail, you would need to be aware
that not everybody has the luxury of living in UTF-8 only world.
Your commit message and cover letter may be in one encoding, the
pathnames that appear in diff headers may be in your filesystem
encoding, and the patch text that appear as the diff payload may
be in another document specific encoding.  All three could be
different (worse, a patch that touch more than one file can
carry different encodings in the payload part), and mixing
character set in a single piece of e-mail confuses people's MUA
and tends to mangle messages.  Quoting non ASCII characters in
pathnames, even they are perfectly valid and ordinary UTF-8
strings, is to eliminate one element in the above three as a
possible source of worries.
