From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 04/13] refs.c: change ref_transaction_create to do error checking and return status
Date: Mon, 21 Apr 2014 15:53:22 -0700
Message-ID: <1398120811-20284-5-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6I-00080Y-A8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbaDUWyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:05 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:56349 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbaDUWxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:40 -0400
Received: by mail-oa0-f73.google.com with SMTP id m1so463643oag.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=461Oa5faVR4KhuTp+0CKr6HgzUkn2ws+qOZ4i5nhhB8=;
        b=WgpOD0mAIGLwXWRt1d8qwLwgmPenx/h2Nz7e5I5dXL5Shz1ZK1Sw8wV8BgB6YCBW62
         PPpFhEsRvfrNPKMdZ3qDFEv4IYEkl9PCs2VGSXf12daY9IIFk09sTbbV0/OatTeV8FhK
         QAMs3mlQM/uCCl1JSjB+KeVay2EE15694CxBqpzu0F66+PTHZ2GPvRBvADT6dj/0S5mm
         +IDrPvA+xC+doZvKwJly0Le7bBIR3S4CTm8KE9xQH5E2TkUqBLAYniXX625JxKykxwKt
         UwcL86QENxrH5ATxEA/jPdxLVrWwegSnfZkwYiH83HJaK4hWGpok5pRAnPu7gMJG/zYb
         kUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=461Oa5faVR4KhuTp+0CKr6HgzUkn2ws+qOZ4i5nhhB8=;
        b=TsCHKvjlG0N7P2lc6hONquIx8/aXrT9EgubsMlc6AFrCKEZ2JkjcB0YAwvsGtfcIN8
         lItcQRSi9x43C8sb4A+xt3PT/nJkPBRNjz5ULwRHRE+P3x4pPpqQaCzceK527mWeArEK
         0yHO2rtp2vL2lCLIRpqEBjRUWRw+tDmWC8N8lTOxGutadl1wIZ7UzY3inM2ckdW98DYD
         1EEov6wz7WJaNHssAA1ucw9XwiGvMJQ6gfI/yth0pzA5+eDTFCSGx9ADhimRHiy+zvn/
         8cWzMZ5KL2IniCtnqMEiKzjgltizyrY5NKJ2K4/dgf2abA0wpMkQr7DBVGBIPyXfNpXW
         DAPw==
X-Gm-Message-State: ALoCoQkLBQTIGkBZ3SuP8kdEKPQTdlYjm7goqp2mJ3TidcqSnZyhMS81Yg3UTthuwWLwHhUbd92zSq+1lFy/4/AsLUfJQuTFr+7xPjv4oH1LXIjWtud/jDmldK0sHbvAkU+UyeMCZE3IZZ5ciG4KgqGW5MLDUzhhvO4uUphwpUvUe8tbJ9T0Phdgc4SPzhHEpazWe0t0phdR
X-Received: by 10.182.106.229 with SMTP id gx5mr13881034obb.31.1398120820131;
        Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si5366643yhb.6.2014.04.21.15.53.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F282C5A4207;
	Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B3728E06AA; Mon, 21 Apr 2014 15:53:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246663>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  8 ++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 811e0b0..7d1e0c0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags))
+		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 8c02779..8c728c6 100644
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
+		die("create ref with null new_sha1");
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
1.9.1.515.g3b87021
