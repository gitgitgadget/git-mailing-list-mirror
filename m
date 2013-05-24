From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Fri, 24 May 2013 13:12:03 +0530
Message-ID: <1369381324-10206-2-git-send-email-artagnon@gmail.com>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 09:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufmc5-0005JZ-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 09:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759972Ab3EXHk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 03:40:27 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49466 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759496Ab3EXHk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 03:40:26 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so1985993pdb.40
        for <git@vger.kernel.org>; Fri, 24 May 2013 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iPYy32bp8uLpOkZyq7JzqFpk1EGlZ4H64PKy4WRm164=;
        b=aNEg0Dv3Gb/EYdvNtDZVBWGlaS5VRSFQ5J9NufAau2XZrVcVu2TdxER5mBiy0YMkc9
         nq/cTDMKIq2UW+cu74RYnZaXGvzG+kUkU9moO9CQtxv/9FI7D0DgFVQuvhYtZqIPpWuw
         rzDWDygYht7CURHXRfH8GEwW0SdmmyhQwPLwiObmeRNKjuAJA5ccvHm3ByCxMstEqfBQ
         8WSSed4osHx2a3QuHtEar5Mygu/hUx16MScci3zewZnC0QNTul4aEpK8ZFN67gPRIHEX
         J9IKSTkjTaXOIWtNA7vtPYLZzL1EiYm67Ewg2S3FmKMpd1Cw6nY3EXJRlkRJiIQoQfTQ
         CAOw==
X-Received: by 10.66.158.36 with SMTP id wr4mr16984501pab.28.1369381225673;
        Fri, 24 May 2013 00:40:25 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wt5sm15136412pbc.38.2013.05.24.00.40.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 00:40:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225331>

Currently, when no (valid) upstream is configured for a branch, you get
an error like:

  $ git show @{u}
  error: No upstream configured for branch 'upstream-error'
  error: No upstream configured for branch 'upstream-error'
  fatal: ambiguous argument '@{u}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

The "error: " line actually appears twice, and the rest of the error
message is useless.  In sha1_name.c:interpret_branch_name(), there is
really no point in processing further if @{u} couldn't be resolved, and
we might as well die() instead of returning an error().  After making
this change, you get:

  $ git show @{u}
  fatal: No upstream configured for branch 'upstream-error'

Also tweak a few tests in t1507 to expect this output.

To justify that this change is safe, consider that all callers of
interpret_branch_name() have to fall in two categories:

1. Direct end-user facing applications like [rev-parse, show] calling in
   with end-user data (in which case the data can contain "@{u}").
   Failing immediately is the right thing to do: the only difference is
   that the die() happens in interpret_branch_name() instead of
   die_verify_filename(), and this is desirable.

2. Callers calling in with programmatic data, and expecting the function
   to return and not die().  In this case, why would anyone ever
   construct a string containing "@{u}" programmatically in the first
   place?  A grep reveals that no part of the code hard-codes either
   "@{u}" or "@{upstream}".  So, these callers will never hit the
   codepath touched by the patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c                   | 11 +++++------
 t/t1507-rev-parse-upstream.sh | 15 +++++----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..61f5a34 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1033,15 +1033,14 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	 * points to something different than a branch.
 	 */
 	if (!upstream)
-		return error(_("HEAD does not point to a branch"));
+		die(_("HEAD does not point to a branch"));
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
-			return error(_("No such branch: '%s'"), cp);
+			die(_("No such branch: '%s'"), cp);
 		if (!upstream->merge)
-			return error(_("No upstream configured for branch '%s'"),
-				     upstream->name);
-		return error(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
+			die(_("No upstream configured for branch '%s'"),
+				upstream->name);
+		die(_("Upstream branch '%s' not stored as a remote-tracking branch"),
 			upstream->merge[0]->src);
 	}
 	free(cp);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index b27a720..2a19e79 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -129,8 +129,7 @@ test_expect_success 'branch@{u} works when tracking a local branch' '
 
 test_expect_success 'branch@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream configured for branch ${sq}non-tracking${sq}
-	fatal: Needed a single revision
+	fatal: No upstream configured for branch ${sq}non-tracking${sq}
 	EOF
 	error_message non-tracking@{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -138,8 +137,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
 
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	error: No upstream configured for branch ${sq}master${sq}
-	fatal: Needed a single revision
+	fatal: No upstream configured for branch ${sq}master${sq}
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -147,8 +145,7 @@ test_expect_success '@{u} error message when no upstream' '
 
 test_expect_success 'branch@{u} error message with misspelt branch' '
 	cat >expect <<-EOF &&
-	error: No such branch: ${sq}no-such-branch${sq}
-	fatal: Needed a single revision
+	fatal: No such branch: ${sq}no-such-branch${sq}
 	EOF
 	error_message no-such-branch@{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -156,8 +153,7 @@ test_expect_success 'branch@{u} error message with misspelt branch' '
 
 test_expect_success '@{u} error message when not on a branch' '
 	cat >expect <<-EOF &&
-	error: HEAD does not point to a branch
-	fatal: Needed a single revision
+	fatal: HEAD does not point to a branch
 	EOF
 	git checkout HEAD^0 &&
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
@@ -166,8 +162,7 @@ test_expect_success '@{u} error message when not on a branch' '
 
 test_expect_success 'branch@{u} error message if upstream branch not fetched' '
 	cat >expect <<-EOF &&
-	error: Upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
-	fatal: Needed a single revision
+	fatal: Upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
 	test_i18ncmp expect actual
-- 
1.8.3.rc3.17.gd95ec6c.dirty
