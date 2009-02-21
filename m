From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4] Test fsck a bit harder
Date: Sat, 21 Feb 2009 12:25:38 +0100
Message-ID: <5d214c5180b20fa90d76cf0c2f064a14be1fb195.1235213803.git.trast@student.ethz.ch>
References: <499F12BF.4080405@kdbg.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 12:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laq1b-0004xQ-US
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 12:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbZBULZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 06:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbZBULZw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 06:25:52 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:8167 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbZBULZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 06:25:51 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 21 Feb 2009 12:25:50 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 21 Feb 2009 12:25:49 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.ga3b4a
In-Reply-To: <499F12BF.4080405@kdbg.org>
X-OriginalArrivalTime: 21 Feb 2009 11:25:49.0999 (UTC) FILETIME=[26080BF0:01C99417]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110941>

git-fsck, of all tools, has very few tests.  This adds some more:
* a corrupted object;
* a branch pointing to a non-commit;
* a tag pointing to a nonexistent object;
* and a tag pointing to an object of a type other than what the tag
  itself claims.

Some of the involved shell programming is due to Johannes Sixt.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Johannes Sixt wrote:
> Any particular reason not to use
> 
> 	test_must_fail git fsck 2>out &&
> 
> here?

I thought I had seen instances where it notices something wrong, but
still exits with success.

I checked again, and apparently I was dreaming.  I changed the tests
to use

	test_must_fail git fsck 2>&1 | tee out

instead, which both checks the exit status and makes the tests more
verbose with -v.

> Shouldn't the cleanup be outside the test_expect_success so that later 
> tests work even if this one fails? (Ditto for subsequent tests.)

Indeed.  I have a tendency to try and wrap as much as possible into
the tests so that it's visible with -v, but here I clearly overshot.

I also used all your shell programming suggestions, thanks a lot.


 t/t1450-fsck.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4597af0..0906b1d 100755
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
+	test_must_fail git fsck 2>&1 | tee out &&
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
+	test_must_fail git fsck 2>&1 | tee out &&
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
+	test_must_fail git fsck 2>&1 | tee out &&
+	grep "Object.*is a blob, not a commit" out
+'
+
+rm .git/refs/tags/wrong
+
+
 test_done
-- 
1.6.2.rc1.310.ga3b4a
