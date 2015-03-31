From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] remote.c: provide per-branch pushremote name
Date: Tue, 31 Mar 2015 13:37:28 -0400
Message-ID: <20150331173727.GD18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:37:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd06a-0005cc-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbbCaRhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:37:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:40423 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752726AbbCaRha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:37:30 -0400
Received: (qmail 16849 invoked by uid 102); 31 Mar 2015 17:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:37:30 -0500
Received: (qmail 25637 invoked by uid 107); 31 Mar 2015 17:37:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:37:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:37:28 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266537>

When remote.c loads its config, it records the
branch.*.pushremote for the current branch along with the
global remote.pushDefault value, and then binds them into a
single value: the default push for the current branch. We
then pass this value (which may be NULL) to remote_get_1
when looking up a remote for push.

This has a few downsides:

  1. It's confusing. The early-binding of the "current
     value" led to bugs like the one fixed by 98b406f
     (remote: handle pushremote config in any order,
     2014-02-24). And the fact that pushremotes fall back to
     ordinary remotes is not explicit at all; it happens
     because remote_get_1 cannot tell the difference between
     "we are not asking for the push remote" and "there is
     no push remote configured".

  2. It throws away intermediate data. After read_config()
     finishes, we have no idea what the value of
     remote.pushDefault was, because the string has been
     overwritten by the current branch's
     branch.*.pushremote.

  3. It doesn't record other data. We don't note the
     branch.*.pushremote value for anything but the current
     branch.

Let's make this more like the fetch-remote config. We'll
record the pushremote for each branch, and then explicitly
compute the correct remote for the current branch at the
time of reading.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 41 +++++++++++++++++++++++------------------
 remote.h |  2 ++
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/remote.c b/remote.c
index 9555904..8363bdb 100644
--- a/remote.c
+++ b/remote.c
@@ -51,7 +51,6 @@ static int branches_alloc;
 static int branches_nr;
 
 static struct branch *current_branch;
-static const char *branch_pushremote_name;
 static const char *pushremote_name;
 
 static struct rewrites rewrites;
@@ -369,9 +368,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!strcmp(subkey, ".remote")) {
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, ".pushremote")) {
-			if (branch == current_branch)
-				if (git_config_string(&branch_pushremote_name, key, value))
-					return -1;
+			return git_config_string(&branch->pushremote_name, key, value);
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -511,10 +508,6 @@ static void read_config(void)
 		current_branch = make_branch(head_ref, 0);
 	}
 	git_config(handle_config, NULL);
-	if (branch_pushremote_name) {
-		free((char *)pushremote_name);
-		pushremote_name = branch_pushremote_name;
-	}
 	alias_all_urls();
 }
 
@@ -705,20 +698,32 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	return "origin";
 }
 
-static struct remote *remote_get_1(const char *name, const char *pushremote_name)
+const char *pushremote_for_branch(struct branch *branch, int *explicit)
+{
+	if (branch && branch->pushremote_name) {
+		if (explicit)
+			*explicit = 1;
+		return branch->pushremote_name;
+	}
+	if (pushremote_name) {
+		if (explicit)
+			*explicit = 1;
+		return pushremote_name;
+	}
+	return remote_for_branch(branch, explicit);
+}
+
+static struct remote *remote_get_1(const char *name, int for_push)
 {
 	struct remote *ret;
 	int name_given = 0;
 
 	if (name)
 		name_given = 1;
-	else {
-		if (pushremote_name) {
-			name = pushremote_name;
-			name_given = 1;
-		} else
-			name = remote_for_branch(current_branch, &name_given);
-	}
+	else
+		name = for_push ?
+		       pushremote_for_branch(current_branch, &name_given) :
+		       remote_for_branch(current_branch, &name_given);
 
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
@@ -739,13 +744,13 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
 struct remote *remote_get(const char *name)
 {
 	read_config();
-	return remote_get_1(name, NULL);
+	return remote_get_1(name, 0);
 }
 
 struct remote *pushremote_get(const char *name)
 {
 	read_config();
-	return remote_get_1(name, pushremote_name);
+	return remote_get_1(name, 1);
 }
 
 int remote_is_configured(const char *name)
diff --git a/remote.h b/remote.h
index 2a7e7a6..30a11da 100644
--- a/remote.h
+++ b/remote.h
@@ -203,6 +203,7 @@ struct branch {
 	const char *refname;
 
 	const char *remote_name;
+	const char *pushremote_name;
 
 	const char **merge_name;
 	struct refspec **merge;
@@ -212,6 +213,7 @@ struct branch {
 
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
+const char *pushremote_for_branch(struct branch *branch, int *explicit);
 
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
-- 
2.4.0.rc0.363.gf9f328b
