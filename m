From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 02/15] branch: report errors in tracking branch setup
Date: Tue, 16 Feb 2016 13:56:29 +0100
Message-ID: <1455627402-752-3-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfFA-0004Yv-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbcBPM44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:56:56 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37178 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932196AbcBPM4x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:53 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4DF08209A4
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Feb 2016 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=I2Wv
	cSbDO8x2ms9UxsDfjCMOj10=; b=Khzdi71LqOx+T5ErParLBbrEoHqFCFnpTBYQ
	FghCVhL8/d0IB67dggTVgngQ/VKB8OIZB1Hjblg4zfmiUnrXh4R6DhMffcdXDr0s
	TYlbjAZW1+VkSceQRopDaBbslq91Iizjd7jwyRVfT7qKMrtWVGxmbDn/OcnWSKSp
	rViedQE=
X-Sasl-enc: WTYX7J6U2hVdVR/ZzfNm0cj27RALyX5+AC28x8nSCceq 1455627412
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id D83BFC00014;
	Tue, 16 Feb 2016 07:56:52 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286353>

When setting up a new tracking branch fails due to issues with
the configuration file we do not report any errors to the user
and pretend setting the tracking branch succeeded.

Setting up the tracking branch is handled by the
`install_branch_config` function. We do not want to simply die
there as the function is not only invoked when explicitly setting
upstream information with `git branch --set-upstream-to=`, but
also by `git push --set-upstream` and `git clone`. While it is
reasonable to die in the explict first case, we would lose
information in the latter two cases, so we only print the error
message but continue the program as usual.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c          | 45 +++++++++++++++++++++++++++++++--------------
 branch.h          |  3 ++-
 t/t3200-branch.sh |  9 ++++++++-
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index 7ff3f20..3b9ccea 100644
--- a/branch.c
+++ b/branch.c
@@ -49,7 +49,13 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+static const char tracking_advice[] =
+N_("\n"
+"After fixing the error cause you may try to fix up\n"
+"the remote tracking information by invoking\n"
+"\"git branch --set-upstream-to=\".");
+
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
@@ -60,20 +66,23 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
 			local);
-		return;
+		return 0;
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	if (git_config_set(key.buf, origin ? origin : ".") < 0)
+		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
+	if (git_config_set(key.buf, remote) < 0)
+		goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		if (git_config_set(key.buf, "true") < 0)
+		    goto out_err;
 	}
 	strbuf_release(&key);
 
@@ -102,6 +111,14 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 					  local, remote);
 		}
 	}
+
+	return 0;
+
+out_err:
+	strbuf_release(&key);
+	error(_("Unable to write upstream branch configuration"));
+	advise(_(tracking_advice));
+	return -1;
 }
 
 /*
@@ -109,8 +126,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
  * config.
  */
-static int setup_tracking(const char *new_ref, const char *orig_ref,
-			  enum branch_track track, int quiet)
+static void setup_tracking(const char *new_ref, const char *orig_ref,
+			   enum branch_track track, int quiet)
 {
 	struct tracking tracking;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
@@ -118,7 +135,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking))
-		return 1;
+		return;
 
 	if (!tracking.matches)
 		switch (track) {
@@ -127,18 +144,18 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_OVERRIDE:
 			break;
 		default:
-			return 1;
+			return;
 		}
 
 	if (tracking.matches > 1)
-		return error(_("Not tracking: ambiguous information for ref %s"),
-				orig_ref);
+		die(_("Not tracking: ambiguous information for ref %s"),
+		    orig_ref);
 
-	install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref);
+	if (install_branch_config(config_flags, new_ref, tracking.remote,
+			      tracking.src ? tracking.src : orig_ref) < 0)
+		exit(-1);
 
 	free(tracking.src);
-	return 0;
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
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
 
-- 
2.7.1
