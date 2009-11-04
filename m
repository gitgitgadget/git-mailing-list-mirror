From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/3] t6030: show "rev-list --bisect" breakage when
	bisecting
Date: Wed, 04 Nov 2009 05:00:01 +0100
Message-ID: <20091104040004.4545.36317.chriscool@tuxfamily.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5X1D-0003dl-03
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbZKDD6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZKDD6e
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:58:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55893 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbZKDD6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:58:31 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D7808818057;
	Wed,  4 Nov 2009 04:58:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AD53E81804E;
	Wed,  4 Nov 2009 04:58:27 +0100 (CET)
X-git-sha1: 935b50b7aae7dfd354ee6b7186abe51b7a314a80 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132034>

In the following commits:

ad3f9a7 Add '--bisect' revision machinery argument
81ee52b Merge branch 'lt/revision-bisect' into next

the '--bisect' argument was added to the revision machinery to easily
use the "bad" and "good" refs from the current bisection in any
command that expect some refs.

The problem was that '--bisect' already had a special meaning for
"git rev-list" outside the revision machinery and now it was eaten by
the revision machinery. So a flag named "bisect" was added to
"struct rev_info" in these commits, so that "git rev-list" outside the
revision machinery could see that "--bisect" had been used and operate
as if "--bisect" had been passed to it.

But the above does not fix everything, and this commit adds a test
case to show that.

Now "git rev-list --bisect BAD --not GOOD" behaves differently
depending on whether we are currently bisecting or not. If we are not
currently bisecting, it uses "BAD --not GOOD" as the bisect refs and
if we are bisecting it uses the bisect refs of the current bisection
as the bisect refs. This means that we don't behave like we used to
when we are bisecting and the reafs passed on the command line to
"git rev-list --bisect" are different from the bisect refs of the
current bisection.

The following commit will fix this regression.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index def397c..88a2877 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -392,6 +392,19 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	git branch -D bisect
 '
 
+test_expect_failure 'bisect and "rev-list --bisect"' '
+	rev_list2=$(git rev-list --bisect $HASH3 --not $HASH1) &&
+	test "$rev_list2" = "$HASH2" &&
+	rev_list4=$(git rev-list --bisect $HASH7 --not $HASH1) &&
+	test "$rev_list4" = "$HASH4" &&
+	git bisect start $HASH7 $HASH1 &&
+	rev_hash4=$(git rev-parse --verify HEAD) &&
+	test "$rev_hash4" = "$HASH4" &&
+	rev_list2=$(git rev-list --bisect $HASH3 --not $HASH1) &&
+	test "$rev_list2" = "$HASH2" &&
+	git bisect reset
+'
+
 # This creates a "side" branch to test "siblings" cases.
 #
 # H1-H2-H3-H4-H5-H6-H7  <--other
-- 
1.6.5.1.gaf97d
