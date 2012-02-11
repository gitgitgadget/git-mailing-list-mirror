From: mhagger@alum.mit.edu
Subject: [PATCH 1/7] t5700: document a failure of alternates to affect fetch
Date: Sat, 11 Feb 2012 07:20:55 +0100
Message-ID: <1328941261-29746-2-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6Ko-0001dn-MO
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2BKGVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50455 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2BKGVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:17 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CB019131;
	Sat, 11 Feb 2012 07:21:09 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190485>

From: Michael Haggerty <mhagger@alum.mit.edu>

If an alternate supplies some, but not all, of the objects needed for
a fetch, fetch-pack nevertheless generates "want" lines for the
alternate objects that are present.  Demonstrate this problem via a
failing test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5700-clone-reference.sh |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index c4c375a..2dafee8 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -52,13 +52,13 @@ test_cmp expected current'
 
 cd "$base_dir"
 
-rm -f "$U"
+rm -f "$U.D"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'GIT_DEBUG_SEND_PACK=3 git clone --reference B "file://$(pwd)/A" D 3>"$U"'
+'GIT_DEBUG_SEND_PACK=3 git clone --reference B "file://$(pwd)/A" D 3>"$U.D"'
 
 test_expect_success 'fetched no objects' \
-'! grep "^want" "$U"'
+'! grep "^want" "$U.D"'
 
 cd "$base_dir"
 
@@ -153,4 +153,32 @@ test_expect_success 'clone with reference from a tagged repository' '
 	git clone --reference=A A I
 '
 
+test_expect_success 'prepare branched repository' '
+	git clone A J &&
+	(
+		cd J &&
+		git checkout -b other master^ &&
+		echo other > otherfile &&
+		git add otherfile &&
+		git commit -m other &&
+		git checkout master
+	)
+'
+
+rm -f "$U.K"
+
+test_expect_failure 'fetch with incomplete alternates' '
+	git init K &&
+	echo "$base_dir/A/.git/objects" >K/.git/objects/info/alternates &&
+	(
+		cd K &&
+		git remote add J "file://$base_dir/J" &&
+		GIT_DEBUG_SEND_PACK=3 git fetch J 3>"$U.K"
+	) &&
+	master_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/master) &&
+	! grep "^want $master_object" "$U.K" &&
+	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
+	! grep "^want $tag_object" "$U.K"
+'
+
 test_done
-- 
1.7.9
