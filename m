From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 14/40] refs.c: update ref_transaction_delete to check for error and return status
Date: Fri,  6 Jun 2014 15:28:52 -0700
Message-ID: <1402093758-3162-15-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2dw-0002LL-IC
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbaFFW3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:32 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:43610 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so741434oag.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8W2PYbtVdSyLFaWc9Dd8RJ9ERUa+7/lo0/uQMznRCls=;
        b=YswnrIq2gWhJFP8WuYwRc4VOJIHb1yLQLY4Bicg45fnC+c08mP6fXBAMtqGwInG5x9
         I+Pe90ziKRuhfU7SrbSKRg9MpU/uDYUbhJp/l0dn5+cXYXKghX08FPq8SkuIhB/dEYiq
         JaQTd3Dj1QBRONTfK1dP34kiEpDu0ohwjn11rRVAy/sCFE0EYuFcOw62CcJa9/7yAFa6
         c+PnVAnFIG/XSJ69mRFIiBPd1D3NTd3XwpC37vJQ/y0n+N+ZJo/vuvCCOOE/EsIz2a3G
         51g/O9PKWI+o9+b0WjvaG88i8qwUUP9KGeNzBFp0cJXOH/c681mvy1zmUoWXFf/Qov+/
         wr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8W2PYbtVdSyLFaWc9Dd8RJ9ERUa+7/lo0/uQMznRCls=;
        b=hijRr2KQzgMsngcC26Hkzcn5T/7q7Ejvm2U+3jHnN0HpX7MZUqPcUVx7Rjev14nB/5
         v00IbvJ1dZ0zx2XD+r3fkpR13tonEnTfPc63DD1j3RVZLklvyfhMExm+wheWWRJaz/5R
         mvyZ5M+CdcchQ1Mygo8DDYv5dsHnXv1SrrgEVDzs//TKaSUTJpn3JCER/eF4oqOf9t3c
         tKLr7aJuXKhIlOwdQJYyB3JTIWpWst41Si0WPkxJwz3KRvNl4QVhhyXFu45p6412o1yl
         swFZaJgLbDQ9/Nt54Cd/Yv55EgCH+j5X6X4CuvsEy+2F8nFf7+hAymHRo2wp1LJyG3kj
         ij4A==
X-Gm-Message-State: ALoCoQlbzJ3Qg9PNYyaH4V4/lsswHH6DahA/+/kRvrEQuB2McwQigUYmI/kqh9T96w0I+/E7XrT/
X-Received: by 10.42.26.77 with SMTP id e13mr4558389icc.7.1402093762258;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750431vdb.0.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EBC3731C62D;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CA55CE1167; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250979>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 41121fa..7c9c248 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 3cb99f6..d9b99c7 100644
--- a/refs.c
+++ b/refs.c
@@ -3459,19 +3459,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index bda790e6..58ba365 100644
--- a/refs.h
+++ b/refs.h
@@ -303,11 +303,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.582.ge25c160
