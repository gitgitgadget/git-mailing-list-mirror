From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 03/11] refs.c: change ref_transaction_create to do error checking and return status
Date: Thu, 17 Apr 2014 12:46:19 -0700
Message-ID: <1397763987-4453-4-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasGp-0003Ll-QL
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbaDQTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:47 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:50823 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaDQTqg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:36 -0400
Received: by mail-qc0-f202.google.com with SMTP id m20so126055qcx.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOQkY13OX18wTfQIJ/bZV1Q+UqcjJM2NpfAQiMilrtU=;
        b=XXG54DkotZS5qTvQgD6C95Z5rlxt9KbllFzQy9XioW7DYrntQRP5MIT6m1AVukRnJ8
         n26qO1ToGlgKOSf9t45XzXHqHPyDBMKLk6yw9l5AcleW3kJ1un+Ehv9cbphDRO9Pl8Kh
         7MUIDD5soFDiyFCLV5dg24W8b0c6lBUUwX4Tzh7FB+vXCT+M5JQMnY4EjZB3vnr3ir55
         ZDUw+Gf/xSH7KRPUShnRsIZm7dlZJVHWU4FElbFpRn29wcxvyY+tqx4auUEUE/rBnDPn
         4E6rUpXFp47plJuwlDMokCTtsiT+23Dw7/Sq6UaLZ4ZweB1ZrE1Wvh3+Fi48YYiKYLq7
         WLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOQkY13OX18wTfQIJ/bZV1Q+UqcjJM2NpfAQiMilrtU=;
        b=ht14fX0iLqw8SGEw0gGS0tnZslntlrr2sTw5cMwzXURqSNaTdV/cEDZE0fNRpkNEPq
         ZqPqpFWue3kYUsyRwMToVuC/n0j+XM4Rvcl5CnU/4Ie1pjqPCm7udGBHAuXHfuceP+t9
         hmw716U2CQ8FiH8inmBChrKrBWxH+Z9MhNFTmE6EyTEwq3bxzbYGhgb4GyyiyFEAiJGy
         C2K4uzc+s7l+DamYpBoCYf873h+3cNhlv1AEjGdBCtTRTS+H+tDmOCqUaWUVUJE3EGdk
         oUXID/PhRcj6Vdcp9MA8qmbP4dGW7Ikg/C50tFHYDva0dDkdS4vJd9vjFUINgNdNEvIW
         LspQ==
X-Gm-Message-State: ALoCoQkFBUVfezmlKU0wfjFvI2IA4msye1cvY3U8Ay68vCEJ7aKbDCnHaxVAIl7V47Mbh8CweIVCilhb8YVRIi9sQ4wBKPE6bQkNwVAq3FXRDg5jyanB3hzd/jep528LjvtfiZuFSC6Dffu9wFvVKrhjZoT4l75xVVI9+RRFtd/qnuMkfLJVSThcW6FJOiVV9CVNy4T3o2pQ
X-Received: by 10.236.69.74 with SMTP id m50mr7297625yhd.0.1397763995264;
        Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si180250yhk.4.2014.04.17.12.46.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 21D025A4252;
	Thu, 17 Apr 2014 12:46:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DAC80E0967; Thu, 17 Apr 2014 12:46:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246440>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  8 ++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 12bfacc..1b8a087 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if(ref_transaction_create(transaction, refname, new_sha1,
+				  update_flags))
+		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index da1761d..c46249f 100644
--- a/refs.c
+++ b/refs.c
@@ -3347,18 +3347,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		return error("create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 00e4f7b..8799e15 100644
--- a/refs.h
+++ b/refs.h
@@ -249,10 +249,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * null SHA-1.  It is verified that the reference does not exist
  * already.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
1.9.1.513.gd486896
