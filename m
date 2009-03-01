From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5] Test fsck a bit harder
Date: Sun,  1 Mar 2009 23:32:43 +0100
Message-ID: <1235946763-15252-1-git-send-email-trast@student.ethz.ch>
References: <200902212021.37807.j6t@kdbg.org>
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LduF7-0006pi-5k
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbZCAWdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756050AbZCAWdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:33:09 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6403 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393AbZCAWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 17:33:08 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 23:33:03 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 23:33:03 +0100
X-Mailer: git-send-email 1.6.2.rc2.289.g2fa25
In-Reply-To: <200902212021.37807.j6t@kdbg.org>
X-OriginalArrivalTime: 01 Mar 2009 22:33:03.0447 (UTC) FILETIME=[AF216E70:01C99ABD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111892>

git-fsck, of all tools, has very few tests.  This adds some more:
* a corrupted object;
* a branch pointing to a non-commit;
* a tag pointing to a nonexistent object;
* and a tag pointing to an object of a type other than what the tag
  itself claims.

Some of the involved shell programming is due to Johannes Sixt.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Sorry for taking so long to fix this.

Johannes Sixt wrote:
> This is wrong: It does not test the exist status. In a pipeline, the shell 
> looks only at the exit status of the last command. You really want this as
> 
>  	test_must_fail git fsck >out 2>&1 &&

You're right.

> If you want to have it more verbose, add 'cat out &&'. But IMHO that is 
> overengineered. If the test detects a regression in the future, it is easy to 
> inspect the file out if necessary.

I usually try to write the tests such that the cause of failure should
be reasonably obvious from the verbose output.  But I don't really
care enough to insert stray cats either...


 t/t1450-fsck.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4597af0..d4a83a1 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -28,4 +28,73 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
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
+	new=${old%/*}/ffffffffffffffffffffffffffffffffffffff &&
+	sha=${new%/*}${new##*/} &&
+	mv .git/objects/$old .git/objects/$new &&
+	git update-index --add --cacheinfo 100644 $sha foo &&
+	tree=$(git write-tree) &&
+	cmt=$(echo bogus | git commit-tree $tree) &&
+	git update-ref refs/heads/bogus $cmt &&
+	test_must_fail git fsck >out 2>&1 &&
+	grep "$sha.*corrupt" out
+'
+
+rm -f .git/objects/$new
+git update-ref -d refs/heads/bogus
+git read-tree -u --reset HEAD
+
+test_expect_success 'branch pointing to non-commit' '
+	git rev-parse HEAD^{tree} > .git/refs/heads/invalid &&
+	git fsck 2>&1 | tee out &&
+	grep "not a commit" out
+'
+
+git update-ref -d refs/heads/invalid
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
+	test_must_fail git fsck >out 2>&1 &&
+	grep "missing commit ffffffffffffffffffffffffffffffffffffffff" out
+'
+
+rm .git/refs/tags/invalid
+rm -f .git/objects/$(echo $tag | sed "s#^..#&/#")
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
+	test_must_fail git fsck >out 2>&1 &&
+	grep "Object.*is a blob, not a commit" out
+'
+
+rm .git/refs/tags/wrong
+
+
 test_done
-- 
1.6.2.rc2.289.g2fa25
