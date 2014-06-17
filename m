From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 33/48] fast-import.c: use a ref transaction when dumping tags
Date: Tue, 17 Jun 2014 08:53:47 -0700
Message-ID: <1403020442-31049-34-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvie-00041f-7M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244AbaFQPyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:36 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:48389 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so7526qgd.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=clooxWm50J2lgRtz4boZTIx3bfj0LV+yICedqEGhakM=;
        b=F8M0X3T+rzstO1Ljy4peraWmtjEr32WYiiikNa1GwGxiy50KsNsCd8vz1DRWKTrbTD
         jTpTA1bhztd/mo1aiaPUAueavhN88zBaQlI/6MzW4xJBycbaLY/4Ars8GsMRvGS69UGp
         QbXOhHxiOexYyFbvF3hx9VHZfON2JEk0plffMfMRarNXhulH9yYIqH1liuKEjS51krLp
         OGylvZ62N5vHTMnzrKUkCPJ/ZrOr4CF+C8CkBL88M/DZ5EMkeHGfITv07l35cU1/k2Wb
         VzG/XzMx6Ui+/P3wkwatO0VVnuQ+wEyUv9dQ9z8U4Lbcxp2xegNMjKdLtawSYMAIRrlt
         XCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clooxWm50J2lgRtz4boZTIx3bfj0LV+yICedqEGhakM=;
        b=e1uwcQW38tMlkjLVKKclEK3c06dVquXEP2rttt5d3YTc/ZpUvl+z99VOpddRcVfv1G
         MI5Ly052lZQaF3IPH+gGNaT9zvTcmGEuJjtlLePe4cayiWbGfzA/HtjE6gYTn8TdFLtG
         Gnex3ypacHJNusDG/B7CKTKZuDTQ/T21S8g7NTiJMuiD/GxN/Mwwmu6v5obPLbNa1pUI
         PpZw0/XYbzoxw5pLQsyaCV3Tx+JZ4rSNgqOzvPVqJiXqzlMTUWUU5SkBlk7btXqAeLf/
         noKcOUvGbZex4DkAvqomrPoa+awoa0pHSAXii0GSRn634RNU8B7PNdiI/XTijTRnVNyn
         /3bA==
X-Gm-Message-State: ALoCoQlNx3TKf0XMyy8IoH4oqPMrqv0leqkeDlur0wx4GLpKLDvtc1S9eL0201qQMVqUPZCxTEas
X-Received: by 10.58.48.233 with SMTP id p9mr2925496ven.31.1403020445734;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1208592yhj.5.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 940DB31C76C;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6FE70E036B; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251879>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cd929dc..191fc47 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1734,15 +1734,32 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
 
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
-		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
+	if (ref_transaction_commit(transaction, msg, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
+	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
+	strbuf_release(&err);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.0.0.438.gec92e5c
