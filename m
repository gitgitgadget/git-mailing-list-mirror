From: Thomas Rast <trast@student.ethz.ch>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/3=5D=20grep=20multithreading=20and=20scaling?=
Date: Fri, 2 Dec 2011 14:07:45 +0100
Message-ID: <cover.1322830368.git.trast@student.ethz.ch>
References: <201111291507.04754.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Dec 02 14:08:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWSqW-000567-8b
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 14:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab1LBNHw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 08:07:52 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3814 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269Ab1LBNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 08:07:51 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:47 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Dec
 2011 14:07:48 +0100
X-Mailer: git-send-email 1.7.8.rc4.388.ge53ab
In-Reply-To: <201111291507.04754.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186217>

[Eric, I measured some numbers that may be interesting to the
discussion about b2924dc.  See below.]

This round wraps up the original patch I posted, plus the draft patch
I posted inline the other day with Ren=C3=A9's review taken into accoun=
t.
I also added a patch that rips out threading in the non-worktree case;
read on for the reasoning.

Ren=C3=A9 Scharfe wrote:
> Hmm, why are [gitattributes lookups] that expensive?
>=20
> callgrind tells me that userdiff_find_by_path() contributes only 0.18=
%
> to the total cost with your first patch.  Timings in my virtual machi=
ne
> are very volatile, but it seems that here the difference is in the
> system time while user is basically the same for all combinations of
> patches.

Well, turns out I was measuring something completely stupid.  I had

  git grep --cached -W INITRAMFS_ROOT_UID

where I put the --cached originally because that makes it independent
of the worktree (which in the very first measurements I still had
wiped, as I tend to do for this repo; I checked it out again after
that).  This in fact gives me (~/g/git-grep --cached
INITRAMFS_ROOT_UID, leaving aside -W; best of 10):

  THREADS=3D8:   2.88user 0.21system 0:02.94elapsed
  THREADS=3D4:   2.89user 0.29system 0:02.99elapsed
  THREADS=3D2:   2.83user 0.36system 0:02.87elapsed
  NO_PTHREADS: 2.16user 0.08system 0:02.25elapsed

Uhuh.  Doesn't scale so well after all.  But removing the --cached, as
most people probably would:

  THREADS=3D8:   0.19user 0.32system 0:00.16elapsed
  THREADS=3D4:   0.16user 0.34system 0:00.17elapsed
  THREADS=3D2:   0.18user 0.32system 0:00.26elapsed
  NO_PTHREADS: 0.12user 0.17system 0:00.31elapsed

So I conclude that during any grep that cannot use the worktree,
having any threads hurts.

In addition, during a grep that *can* use the worktree, THREADS=3D8
still helps somewhat on my dual-core i7, though it goes downhill from
there (12 is again as fast as 4; I verified these details using
best-of-50 timings, and it is reproducible.)

I have also run timings on a 2*6-core workstation running OS X, where
performance is best at 5 cores:

  2 threads:  0.96 real   0.41 user   1.27 sys
  3 threads:  0.68 real   0.41 user   1.30 sys
  4 threads:  0.54 real   0.43 user   1.63 sys
  5 threads:  0.50 real   0.41 user   1.51 sys
  6 threads:  0.54 real   0.43 user   1.63 sys
  7 threads:  0.86 real   0.49 user   1.93 sys
  8 threads:  0.98 real   0.51 user   2.07 sys

I kid you not.  That's best-of-50 and rather stable.  It's on the same
tree as the Linux machine too, except for the problem that the OS X FS
is set to case-insensitive and thus cannot represent the tree exactly.
So from git's POV, there are unstaged changes.

Sadly I do not have access to a Linux box having more than 2 physical
cores.  If you have one, please run some tests :-)

So based on my measurements, I would suggest that unless we have
evidence of it scaling beyond 8 cores on some machine, b2924dc (grep:
detect number of CPUs for thread spawning) be dropped.  For now I'm
ignoring the problem that on OS X it doesn't even scale to 8; I'd
rather check how it fares on Linux first.

I added a third patch on top that disables threading in any case that
does not hit the worktree.  I wonder if I missed something or if it
really is that simple.  The neat part is that it's also a reduction in
code required, and at the same time avoids any issues 2/3 might have
with a future attributes-from-trees implementation.

With this I get

  worktree, 8 threads: 0.15user 0.37system 0:00.17elapsed
  --cached, 8 threads: 2.18user 0.07system 0:02.27elapsed

Of course, we could probably gain a huge boost if the read_sha1
machinery could be made threaded, so that it can unpack several
objects at a time.  In addition, I can well imagine that there are
combinations of delta density, object size, and luck where it pays off
to grep in parallel.  Do we care?

Now I really should do something else than fretting over the
sub-second performance of git-grep...


Thomas Rast (3):
  grep: load funcname patterns for -W
  grep: enable threading with -p and -W using lazy attribute lookup
  grep: disable threading in all but worktree case

 builtin/grep.c  |  153 ++++++++++++++++-------------------------------=
-------
 grep.c          |   73 ++++++++++++++++----------
 grep.h          |    7 +++
 t/t7810-grep.sh |   14 +++++
 4 files changed, 112 insertions(+), 135 deletions(-)

--=20
1.7.8.rc4.388.ge53ab
