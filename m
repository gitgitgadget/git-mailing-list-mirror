From: David Turner <dturner@twopensource.com>
Subject: [PATCH 24/24] refs: on symref reflog expire, lock symref not referrent
Date: Thu,  7 Apr 2016 15:03:11 -0400
Message-ID: <1460055791-23313-25-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDl-0007MT-0p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbcDGTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:53 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36046 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbcDGTDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:48 -0400
Received: by mail-qk0-f170.google.com with SMTP id i4so34930928qkc.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTTm6VCEvyHqcI2TCf9PqEAI15H/CuJzqPOiC90xYmY=;
        b=ksY2awcml3uVr3ony4qGX1Xv5dBXxaC2cqM8tENeE1HpjJDpp3gtzPEpSf8NGttX7U
         n8OZYjP6pfFv5CnzPeAMYHBeJuokd+PkpZ7EqZeqJx0RmVU09jNJrXIHxvocHxN5tgP0
         dCqCfM685i+0XBnQpMzoG5+GmmrUZ/AZLACladFkJ7sQMT3c5YfPdZHA6PsYoOpE2wOW
         nKy3kcfDs44n2dij/s84R0K4IWZUMDoTzl4AAHh3wn/F9AiM7RZ11YWzXtCPJc971AKX
         nISBbvzwAP3JXen71Q7/Ag+TqPAtOC6Reo4xPOiq1D5Ehr3B9hzeYnSHh2dHHZ8BHELw
         uANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTTm6VCEvyHqcI2TCf9PqEAI15H/CuJzqPOiC90xYmY=;
        b=Ou25aUncql2u4HlsMmkPs6ekRD4RBvxFeDJLYrZhVijEU1NXnDK0Uku+AjwsChSYdR
         OGoDI4KYAok2nysKe6bjX3a1iIoXJBM4uPJXZgycbID3kvSa9n7ljdku6ttrMSkylOdf
         v29uM5I9LcmUmD5rClGDVzp4gCtnzjBbcfn6Sy3jaQwbPp9KbJbFFX0hK+v/M4tigm9m
         w9j/d1MJbvbHbL7CcpWpxHIQi9gIanF7THIEdndcaDw4VWzT/QJwGBCc2fMRcufDy06m
         1Z2TkSvwKPH64kJrSvRNZw29NRxqsumHpV9dv8vY6Vu9X2PKMt620kON4vgZ2Ifd6TWX
         JBEQ==
X-Gm-Message-State: AD7BkJLtoajZCabCLzLIfFt5U6bvn1LHoU/QVcFHvfAybVW9n+5c8UVD8SedYclSVrUNjQ==
X-Received: by 10.55.77.216 with SMTP id a207mr5971606qkb.80.1460055827286;
        Thu, 07 Apr 2016 12:03:47 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290965>

When locking a symbolic ref to expire a reflog, lock the symbolic
ref (using REF_NODEREF) instead of its referent.

Add a test for this.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c |  3 ++-
 t/t1410-reflog.sh    | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71848ab..5e67bfa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3314,7 +3314,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index c623824..9cf91dc 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -338,4 +338,14 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'reflog expire operates on symref not referrent' '
+	git branch -l the_symref &&
+	git branch -l referrent &&
+	git update-ref referrent HEAD &&
+	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
+	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
+	touch .git/refs/heads/referrent.lock &&
+	git reflog expire --expire=all the_symref
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
