From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] t: simplify loop exit-code status variables
Date: Wed, 25 Mar 2015 01:30:17 -0400
Message-ID: <20150325053017.GF31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:30:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadtY-0001t1-F8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbbCYFaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:30:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:38175 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751021AbbCYFaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:30:19 -0400
Received: (qmail 17510 invoked by uid 102); 25 Mar 2015 05:30:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:30:20 -0500
Received: (qmail 11726 invoked by uid 107); 25 Mar 2015 05:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:30:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266259>

Since shell loops may drop the exit code of failed commands
inside the loop, some tests try to keep track of the status
by setting a variable. This can end up cumbersome and hard
to read; it is much simpler to just exit directly from the
loop using "return 1" (since each case is either in a helper
function or inside a test snippet).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3060-ls-files-with-tree.sh | 13 ++++---------
 t/t3901-i18n-patch.sh         |  8 ++------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 61c1f53..36b10f7 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -25,15 +25,10 @@ test_expect_success setup '
 		do
 			num=00$n$m &&
 			>sub/file-$num &&
-			echo file-$num >>expected || {
-				bad=t
-				break
-			}
-		done && test -z "$bad" || {
-			bad=t
-			break
-		}
-	done && test -z "$bad" &&
+			echo file-$num >>expected ||
+			return 1
+		done
+	done &&
 	git add . &&
 	git commit -m "add a bunch of files" &&
 
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index a392f3d..75cf3ff 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -9,7 +9,7 @@ test_description='i18n settings and format-patch | am pipe'
 
 check_encoding () {
 	# Make sure characters are not corrupted
-	cnt="$1" header="$2" i=1 j=0 bad=0
+	cnt="$1" header="$2" i=1 j=0
 	while test "$i" -le $cnt
 	do
 		git format-patch --encoding=UTF-8 --stdout HEAD~$i..HEAD~$j |
@@ -20,14 +20,10 @@ check_encoding () {
 			grep "^encoding ISO8859-1" ;;
 		*)
 			grep "^encoding ISO8859-1"; test "$?" != 0 ;;
-		esac || {
-			bad=1
-			break
-		}
+		esac || return 1
 		j=$i
 		i=$(($i+1))
 	done
-	(exit $bad)
 }
 
 test_expect_success setup '
-- 
2.3.4.635.gd6ffcfe
