From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 2/2] receive-pack: Don't run update hook for corrupt or nonexistent ref
Date: Sun, 25 Sep 2011 13:06:22 +0800
Message-ID: <1316927182-14212-3-git-send-email-pangyanhan@gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 07:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7gyr-0002yq-FM
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 07:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109Ab1IYFKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 01:10:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33905 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1IYFKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 01:10:13 -0400
Received: by gxk6 with SMTP id 6so3578302gxk.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3XrS5VJZ+nahiekCiAHuyucB84YwGluSq6+iiAbr12c=;
        b=F/Z0nGftSzYTGhLeWXUHAGLXmDMDozRJtWkHtlXW8xbskOTZhMd0iBNF9velh4Y9p/
         8difC2rECnSa27cmnSy4Us1htAy79iv/Ix9RdbktBqyIItVSKoHFPHh8C6vLSSf8B935
         9EunVIkds2/0EKBHuik8sSxNKOHjo86cxqSL4=
Received: by 10.68.35.232 with SMTP id l8mr20573638pbj.75.1316927412428;
        Sat, 24 Sep 2011 22:10:12 -0700 (PDT)
Received: from localhost (bb116-14-45-233.singnet.com.sg. [116.14.45.233])
        by mx.google.com with ESMTPS id n10sm57751381pbe.4.2011.09.24.22.09.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 22:09:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc3.2.g6432
In-Reply-To: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182058>

Teach receive-pack not to run update hook for a corrupt or nonexistent ref.

In addition, update the warning message for deleting a corrupt or nonexistent
ref from:

"Allowing deletion of corrupt ref"

to:

"Allowing deletion of corrupt/nonexistent ref"

Noticed-by: Sitaram Chamarty <sitaramc@gmail.com>
Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 builtin/receive-pack.c |   50 +++++++++++++++++++++++++++--------------------
 t/t5516-fetch-push.sh  |   33 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..a9385cf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -346,6 +346,17 @@ static void refuse_unconfigured_deny_delete_current(void)
 		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
 }
 
+static const char *delete_null_sha1_ref(const char *namespaced_name,
+										const char *name,
+										unsigned char *old_sha1)
+{
+	if (delete_ref(namespaced_name, old_sha1, 0)) {
+		rp_error("failed to delete %s", name);
+		return "failed to delete";
+	}
+	return NULL; /* good */
+}
+
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
@@ -438,33 +449,30 @@ static const char *update(struct command *cmd)
 			return "non-fast-forward";
 		}
 	}
+
+	/* Don't run update hook for corrupt/nonexistent ref */
+	if (is_null_sha1(new_sha1) && !parse_object(old_sha1)) {
+		rp_warning("Allowing deletion of corrupt/nonexistent ref.");
+		old_sha1 = NULL;
+		return delete_null_sha1_ref(namespaced_name, name, old_sha1);
+	}
+
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
 		return "hook declined";
 	}
 
-	if (is_null_sha1(new_sha1)) {
-		if (!parse_object(old_sha1)) {
-			rp_warning("Allowing deletion of corrupt ref.");
-			old_sha1 = NULL;
-		}
-		if (delete_ref(namespaced_name, old_sha1, 0)) {
-			rp_error("failed to delete %s", name);
-			return "failed to delete";
-		}
-		return NULL; /* good */
-	}
-	else {
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1, 0);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
-		}
-		return NULL; /* good */
+	if (is_null_sha1(new_sha1))
+		return delete_null_sha1_ref(namespaced_name, name, old_sha1);
+
+	lock = lock_any_ref_for_update(namespaced_name, old_sha1, 0);
+	if (!lock) {
+		rp_error("failed to lock %s", name);
+		return "failed to lock";
 	}
+	if (write_ref_sha1(lock, new_sha1, "push"))
+		return "failed to write"; /* error() already called */
+	return NULL; /* good */
 }
 
 static char update_post_hook[] = "hooks/post-update";
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3abb290..b7a74e3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -40,6 +40,20 @@ mk_test () {
 	)
 }
 
+mk_test_with_update_hook () {
+	mk_test "$@" &&
+	(
+		cd testrepo &&
+		mkdir .git/hooks &&
+		cd .git/hooks &&
+		cat >update <<'EOF'
+#!/bin/sh
+printf %s "$@" >>update.args
+EOF
+		chmod u+x update
+	)
+}
+
 mk_child() {
 	rm -rf "$1" &&
 	git clone testrepo "$1"
@@ -559,6 +573,25 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'deleting existing ref triggers update hook' '
+	mk_test_with_update_hook heads/master &&
+	(
+	cd testrepo &&
+	git rev-parse --verify refs/heads/master &&
+	git config receive.denyDeleteCurrent warn
+	) &&
+	git push testrepo :refs/heads/master &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master) &&
+	(cd testrepo/.git && test -s update.args)
+'
+
+test_expect_success 'deleting nonexistent ref does not trigger update hook' '
+	mk_test_with_update_hook heads/master &&
+	rm -f testrepo/.git/objects/??/* &&
+	git push testrepo :refs/heads/master &&
+	(cd testrepo/.git && ! test -f update.args)
+'
+
 test_expect_success 'allow deleting a ref using --delete' '
 	mk_test heads/master &&
 	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
-- 
1.7.7.rc3.2.g29f2e6
