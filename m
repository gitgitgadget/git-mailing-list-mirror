From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 31/48] refs.c: change update_ref to use a transaction
Date: Tue, 17 Jun 2014 08:53:45 -0700
Message-ID: <1403020442-31049-32-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvjE-0004oR-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933443AbaFQPy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:58 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:55745 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so880887qcv.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lReEGurQscD2d9zjSQ1JYNMtdvbPEGG0FhJmJzE/2l8=;
        b=mL1kYsI81ouhs+Fr5Yl/O/+9hjlilDjfWNnd0ZBNdpdGHxop9yQ6cP0pA8vAlPzs7g
         OolVT5GBqu1fm0qhs99R3igjHC5kHN+EXv1C6LMntw6FXUF+lbCdYmErnMypj2UU9J5D
         weW0iNDa3C9DvE1vNh03sZL6KNH6BoSYTxripFMi7xTln01XAMeCT7N1i2grhmEyUkSA
         deYugmHgDmX+cjLBNPI85H4o6UcC+LwnVnkaU9hUz5bb3STMFBdNTHGJPgDFx2FdyQOl
         3faIj5FTZASzgOA/+Q16d3w7vPQ7T7WylnXjLozcaO4UYQba3fcyKcnGyV171+Jw0M5I
         Ywyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lReEGurQscD2d9zjSQ1JYNMtdvbPEGG0FhJmJzE/2l8=;
        b=iriUZxTF6/j9kkZhRzVsJECn+DsOnhrgifBMpgu21Dno5edmrCQWrEYBX4702LZL/i
         /sw+wR38qA+WCuPERQOwMGe+Td0PFkcfgNSwFscAoYVS4dyGYoMuoUTqiDVkJDKvNyUz
         QOxOJnzVA1PmyefsrOP+SCXO98YRhBmkN0SgU4ZmmmzzRWaSTWjo37Z4pZUC7i0f8/bF
         gcAKVHNjFOupr+RFIGF4BwCoXHa7fgG8iFIz3xsBcUX+JnpmkHmbIluuJInoN3rJO6Bg
         xhyvuvCaW0UPPp9wjTcgYDIUoEyZW9CyWg+R/AvdD/CHVLQSpPBnmJV4/A6Evi45zxcE
         S21g==
X-Gm-Message-State: ALoCoQlefr9UnXgvFikofkJcq/ThS57nzECiiC2+MzIKXKM3SqdJPp+L8Br/NRmaq+YLgOJgYTkJ
X-Received: by 10.58.178.39 with SMTP id cv7mr1876936vec.9.1403020445493;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si1209971yhm.0.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5564431C76B;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 33BBCE1354; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251891>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index be29f66..af211b6 100644
--- a/refs.c
+++ b/refs.c
@@ -3547,11 +3547,28 @@ int update_ref(const char *action, const char *refname,
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
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.438.gec92e5c
