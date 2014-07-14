From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 16/19] refs.c: make update_ref_write update a strbuf on failure
Date: Mon, 14 Jul 2014 13:58:58 -0700
Message-ID: <1405371541-32121-17-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLj-00037o-Ta
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbaGNU7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:40 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:45899 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so1031131pdi.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QUKnjrdZitXz8wMVoOqT+Co92vEoWRZeQCJicdiLHa0=;
        b=GFsN/fIzsxAkkicx4ROPxsAwXAD0/Ucl6pQgfiuSobzYnXK47NV4Pld4alb+eUUZ7X
         dvJoZt5Hrwydy4uhIx1V8aVpWq6IQ7ttQcHdhJ5re6ihUQfTvPjTynLpmVn5Lz7IXeat
         4JZ9Simx3reDpGh6AuOdLaBJ+pU5d9mmm+JCETxwZEOe3P0TNuurQDoe2wJPl5HvwuYV
         RnojusnuEa68GRZZsylcqa/3kLNmIJFpPBq4zoQk9OYcnp9XiX2j8G5m1s9MRiplA8fl
         kggKSOPsAY+Em0XYsoFkqzjNFCB62XXdrGUI2SUqN/cprvAOCrBwIgC4nL5CwM/YwG0L
         yFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QUKnjrdZitXz8wMVoOqT+Co92vEoWRZeQCJicdiLHa0=;
        b=d+jqS7552ojgXEs/57+6q3GoJa1P3rTAGILGCBB4aNxj8dcfK6G6PwX1xGGYq+nFpb
         cf/cMdomM5UKVdWL3z2NAfY3PQnFcjTX+mxhAZBm/sWpdI6uveC6/0asHN/FrqmTUyPl
         oN+dGvbE229WIYot0dBFdS2yLvyfLX2u1KPPWpOWD+tRh8CpzEFp5xs0/GyRU/x+u5KS
         gLEQMXh3EsYbMxwZlkyeRnwf5t/w8hEnMQ3JVy57nHFV6X9q4kbmb/SthlmTBW7dHrkr
         j2HqF3R9++v7DixyQRaOLvTGF2ICL8tICVBVZaDVZY3UdUVmXCuZ4H/1xTvHJuQ7QGCK
         52cA==
X-Gm-Message-State: ALoCoQmzy8Iz0xC4AsuYy21J+w0rPgrFu3byD4cFfVI3tVXZbmlkPL13yVkm4vI2oFdM24rKg+OB
X-Received: by 10.66.157.67 with SMTP id wk3mr8953382pab.24.1405371546178;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si822287yhe.2.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F07945A4309;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C925BE0B27; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253528>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 115f143..003b313 100644
--- a/refs.c
+++ b/refs.c
@@ -3353,10 +3353,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3477,7 +3480,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3559,7 +3562,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.1.546.gf603308
