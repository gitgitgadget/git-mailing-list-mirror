From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 16:11:54 +0530
Message-ID: <1369132915-25657-2-git-send-email-artagnon@gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 12:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uejzj-0008DL-4g
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 12:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab3EUKkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 06:40:18 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35588 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3EUKkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 06:40:16 -0400
Received: by mail-pd0-f175.google.com with SMTP id 6so138526pdd.20
        for <git@vger.kernel.org>; Tue, 21 May 2013 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/pk8WjUtR2x+d0duI2/vEF6O8580oPXDJZ/tBaAMi3k=;
        b=FSUXP5U0adQZe+S4iX0KefwoWlSR8WCbjt8/F8JYeyp31XL7worbCQ/r5BEKDH1Tp7
         sNSOmiS5Ws26kEh9j7BtBNZSsoHAeSpUDLDogOn1n7P2VS9VbWsmBEjjd29msmBFu2U/
         lRjgJta5c5MVkQSKsiQJMC58J9VB0tc2gN3QBbone4mGAiXqhutjPdJ4B/Kox5RbA+5q
         POIwwzP1gTEG+hc4idVvJYQca035S3gyymfWA33s1nwT+cDX1fqL80VMBiWky83/DpJW
         wUGyHPAeGL+40d6ra9EfZ5JNe5DIFScLaBwqllAX6nY/cZZEODSYCdV86ryhhqZBhWuu
         nKNg==
X-Received: by 10.68.0.199 with SMTP id 7mr2035098pbg.105.1369132815664;
        Tue, 21 May 2013 03:40:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm2198426pbc.42.2013.05.21.03.40.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 03:40:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.6.ga9126d5.dirty
In-Reply-To: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225025>

Currently, when no (valid) upstream is configured for a branch, we get
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
1.8.3.rc3.6.ga9126d5.dirty
