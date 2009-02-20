From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] Test fsck a bit harder
Date: Fri, 20 Feb 2009 20:40:03 +0100
Message-ID: <effac809336c1e05613eed315483ec32f3a4c75b.1235158438.git.trast@student.ethz.ch>
References: <0599d1b4fe0f243b3d86d9afd9c67858861838aa.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 20:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabFq-0000A1-Ce
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 20:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZBTTkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbZBTTkR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 14:40:17 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:26312 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbZBTTkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 14:40:16 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:40:15 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:40:14 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.g364d6
In-Reply-To: <0599d1b4fe0f243b3d86d9afd9c67858861838aa.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 20 Feb 2009 19:40:14.0563 (UTC) FILETIME=[0D138B30:01C99393]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110878>

git-fsck, of all tools, has very few tests.  This adds some more:
* a corrupted object;
* a branch pointing to a non-commit;
* a tag pointing to a nonexistent object;
* and a tag pointing to an object of a type other than what the tag
  itself claims.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I investigated the test failures with v2, and it turns out the problem
was in my use of hash-object.  When correctly passing '-t tag' for the
tags, fsck does detect the breakage.  So here's an updated version of
this test.  Interdiff:

  diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
  index 628db19..a22632f 100755
  --- a/t/t1450-fsck.sh
  +++ b/t/t1450-fsck.sh
  @@ -66,13 +66,13 @@ tagger T A Gger <tagger@example.com> 1234567890 -0000
   This is an invalid tag.
   EOF

  -test_expect_success 'tag pointing to nonexistent' '
  -       tag=$(git hash-object -t tag -w --stdin < invalid-tag) &&
  +test_expect_failure 'tag pointing to nonexistent' '
  +       tag=$(git hash-object -w --stdin < invalid-tag) &&
          echo $tag > .git/refs/tags/invalid &&
  -       git fsck 2>&1 | tee out &&
  -       grep "missing commit ffffffffffffffffffffffffffffffffffffffff" out &&
  -       rm .git/refs/tags/invalid &&
  -       rm -f .git/objects/$(echo $tag | sed "s#^..#&/#")
  +       git fsck --tags 2>out &&
  +       cat out &&
  +       grep "could not load tagged object" out &&
  +       rm .git/refs/tags/invalid
   '

   cat > wrong-tag <<EOF
  @@ -84,11 +84,12 @@ tagger T A Gger <tagger@example.com> 1234567890 -0000
   This is an invalid tag.
   EOF

  -test_expect_success 'tag pointing to something else than its type' '
  -       tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
  +test_expect_failure 'tag pointing to something else than its type' '
  +       tag=$(git hash-object -w --stdin < wrong-tag) &&
          echo $tag > .git/refs/tags/wrong &&
  -       git fsck 2>&1 | tee out &&
  -       grep "Object.*is a blob, not a commit" out &&
  +       git fsck --tags 2>out &&
  +       cat out &&
  +       grep "some sane error message" out &&
          rm .git/refs/tags/wrong
   '

 t/t1450-fsck.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4597af0..628db19 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -28,4 +28,70 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
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
+test_expect_success 'tag pointing to nonexistent' '
+	tag=$(git hash-object -t tag -w --stdin < invalid-tag) &&
+	echo $tag > .git/refs/tags/invalid &&
+	git fsck 2>&1 | tee out &&
+	grep "missing commit ffffffffffffffffffffffffffffffffffffffff" out &&
+	rm .git/refs/tags/invalid &&
+	rm -f .git/objects/$(echo $tag | sed "s#^..#&/#")
+'
+
+cat > wrong-tag <<EOF
+object $(echo blob | git hash-object -w --stdin)
+type commit
+tag wrong
+tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+This is an invalid tag.
+EOF
+
+test_expect_success 'tag pointing to something else than its type' '
+	tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
+	echo $tag > .git/refs/tags/wrong &&
+	git fsck 2>&1 | tee out &&
+	grep "Object.*is a blob, not a commit" out &&
+	rm .git/refs/tags/wrong
+'
+
+
+
 test_done
-- 
1.6.2.rc1.310.g364d6
