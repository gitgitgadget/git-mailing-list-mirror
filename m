From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 17/48] refs.c: make update_ref_write update a strbuf on failure
Date: Tue, 17 Jun 2014 08:53:31 -0700
Message-ID: <1403020442-31049-18-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:57:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvl7-0007Le-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbaFQP40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:26 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:62923 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so361366igb.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9m2B30s6SD4Ldr3CjTXL/Yd6c6HTnjSEjhNBuBG0Za4=;
        b=gDgcGKYJ+4Gx2Ebndd+qBDhl2cK6qeZKCNX1CHEwsCVN5e3BKD5OTu+JRlZDMWCEFA
         LBijUJl4ESm3Kb4NzSxVngoFYZJLHXphwxq6Hcj5J212VO74gh7doQQCOuqh62QGsZIs
         g4PXcfEyL6pac9VwYxhvy9yLHgzT5rPxbRkCzouEueLatPK5592p6HqfdAR8soW4TDC+
         FJQK3Vw2o+ldHFy7nJ8zg1xkgBhF2fqhyER8j1gIKlwOyvnjTuO4Zv+k5njPLgOUM4+B
         kaBpEAL14q3uEIzSrK7XeaniDOSrkLoL5yYmMbcRHd6ExVsKDmhnY8XaCmpJEmZlILGB
         0VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9m2B30s6SD4Ldr3CjTXL/Yd6c6HTnjSEjhNBuBG0Za4=;
        b=R4efXLRVsneCmNPJiP/byXBJMie/P+1ynZK/eJWLcyrV+zprbdLyih2Vbn5kzpZHUD
         YsKKHFunNO7Kx91U5oYOd9ffIa5BXqEr8Cauh8wkXmEIYT8422+pf/Hh5uoeSkd/nJdX
         t4XuzTxb6Zn1bHgQV66Sy9tfIZYkUYL4m+e/d7R98TZrod3xT8oJ8imiSJYZrR+xmK+x
         S5LComLd26+cnaZKIf0UrjQ1rXvew3qNT8hahUIm08lACTK8RMgdke574b5g54Y1DBCQ
         sSaicCVnhu8ZoHHQQl/9X3216DsZFoMFgnAhGmqAT/VUSPcsfBZM6fxItGa1Cp6upmZy
         nRbg==
X-Gm-Message-State: ALoCoQm/HJFBKs8G9JxlMjJWH4xA5x4/qGqYXr/DDwLpfimVxIyyUJf0iasT6hvROfpHLmcguXdX
X-Received: by 10.182.121.232 with SMTP id ln8mr2048277obb.11.1403020445042;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1209154yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DA0A85A46BB;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98619E179B; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251908>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 7223542..4ce8959 100644
--- a/refs.c
+++ b/refs.c
@@ -3376,10 +3376,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3500,7 +3503,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3582,7 +3585,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.438.gec92e5c
