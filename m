From: Andrew Wheeler <agwheeler@gmail.com>
Subject: [PATCH v3] push --force-with-lease: Fix ref status reporting
Date: Thu, 28 Jan 2016 14:28:18 -0600
Message-ID: <1454012898-10138-1-git-send-email-agwheeler@gmail.com>
Cc: gitster@pobox.com, Andrew Wheeler <awheeler@motorola.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtBG-00009g-7X
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967691AbcA1U2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 15:28:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36697 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933476AbcA1U2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 15:28:23 -0500
Received: by mail-io0-f194.google.com with SMTP id h8so4846248ioe.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v4v18FgSwsw0A5/l6AdzUZsMo3nqdJPCh1GvNriykgk=;
        b=eM1BMzl9T+SsY/n6X4+PdY5MGJBx3TuaQXJOWFwpAenAApZ+0PxjNsh5s7FCMIXMPv
         LFtNtsID6B4cU5GkISHRXpQl/kP6lSd44PqOZVvWzHOVggFF6y4zUzZSrRIFy3vw0qbg
         XtWBGVjWO4m6pFYpAfsucKDGPquoDODqwQlc8WqQci/kbdrIlC5WubGTVhIG/m460n5N
         RAJ15zGZ1tMOCd3MGMKa5SHcaIWT35tOEuMG9gGAYOeRJ6CuvqTXWcytHQx6UgMmVp7g
         stTnHEmRTaU25cFte8LpyKHtuysAZ8X2HW4M8Rt5I4Ko+Tp+5q1Q9GOsnuxdb2oFrRTn
         yMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v4v18FgSwsw0A5/l6AdzUZsMo3nqdJPCh1GvNriykgk=;
        b=Jl/Q2Ol0I0qYUsSO+QuhYT75TRDPmfafT4OXIRqV6liU7QDdhQpaTiJvzPZKn7kg/u
         7j3j2RJM24QZ79nB2Gy31kQJmqq1yZZvnB4cAKhJGsxtyULSwomGQnz8qNcdg80Ronfg
         Z3pxPNkEzE/Zjxai9YPmZbkcudrI1ZLU53i1orQElk/QFoQ7ZzlZMeThv9BL1uEc9jBv
         FhDx3Qx3KAOPRMKYziPevoK6VQwFrWP4gJdtEULAtLPQA4PgBolsb3H1GOhfDT12ILhH
         mrbSL1g7BE/gthT3e51+mWsPqDJGMeYFTvzyluSzwBeKnrsoDWNdW/U3KbSjIyEaNmJW
         hB4w==
X-Gm-Message-State: AG10YOS571DxuDqr2S6+gqf3kqMDRKEsVhydVlc4Fn+tZS+abYIuDHKm1WX/UGhfNyrWqQ==
X-Received: by 10.107.186.86 with SMTP id k83mr4884795iof.135.1454012902019;
        Thu, 28 Jan 2016 12:28:22 -0800 (PST)
Received: from mba.mot.com.com ([144.188.128.4])
        by smtp.gmail.com with ESMTPSA id i70sm5096438ioe.40.2016.01.28.12.28.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jan 2016 12:28:21 -0800 (PST)
X-Mailer: git-send-email 1.7.11.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285025>

From: Andrew Wheeler <awheeler@motorola.com>

The --force--with-lease push option leads to less
detailed status information than --force. In particular,
the output indicates that a reference was fast-forwarded,
even when it was force-updated.

Modify the --force-with-lease ref status logic to leverage
the --force ref status logic when the "lease" conditions
are met.

Also, enhance tests to validate output status reporting.

Signed-off-by: Andrew Wheeler <awheeler@motorola.com>
---
 remote.c            | 15 ++++++++-------
 t/t5533-push-cas.sh |  9 ++++++---
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index 9d34b5a..3ceac07 100644
--- a/remote.c
+++ b/remote.c
@@ -1545,11 +1545,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		}
 
 		/*
-		 * Bypass the usual "must fast-forward" check but
-		 * replace it with a weaker "the old value must be
-		 * this value we observed".  If the remote ref has
-		 * moved and is now different from what we expect,
-		 * reject any push.
+		 * If the remote ref has moved and is now different
+		 * from what we expect, reject any push.
 		 *
 		 * It also is an error if the user told us to check
 		 * with the remote-tracking branch to find the value
@@ -1560,10 +1557,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			if (ref->expect_old_no_trackback ||
 			    oidcmp(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
+			else
+				/* If the ref isn't stale then force the update. */
+				force_ref_update = 1;
 		}
 
 		/*
-		 * The usual "must fast-forward" rules.
+		 * If the update isn't already rejected then check
+		 * the usual "must fast-forward" rules.
 		 *
 		 * Decide whether an individual refspec A:B can be
 		 * pushed.  The push will succeed if any of the
@@ -1582,7 +1583,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
+		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_object_file(&ref->old_oid))
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index c402d8d..c65033f 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -101,7 +101,8 @@ test_expect_success 'push to update (allowed, tracking)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force-with-lease=master origin master
+		git push --force-with-lease=master origin master 2>err &&
+		! grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -114,7 +115,8 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 		cd dst &&
 		git reset --hard HEAD^ &&
 		test_commit D &&
-		git push --force-with-lease=master origin master
+		git push --force-with-lease=master origin master 2>err &&
+		grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -147,7 +149,8 @@ test_expect_success 'push to delete (allowed)' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
-		git push --force-with-lease=master origin :master
+		git push --force-with-lease=master origin :master 2>err &&
+		grep deleted err
 	) &&
 	>expect &&
 	git ls-remote src refs/heads/master >actual &&
-- 
1.7.11.2
