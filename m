From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 26/44] fast-import.c: use a ref transaction when dumping tags
Date: Fri, 16 May 2014 10:37:14 -0700
Message-ID: <1400261852-31303-27-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5x-0000p5-1I
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131AbaEPRiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:52 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:47040 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so586239obc.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aEKQ/4SUqbXwdl5TQUzbWvFv6pOJkqsif1LmQYCIRm8=;
        b=SPplPq4Gk16XeEA0GK9AaqVF+0l0vL3AIRJdC5mqMhX47S595meHqU7WUm59Dtv+Nk
         DzzCqKbFL0Vgh9fs0Gl/LZ3JfNbkPwxj7vLui8vUBuKt0hiRL/6z7HVRT/dAynyfnUWQ
         Agc91VdSue9jeS7cLV+AOu3SWkpcXDZuX6ufDE/2X4cYmTRZ65+qgudBYpE6gTPuvK/I
         afiQBRSoJXnDgcmDFO3fKTZDNqkn55ueJE/AaTRjalg0jp/Ir8g2GS3LNtyCH++s+oXW
         cVjAekYfsnxYEP5MyOoeaHWXt/cCV6dqCT59V1UVlMZfFylcj+oEJfaYCsuxRgqcsGCG
         AeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aEKQ/4SUqbXwdl5TQUzbWvFv6pOJkqsif1LmQYCIRm8=;
        b=flgFjZfboF4EOvr6MoDzwhqfZ0BCQ4bDlQYEPb2b+XNLYIVqNmattApg+FAtHs0MjI
         +aKyXRYXBXr4VlVe3OGg2dcuIB4jjeo1VwjGCOo3mJ/kLyOYs5r1VHPD1XEKQuq2s83P
         wk5CGHc5mvt/WetalORhoCE8u/91k6TXm7tL0NmD0e3hoZAS4+8B7gR/mda5xv/rwu6o
         wTVFxwSCEwLdQFmFdxrNXiI7Dm/CrduW71dhwOCl8Xg4b9PphzjizjrOegk/p44dphWz
         CBHQFxIsjL0V+mnotE8vv+egkDTJstSbHD0lL3mBmD63qstQW8u9tFto/w4603jEF8Hy
         e9iA==
X-Gm-Message-State: ALoCoQmlxwjWvYZCuJzOvhssZ/4lhGxkE8qTFa9Li86SFQcI9f4MTRjiFHu9zjJARIU8OMQX8pmi
X-Received: by 10.43.90.198 with SMTP id bj6mr7367756icc.16.1400261857865;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si442532yhq.3.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B17B531C227;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8FE5AE0B9F; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249375>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cb3f5af..9c76c73 100644
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
2.0.0.rc3.510.g20c254b
