From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC] log(n)-transmissions common commit handshake
Date: Thu, 18 Sep 2008 01:00:30 +0200
Message-ID: <200809180100.32626.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19092520.ZzdcSDiUix";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 01:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg61p-0006mg-In
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 01:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYIQXAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 19:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYIQXAg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 19:00:36 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38022 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbYIQXAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 19:00:35 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 01:00:33 +0200
Received: from [192.168.0.2] ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 01:00:32 +0200
User-Agent: KMail/1.9.9
X-OriginalArrivalTime: 17 Sep 2008 23:00:32.0596 (UTC) FILETIME=[2FF0D940:01C91919]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96149>

--nextPart19092520.ZzdcSDiUix
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi *

This is a fairly long mail, so here's a brief abstract:

  Using two passes, first exponential stride through history, then
  bisection on the "right" windows, we implement the find_common
  handshake in log(history_size) many transmissions.  The followup
  patch partially achieves that, but a few points are open and strict
  backwards compatibility is missing (but its absence is Mostly
  Harmless).

Terminology
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The sending side (running upload-pack) is called server, and the
receiving side (running fetch-pack) is the client.  Commits fall into
the following categories:

'want':
	Requested by the client for transmission.

'have':
	In the client's object storage.

'common':
	In both client's and server's object storage.

'private':
	have, but not in the server's storage.

'required':
	Part of the history graph "between" commons and wants; minimal
	subset that needs to be sent over the wire as part of the
	transmission.

("Verbing weirds language." -- Calvin)

