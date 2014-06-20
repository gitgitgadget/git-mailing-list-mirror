From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 30/48] refs.c: change update_ref to use a transaction
Date: Fri, 20 Jun 2014 07:43:11 -0700
Message-ID: <1403275409-28173-31-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04u-0003ML-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbaFTOpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:47 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33234 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so505981vcb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUXB6ZYdY23GzX1AkB/FQbxuvvtfGfYKVTdn+8t3TeA=;
        b=jnJo+e9gzbf/xTl7ufWHLzzouqChH7EXBnvv4nFXnpOZTPkjbNTVkO9GPZ4F23lj09
         tdHaul0iz+y28IajYJOXY6Edh8mY/x65NIubhbOqNkjo8GpKLuvjJF0+sIyecoewy6FU
         Xhn/ix7u6IHeIGk/KEadFdO8FG1sntnNn6wltSAe0vp0rjES5dIRc178spINWptTWp1y
         t5qw2vTieeGKe/JVaruw2owpIduAaedwFuDJO7SM25IsrcqMtvAVC+TEbrvXSkX4TKwM
         OQKWFuQyhCHx94g2/PNleNrDqjDxz9FkcZZjxSvvjXOOqbO/iqnGLUC2cSrgq30npOaz
         H7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUXB6ZYdY23GzX1AkB/FQbxuvvtfGfYKVTdn+8t3TeA=;
        b=FO/Ydm9ouO0XljylViBMgKoo69TkcbXOJIWFlrVpr838uo9GLn9/pCbj4HCo4CDYN0
         YU3jomOs4MMwcWidjq869AdZqxi5CYRLD7FCLbTsWtU7Zprg4gdQKM7C/FvxZXWIUGXP
         /3HVrZsQ2uENVad15G1hjbtAzs89pIxD7saosVWWz/iyYKoHuu2bF4LAkn901az3L8lR
         RUE+DLYvL0efxxE/hMTawmUQEjk2+BiUm1LWkw6ToH4JQoi1nZmkkInDVsZvKVmP+Fyf
         xxoReRiElNjETHOl0SfZkEuYOiU6yci1peejry6pLv0MP5qsnRL0Am8sm5mfg1X3zpyS
         zing==
X-Gm-Message-State: ALoCoQkKtOeuz9N6S7CaoDQtK3Buz0HsBYzROVAecSGBvXR/IpZL+Imd/NCrkoDyuB2nik6r3WJ8
X-Received: by 10.58.199.135 with SMTP id jk7mr1514538vec.22.1403275413331;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si663697yhp.6.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3203D5A43E3;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0DD41E0769; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252254>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8c695ba..4bdccc5 100644
--- a/refs.c
+++ b/refs.c
@@ -3524,11 +3524,31 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.420.g181e020.dirty
