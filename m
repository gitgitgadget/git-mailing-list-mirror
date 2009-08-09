From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] merge: fix incorrect merge message for ambiguous
 tag/branch
Date: Sun, 9 Aug 2009 06:02:24 -0400
Message-ID: <20090809100224.GB25231@coredump.intra.peff.net>
References: <20090809100045.GA25197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 12:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma5EY-0004ta-Oo
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 12:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZHIKC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 06:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZHIKC0
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 06:02:26 -0400
Received: from peff.net ([208.65.91.99]:52372 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbZHIKCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 06:02:25 -0400
Received: (qmail 3123 invoked by uid 107); 9 Aug 2009 10:04:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 06:04:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 06:02:24 -0400
Content-Disposition: inline
In-Reply-To: <20090809100045.GA25197@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125339>

If we have both a tag and a branch named "foo", then calling
"git merge foo" will warn about the ambiguous ref, but merge
the tag.

When generating the commit message, though, we simply
checked whether "refs/heads/foo" existed, and if it did,
assumed it was a branch. This led to the statement "Merge
branch 'foo'" in the commit message, which is quite wrong.

Instead, we should use dwim_ref to find the actual ref used,
and describe it appropriately.

In addition to the test in t7608, we must also tweak the
expected output of t4202, which was accidentally triggering
this bug.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-merge.c           |   15 +++++++--------
 t/t4202-log.sh            |    4 ++--
 t/t7608-merge-messages.sh |    2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 82b5466..f7db148 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -358,6 +358,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	const char *ptr;
+	char *found_ref;
 	int len, early;
 
 	strbuf_branchname(&bname, remote);
@@ -368,14 +369,12 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die("'%s' does not point to a commit", remote);
 
-	strbuf_addstr(&buf, "refs/heads/");
-	strbuf_addstr(&buf, remote);
-	resolve_ref(buf.buf, branch_head, 0, NULL);
-
-	if (!hashcmp(remote_head->sha1, branch_head)) {
-		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
-			sha1_to_hex(branch_head), remote);
-		goto cleanup;
+	if (dwim_ref(remote, strlen(remote), branch_head, &found_ref) > 0) {
+		if (!prefixcmp(found_ref, "refs/heads/")) {
+			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 	}
 
 	/* See if remote matches <name>^^^.. or <name>~<number> */
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48e0088..1e952ca 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -320,11 +320,11 @@ test_expect_success 'set up more tangled history' '
 '
 
 cat > expect <<\EOF
-*   Merge branch 'reach'
+*   Merge commit 'reach'
 |\
 | \
 |  \
-*-. \   Merge branches 'octopus-a' and 'octopus-b'
+*-. \   Merge commit 'octopus-a'; commit 'octopus-b'
 |\ \ \
 * | | | seventh
 | | * | octopus-b
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 9d10583..81ced8a 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -38,7 +38,7 @@ test_expect_success 'merge tag' '
 	check_oneline "Merge commit Qtag-1Q"
 '
 
-test_expect_failure 'ambiguous tag' '
+test_expect_success 'ambiguous tag' '
 	git checkout -b ambiguous master &&
 	test_commit ambiguous &&
 	git checkout master &&
-- 
1.6.4.178.g7a987
