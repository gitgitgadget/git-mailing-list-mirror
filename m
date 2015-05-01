From: Jeff King <peff@peff.net>
Subject: [PATCH 05/12] remote.c: introduce branch_get_upstream helper
Date: Fri, 1 May 2015 18:47:09 -0400
Message-ID: <20150501224708.GE1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJiG-0006rZ-7c
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbbEAWrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:47:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:53106 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbbEAWrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:47:11 -0400
Received: (qmail 23385 invoked by uid 102); 1 May 2015 22:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:47:11 -0500
Received: (qmail 21014 invoked by uid 107); 1 May 2015 22:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:47:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:47:09 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268190>

All of the information needed to find the @{upstream} of a
branch is included in the branch struct, but callers have to
navigate a series of possible-NULL values to get there.
Let's wrap that logic up in an easy-to-read helper.

Signed-off-by: Jeff King <peff@peff.net>
---
New in v2.

 builtin/branch.c       |  8 +++-----
 builtin/for-each-ref.c |  5 ++---
 builtin/log.c          |  7 ++-----
 remote.c               | 12 +++++++++---
 remote.h               |  7 +++++++
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1d15037..bd1fa0b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -123,14 +123,12 @@ static int branch_merged(int kind, const char *name,
 
 	if (kind == REF_LOCAL_BRANCH) {
 		struct branch *branch = branch_get(name);
+		const char *upstream = branch_get_upstream(branch);
 		unsigned char sha1[20];
 
-		if (branch &&
-		    branch->merge &&
-		    branch->merge[0] &&
-		    branch->merge[0]->dst &&
+		if (upstream &&
 		    (reference_name = reference_name_to_free =
-		     resolve_refdup(branch->merge[0]->dst, RESOLVE_REF_READING,
+		     resolve_refdup(upstream, RESOLVE_REF_READING,
 				    sha1, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(sha1);
 	}
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..dc2a201 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -664,10 +664,9 @@ static void populate_value(struct refinfo *ref)
 				continue;
 			branch = branch_get(ref->refname + 11);
 
-			if (!branch || !branch->merge || !branch->merge[0] ||
-			    !branch->merge[0]->dst)
+			refname = branch_get_upstream(branch);
+			if (!refname)
 				continue;
-			refname = branch->merge[0]->dst;
 		} else if (starts_with(name, "color:")) {
 			char color[COLOR_MAXLEN] = "";
 
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..fb61c08 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1632,16 +1632,13 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		break;
 	default:
 		current_branch = branch_get(NULL);
-		if (!current_branch || !current_branch->merge
-					|| !current_branch->merge[0]
-					|| !current_branch->merge[0]->dst) {
+		upstream = branch_get_upstream(current_branch);
+		if (!upstream) {
 			fprintf(stderr, _("Could not find a tracked"
 					" remote branch, please"
 					" specify <upstream> manually.\n"));
 			usage_with_options(cherry_usage, options);
 		}
-
-		upstream = current_branch->merge[0]->dst;
 	}
 
 	init_revisions(&revs, prefix);
diff --git a/remote.c b/remote.c
index 9f84ea3..c826fad 100644
--- a/remote.c
+++ b/remote.c
@@ -1695,6 +1695,13 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+const char *branch_get_upstream(struct branch *branch)
+{
+	if (!branch || !branch->merge || !branch->merge[0])
+		return NULL;
+	return branch->merge[0]->dst;
+}
+
 static int ignore_symref_update(const char *refname)
 {
 	unsigned char sha1[20];
@@ -1904,12 +1911,11 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	int rev_argc;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	if (!branch ||
-	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
+	base = branch_get_upstream(branch);
+	if (!base)
 		return 0;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
 		return -1;
 	theirs = lookup_commit_reference(sha1);
diff --git a/remote.h b/remote.h
index 30a11da..d968952 100644
--- a/remote.h
+++ b/remote.h
@@ -218,6 +218,13 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit);
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/**
+ * Return the fully-qualified refname of the tracking branch for `branch`.
+ * I.e., what "branch@{upstream}" would give you. Returns NULL if no
+ * upstream is defined.
+ */
+const char *branch_get_upstream(struct branch *branch);
+
 /* Flags to match_refs. */
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
-- 
2.4.0.rc3.477.gc25258d
