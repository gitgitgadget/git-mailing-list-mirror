From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 17/48] refs.c: make update_ref_write update a strbuf on failure
Date: Thu, 12 Jun 2014 10:21:08 -0700
Message-ID: <1402593699-13983-18-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8j9-0000FP-FE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649AbaFLRXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:37 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:39589 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so244598qcz.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9ntM5HMDP3OPoqZUzeeIDkBjfHexuWikJ+qUKnjDRU=;
        b=hbtq9koeMfNydKBjJC2Zex+xk2b1dWSORugt7oxmKwEj+/KbHEbtIzv5K4jlZz5Peo
         UoDeWSEkBIcnfyVPEACKAqbl8Y/3KXFVXvX+xiRvjLryFag9rhBKaXlhsYQ+0/JjxbT/
         bGEfeOXHC8i4xmgZFo6TbTgARN9HUqvh+t71Ivbbt6IjV8dUPjOzMDs0TEb6E3sDjKbq
         imcfSEXQvLkCrE679ILjiqUYlGq+H6d6b61ei6V0WH2bKij2xeOoJAe1HjMfrzDHvR1u
         cFaKl/N3WFrq69nn2LWe8ODDhp+5ZMFBL+hLPq8mucqCA4RYFygOMbji4E+8fo2Mj/g8
         w5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9ntM5HMDP3OPoqZUzeeIDkBjfHexuWikJ+qUKnjDRU=;
        b=lVd55wEKtTwuwfWIYGcTbhDNfoiYE5RvJSorsfgJ6H55Sj4EL+sfjZ4pTXzYGC3WDH
         h3OQzbTTCKwd32iUDbof5PmE4d/B+qNLvNOHhE8/J3ctdxs3KFQwAH8FMfZZS9lb6PxU
         TVYIo1eFCoXD0W7O95r0wc6EJUz987I8/WH7RTh4z8tY44gMqgcaeR17jDnim4bauW4S
         43pjf4yYTUtkgI5wodWFIy8RSVEJMprqIDJpa36QB07HGAsaAPZPvqVhX3nq6PN5s9KX
         Vyj5a2nnrjDqAjk5zB/3uvYPKmq44TqbMK7uQEeiWDSVAaec2BZd4E2iuw61bvblYiMG
         B0dA==
X-Gm-Message-State: ALoCoQn3QvhpyC2JrS2RTEQqFnyVao1cge73OSvM9uYBFgoF1FjE17pTnldj8qvDOBDtuCrW0lFc
X-Received: by 10.236.35.5 with SMTP id t5mr6534237yha.9.1402593703510;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si113768yhm.0.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5F58231C65C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3BC6DE064C; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251455>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 162dc6c..a4abe10 100644
--- a/refs.c
+++ b/refs.c
@@ -3350,10 +3350,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3474,7 +3477,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3556,7 +3559,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.599.g83ced0e
