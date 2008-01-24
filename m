From: Junio C Hamano <gitster@pobox.com>
Subject: On pathnames
Date: Thu, 24 Jan 2008 13:02:54 -0800
Message-ID: <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	<alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	<20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 22:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI9F4-0004qq-39
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617AbYAXVDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756586AbYAXVDM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:03:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbYAXVDK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 16:03:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 134332AF1;
	Thu, 24 Jan 2008 16:03:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B9C292AEE;
	Thu, 24 Jan 2008 16:02:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71661>

One of Linus's recent patch introduces an index hashtable so
that we can later hash "equivalent" names into the same bucket
to allow us non-byte-by-byte comparison.

Before going further, I needed to formalize what we are trying
to achieve.  I learned a few things from the long flamewar
thread, but it is very inefficient to go back to the thread to
pick only the useful pieces.  The whole flamewar simply did not
fit a small Panda brain.

That was the reason for this write-up.

Design constraints.  In the following, I'll use two names $A and
$B as an example.  They are a pair of names that are considered
equivalent in some contexts, such as:

        A=3Dxt_connmark.c  B=3Dxt_CONNMARK.c

 (1) Some filesystems prevent you from having these two
     (confusing) paths in a directory at the same time.  Some do
     not implement this confusion prevention, and allows both
     names to exist at the same time.

     Let's call the former "case insensitive", and the latter
     "case sensitive".

 (2) readdir(3) on some "case insensitive" filesystems returns
     $A, after a successful creat(2) of $B.  Others remember
     which one of the two "equivalent" names were used in
     creat(2).

     Let's call the former "case folding", and the latter "case
     preserving".

     We assume open(2) or lstat(2) of $A or $B will succeed
     after allowing creat(2) of $B if a case folding filesystem
     returns $A from readdir(3).

 (3) Among the "case folding" ones, some filesystems fold the
     pathname to a form that is less interoperable with other
     systems, and/or the form that is likely to be different
     from what the end-user usually enters.

     Such filesystems are "inconveniently case folding".

The last one is not quite apparent with the "xt_connmark.c"
example, but if you replace $A and $B in the above description
with:

        A=3DMa"rchen       B=3DM=C3=A4rchen

it would hopefully become more clear.

=46or example, vfat is generally "case preserving".  In that long
flamewar thread, I think we learned that HFS+ is in general
"inconveniently case folding" with respect to Unicode, by always
folding to $A but the keyboard/IM input is more likely to come
as $B, which happens to be the more interoperable form with
other systems.


Issues with case insensitive filesystems
----------------------------------------

At the data structure level, a pathname to git is a sequence of
bytes terminated with NUL.  This will _not_ change.

By the way, at the data structure level, a tree entry in git can
represent a blob that is a symbolic link.  A tree entry in git
can also represent a blob that is a regular file, and in that
case, it can represent if it is executable or not.  These will
also not change.

Now, let's think about how we allow use of git on a filesystem
that is incapable of symbolic links, and/or a filesystem that
does not have trustable executable bit.

We do not say "Symlinks are evil and not supported everywhere,
so let's introduce a project configuration to disallow addition
of symlinks".  We do not say that to the executable bit, either.

Instead, we have fallback methods to allow manipulating symlinks
and executable bit on such a filesystem that is incapable of
handling them natively.

We should be able to do the same for this "case sensitivity"
issue.  A tree that has xt_connmark.c and xt_CONNMARK.c at the
same time cannot be checked out on a case insensitive filesystem.

The filesystem is simply incapable of it (please just calmly
rephrase it in your head as "does not allow such confusing
craziness" instead of starting another flamewar, if you feel the
expression "incapable of" insults your favorite filesystem).

That may mean the project should avoid such equivalent names in
its trees (and having a project wide configuration could be a
technical means to help enforcing that policy), but it does not
mean the core level of git should prevent them to be created on
such systems.  It just means that there should be a way, that
could (and sometimes has to) be different from the "natural"
way, to manipulate such tree entries even on a case insensitive
filesystem.

=46or example, if I find that RelNotes symlink incorrectly points
at Documentation/RelNotes-1.5.44.txt and want to fix it and push
it out immediately, but if I am on the road and the only
environment I can borrow is a git installation on a filesystem
that is symlink-challenged, I can still do the fix. On such a
filesystem, a symlink is checked out as a regular file but is
still marked as a symlink in the index.  The only thing I need
to do is to edit the file (making sure not to add an extra LF at
the end) and add it to the index.  That's certainly different
from the "natural" way to do that on a filesystem with symlinks,
which is "ln -fs Documentation/RelNotse-1.5.4.txt RelNotes", but
the point is that we make it possible.

The same thing should apply to two files that cannot be checked
out at the same time on case insensitive filesystems.  Perhaps
we could have something like:

	$ git show :xt_CONNMARK.c >xt_connmark-1.c
        $ edit xt_connmark-1.c
	$ git add --as xt_CONNMARK.c xt_connmark-1.c


Issues with case folding filesystems
------------------------------------

In addition to the above, case folding filesystems additionally
have an issue even when there is no "confusing" names in the
tree.  The project may want to have "M=C3=A4rchen" (but not
"Ma"rchen"), but a checkout (which is creat(2) of "M=C3=A4rchen" --
because that is the byte sequence recorded in tree objects and
the index) will result in "Ma"rchen" and no "M=C3=A4rchen" (hence
readdir(3) returns "Ma"rchen").

Linus's patch to use a hashtable that links "equivalent" names
together is a step in the right direction to address this.  The
tree (and the index) has name $B, we check out and the
filesystem folds it to $A.  When we get the name $A back from
the filesystem (via readdir(3)), we hash the name using a hash
function that would drop names $A and $B into the same bucket,
and compare that name $A with each hash entry using a comparison
that considers $A and $B are equivalent.  If we find one, then
we keep the name $B we have already.

If it is a new file, we won't find any name that is equivalent
to $A in the index, and we use the name $A obtained from
readdir(3).

BUT with a twist.

If the filesystem is known to be inconveniently case folding, we
are better off registering $B instead of $A (assuming we can
convert from $A to $B).

One bad issue during development is that we cannot sanely
emulate case folding behaviour on non case-folding filesystems
without wrapping open(2), lstat(2), and friends, because of the
assumption we made above in (2) where we defined the term "case
folding".  This means that the codepath to deal with case
folding filesystems inevitably are harder to debug.



Tasks
-----

 - Identify which case folding filesystems need to be supported,
   and make sure somebody understands its folding logic;

 - For each supported case folding logic, these are needed:

   - a hash function that throws "equivalent" names in the same
     bucket, to be used in Linus's patch;

   - a compare function to determine equivalent names;

   - a convert function that takes a possibly inconvenient form
     of equivalent name (i.e. $A above) as input and returns
     more convenient form (i.e. $B above)

 - Identify places that we use the names obtained from places
   other than the index and tree.  From these places, we would
   need to call the convert function to (de)mangle the name
   before they hit the index.

   Because we may be getting driven by something like:

	$ find | xargs git-foo

   handling readdir(3) we do ourselves any specially does not
   make much sense.  Any path from the user is suspect.

 - Identify places that we look for a name in the index, and
   perform equivalent comparison instead of memcmp(3) we
   traditionally did.  Linus's patch gives scaffolding for this.
