From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 17/42] refs.c: change update_ref to use a transaction
Date: Wed, 14 May 2014 14:16:51 -0700
Message-ID: <1400102236-30082-18-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYW-0002V2-WB
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbaENVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:32 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:55180 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbaENVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:26 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so36994pbb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A6HxD15BqBh8xmbxbi9DDNWRS460G/jJrhSWqgxYB60=;
        b=ThsZySzNxwkAFGXmwCcx6xazmUb0u3+PzYq9GSy9ZQWqm5J1iOlWR6mSDfkTnV/bg/
         gjgPNlLmtYL0sXYPqKLHb/kdiEjVoJxS3o7JQTa2/VgMdQtt+O8kxq8TTqup7epUMKb+
         ea354D9NJWWA6SYoQpr5gwhG1nKqYMjyxfSzGBjKBLDyciFQ91bEBIMA25CiapVFz+nl
         1D89s/CNUFEadn40TzJsq7KxtOKpBPg/H/cU4W/ZhkKCrMWDjfYfcvIUz60B+0lXGHXe
         J8TUCgxXsgqo1xKZuujT8NQDWv9ftwOMfjVNw7PsrXQK47218OFeVZ1Cz/dLkZh3EBDf
         rYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A6HxD15BqBh8xmbxbi9DDNWRS460G/jJrhSWqgxYB60=;
        b=iujGZIqv7hWVIO8nhksrpPNK1YGWlCojOx8cUHnRIOq2jrokfLIgKtIiNrxn5xqWsa
         oPucExbB20Xz2pBxBY/BpL86ddzRQMRywX3qN/+omqPTnqV1dxyxGaTbEuojkyiL5KmU
         vhk/j0D5MXa8An3P7679NfQJNIcxpkJbfSH0qpZ6uBf7cZm8OKxmcBJDXT/C5+CqiZog
         LMiuAwrg++nIsORQ1OP3UUIeYirTxtrxCOgcB4jVvlR+y66ThLtTJntNvZ8075+cYylt
         ouz9CcbGrfl29yl1C9PXS/e4XRxjG/yusqy3LvGNCFa4OpGHDMGBIwL4sWqgqD1tpIct
         cAJQ==
X-Gm-Message-State: ALoCoQn1xk2Uh9kvVJpTuDGMK3aYQegw6cYCduN4TMwfXHLAF4lJaAKbJgRlX4SxQ1+hzyIJ2E8Q
X-Received: by 10.66.141.135 with SMTP id ro7mr2911050pab.28.1400102245760;
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si145560yhq.3.2014.05.14.14.17.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 92F3C31C1F8;
	Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 57577E0CB6; Wed, 14 May 2014 14:17:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248957>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 64e3d53..55aa5a9 100644
--- a/refs.c
+++ b/refs.c
@@ -3405,11 +3405,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
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
2.0.0.rc3.471.g2055d11.dirty
