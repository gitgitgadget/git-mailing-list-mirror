From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH v2 0/1] cygwin: fast stat functions
Date: Wed, 10 Jul 2013 21:19:42 +0100
Message-ID: <51DDC1DE.1060709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	mlevedahl@gmail.com, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 10 22:25:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux0xB-0002Jl-2f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab3GJUZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 16:25:27 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:46528 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754342Ab3GJUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 16:25:26 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id BCAAC18C87D;
	Wed, 10 Jul 2013 21:25:23 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 84C6418C831;
	Wed, 10 Jul 2013 21:25:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Wed, 10 Jul 2013 21:25:20 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230070>


If you are wondering, v1 of this patch was appended to an email
that is part of the "cygwin: Remove the Win32 l/stat() functions"
thread.

Changes from v1:

    - add comment in git-compat-util.h to explain the use
      of the "fast" stat variants.
    - remove the fast_stat() function, along with the now
      redundant code in compat/cygwin.c
    - add the fast_fstat() function; this is used by code
      in write_entry() (entry.c:139), even though it is not
      actually called by cygwin.
    - replaced an additional call to lstat with fast_lstat.
    - a commit message

This patch, which was built on master @ commit 56df44a, has passed
the full test suite:

    $ GIT_SKIP_TESTS='t0008 t0061.3 t0070.3 t4130 t9010 t9300' \
        make test >test-outp15 2>&1
    $

After Torsten's patch, I didn't need to skip t0070.3; that was just
force of habit! Once Mark's PIPE prerequisite patch is applied, I
would not have to skip t0008, t9010 and t9300.

I also used one of Torsten's tests, on git.git, to provide a quick
check on performance:

    $ time bin-wrappers/git -c core.filemode=true status -uno

which gave the following results (5 runs, discard fastest, slowest
and average remaining three):

    master @ 56df44a + this patch
    true   0.641, 0.656, (0.688), 0.657, (0.640) = 0.651
    false  0.500, (0.531), 0.500, (0.469), 0.500 = 0.500

    master @ 56df44a
    true   0.670, (0.734), (0.638), 0.648, 0.663 = 0.660
    false  (0.509), (0.490), 0.496, 0.497, 0.498 = 0.497

So, this patch does not cause any performance regression (+/- 1%).

However, I was a bit worried by the timings, until I noticed that
(on cygwin) the timings are affected by running from the build
directory. Note the timings for v1.8.3:

    v1.8.3 (build)
    true   0.671, 0.672, (0.640), 0.672, (0.969) = 0.672
    false  (0.515), 0.532, 0.516, 0.516, (0.547) = 0.521

    v1.8.3 (installed)
    true   (0.250), (0.266), 0.265, 0.250, 0.265 = 0.260
    false  (0.109), (0.125), 0.109, 0.125, 0.125 = 0.120

Also, just for comparison, here are the numbers for Linux and
MinGW on the same laptop:

                          Linux   MinGW
    master + patch        0.045   0.115
    master @ 56df44a      -----   0.110
    v1.8.3 (build)        0.045   0.109
    v1.8.3 (installed)    0.045   0.094

So, this patch seems to cause a 5% slowdown on MinGW; I haven't
looked into this yet. Note that the "build directory slowdown" is
much less pronounced on MinGW, and non existent (or too small to
notice) on Linux.

This patch is marked RFC because:

    - I don't like the function names; suggestions welcome!
    - Is fast_fstat() necessary; should we remove the use of
      fstat() in write_entry() instead. (I don't think so).
    - Is the 5% slowdown on MinGW a real problem? (are the
      static inline functions being in-lined?)
    - I need to double check that I have replaced all relevant
      lstat() calls.

ATB,
Ramsay Jones


Ramsay Jones (1):
  cygwin: Add fast_lstat() and fast_fstat() functions

 builtin/apply.c        |  8 ++++----
 builtin/commit.c       |  2 +-
 builtin/ls-files.c     |  2 +-
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 check-racy.c           |  2 +-
 compat/cygwin.c        | 48 ++++++++++--------------------------------------
 compat/cygwin.h        | 17 +++++++++--------
 diff-lib.c             |  2 +-
 diff.c                 |  2 +-
 entry.c                |  6 +++---
 git-compat-util.h      | 27 +++++++++++++++++++++++++--
 help.c                 |  5 +----
 path.c                 |  9 +--------
 preload-index.c        |  2 +-
 read-cache.c           |  6 +++---
 unpack-trees.c         |  8 ++++----
 17 files changed, 68 insertions(+), 82 deletions(-)

-- 
1.8.3
