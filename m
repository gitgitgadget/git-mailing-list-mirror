From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 5/8] Test fsck a bit harder
Date: Thu, 19 Feb 2009 12:13:39 +0100
Message-ID: <0599d1b4fe0f243b3d86d9afd9c67858861838aa.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sx-0000Pm-Fn
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbZBSLOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZBSLOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:09 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbZBSLOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:14:05 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:53 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0821 (UTC) FILETIME=[25BBDE50:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110675>

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

Fixed a missing --stdin when calling git-hash-object.  I also added
some debugging 'cat out' to make it easier to fix the 'grep'
invocation when fsck actually starts printing errors for these
corruptions.

   --- a/t/t1450-fsck.sh
   +++ b/t/t1450-fsck.sh
  -@@ -28,4 +28,69 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
  +@@ -28,4 +28,71 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
          )
    '

  @@ -79,12 +80,13 @@
   +      tag=$(git hash-object -w --stdin < invalid-tag) &&
   +      echo $tag > .git/refs/tags/invalid &&
   +      git fsck --tags 2>out &&
  ++      cat out &&
   +      grep "could not load tagged object" out &&
   +      rm .git/refs/tags/invalid
   +'
   +
   +cat > wrong-tag <<EOF
  -+object $(echo blob | git hash-object -w)
  ++object $(echo blob | git hash-object -w --stdin)
   +type commit
   +tag wrong
   +tagger T A Gger <tagger@example.com> 1234567890 -0000
  @@ -96,6 +98,7 @@
   +      tag=$(git hash-object -w --stdin < wrong-tag) &&
   +      echo $tag > .git/refs/tags/wrong &&
   +      git fsck --tags 2>out &&
  ++      cat out &&
   +      grep "some sane error message" out &&
   +      rm .git/refs/tags/wrong
   +'


 t/t1450-fsck.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4597af0..a22632f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -28,4 +28,71 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
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
+	cat out &&
+	grep "could not load tagged object" out &&
+	rm .git/refs/tags/invalid
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
+test_expect_failure 'tag pointing to something else than its type' '
+	tag=$(git hash-object -w --stdin < wrong-tag) &&
+	echo $tag > .git/refs/tags/wrong &&
+	git fsck --tags 2>out &&
+	cat out &&
+	grep "some sane error message" out &&
+	rm .git/refs/tags/wrong
+'
+
+
+
 test_done
-- 
1.6.2.rc1.266.gce6c4
