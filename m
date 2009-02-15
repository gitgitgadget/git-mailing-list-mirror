From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 5/8] Test fsck a bit harder
Date: Sun, 15 Feb 2009 23:25:42 +0100
Message-ID: <fc8b0b6a528906e5d66eee3985b00bc3542cec54.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSv-0004VH-Ne
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZBOW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZBOW0I
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:08 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbZBOW0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:26:06 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:54.0803 (UTC) FILETIME=[5DDB0C30:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110075>

git-fsck, of all tools, has very few tests.  This adds some more:
* a corrupted object;
* a branch pointing to a non-commit;
* a tag pointing to a nonexistent object;
* and a tag pointing to an object of a type other than what the tag
  itself claims.

Only the first two are caught.  At least the third probably should,
too, but currently slips through.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t1450-fsck.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4597af0..302c910 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -28,4 +28,69 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
 	)
 '
 
+# Corruption tests follow.  Make sure to remove all traces of the
+# specific corruption you test afterwards, lest a later test trip over
+# it.
+
+test_expect_success 'object with bad sha1' '
+	sha=$(echo blob | git hash-object -w --stdin) &&
+	echo $sha &&
+	old=$(echo $sha | sed "s+^..+&/+") &&
+	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
+	sha="$(dirname $new)$(basename $new)"
+	mv .git/objects/$old .git/objects/$new &&
+	git update-index --add --cacheinfo 100644 $sha foo &&
+	tree=$(git write-tree) &&
+	cmt=$(echo bogus | git commit-tree $tree) &&
+	git update-ref refs/heads/bogus $cmt &&
+	(git fsck 2>out; true) &&
+	grep "$sha.*corrupt" out &&
+	rm -f .git/objects/$new &&
+	git update-ref -d refs/heads/bogus &&
+	git read-tree -u --reset HEAD
+'
+
+test_expect_success 'branch pointing to non-commit' '
+	git rev-parse HEAD^{tree} > .git/refs/heads/invalid &&
+	git fsck 2>out &&
+	grep "not a commit" out &&
+	git update-ref -d refs/heads/invalid
+'
+
+cat > invalid-tag <<EOF
+object ffffffffffffffffffffffffffffffffffffffff
+type commit
+tag invalid
+tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+This is an invalid tag.
+EOF
+
+test_expect_failure 'tag pointing to nonexistent' '
+	tag=$(git hash-object -w --stdin < invalid-tag) &&
+	echo $tag > .git/refs/tags/invalid &&
+	git fsck --tags 2>out &&
+	grep "could not load tagged object" out &&
+	rm .git/refs/tags/invalid
+'
+
+cat > wrong-tag <<EOF
+object $(echo blob | git hash-object -w)
+type commit
+tag wrong
+tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+This is an invalid tag.
+EOF
+
+test_expect_failure 'tag pointing to something else than its type' '
+	tag=$(git hash-object -w --stdin < wrong-tag) &&
+	echo $tag > .git/refs/tags/wrong &&
+	git fsck --tags 2>out &&
+	grep "some sane error message" out &&
+	rm .git/refs/tags/wrong
+'
+
+
+
 test_done
-- 
1.6.2.rc0.335.g1a2b
