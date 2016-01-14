From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 01/20] refs: add a backend method structure with transaction functions
Date: Thu, 14 Jan 2016 11:25:58 -0500
Message-ID: <1452788777-24954-2-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkW-0002yd-2A
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbcANQ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:34 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33166 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbcANQ0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:32 -0500
Received: by mail-qg0-f41.google.com with SMTP id b35so356504740qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNkMTAq0OeVYU2rFDhrV79rI98IkqWrDPIcr3ogPVj4=;
        b=AVCG9K724Zhqcf4e0QLDjBKJXTb50jK+zpjEEp+I42m6PxeumEWh+OtWsJIUgJJvfI
         heMDxQvvIIXhKS8NqnGjAo07ziCAkucYUWqPP2V8rp1TjL2ETMyF7Po0naJjKShTWMDr
         I0emgHlO1u0B7EOqetO15iJJeZhhpVreT1+vAtLPrfM5971jhOp/XIy5Bf+zZzHAuR6V
         X83tIOc+P4ERsvmywforGHOwre+qMuK9vWA9VcaKwXF1ysZri6fjRjQVdRtpiqqzwvHJ
         3ONV/0ACac+HLajw35WrhKJbTdsXUAhSoytO9YuKGnqL3EcC7OG8BfcqMEdrToVcBifW
         Qjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNkMTAq0OeVYU2rFDhrV79rI98IkqWrDPIcr3ogPVj4=;
        b=mox/zrksQpIlUC9U8pgce+gj5NZTeDKx4RpKl3uiMn0vE8LL7mno7uUDU3xQcJQBSm
         eArv11/8Lk+fzsJVMTbyt8h9GqSUdRagAKE1ivrPWDi5Jxa2DZWsbrDBRdpGYEQ39y4G
         VxRceF7B+y9nmf97/84dZcnXqhGq3aEh/HA7Yo2AQfFVMQvHmjyZcDrjVi0EQr5Mbcvd
         1Eea1IwPOXEwXoNwFXpG5gH2axl3e8bqL+y+kuhMyMlvN8FwFBcqO73PJyZcP3p1tI1r
         btglfywW2lIiG1eF30FmjiB4/i4tFWtIvLwuQ4/4bmxTHYJQOtrOqHhXzJvnyQxPKANl
         9lZQ==
X-Gm-Message-State: ALoCoQmFhNYSPx0fB++Qly5kFIQxE4N3aseFoIZsx+HMtXiOlOUk4D9nFps+VrxeAJPr/vxOv4kNOnyhe8hO8IwXfVlaa6KP6w==
X-Received: by 10.140.236.68 with SMTP id h65mr7161339qhc.13.1452788791741;
        Thu, 14 Jan 2016 08:26:31 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:30 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284055>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for storage backend methods. Start by adding a
method pointer for the transaction commit function.

Add a function set_refs_backend to switch between storage
backends. The files based storage backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 29 +++++++++++++++++++++++++++++
 refs.h               |  5 +++++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 10 ++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e2d34b2..485b905 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,28 @@
 #include "tag.h"
 
 /*
+ * We always have a files backend and it is the default.
+ */
+struct ref_storage_be refs_be_files;
+static struct ref_storage_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+static struct ref_storage_be *refs_backends = &refs_be_files;
+
+int set_ref_storage_backend(const char *name)
+{
+	struct ref_storage_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
@@ -1082,3 +1104,10 @@ int rename_ref_available(const char *oldname, const char *newname)
 	strbuf_release(&err);
 	return ret;
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 3c3da29..c831b8e 100644
--- a/refs.h
+++ b/refs.h
@@ -508,4 +508,9 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/*
+ * Switch to an alternate ref storage backend.
+ */
+int set_ref_storage_backend(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81c92b4..69708e6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3128,8 +3128,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3515,3 +3515,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..b110c77 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,14 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+/* refs backends */
+typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct strbuf *err);
+
+struct ref_storage_be {
+	struct ref_storage_be *next;
+	const char *name;
+	ref_transaction_commit_fn *transaction_commit;
+};
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
