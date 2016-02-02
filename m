From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 02/15] branch: die on error in setting up tracking branch
Date: Tue,  2 Feb 2016 12:51:43 +0100
Message-ID: <1454413916-31984-3-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVS-000650-66
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbcBBLwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36035 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754702AbcBBLwN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8019F2100B
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:12 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 02 Feb 2016 06:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=eEqv
	rQHPYrA7CgmlwB+4fDSZaAs=; b=rhzFSNg0vLkLty2C6VbnHrwPljzQn5KVemMz
	V0ZVdCIGOYZ3hBcS1OcTmtq3J0+R620a03TBAbL1obxR6x8VCfiD9Xncim8XCEli
	OLDEP8uNCyY78BYolH7cdIWDyf+PtqGloztKfu3uTgQccLKnTPodmoBEYQHyGeSr
	ILDq7XQ=
X-Sasl-enc: coT+rkrBGF0L6injzLBCRki0GwKFQ55stIPH0RZyrjeA 1454413932
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id D8A18C00012;
	Tue,  2 Feb 2016 06:52:11 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285254>

The setup_tracking function calls install_branch_config, which
may fail writing the configuration due to a locked configuration
file or other error conditions. setup_tracking can also fail when
trying to track ambiguous information for a reference. While this
condition is checked for and an error code is returned, this
error is not checked by the caller.

Fix both issues by dying early when error occur.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c          | 19 +++++++++----------
 branch.h          |  1 +
 t/t3200-branch.sh |  9 ++++++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index 7ff3f20..7106369 100644
--- a/branch.c
+++ b/branch.c
@@ -64,16 +64,16 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	git_config_set(key.buf, origin ? origin : ".");
+	git_config_set_or_die(key.buf, origin ? origin : ".");
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	git_config_set(key.buf, remote);
+	git_config_set_or_die(key.buf, remote);
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		git_config_set_or_die(key.buf, "true");
 	}
 	strbuf_release(&key);
 
@@ -109,8 +109,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
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
@@ -118,7 +118,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking))
-		return 1;
+		return;
 
 	if (!tracking.matches)
 		switch (track) {
@@ -127,18 +127,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
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
 
 	install_branch_config(config_flags, new_ref, tracking.remote,
 			      tracking.src ? tracking.src : orig_ref);
 
 	free(tracking.src);
-	return 0;
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
diff --git a/branch.h b/branch.h
index 58aa45f..8ce22f8 100644
--- a/branch.h
+++ b/branch.h
@@ -43,6 +43,7 @@ void remove_branch_state(void);
 /*
  * Configure local branch "local" as downstream to branch "remote"
  * from remote "origin".  Used by git branch --set-upstream.
+ * Dies if unable to install branch config.
  */
 #define BRANCH_CONFIG_VERBOSE 01
 extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
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
2.7.0
