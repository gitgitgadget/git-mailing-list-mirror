From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3] peel_onion(): add support for <rev>^{tag}
Date: Tue,  3 Sep 2013 13:37:33 -0400
Message-ID: <1378229853-21236-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Tue Sep 03 19:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuYE-0000CK-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759367Ab3ICRh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:37:58 -0400
Received: from smtp.bbn.com ([128.33.1.81]:33494 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758932Ab3ICRh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:37:57 -0400
Received: from socket.bbn.com ([192.1.120.102]:59541)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGuY1-000JaN-HC; Tue, 03 Sep 2013 13:37:49 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3EE0E3FF72
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233752>

Complete the <rev>^{<type>} family of object descriptors by having
<rev>^{tag} dereference <rev> until a tag object is found (or fail if
unable).

At first glance this may not seem very useful, as commits, trees, and
blobs cannot be peeled to a tag, and a tag would just peel to itself.
However, this can be used to ensure that <rev> names a tag object:

    $ git rev-parse --verify v1.8.4^{tag}
    04f013dc38d7512eadb915eba22efc414f18b869
    $ git rev-parse --verify master^{tag}
    error: master^{tag}: expected tag type, but the object dereferences to tree type
    fatal: Needed a single revision

Users can already ensure that <rev> is a tag object by checking the
output of 'git cat-file -t <rev>', but:
  * users may expect <rev>^{tag} to exist given that <rev>^{commit},
    <rev>^{tree}, and <rev>^{blob} all exist
  * this syntax is more convenient/natural in some circumstances

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
Changes since v2 (2013-09-02, see
<http://thread.gmane.org/gmane.comp.version-control.git/233598>):
  * add a test case (hopefully I didn't go overboard)
  * explain in the commit message why we might want <rev>^{tag} when
    it's already possible to parse the output of 'git cat-file -t
    <rev>'

 Documentation/revisions.txt |  3 +++
 sha1_name.c                 |  2 ++
 t/t1511-rev-parse-caret.sh  | 29 ++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..b3322ad 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -121,6 +121,9 @@ some output processing may assume ref names in UTF-8.
 object that exists, without requiring 'rev' to be a tag, and
 without dereferencing 'rev'; because a tag is already an object,
 it does not have to be dereferenced even once to get to an object.
++
+'rev{caret}\{tag\}' can be used to ensure that 'rev' identifies an
+existing tag object.
 
 '<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
   A suffix '{caret}' followed by an empty brace pair
diff --git a/sha1_name.c b/sha1_name.c
index 65ad066..6dc496d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -679,6 +679,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	sp++; /* beginning of type name, or closing brace for empty */
 	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
 		expected_type = OBJ_COMMIT;
+	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
+		expected_type = OBJ_TAG;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
 		expected_type = OBJ_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index eaefc77..5771cbd 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -6,14 +6,21 @@ test_description='tests for ref^{stuff}'
 
 test_expect_success 'setup' '
 	echo blob >a-blob &&
-	git tag -a -m blob blob-tag `git hash-object -w a-blob` &&
+	BLOB_SHA1=`git hash-object -w a-blob` &&
+	git tag -a -m blob blob-tag $BLOB_SHA1 &&
+	BLOB_TAG_SHA1=`git rev-parse --verify blob-tag` &&
 	mkdir a-tree &&
 	echo moreblobs >a-tree/another-blob &&
 	git add . &&
 	TREE_SHA1=`git write-tree` &&
 	git tag -a -m tree tree-tag "$TREE_SHA1" &&
+	TREE_TAG_SHA1=`git rev-parse --verify tree-tag` &&
 	git commit -m Initial &&
+	COMMIT_SHA1=`git rev-parse --verify HEAD` &&
 	git tag -a -m commit commit-tag &&
+	COMMIT_TAG_SHA1=`git rev-parse --verify commit-tag` &&
+	git tag -a -m tag tag-tag $COMMIT_TAG_SHA1 &&
+	TAG_TAG_SHA1=`git rev-parse --verify tag-tag` &&
 	git branch ref &&
 	git checkout master &&
 	echo modified >>a-blob &&
@@ -54,6 +61,26 @@ test_expect_success 'ref^{tree}' '
 	test_must_fail git rev-parse blob-tag^{tree}
 '
 
+test_expect_success 'ref^{tag}' '
+	echo $BLOB_TAG_SHA1 >expected &&
+	git rev-parse --verify blob-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	echo $TREE_TAG_SHA1 >expected &&
+	git rev-parse --verify tree-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	echo $COMMIT_TAG_SHA1 >expected &&
+	git rev-parse --verify commit-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	echo $TAG_TAG_SHA1 >expected &&
+	git rev-parse --verify tag-tag^{tag} >actual &&
+	test_cmp expected actual &&
+	test_must_fail git rev-parse --verify $BLOB_SHA1^{tag} &&
+	test_must_fail git rev-parse --verify $TREE_SHA1^{tag} &&
+	test_must_fail git rev-parse --verify $COMMIT_SHA1^{tag} &&
+	test_must_fail git rev-parse --verify rev^{tag} &&
+	true
+'
+
 test_expect_success 'ref^{/.}' '
 	git rev-parse master >expected &&
 	git rev-parse master^{/.} >actual &&
-- 
1.8.4
