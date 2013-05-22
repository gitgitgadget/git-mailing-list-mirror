From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Wed, 22 May 2013 16:09:54 +0530
Message-ID: <1369219195-20096-2-git-send-email-artagnon@gmail.com>
References: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 22 12:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf6R9-0002Rl-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 12:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3EVKiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 06:38:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39529 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab3EVKiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 06:38:16 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so1659555pac.0
        for <git@vger.kernel.org>; Wed, 22 May 2013 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=00bNvh9XAJ4UVsjgllmY9MSCCP2J0y1s4gYtsG5T9Rk=;
        b=A6KoegIgupGQ71toWVfzuYnLvZ2fRLSYr0i+/DKHSrh5zJ3ThB6tsNNxvJKBktfEF/
         cNO3AOA0yvWOQGFRy3XflHWBaSHrrs8J7KCcp1Sehj/NEf7OoxQp5jRvPk+vdVVbAuhZ
         sWd9mV6Dbe+fOiNlU/+7MBuqnH/xqdixav+n3EYcfl1rcWxeWW+jlZVvAkmt1hQX+UsY
         qx8H5FhQWvyF3en9fEiy6r/AUYan0OwRQCEWV+nXC3l3yAks7rSQFjQUqLBGBlK5Yj0r
         09h0OyuuyusoEpKzPj7XZYom32klf5vdlJkSeghYMPb1+k/VU11+65mjS4vktzs0BHL5
         wguQ==
X-Received: by 10.66.248.228 with SMTP id yp4mr7568549pac.158.1369219096405;
        Wed, 22 May 2013 03:38:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id un15sm5905724pab.7.2013.05.22.03.38.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 May 2013 03:38:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.10.g6f8d616
In-Reply-To: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225144>

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
   place?  So, these callers can never hit the codepath touched by this
   patch, and the change does not affect them.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c                   | 13 +++++++------
 t/t1507-rev-parse-upstream.sh | 15 +++++----------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..416a673 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1033,14 +1033,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	 * points to something different than a branch.
 	 */
 	if (!upstream)
-		return error(_("HEAD does not point to a branch"));
+		die(_("HEAD does not point to a branch"));
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
-			return error(_("No such branch: '%s'"), cp);
-		if (!upstream->merge)
-			return error(_("No upstream configured for branch '%s'"),
-				     upstream->name);
-		return error(
+			die(_("No such branch: '%s'"), cp);
+		if (!upstream->merge) {
+			die(_("No upstream configured for branch '%s'"),
+				upstream->name);
+		}
+		die(
 			_("Upstream branch '%s' not stored as a remote-tracking branch"),
 			upstream->merge[0]->src);
 	}
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
1.8.3.rc3.10.g6f8d616
