From: David Turner <dturner@twopensource.com>
Subject: [PATCH 35/43] refs-be-files.c: add method to expire reflogs
Date: Wed,  2 Sep 2015 21:55:05 -0400
Message-ID: <1441245313-11907-36-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlg-0006mV-4r
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbbICB4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:47 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36312 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbICB4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:19 -0400
Received: by qgx61 with SMTP id 61so18643521qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hp7FIEmgMMNTsj3pWrL/0SKYv0RBJfnTgV5Amvm8GRo=;
        b=HWV6pEb5ecelvAxaVHjKXQDS3kqf4/e4hJaSL6Hyjy2vZ1JYBaU5Esmt2JmV6J51Hy
         yTl6niaZ8+PDhx0HTGbu4AkNcrVj30dzE9ajykyeo24OKnGj5ESFPNDRfG1mZZljBjJL
         RjihtY/B4H4AkolQsbkyCMWB+2EbJHeH8GdtZPNm7v3cIauA1yb3LTCvQU49LH4J497S
         zB71bDFm75GadVfJSwBIyAOAXeo07hi1P2AVqT57xqlHsFDVnURL1joSqERnGY4RkUnM
         iGbelZPtXYna/vmn/oPEbnYvOfJeuSR1fev787+tab89HfvxFSpSt+1L74cp1lxEjoo8
         N2wQ==
X-Gm-Message-State: ALoCoQmrIslA/uVJTEd5ZcwabxVpY44roo8uNAq+zFLkEEZY8+3KitpGOwLuy/0T8jEQEJwPdcRb
X-Received: by 10.140.109.36 with SMTP id k33mr2319781qgf.12.1441245378463;
        Wed, 02 Sep 2015 18:56:18 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277159>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 3 ++-
 refs.h          | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 5170c5c..71c39ca 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3607,7 +3607,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-int reflog_expire(const char *refname, const unsigned char *sha1,
+static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 		 unsigned int flags,
 		 reflog_expiry_prepare_fn prepare_fn,
 		 reflog_expiry_should_prune_fn should_prune_fn,
@@ -3748,6 +3748,7 @@ struct ref_be refs_be_files = {
 	files_reflog_exists,
 	files_create_reflog,
 	files_delete_reflog,
+	files_reflog_expire,
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
 	files_pack_refs,
diff --git a/refs.h b/refs.h
index 76661ef..fd461e9 100644
--- a/refs.h
+++ b/refs.h
@@ -625,6 +625,12 @@ typedef int (*for_each_reflog_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*reflog_exists_fn)(const char *refname);
 typedef int (*create_reflog_fn)(const char *refname, int force_create, struct strbuf *err);
 typedef int (*delete_reflog_fn)(const char *refname);
+typedef int (*reflog_expire_fn)(const char *refname, const unsigned char *sha1,
+				unsigned int flags,
+				reflog_expiry_prepare_fn prepare_fn,
+				reflog_expiry_should_prune_fn should_prune_fn,
+				reflog_expiry_cleanup_fn cleanup_fn,
+				void *policy_cb_data);
 
 /* resolution functions */
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
@@ -679,6 +685,7 @@ struct ref_be {
 	reflog_exists_fn reflog_exists;
 	create_reflog_fn create_reflog;
 	delete_reflog_fn delete_reflog;
+	reflog_expire_fn reflog_expire;
 	resolve_ref_unsafe_fn resolve_ref_unsafe;
 	verify_refname_available_fn verify_refname_available;
 	pack_refs_fn pack_refs;
-- 
2.0.4.315.gad8727a-twtrsrc
