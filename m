From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 30/43] refs-be-files.c: add method to expire reflogs
Date: Mon, 28 Sep 2015 18:02:05 -0400
Message-ID: <1443477738-32023-31-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWn-0001ih-3T
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbbI1WDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:33 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32886 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbbI1WD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:27 -0400
Received: by qgev79 with SMTP id v79so133379889qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BX819+Ceae0MzQf3mIfnYbCVtvIDvhxAd//oRt04zMg=;
        b=aCbchqYRMCAc5CdgNxT0UrxrkyZ+KI7S1/m8ztdT5Jw5vVauhWztYwyOvV1XEepkO6
         jKfvEYwSZw7LLEasH+Ki8i+PCshSu7yk+OTsGyn/ejdCPF2pIfYA/1CbThyMgk0UfW30
         uZaFhTfaCevbbQFjlK0zaaqBtss8tcfWZpKdtVymS8eyalYc7kHt8FTdN4WZwu1PSTSz
         REDb7mQwho2zhBKL9toGKCM22nwRQhooTdpxTAMd8aZngzu2qon49LxCYW4l7r/1dcXB
         /jm/PlwDn1EOhByJxUK39cmV0oo4B0cDpJ1ehYCiYA+mEfpUpPnkeP0VoVb7HLHhDJjP
         H6MQ==
X-Gm-Message-State: ALoCoQlm0KRuqM7XUXKkolsbbdh4PUfLWCqpuAOumXINs7VQSU0dPQpUqSc/iSESj2rZJak1aPXU
X-Received: by 10.140.145.75 with SMTP id 72mr26825608qhr.81.1443477807008;
        Mon, 28 Sep 2015 15:03:27 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278774>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 13 +++++++------
 refs.c          | 12 ++++++++++++
 refs.h          |  7 +++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index fdb47e0..93a5a33 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3633,12 +3633,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-int reflog_expire(const char *refname, const unsigned char *sha1,
-		  unsigned int flags,
-		  reflog_expiry_prepare_fn prepare_fn,
-		  reflog_expiry_should_prune_fn should_prune_fn,
-		  reflog_expiry_cleanup_fn cleanup_fn,
-		  void *policy_cb_data)
+static int files_reflog_expire(const char *refname, const unsigned char *sha1,
+			       unsigned int flags,
+			       reflog_expiry_prepare_fn prepare_fn,
+			       reflog_expiry_should_prune_fn should_prune_fn,
+			       reflog_expiry_cleanup_fn cleanup_fn,
+			       void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
@@ -3755,6 +3755,7 @@ struct ref_be refs_be_files = {
 	files_reflog_exists,
 	files_create_reflog,
 	files_delete_reflog,
+	files_reflog_expire,
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
 	files_pack_refs,
diff --git a/refs.c b/refs.c
index 7b2a47b..96fa699 100644
--- a/refs.c
+++ b/refs.c
@@ -1189,3 +1189,15 @@ int delete_reflog(const char *refname)
 {
 	return the_refs_backend->delete_reflog(refname);
 }
+
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data)
+{
+	return the_refs_backend->reflog_expire(refname, sha1, flags,
+					       prepare_fn, should_prune_fn,
+					       cleanup_fn, policy_cb_data);
+}
diff --git a/refs.h b/refs.h
index 494f8c8..06089f8 100644
--- a/refs.h
+++ b/refs.h
@@ -618,6 +618,12 @@ typedef int (*reflog_exists_fn)(const char *refname);
 typedef int (*create_reflog_fn)(const char *refname, int force_create,
 				struct strbuf *err);
 typedef int (*delete_reflog_fn)(const char *refname);
+typedef int (*reflog_expire_fn)(const char *refname, const unsigned char *sha1,
+				unsigned int flags,
+				reflog_expiry_prepare_fn prepare_fn,
+				reflog_expiry_should_prune_fn should_prune_fn,
+				reflog_expiry_cleanup_fn cleanup_fn,
+				void *policy_cb_data);
 
 /* resolution functions */
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
@@ -673,6 +679,7 @@ struct ref_be {
 	reflog_exists_fn reflog_exists;
 	create_reflog_fn create_reflog;
 	delete_reflog_fn delete_reflog;
+	reflog_expire_fn reflog_expire;
 	resolve_ref_unsafe_fn resolve_ref_unsafe;
 	verify_refname_available_fn verify_refname_available;
 	pack_refs_fn pack_refs;
-- 
2.4.2.644.g97b850b-twtrsrc