When I say "a commit is not _yet_ X", I mean "it is not yet known to
be X", usually from the client's POV.


Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This spawned out of the O(#haves*#wants*#history) analysis late last
week.  As a brief summary, the server uses the fairly expensive test
ok_to_give_up() to check whether it can cut the handshake short since
it knows enough commons to cover all wants.  The thread is here:

  http://article.gmane.org/gmane.comp.version-control.git/95787

(Be sure to read the follow-up regarding the first '*' bullet point.)

It does this shortcut because the client risks getting side-tracked on
a private chunk of history leading to a private root.  (According to
the commit message.  I'm not sure how effective it really is.)

This check by far dominates the rest of the server's work, which is
mostly lookup_object(): it only has to take each "have" line sha1, see
if it is present, and if so, ACK it.  The client announces when it
considers the handshake finished, so there is no other requirement to
test for it.

A more efficient handshake could -- in addition to being more
efficient :-) -- solve this problem simply by hitting the private root
very quickly and proceeding elsewhere, avoiding the server-side check.


Outline of current algorithm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

The client sends all its 'have' sha1s, ordered by date, in chunks of
32.  The server replies with an ACK for each 'common', i.e., for any
sha1 it finds in its own object store.

[This is complicated a bit by the exchange of refs, see "Open
questions".]

As it goes, the client marks the commons, and as soon as it runs out
of unmarket commits, it sends a "done".  The server then knows the
entire set of commons too, and can proceed to generate a pack file of
the requireds.

There is a hard limit of 256 commits that go un-ACKed until the client
gives up and declares that there are no common commits.


Idea
=3D=3D=3D=3D

The proposed algorithm scans the haves in a different order, using two
stages: exponential stride and bisection.

(1) Exponential stride:
=2D----------------------

Emit the first commit, then the 2nd from that, then the 4th from that,
and so on.  As a boundary case, always emit the root.

If the history has "bounded width" (the meaning should be fairly
obvious), then this stage emits O(log(n)) commits up to the root.

(2) Bisection:
=2D-------------

Call a pair of (A,B) where A is an ancestor of B "interesting" if B is
not yet common and A is not yet private.

Then the bisection step is: between any interesting pair of commits
(A,B) emitted so far, emit the one in the middle M=3DM(A,B).

["Cut points" between last common and first private commits clearly
lie only between such pairs.]

Assuming for a moment that the server responds immediately, this also
takes only O(log(n)) commits since M must be either common or private,
and thus A..M or M..B is no longer interesting, respectively.

To deal with the delayed responses in the actual protocol, at each
pass 'i' emit M(A,B) for all (A,B) in pairs(i) only if the pair is
still interesting.  Add both (A,M) and (M,B) to pairs(i+1).  Iterate.
pairs(0) is constructed from pass (1).

Intuitively, this means we emit more than log(n) only if we have
nothing else left to do.

=2D---

Between the two stages, we achieve O(log(n)) complexity.  (This
notably means that we hit private roots in far less transmitted sha1s
than the chunk size of 32.)

Unfortunately, this ordering sometimes conflicts with the server's
ok_to_give_up() shortcut mentioned in "Motivation": Consider a linear
branch 'master', and suppose the only 'common' sent out in the first
batch was the root.  ok_to_give_up() detects that it has a common on
the only ancestry line of the want, and trigger a fake ACK for all
further commits.  This becomes a problem when we later emit, say,
'master~1' and the server ACKs it even though it is private.  (It does
not affect correctness, but can increase the depth of history
transmitted by a factor of 2 at worst.)


RFC Implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I'll just highlight a few design decisions.  It's my first serious C
coding in years, so warm up the flamethrowers...

* The work_list (replacing rev_list) is the "recursion stack" for
  get_rev().  New "frames" are inserted such that the order of emitted
  commits is
   (a) refs
   (b) stage (1) in date order
   (b) stage (2) in bisection depth order

  get_rev() is split across functions for each case.

  Refs are moved to front because the current code emits them anyway
  (see "Open questions" below), mostly to help fill the first 64
  "have" lines with things we are going to send anyway, as opposed to
  the "real" walk where we make choices.

* The bisection does not actually remember pairs, but flags commits
  with the directions it has already started a bisection from them.
  Combined with the existing POPPED flag for commits that were
  emitted, the pair (A,B) can be determined from (A,direction) by a
  parent/children search through the history.  This simplifies the
  implementation.

  The idea is then to scan with two pointers 'half' and 'full' in
  parallel, where the first one makes only half as many steps, until
  we hit a POPPED commit.  This must then be the interval we want to
  bisect, and we can check whether it is still interesting, emit M,
  and queue it for recursion at one level deeper.

* We maintain a list 'outstanding' of all commits that have been sent,
  so that an "implied not-ACK" can be inferred from the next ACK.
  This is used to do a child-recursive NOTCOMMON flagging, analogous
  to the parent-recursive COMMON flagging on an ACK.  The bisection
  uses these flags to determine ranges.

* Yes, commit_info is a pointless level of indirection.  I had more
  tracking information in it before the last draft, and left it in for
  the time being.

[Hint: when playing with the patch, command lines such as

   git fetch-pack -v -k <url> <head> 2>&1 | git name-rev --stdin

help see the effects.]


Open Problems
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Effect of branch/merge points

  I do not see a better solution to deal with branch/merge points than
  recursing into them.  There may be examples of history where this
  extra level of recursion spoils the log(n) bound.  Carefully
  choosing which side to scan first might help.

* Impact/clever use of refs

  For some reason, current git sends all refs to the server, even if
  the server should already know about lots of them.  For example, in
  git.git, emitting v1.6.0.2 covers almost all tags in the repository
  by simple ancestor scanning.

  Is there a reason for this behaviour?  Otherwise it would be better
  to emit them in date order and intelligently handle commons.  (In
  fact this does not depend on the discussed change.)

* Backwards compatibility

  As mentioned above, ok_to_give_up() is not really compatible with
  this algorithm.  I suppose we should introduce a new capability
  identifier that has the client enable the log(n) walker, and the
  server disable ok_to_give_up()?  Is there a better approach, or are
  there problems with it?  (I haven't worked with the protocol enough
  to say, though it seems harmless.)

=2E.. and of course everything that I missed. ;-)


I'd greatly appreciate comments, especially from people who know the
protocol side of git.

=2D Thomas


=2D-=20
Thomas Rast
trast@student.ethz.ch





--nextPart19092520.ZzdcSDiUix
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjRjBAACgkQqUud07tmzP1sMwCfey4dKVYSsklVHtWQSZq69a/9
kWYAn1od/DMm6glY9Xowc3FH2JSM7RdH
=fuCt
-----END PGP SIGNATURE-----

--nextPart19092520.ZzdcSDiUix--
