From: Andrew Wheeler <agwheeler@gmail.com>
Subject: [PATCH v2] push --force-with-lease: Fix ref status reporting
Date: Thu, 28 Jan 2016 14:20:10 -0600
Message-ID: <1454012410-10049-1-git-send-email-agwheeler@gmail.com>
Cc: gitster@pobox.com, Andrew Wheeler <awheeler@motorola.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:20:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOt3H-0000dE-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbcA1UUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 15:20:19 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36761 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbcA1UUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 15:20:18 -0500
Received: by mail-io0-f196.google.com with SMTP id h8so4829244ioe.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MHw3PrMUmkQmntWbd5yZ2/gsBxLSzEhH3pfa4bwBOkM=;
        b=H783FB14j7CULYH00bv/gfaGGlx85mwJ4diPO0vr6kGAxZvzOTbhwvRVE7GbMbRwj+
         gqH3qTg1Is/V3SAOi2I30CRDPI2NhotwHbuKWTZxsKjMwTiZgiD15lQjUL6C7BRTowm8
         vQKyJSiPmpuDmqWaKNKeaLAfsfNw0BXzqlgYgHI2J8nMDuT0xDiWQT/EYBlxY0BOsnW4
         Rtyy5vwfqwsh7LT6+glFe2nMwJTTVK7jMhOAcg8mB2O9W7dTAqgCUF/zN4Osc1Joj2kK
         gwxMFBco6saYp9ugGIiE5AFsHKATOftoOND1iEk19NTuiVuSH0CwaJSZBGcqmiESMTmB
         WwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MHw3PrMUmkQmntWbd5yZ2/gsBxLSzEhH3pfa4bwBOkM=;
        b=HXlC9SYr+xKeel1Qm++vPbEVO2Ya1Mn2rneqVJgVMuJaEi1CkpywQe2HeBpUwHVMdl
         hTW0bzi7CXRUyTuxNU1G3cTuefcR+vSaeVK+Bo957R6RT8MbwARezV5ThIwCyy6DkF/V
         HRTFkdf/pI9++3EL/2B8Bkav+SdkbczZdGBigUw2O/YaW06hns98ivAbxeRGzcw79DZm
         ID4NVq6VNl2baIFZR1n0oQSfqLrV1tOKl0dhGETduxMvJzw2X8ZDHupARUDNwRVg5vsb
         DnNoE3j346GQZg2igwvSR1ULFyw0vGm21BAwvx45Nrvxsuu8ZGdT1q5Ujh950jgJRJSp
         DcJw==
X-Gm-Message-State: AG10YOT3dNLmmnmH6ACUhozBPb5nI6VuOUNOYpLgmPGxDEnIDyihtKItQR6wp4ZoVhRZQA==
X-Received: by 10.107.131.206 with SMTP id n75mr4080275ioi.189.1454012414731;
        Thu, 28 Jan 2016 12:20:14 -0800 (PST)
Received: from mba.mot.com.com ([144.188.128.4])
        by smtp.gmail.com with ESMTPSA id q1sm1488088igg.17.2016.01.28.12.20.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jan 2016 12:20:14 -0800 (PST)
X-Mailer: git-send-email 1.7.11.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285024>

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
 remote.c            | 16 +++++++++-------
 t/t5533-push-cas.sh |  9 ++++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index 9d34b5a..bad6213 100644
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
@@ -1580,9 +1581,10 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * (4) it is forced using the +A:B notation, or by
 		 *     passing the --force argument
+		 *
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
