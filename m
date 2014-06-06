From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 23/40] refs.c: change update_ref to use a transaction
Date: Fri,  6 Jun 2014 15:29:01 -0700
Message-ID: <1402093758-3162-24-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fv-0003X3-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaFFWbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:34 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:46723 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so740490iec.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O495Wa6swYoYxk/LAUpi4Xwbq+ttYVsFyz2e6uK/hBI=;
        b=pqd2PEvF7t7ta5HwZZIbOe0m78Y1+mmnbhHd+Cj/cd3h85BPF2LUxsXpzoydT9fhX1
         ztTslTROQf6eQA/LJfVLS3Lxs+hEpw/Vo/W/U9Mk8383+8WhoZ9UKUSBtyrc2g9NOh65
         emG5sP+5vD+ZwEhMOGLVV5QVFY/BwEk7ausN5XXwd6ZBHKM3aQL3MnqsUnvdmcNmR9Dm
         ms4n11VZrnEvlV0KjI/k5df5+cGMlc5hk6ncBM1MV+U7009sQpOsEHMd2e0Ix+g59aQU
         /F33fqm7gb72YUvjZKujKONod1GhxOZutw5pAHxMDqV+t3OIFCwkiULWnJ7m/FzWJ/8L
         qDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O495Wa6swYoYxk/LAUpi4Xwbq+ttYVsFyz2e6uK/hBI=;
        b=KsFoLLAGtmAjRstxfs1aOSonT1ck3b5yLaj9uoz7SJJe+819HXzxeJ1K7NMSVXln3O
         NgKEXlFo2rQiyntXOxHOLYUX12zk/zHbWZ2braRIWkj6CC+F4KJlevfWBRNFei1sIdGh
         XtEDVHz2pr5G3qkrJj5us6BEx+l0liNVGFwHKMIyTae6s5vq4T/CgFQdUPRmbqKRL8RL
         8rps6ZBXsCPa73QuR3haXkjhufdoM9U8vgTUhQavXzc62mkkEc9fNzEfgCv6PX//epSN
         znZFm2i5/AK4GdHuOrDimjrQM2ez16CVph2F03u9j6jjWn9ywattkLmbMJkTUOO++ssb
         knXw==
X-Gm-Message-State: ALoCoQkE1daTiYXztWYo3z29VepXsydmwDvu+F0jogj0csUbJTnnDdaO7hRxPj5c2oIQbamZLNbw
X-Received: by 10.50.61.146 with SMTP id p18mr4059230igr.3.1402093762727;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751216vda.3.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7876F5A44EE;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 549A6E109D; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251008>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index dd98202..6d2caf7 100644
--- a/refs.c
+++ b/refs.c
@@ -3514,11 +3514,28 @@ int update_ref(const char *action, const char *refname,
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
2.0.0.582.ge25c160
