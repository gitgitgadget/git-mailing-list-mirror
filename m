From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 16/48] refs.c: make update_ref_write update a strbuf on failure
Date: Thu, 19 Jun 2014 08:52:58 -0700
Message-ID: <1403193210-6028-17-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeet-0006GL-M0
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005AbaFSPxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:44 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:57473 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757790AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so330803veb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yL/aunZGkFbNMB42L9cXr2lOd1yN1r78utnO2rfB6N8=;
        b=hI2Aubw3IIfRSwe/n37eAVhn1FJ1sVQkNy5uq3oQ65FmmB/vm/XGoIp0RpJlCvtNiQ
         5vFfdSOleyc0aHNL0jRifXwB+yl8FVOGYh1x3YnB9L1MkfpND0vm06WY4OlFr09yC2lc
         USYCF+zxJ9QAFqNTM/EyiOuXLRQJ2N0MrsggQy6mK+0vi7pVsSdhVVCfGkbTd3RLiLxS
         BXdZIDYgjbuv3CUNpD7x3H9OZkVbfp6kHSO9ocdlAh3R4dSrrMNHKwa6edpzz83NmScv
         nEZWj6VMlUZtMagswETnxItVWwAGs9ne5ryPXS2HBeeZMieQHy8f3I8wIIduEokKyFOp
         V/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yL/aunZGkFbNMB42L9cXr2lOd1yN1r78utnO2rfB6N8=;
        b=OufV47NarW8Aih6QVv/m9OmLk09wP50mGjzF9EqexQfFKmtbyj9zZHRusAkLWxsshF
         4xr3nnpnoBvQFFzLZJRxX5JXUUULYZzlRDTCNTumGG4kbzh6RaPupF05tcV62ETXVANg
         BbPCikYIqeSz1LTjQ8TEwnQXSRhdgpXaDG8HO26OeF0jOF1y1DCMv8lUPX+p5pinfMB9
         T3NGTIyC3tNcTDXuoQMbJi/bsUXEczJF4T5kLcTmbT0GTVs9CR1Gp07zDUF+3Uft4SWb
         CVfARnRD9eLQBV6vcHN1X/AGtbXyTbbZzpASVuUyYEmLQY51vvM3hjE+m4Sn2wzB7BFb
         9R5A==
X-Gm-Message-State: ALoCoQnsGNqLo+v3dABPbPmMympycBT+DkB4aFoEepIdvZ255cwlEH+3N4XZdHOqp1l/4uqlUh2P
X-Received: by 10.236.117.11 with SMTP id i11mr2381539yhh.0.1403193213318;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si421014yhm.0.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 30B8331C2E6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DB30BE1B1A; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252117>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.0.0.438.g337c581
