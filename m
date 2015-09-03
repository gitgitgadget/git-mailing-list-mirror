From: David Turner <dturner@twopensource.com>
Subject: [PATCH 28/43] refs.c: add ref backend init function
Date: Wed,  2 Sep 2015 21:54:58 -0400
Message-ID: <1441245313-11907-29-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJm3-00071H-Li
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbbICB4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:06 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33358 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbbICB4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:03 -0400
Received: by qkdv1 with SMTP id v1so15674188qkd.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rL75hmC6HcKaKOB/fDBoO/abczJnLlftH8jxvy4xWpY=;
        b=j3rHY0Zbi+qsmUvYiDG6hJSvU29hVVbuUJirWvPZHSVzyPu47nMeA/w9r5UO3xqr+k
         ssTjy9iJjR1d30mC0n9FsoSC6mRRxTP4SfNg4fLCd5aczr3id44Impe8wxxwb/bz/EMu
         84GxuFxLaX3U8jHKhHyLPynxuGQuQ5aCosWMPMsnmEi/tArgSy9OlWykDcMt0zi96nqG
         v/3uNypv84yJndiyHkbeP0Fy2Y/9Yh8724B/xGoMYWHFG5a5qZHVIy5RGmAE+0olgLWn
         kPWkYZTekAVKvTi6L5L6ISfh1jHbyTwL/HHwC2XANN8gYwlK3JRRVdDLPRZ0POdi1O6W
         My8g==
X-Gm-Message-State: ALoCoQmKFGruqa+01mqDvR2lAFF5+dlqWzvEIbQjDszEwRxZXuWAe4/KlU3vgQv1dG4JL2V0G2Oo
X-Received: by 10.55.15.3 with SMTP id z3mr33829710qkg.29.1441245363218;
        Wed, 02 Sep 2015 18:56:03 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277168>

The file backend doesn't need this function, but other backends might.

Signed-off-by: David Turner <dturner@twitter.com>
Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
---
 refs-be-files.c | 1 +
 refs.c          | 4 +++-
 refs.h          | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 3138624..6a10d4b 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3722,6 +3722,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 struct ref_be refs_be_files = {
 	NULL,
 	"files",
+	NULL,
 	files_transaction_begin,
 	files_transaction_update,
 	files_transaction_create,
diff --git a/refs.c b/refs.c
index a9e6ca1..60f3503 100644
--- a/refs.c
+++ b/refs.c
@@ -19,13 +19,15 @@ struct ref_be *refs_backends = &refs_be_files;
 /*
  * This function is used to switch to an alternate backend.
  */
-int set_refs_backend(const char *name)
+int set_refs_backend(const char *name, void *init_data)
 {
 	struct ref_be *be;
 
 	for (be = refs_backends; be; be = be->next)
 		if (!strcmp(be->name, name)) {
 			the_refs_backend = be;
+			if (be->init_backend)
+				be->init_backend(init_data);
 			return 0;
 		}
 	return 1;
diff --git a/refs.h b/refs.h
index 7204a56..d594a12 100644
--- a/refs.h
+++ b/refs.h
@@ -586,6 +586,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /* refs backends */
+typedef void (*ref_backend_init_fn)(void *data);
 typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
 typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
 		const char *refname, const unsigned char *new_sha1,
@@ -635,6 +636,7 @@ typedef int (*for_each_reftype_fullpath_fn)(each_ref_fn fn, char *type, unsigned
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
+	ref_backend_init_fn init_backend;
 	ref_transaction_begin_fn transaction_begin;
 	ref_transaction_update_fn transaction_update;
 	ref_transaction_create_fn transaction_create;
@@ -662,6 +664,6 @@ struct ref_be {
 
 
 extern struct ref_be refs_be_files;
-int set_refs_backend(const char *name);
+int set_refs_backend(const char *name, void *init_data);
 
 #endif /* REFS_H */
-- 
2.0.4.315.gad8727a-twtrsrc
