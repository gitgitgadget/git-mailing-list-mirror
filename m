From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 07/44] refs.c: make update_ref_write update a strbuf on failure
Date: Fri, 16 May 2014 10:36:55 -0700
Message-ID: <1400261852-31303-8-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6w-0003E3-0y
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152AbaEPRju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:50 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:52621 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so586844oah.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDE3VmjuGBmKeNPSC6li36ruSgIJhmIbPkUy14cpF5E=;
        b=eRMRUBb3I8qAAZYG+DGXomkPurNs+jaBTU7pbIA3t4F1xmgJG/Q4vYhfjtLmZFiPyv
         hUf2DAjRk0JUAXfH6ok9dw7Fv+5NuYYykEEcxr9t7sdQM9KFIcvyS/WOL3JYt3N+ynqF
         jFBsFOwokcogDcuiTFfatw/TF+244B0y8csBeMeGy/J3mGcKAK6nUJyi+fwh6znDMUPj
         o6JCCMpI1TnkHyxZns2MobAd50uSaDom6fv3QJvSrioy8Mvj8iI9V0d1e6wSLjg19eNa
         MZHasV4cyz3jsXRpsTQdRFQb8OpJiGQUO+j+gE00TuPkJYSEOJW3oeQam0oS7lvneUcl
         wQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDE3VmjuGBmKeNPSC6li36ruSgIJhmIbPkUy14cpF5E=;
        b=YwqhX8zWwbMnlaSXzGUgYgmJ+0FWULBQSrjqL+SXClxnagfl5OkrAHyN4BL5p3gglM
         IUeqKCYFsv7FrgmzGzi6zqMjPBQlPOwkpTdFM0s68R31qDHU2S37fJeZoxcJedJguYK+
         CTY/OlY/rwzUY33kIswUXumi2TXXHNZnHMEcOGYfCgugz3zMhH4ZX21tDGXa4srP+iUk
         5oVlXmA6Vw2uwfMeurFtOw7e67aUH/pmz+rzO525dCBcMXIyGHfv3xSKrJKSZFLPSzbg
         EPCU1FU+jYsgo3m0+h9Pe/LR6P2rIFIpjOUPlxrIpwJ5/tjOrSpLqxJoB/CmUYleaq/n
         Si4A==
X-Gm-Message-State: ALoCoQmBFy6TZPPyn3TTKHQ75+wz1n7SSM0d98zWYf/1GpGAzSuLHPLpJnZ8QHHPPSu0bTYjqPrD
X-Received: by 10.43.94.71 with SMTP id bx7mr7709768icc.2.1400261857124;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si442301yhk.4.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F059F5A40F6;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AE538E13E4; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249393>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index bc444c7..582c74b 100644
--- a/refs.c
+++ b/refs.c
@@ -3301,10 +3301,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3425,7 +3428,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3507,7 +3510,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.rc3.510.g20c254b
