From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 47/48] fetch.c: change s_update_ref to use a ref transaction
Date: Tue, 17 Jun 2014 08:54:01 -0700
Message-ID: <1403020442-31049-48-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvit-0004L4-NU
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbaFQPyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:55 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:38909 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1487176oag.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XWPh6k/vCfz3ldnlMWUYAG/GifnG8v6qhzlSZIp5+sY=;
        b=B/rPHjxoTI8DNAvCgie3S20dwfjG3fodZyAu4SHj80w7AFP1BftN+d4KBOJKNxaGFd
         QvGCUhSpLCyhC4u+mbX1lrm9lPcoX6Pug9c9sH2JgnI/0PmNYvvpwlIloMFHkI477gBO
         n9DlS67xeNtq9FfseuOzeOeoq+wlvRUn9Ov1xGNSDCLrlncvcuq7vp2NwJoZOga/RBDc
         rpJZgmT5X98OZ3yC+TawgeOcJOXz3Z7E6tg1C3/+6h6ivYsgclGPxucNW/MRksD1Q/me
         wwD0x/aFnGOmOkutBYmWkjXxw7KwP2fTQ9jRKZAdl6QqZHTJ1c/OjueV7LB0IC7coG5k
         SNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XWPh6k/vCfz3ldnlMWUYAG/GifnG8v6qhzlSZIp5+sY=;
        b=Q1qHsTS+buqOGwgGxjF4HLMF9Z12FdLkt5/L7kq0Y0Z+5U+qgq7qb+dhnzZeJU1Ixd
         rT+zegeg+uZiDT6apjUGt+pG8dAGTUgkQvAt9B+WqM/Ud4RgVggcfKSjF1oIYjtHj53/
         X8bMSgPZ4UXdsKsQIeZAwzW1qvP5ps8yko3QPCUDWHtVAyUje6CxzP/UL+pqTP5ykYoV
         E9OttD0482/kBYRfLAT69a4LRoPrAGD5tQDLGA9Sy+bUPQOlFD1jsCGdduY+t765s6GU
         LsBx6s/B+Gd/yleQlpFBKwT93h7Ze1v6VOxIeECv34NPXRoUwi+IZoZNDx7ZXZlDL5bH
         Q6tg==
X-Gm-Message-State: ALoCoQmd9fWzQfj2cQZmn/tUTjk2z0IbX+0wOXVk9g75E74vPfUPl3xer6mH9kvkmzCs1cRCsAM2
X-Received: by 10.182.123.196 with SMTP id mc4mr945366obb.41.1403020446228;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209167yhb.3.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 109E531C76E;
	Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E5FFDE10DE; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251885>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,23 +375,36 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
+
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
-- 
2.0.0.438.gec92e5c
