From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 07/44] refs.c: make update_ref_write update a strbuf on failure
Date: Thu, 15 May 2014 10:29:22 -0700
Message-ID: <1400174999-26786-8-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWJ-00030c-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbaEORcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:32 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:45727 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so255932pbc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i/Fn7xs8D2edHv7kNf56hbh4ClnkjhU1TazhoORbLUU=;
        b=QGyur0gyVticOVhRIWVzsNd36kx8qd8z7xD1QdUsG+eCe0WzvS7Kot1rfv5IYiFb04
         Z+6dzgJcdBfAQXopPoC4SG6m3lBUatnHoMITycOBDFAqCBQITcpOcvNMuLFyvAxRHkV5
         BSqfxPlfr2WmQaJXWDSd4qYQG2gHt/fjJWUrD4/+6YXCR6/QTQ/7Xx2RDelkYXK61c0E
         wSAhXWptkOH0yyF/onGa096CJo7b+B/IPP6mSmxEFrndIClrTr7w+R31KwWhvkmed+I2
         55M14O3BQjfkHmH3jaeq2cKJ7fWriT4/Ms6TunXk2OUsWpNi9VOO4AdmG7l3b1QgCy4o
         qMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i/Fn7xs8D2edHv7kNf56hbh4ClnkjhU1TazhoORbLUU=;
        b=cl5D9Cs0YMbs0eS5fKhZuJxpmC9cKDR6ODzm1mX0gb7SXTHn1sgxT9ErJ8EGTDjZUh
         4/poLux/rPCoK9BvPt1duH4xYgN6ONizHjmZHvoUuiyA3TQOTOL/Af4EETlFwyEyJf+P
         C6jci0+MyJTdnS0ntSGDR/QoaZWQ24M8W92s5fFHRBv2xxHtkrVZcT6WLiBISM5Sbdh2
         Y5ztd7nUNqKuJHiNNLTm1eU2YwKq+raHy7WTx+0YOT24qoAFFybD0xpvCiyfJy7WxnGd
         3bgBaWKLJSW5qg3CzTGzYPc6Kfj8sKh2JZX4IKjIHMj00OqM3n3UEsOkIthdbCCcOOFg
         H0qQ==
X-Gm-Message-State: ALoCoQlGm3HdzdVLtdR1rmDUnqw/szvVaO0uNHo492Vn/fuGQEVA8m7gOc3UgkFdxK4HFMi6Qe+G
X-Received: by 10.66.141.135 with SMTP id ro7mr5456910pab.28.1400175006228;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si273161yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 105DE5A42E3;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B801AE17B9; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249160>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index a150520..18dff1b 100644
--- a/refs.c
+++ b/refs.c
@@ -3273,10 +3273,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3402,7 +3405,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3484,7 +3487,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.rc3.477.g0f8edf7
