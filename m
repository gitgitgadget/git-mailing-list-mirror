From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] tests: allow user to specify trash directory location
Date: Sun, 9 Aug 2009 04:39:45 -0400
Message-ID: <20090809083945.GC8250@coredump.intra.peff.net>
References: <20090809083518.GA8147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 10:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma3wY-0006b8-UM
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 10:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbZHIIjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 04:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZHIIjr
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 04:39:47 -0400
Received: from peff.net ([208.65.91.99]:32956 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZHIIjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 04:39:46 -0400
Received: (qmail 2777 invoked by uid 107); 9 Aug 2009 08:42:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 04:42:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 04:39:45 -0400
Content-Disposition: inline
In-Reply-To: <20090809083518.GA8147@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125332>

The tests generate a large amount of I/O activity creating
and destroying repositories and files. We can improve the
time it takes to run the test suite by creating trash
directories on filesystems with better performance
characteristic, even though we may not want the rest of the
git repository on those filesystems (e.g., because they are
not network connected, or because they are temporary
ramdisks).

For example, on a dual processor system:

  $ cd t && time make -j32
  real    1m51.562s
  user    0m59.260s
  sys     1m20.933s

  # /dev/shm is tmpfs
  $ cd t && time make -j32 GIT_TEST_OPTS="--root=/dev/shm"
  real    1m1.484s
  user    0m53.555s
  sys     1m5.264s

We almost halve the wall clock time, and we utilize the
dual processors much better.

Signed-off-by: Jeff King <peff@peff.net>
---
There is a test below for absolute versus relative path in the root
provided.  Do we need some extra magic to make it work on non-Unix
platforms?

 t/test-lib.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e6a7bb1..a5b8d03 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -114,6 +114,9 @@ do
 		valgrind=t; verbose=t; shift ;;
 	--tee)
 		shift ;; # was handled already
+	--root=*)
+		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -645,7 +648,11 @@ fi
 
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
-TRASH_DIRECTORY="$TEST_DIRECTORY/$test"
+test -n "$root" && test="$root/$test"
+case "$test" in
+/*) TRASH_DIRECTORY="$test" ;;
+ *) TRASH_DIRECTORY="$TEST_DIRECTORY/$test" ;;
+esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
 	GIT_EXIT_OK=t
-- 
1.6.4.178.g7a987
