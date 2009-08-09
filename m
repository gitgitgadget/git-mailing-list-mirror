From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] tests: provide $TRASH_DIRECTORY variable
Date: Sun, 9 Aug 2009 04:38:11 -0400
Message-ID: <20090809083810.GB8250@coredump.intra.peff.net>
References: <20090809083518.GA8147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 10:38:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma3v4-0006Eq-Ah
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 10:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbZHIIiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 04:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZHIIiN
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 04:38:13 -0400
Received: from peff.net ([208.65.91.99]:32950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbZHIIiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 04:38:12 -0400
Received: (qmail 2754 invoked by uid 107); 9 Aug 2009 08:40:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 04:40:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 04:38:11 -0400
Content-Disposition: inline
In-Reply-To: <20090809083518.GA8147@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125331>

Most scripts don't care about the absolute path to the trash
directory. The one exception was t4014 script, which pieced
together $TEST_DIRECTORY and $test itself to get an absolute
directory.

Instead, let's provide a $TRASH_DIRECTORY which specifies
the same thing. This keeps the $test variable internal to
test-lib.sh and paves the way for trash directories in other
locations.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4014-format-patch.sh |    3 +--
 t/test-lib.sh           |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 922a894..531f5b7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -493,13 +493,12 @@ test_expect_success 'format-patch from a subdirectory (2)' '
 '
 
 test_expect_success 'format-patch from a subdirectory (3)' '
-	here="$TEST_DIRECTORY/$test" &&
 	rm -f 0* &&
 	filename=$(
 		rm -rf sub &&
 		mkdir -p sub/dir &&
 		cd sub/dir &&
-		git format-patch -1 -o "$here"
+		git format-patch -1 -o "$TRASH_DIRECTORY"
 	) &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
 	test -f "$basename"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fdc5d9..e6a7bb1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -645,7 +645,8 @@ fi
 
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
-test ! -z "$debug" || remove_trash="$TEST_DIRECTORY/$test"
+TRASH_DIRECTORY="$TEST_DIRECTORY/$test"
+test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
1.6.4.178.g7a987
