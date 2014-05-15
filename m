From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 11/44] refs.c: change ref_transaction_create to do error checking and return status
Date: Thu, 15 May 2014 10:29:26 -0700
Message-ID: <1400174999-26786-12-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUN-0007HV-7y
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbaEORad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:33 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:61504 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so636952vcb.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GjB4PVy2ck07BnRVTEYZlqgCQLDicrl3p/Uc9qOZ7A=;
        b=YLc6lq3/i8tWVIGhN2NCjhLMHdKaptpnbnQyj4+PX7UTMkR9+StqhmOWkTrtn8ooQx
         L5/nCXt3iqs5Lc1iIzzICgO8/LfmCkUDFLGkiIFzUS0P20MrxCD98kZkgGQr78hbNjbT
         nZyMUHDRGw9x/8Kqg+wvnkAXEAv0srgsBMnw8uU6onBaUHvl/b2MavBYQ5SILhtykPZa
         SxYwpQ3wXFZXibDt7EkmZvaTjeO8MrEMF8uaHL7kLBdtpyy/u+tXt6d66Qeb67VqoBfe
         hws0+EsO2IIKlhir/Wmw4J1uBlEdtm7rgmFdPvO35ul4GlyAaD7yxx8iqum53KhM7v+c
         H7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GjB4PVy2ck07BnRVTEYZlqgCQLDicrl3p/Uc9qOZ7A=;
        b=QP8hFoaTkiQsd0kjRhNjCkwJcLyNkJ+hIqKvQpkryEFi/DfkaE0Vi08kYlK15SX7H3
         ZJEd3NwmvkERk0DQeaGWraqnSKst6If2hvCE8fe9sQi3+O+QtzxAqpXmRIHHwIwwnOb/
         U+C6cvI0uThd+aHQnCNLoI57WN0C+PSijgpw5H/zdXmbQKPiigvZy+58DpvlLOqpPGEt
         A73RcRN53p/sdS4rR3a/pLCfwEXikOJfc4T/N9x7m7l4T0ysQoc5hPNXZWJoxSLpjy6u
         hdZ8M+VGUC40JTnqkOweLgfE/CqsL1qXrTFoACJBHzvld6Qo200QdHRkuOjHE5Pt2S+P
         YC5w==
X-Gm-Message-State: ALoCoQnN6XABFpwE1u/zjkXw/IWkj3hRv2gwEabQOfBT6rma1ZJWdBUEk1zjYP2JB0pdbiDNvMGl
X-Received: by 10.58.198.130 with SMTP id jc2mr5990664vec.9.1400175006411;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si199308yhj.5.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3F5FD31C2D6;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E60A0E1129; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249126>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               | 11 +++++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 59c4d6b..0924502 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags))
+		die("cannot create ref '%s'", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index e8c2345..f38d3d6 100644
--- a/refs.c
+++ b/refs.c
@@ -3373,18 +3373,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
+		die("BUG: create ref with null new_sha1");
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
index fd8d731..e3bdd57 100644
--- a/refs.h
+++ b/refs.h
@@ -257,11 +257,14 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
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
2.0.0.rc3.477.g0f8edf7
