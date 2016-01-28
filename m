From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/9] branch: return error code for install_branch_config
Date: Thu, 28 Jan 2016 10:00:30 +0100
Message-ID: <1453971637-22273-3-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiSE-0007FS-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbcA1JBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:01:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60030 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755206AbcA1JAn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 15A4B21EFD
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:43 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 28 Jan 2016 04:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=UCG2
	+X5EcO8BmazdRzdoOdyyFSQ=; b=JKme4Oj9TiyUCnP1N2TpmxvlWb/Cqql1WQNl
	J9wJ33hortDedA+IbuqkDTAjjNL4aogZlqAspoCMYi3zwxSeY0blsKVLhKmsRmz7
	qzMplcOdngW1R8ZHpicn4im79HzOVDabEkRDt8SSW7ajOkjIQ3cm1sNgeYNlGHIX
	TEQFkYE=
X-Sasl-enc: D59Z3iEhzZwLKfYCEdC2opT2PHGVwDqlSLzQ8jhUwD7S 1453971642
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 939256800D1;
	Thu, 28 Jan 2016 04:00:42 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285002>

The install_branch_config function may fail to write the
configuration file due to locking. To accomodate for this
scenario, introduce a return value which may be used to check if
the function did finish correctly and adjust callers to use this
error code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c          | 31 +++++++++++++++++++++----------
 branch.h          |  3 ++-
 builtin/clone.c   |  9 ++++++---
 t/t3200-branch.sh |  9 ++++++++-
 transport.c       | 11 ++++++-----
 5 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 7ff3f20..7f35bcf 100644
--- a/branch.c
+++ b/branch.c
@@ -49,33 +49,38 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
-	int rebasing = should_setup_rebase(origin);
+	int ret = 0, rebasing = should_setup_rebase(origin);
 
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
 			local);
-		return;
+		return ret;
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	ret = git_config_set(key.buf, origin ? origin : ".");
+	if (ret)
+		goto out;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
+	ret = git_config_set(key.buf, remote);
+	if (ret)
+		goto out;
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		ret = git_config_set(key.buf, "true");
+		if (ret)
+			goto out;
 	}
-	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (shortname) {
@@ -102,6 +107,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 					  local, remote);
 		}
 	}
+
+out:
+	strbuf_release(&key);
+	return ret;
 }
 
 /*
@@ -134,8 +143,9 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		return error(_("Not tracking: ambiguous information for ref %s"),
 				orig_ref);
 
-	install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref);
+	if (install_branch_config(config_flags, new_ref, tracking.remote,
+				  tracking.src ? tracking.src : orig_ref))
+		return error(_("Could not install branch configuration"));
 
 	free(tracking.src);
 	return 0;
@@ -295,7 +305,8 @@ void create_branch(const char *head,
 	}
 
 	if (real_ref && track)
-		setup_tracking(ref.buf + 11, real_ref, track, quiet);
+		if (setup_tracking(ref.buf + 11, real_ref, track, quiet) < 0)
+			die(_("Could not setup tracking branch"));
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/branch.h b/branch.h
index 58aa45f..78ad438 100644
--- a/branch.h
+++ b/branch.h
@@ -43,9 +43,10 @@ void remove_branch_state(void);
 /*
  * Configure local branch "local" as downstream to branch "remote"
  * from remote "origin".  Used by git branch --set-upstream.
+ * Returns 0 on success.
  */
 #define BRANCH_CONFIG_VERBOSE 01
-extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+extern int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
 /*
  * Read branch description
diff --git a/builtin/clone.c b/builtin/clone.c
index a7c8def..8b11650 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -648,6 +648,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
 	const char *head;
+
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
@@ -655,7 +656,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		if (!option_bare) {
 			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
-			install_branch_config(0, head, option_origin, our->name);
+			if (install_branch_config(0, head, option_origin, our->name))
+				die(_("Could not update '%s'"), head);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_oid.hash);
@@ -1054,8 +1056,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config(0, "master", option_origin,
-					      "refs/heads/master");
+			if (install_branch_config(0, "master", option_origin,
+						  "refs/heads/master"))
+				die(_("Could not set up master branch"));
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdaf6f6..dd776b3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -446,6 +446,13 @@ test_expect_success '--set-upstream-to fails on a non-ref' '
 	test_must_fail git branch --set-upstream-to HEAD^{}
 '
 
+test_expect_success '--set-upstream-to fails on locked config' '
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	git branch locked &&
+	test_must_fail git branch --set-upstream-to locked
+'
+
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.master.remote foo &&
 	test_config branch.master.merge foo &&
@@ -579,7 +586,7 @@ test_expect_success 'avoid ambiguous track' '
 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
 	git config remote.ambi2.url lilili &&
 	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
-	git branch all1 master &&
+	test_must_fail git branch all1 master &&
 	test -z "$(git config branch.all1.merge)"
 '
 
diff --git a/transport.c b/transport.c
index 67f3666..f7ad752 100644
--- a/transport.c
+++ b/transport.c
@@ -181,11 +181,12 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		if (!remotename || !starts_with(remotename, "refs/heads/"))
 			continue;
 
-		if (!pretend)
-			install_branch_config(BRANCH_CONFIG_VERBOSE,
-				localname + 11, transport->remote->name,
-				remotename);
-		else
+		if (!pretend) {
+			if (install_branch_config(BRANCH_CONFIG_VERBOSE,
+				    localname + 11, transport->remote->name,
+				    remotename))
+				die(_("Could not set upstream"));
+		} else
 			printf("Would set upstream of '%s' to '%s' of '%s'\n",
 				localname + 11, remotename + 11,
 				transport->remote->name);
-- 
2.7.0
