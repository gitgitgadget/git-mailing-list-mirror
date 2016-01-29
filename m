From: Andrew Wheeler <agwheeler@gmail.com>
Subject: [PATCH v4] push --force-with-lease: Fix ref status reporting
Date: Fri, 29 Jan 2016 17:18:42 -0600
Message-ID: <1454109522-11186-1-git-send-email-agwheeler@gmail.com>
Cc: gitster@pobox.com, Andrew Wheeler <awheeler@motorola.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 00:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPIJd-0003CN-3a
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 00:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbcA2XSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 18:18:53 -0500
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35590 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbcA2XSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 18:18:52 -0500
Received: by mail-ig0-f193.google.com with SMTP id mw1so5931igb.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 15:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=e8nDuW8tZs+vQPoGiODarB6ZOmj72rzfTPx2fWq/NYI=;
        b=BXVU2CpzInKEGUJAVCphbP+bwIUKlkNdCmbljrAjcFlADy0ilke+j8sKzaswVqRJxM
         B8qCYARErv+HymhDn/7z9GgQQQPi2J6cwBeYmrAsR+GxdRgA6fpse+wXpSJQn0lL03gr
         g9Ayt5ASXl9FIqAjxlToYJKrp6wctmTeKKV+G/q4Y1X9NFi8d9I+Ca1pEDJ6cUoxcNwq
         xA7rZIvNkE2L/2g+jL3ks+CYFE75FRnH3HFlpPou0V+nd4l7//tJjxt8P4FS/1Zq3pPC
         Uv1/C9VM8b4VFmPzEqHcRruUVitbd1dJ770MPIeiWgBh8/AJvJgvi4t8pohDvCqBCPd/
         lCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e8nDuW8tZs+vQPoGiODarB6ZOmj72rzfTPx2fWq/NYI=;
        b=VkmfYJhmrRXA03vlMpjq/BNUFiqF8AfOAKtnEJndmb7VhA2YBpHHfQ9l9gldYeXlbs
         Goj0hMxF1gOm37hT257TXMCc26GuvgjWm723r/GBp+7cU1GowDJxENbkk76auc3nH6Qy
         Ix1lNtLnGdL4Dhj4Ea3rxGGxvoL97SOU0myjPf/F5byR08iFB7/IZJBpuyDcm37JugXQ
         oVHZ355+SDqtwhUFbk7g+tBv3X0TLPkcwqRSFantNUe2/zAciejgGcCttcuRMLthXowa
         hOtFcZ+4t3Fzw5fzJg/d/KErq/FEMWNJXNkLOBcWxmSc4Gh8ODA1j61Z/lu4IutwRgU+
         D55Q==
X-Gm-Message-State: AG10YORndYWC4lMfYc9rH9uj8/6h6kczdRoM8ojOVoNJ8UJGRyHfQGTU4ZAIu7QcqQ63Ow==
X-Received: by 10.50.134.129 with SMTP id pk1mr12609256igb.11.1454109531582;
        Fri, 29 Jan 2016 15:18:51 -0800 (PST)
Received: from mba.mot.com.com ([144.188.128.4])
        by smtp.gmail.com with ESMTPSA id qs8sm3467499igb.19.2016.01.29.15.18.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jan 2016 15:18:51 -0800 (PST)
X-Mailer: git-send-email 1.7.11.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285097>

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
 t/t5533-push-cas.sh | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 12 deletions(-)

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
index c402d8d..c732012 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -25,7 +25,8 @@ test_expect_success 'push to update (protected)' '
 	(
 		cd dst &&
 		test_commit D &&
-		test_must_fail git push --force-with-lease=master:master origin master
+		test_must_fail git push --force-with-lease=master:master origin master 2>err &&
+		grep "stale info" err
 	) &&
 	git ls-remote . refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -37,7 +38,8 @@ test_expect_success 'push to update (protected, forced)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force --force-with-lease=master:master origin master
+		git push --force --force-with-lease=master:master origin master 2>err &&
+		grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -101,7 +103,8 @@ test_expect_success 'push to update (allowed, tracking)' '
 	(
 		cd dst &&
 		test_commit D &&
-		git push --force-with-lease=master origin master
+		git push --force-with-lease=master origin master 2>err &&
+		! grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -114,7 +117,8 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 		cd dst &&
 		git reset --hard HEAD^ &&
 		test_commit D &&
-		git push --force-with-lease=master origin master
+		git push --force-with-lease=master origin master 2>err &&
+		grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
 	git ls-remote src refs/heads/master >actual &&
@@ -147,7 +151,8 @@ test_expect_success 'push to delete (allowed)' '
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
