From: Jeff King <peff@peff.net>
Subject: [PATCH v3 08/14] remote.c: report specific errors from
 branch_get_upstream
Date: Thu, 21 May 2015 00:45:32 -0400
Message-ID: <20150521044532.GH23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMW-00006e-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbbEUEph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:33695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753384AbbEUEpf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:35 -0400
Received: (qmail 2373 invoked by uid 102); 21 May 2015 04:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:34 -0500
Received: (qmail 31232 invoked by uid 107); 21 May 2015 04:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269549>

When the previous commit introduced the branch_get_upstream
helper, there was one call-site that could not be converted:
the one in sha1_name.c, which gives detailed error messages
for each possible failure.

Let's teach the helper to optionally report these specific
errors. This lets us convert another callsite, and means we
can use the helper in other locations that want to give the
same error messages.

The logic and error messages come straight from sha1_name.c,
with the exception that we start each error with a lowercase
letter, as is our usual style (note that a few tests need
updated as a result).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c              |  2 +-
 builtin/for-each-ref.c        |  2 +-
 builtin/log.c                 |  2 +-
 remote.c                      | 33 +++++++++++++++++++++++++++++----
 remote.h                      |  6 +++++-
 sha1_name.c                   | 25 +++++++------------------
 t/t1507-rev-parse-upstream.sh |  8 ++++----
 7 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1eb6215..cc55ff2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -123,7 +123,7 @@ static int branch_merged(int kind, const char *name,
 
 	if (kind == REF_LOCAL_BRANCH) {
 		struct branch *branch = branch_get(name);
-		const char *upstream = branch_get_upstream(branch);
+		const char *upstream = branch_get_upstream(branch, NULL);
 		unsigned char sha1[20];
 
 		if (upstream &&
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index dc2a201..18d209b 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -664,7 +664,7 @@ static void populate_value(struct refinfo *ref)
 				continue;
 			branch = branch_get(ref->refname + 11);
 
-			refname = branch_get_upstream(branch);
+			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
 				continue;
 		} else if (starts_with(name, "color:")) {
diff --git a/builtin/log.c b/builtin/log.c
index fb61c08..6faeb82 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1632,7 +1632,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		break;
 	default:
 		current_branch = branch_get(NULL);
-		upstream = branch_get_upstream(current_branch);
+		upstream = branch_get_upstream(current_branch, NULL);
 		if (!upstream) {
 			fprintf(stderr, _("Could not find a tracked"
 					" remote branch, please"
diff --git a/remote.c b/remote.c
index dca3442..1b7051a 100644
--- a/remote.c
+++ b/remote.c
@@ -1705,10 +1705,35 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
-const char *branch_get_upstream(struct branch *branch)
+__attribute((format (printf,2,3)))
+static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
-	if (!branch || !branch->merge || !branch->merge[0])
-		return NULL;
+	if (err) {
+		va_list ap;
+		va_start(ap, fmt);
+		strbuf_vaddf(err, fmt, ap);
+		va_end(ap);
+	}
+	return NULL;
+}
+
+const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+{
+	if (!branch)
+		return error_buf(err, _("HEAD does not point to a branch"));
+	if (!branch->merge || !branch->merge[0] || !branch->merge[0]->dst) {
+		if (!ref_exists(branch->refname))
+			return error_buf(err, _("no such branch: '%s'"),
+					 branch->name);
+		if (!branch->merge)
+			return error_buf(err,
+					 _("no upstream configured for branch '%s'"),
+					 branch->name);
+		return error_buf(err,
+				 _("upstream branch '%s' not stored as a remote-tracking branch"),
+				 branch->merge[0]->src);
+	}
+
 	return branch->merge[0]->dst;
 }
 
@@ -1921,7 +1946,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	int rev_argc;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = branch_get_upstream(branch);
+	base = branch_get_upstream(branch, NULL);
 	if (!base)
 		return 0;
 
diff --git a/remote.h b/remote.h
index d968952..03ca005 100644
--- a/remote.h
+++ b/remote.h
@@ -222,8 +222,12 @@ int branch_merge_matches(struct branch *, int n, const char *);
  * Return the fully-qualified refname of the tracking branch for `branch`.
  * I.e., what "branch@{upstream}" would give you. Returns NULL if no
  * upstream is defined.
+ *
+ * If `err` is not NULL and no upstream is defined, a more specific error
+ * message is recorded there (if the function does not return NULL, then
+ * `err` is not touched).
  */
-const char *branch_get_upstream(struct branch *branch);
+const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
 
 /* Flags to match_refs. */
 enum match_refs_flags {
diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..461157a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1059,27 +1059,16 @@ static const char *get_upstream_branch(const char *branch_buf, int len)
 {
 	char *branch = xstrndup(branch_buf, len);
 	struct branch *upstream = branch_get(*branch ? branch : NULL);
+	struct strbuf err = STRBUF_INIT;
+	const char *ret;
 
-	/*
-	 * Upstream can be NULL only if branch refers to HEAD and HEAD
-	 * points to something different than a branch.
-	 */
-	if (!upstream)
-		die(_("HEAD does not point to a branch"));
-	if (!upstream->merge || !upstream->merge[0]->dst) {
-		if (!ref_exists(upstream->refname))
-			die(_("No such branch: '%s'"), branch);
-		if (!upstream->merge) {
-			die(_("No upstream configured for branch '%s'"),
-				upstream->name);
-		}
-		die(
-			_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			upstream->merge[0]->src);
-	}
 	free(branch);
 
-	return upstream->merge[0]->dst;
+	ret = branch_get_upstream(upstream, &err);
+	if (!ret)
+		die("%s", err.buf);
+
+	return ret;
 }
 
 static int interpret_upstream_mark(const char *name, int namelen,
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 1978947..46ef1f2 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -150,7 +150,7 @@ test_expect_success 'branch@{u} works when tracking a local branch' '
 
 test_expect_success 'branch@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	fatal: No upstream configured for branch ${sq}non-tracking${sq}
+	fatal: no upstream configured for branch ${sq}non-tracking${sq}
 	EOF
 	error_message non-tracking@{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -158,7 +158,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
 
 test_expect_success '@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
-	fatal: No upstream configured for branch ${sq}master${sq}
+	fatal: no upstream configured for branch ${sq}master${sq}
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -166,7 +166,7 @@ test_expect_success '@{u} error message when no upstream' '
 
 test_expect_success 'branch@{u} error message with misspelt branch' '
 	cat >expect <<-EOF &&
-	fatal: No such branch: ${sq}no-such-branch${sq}
+	fatal: no such branch: ${sq}no-such-branch${sq}
 	EOF
 	error_message no-such-branch@{u} 2>actual &&
 	test_i18ncmp expect actual
@@ -183,7 +183,7 @@ test_expect_success '@{u} error message when not on a branch' '
 
 test_expect_success 'branch@{u} error message if upstream branch not fetched' '
 	cat >expect <<-EOF &&
-	fatal: Upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
+	fatal: upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
 	test_i18ncmp expect actual
-- 
2.4.1.528.g00591e3
