From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 3/5] checkout: Use remote refspecs when DWIMming tracking branches
Date: Fri, 19 Apr 2013 08:20:40 +0200
Message-ID: <1366352442-501-4-git-send-email-johan@herland.net>
References: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hl-0002ou-UP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968Ab3DSGVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:46 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:43105 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab3DSGVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:43 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so257085lab.17
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=g7TgUlXSOPtxCBBwSzw1NJ9wG34pTpwGraPZhifo/1k=;
        b=SmlBBh2a3y4Zl7TvPR35jwFp5PpuDeZHpAKgVtfaqSyhVA2JoaHV5xqD2T0hElDJu+
         stqi3qEaZEfmmxoteOuCLSwAS3ogpdRDLhfaL8tAGtQMx1P02Bnu7uwz7i2PaFBe0uIR
         nqC3UaWxtpsRqlSh0WNjErHKKIm1aTQnI+vpX5NHORyBUr77BvRATKOVDldsd9cX2pSJ
         gSQoN2z8OnldqGwfzzWAvjtCi+LJNxTJ24MB0SytkaQXYFz0JA5CsDRIkYlXWNDv6ARG
         UfAoiqjrxVLRqkgzdfFYW0qL2huNKqPxEWuV5VkgpeADs3jVHN5ByOjCJnnPhc8s5DGr
         9hkg==
X-Received: by 10.152.120.6 with SMTP id ky6mr7409265lab.19.1366352501988;
        Thu, 18 Apr 2013 23:21:41 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366352442-501-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221745>

The DWIM mode of checkout allows you to run "git checkout foo" when there is
no existing local ref or path called "foo", and there is exactly one remote
with a remote-tracking branch called "foo". Git will then automatically
create a new local branch called "foo" using the remote-tracking "foo" as
its starting point and configured upstream.

However, the current code hardcodes the assumption that all remote-tracking
branches are located at refs/remotes/$remote/*, and that "git checkout foo"
must find exactly one ref matching "refs/remotes/*/foo" to succeed.
This approach fails if a user has customized the refspec of a given remote to
place remote-tracking branches elsewhere.

The better way to find a tracking branch is to use the fetch refspecs for the
configured remotes to deduce the available candidate remote-tracking branches
corresponding to a remote branch of the requested name, and if exactly one of
these exists (and points to a valid SHA1), then that is the remote-tracking
branch we will use.

For example, in the case of "git checkout foo", we map "refs/heads/foo"
through each remote's refspec to find the available candidate remote-tracking
branches, and if exactly one of these candidates exist in our local repo, then
we have found the upstream for the new local branch "foo".

This fixes most of the failing tests introduced in the previous patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-checkout.txt |  6 +++---
 builtin/checkout.c             | 42 ++++++++++++++++++++++--------------------
 t/t2024-checkout-dwim.sh       |  6 +++---
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8edcdca..bf0c99c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -131,9 +131,9 @@ entries; instead, unmerged entries are ignored.
 	"--track" in linkgit:git-branch[1] for details.
 +
 If no '-b' option is given, the name of the new branch will be
-derived from the remote-tracking branch.  If "remotes/" or "refs/remotes/"
-is prefixed it is stripped away, and then the part up to the
-next slash (which would be the nickname of the remote) is removed.
+derived from the remote-tracking branch, by looking at the local part of
+the refspec configured for the corresponding remote, and then stripping
+the initial part up to the "*".
 This would tell us to use "hack" as the local branch when branching
 off of "origin/hack" (or "remotes/origin/hack", or even
 "refs/remotes/origin/hack").  If the given name has no slash, or the above
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f8033f4..d6f9c01 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -822,38 +822,40 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 }
 
 struct tracking_name_data {
-	const char *name;
-	char *remote;
+	/* const */ char *src_ref;
+	char *dst_ref;
+	unsigned char *dst_sha1;
 	int unique;
 };
 
-static int check_tracking_name(const char *refname, const unsigned char *sha1,
-			       int flags, void *cb_data)
+static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
-	const char *slash;
-
-	if (prefixcmp(refname, "refs/remotes/"))
-		return 0;
-	slash = strchr(refname + 13, '/');
-	if (!slash || strcmp(slash + 1, cb->name))
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.src = cb->src_ref;
+	if (remote_find_tracking(remote, &query) ||
+	    get_sha1(query.dst, cb->dst_sha1))
 		return 0;
-	if (cb->remote) {
+	if (cb->dst_ref) {
 		cb->unique = 0;
 		return 0;
 	}
-	cb->remote = xstrdup(refname);
+	cb->dst_ref = xstrdup(query.dst);
 	return 0;
 }
 
-static const char *unique_tracking_name(const char *name)
+static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, 1 };
-	cb_data.name = name;
-	for_each_ref(check_tracking_name, &cb_data);
+	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	char src_ref[PATH_MAX];
+	snprintf(src_ref, PATH_MAX, "refs/heads/%s", name);
+	cb_data.src_ref = src_ref;
+	cb_data.dst_sha1 = sha1;
+	for_each_remote(check_tracking_name, &cb_data);
 	if (cb_data.unique)
-		return cb_data.remote;
-	free(cb_data.remote);
+		return cb_data.dst_ref;
+	free(cb_data.dst_ref);
 	return NULL;
 }
 
@@ -916,8 +918,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (dwim_new_local_branch_ok &&
 		    !check_filename(NULL, arg) &&
 		    argc == 1) {
-			const char *remote = unique_tracking_name(arg);
-			if (!remote || get_sha1(remote, rev))
+			const char *remote = unique_tracking_name(arg, rev);
+			if (!remote)
 				return argcount;
 			*new_branch = arg;
 			arg = remote;
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 36bf52f..fc6edc9 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -95,15 +95,15 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 	git fetch repo_d
 '
 
-test_expect_failure 'checkout of branch from multiple remotes fails #2' '
+test_expect_success 'checkout of branch from multiple remotes fails #2' '
 	test_must_fail git checkout bar
 '
 
-test_expect_failure 'checkout of branch from multiple remotes fails #3' '
+test_expect_success 'checkout of branch from multiple remotes fails #3' '
 	test_must_fail git checkout baz
 '
 
-test_expect_failure 'checkout of branch from a single remote succeeds #3' '
+test_expect_success 'checkout of branch from a single remote succeeds #3' '
 	git checkout spam &&
 	test_tracking_branch spam repo_c refs/remotes/extra_dir/repo_c/extra_dir/spam
 '
-- 
1.8.1.3.704.g33f7d4f
