From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 26/44] fast-import.c: use a ref transaction when dumping tags
Date: Thu, 15 May 2014 16:15:23 -0700
Message-ID: <1400195741-22996-27-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tl-0006vQ-9c
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbaEOXRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:09 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:58073 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so346905pbb.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inSWWH9N1DAmhjUvku6mRRmWcTZAb51Efd8eCWHLeus=;
        b=leXAC858xoLskTigNJ1tG0nZkKYupMj1QX+HTVtZzr4oLj2umZeows31PUcEThIVpW
         bDlS3aMJXdonCu47LMg7gsSaUmZjUYkEy1QJRLxrtxq5ZnZ5cvmdlCI83fCzggvZjDRU
         HZRKZYykftZ2Iz5b7b5xpUjUt31DTMN9zAMGcEwJ2/VXNsJL++p1uC1THaB1TimYXK5l
         ObBMYOCUvJHR6bNPI6E1gEFuCVTGnOj0dgd37PYCKwSazngon942l9YLUB5OAadu5Y3C
         cAmOSiSzDs7zZkQuYtWSCryPFNjIPRO8EQ81S51Qsq+x5mkbd/l4SbHFEOtLF5qec2Nl
         yEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inSWWH9N1DAmhjUvku6mRRmWcTZAb51Efd8eCWHLeus=;
        b=HIFo244SX63+8qXeJZref5L/h0p32hsEUS7hDov0LcnttVo/rdn961gro2dPzypeN2
         0dnyOIXgD14qM+sP5HU4DCMpoC/nF4Z7RxYATOMlVa2EYPvlh4H8P7AXKim0NoKoAdaP
         drP+4puAYM/pFHp3FXramwDbQmbafAfMx4IPfeC178Py27XCtde7bdUJpty/SG4nZec/
         4lVk01LSmjtE0BkE5J8M+xXIzXcq8LuYBBwflDt76bWVR3QOztYMezFYsAdFhQBLzi1k
         /RS2tUyyWWIGUos86xulxWLER0B5QspnMNqekb4pU7iZMKUPWZhl7zQu39pow8yWTCAb
         +KgA==
X-Gm-Message-State: ALoCoQnP5WlF6hIP3bd5+BFs4z85r5Jbs5ar+ZvotfDvvnWkiFkMYn3x/aHxJudXdl+9qxy9vKf6
X-Received: by 10.68.134.233 with SMTP id pn9mr6492396pbb.5.1400195745627;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244839yhj.5.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 70C4931C1ED;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B1F5E0D39; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249246>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6b186ce..6ef5cec 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,22 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
 	char ref_name[PATH_MAX];
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin();
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		sprintf(ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name, t->sha1,
+					   NULL, 0, 0, &err))
+			failure |= error("%s", err.buf);
 	}
+	if (failure || ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.rc3.477.gffe78a2
