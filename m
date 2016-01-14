From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 07/20] refs: add method for delete_refs
Date: Thu, 14 Jan 2016 11:26:04 -0500
Message-ID: <1452788777-24954-8-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjZ-0002BJ-52
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbcANQ0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:42 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33271 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbcANQ0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:40 -0500
Received: by mail-qg0-f44.google.com with SMTP id b35so356507959qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6/rJn+8xhiDdtoT8zt9NGiyO45qc2kyKdpwkUceDkg=;
        b=MyOwL7lPyHq9D1zCOM0RiZrnQct8JVYDHek0oc88BLk7ZnNRWU2hpar/7H2D6S24su
         gQ7PyaKe72tM7URbgVrw5M8UPYmnc7TqYN3+WforqtB9Fm+PlOlSXghZrljIFd0dlSnQ
         HepXt3RGahYdA/9xN/z3Z9t3NlDDPT6kVQbhChIaZGsps2cu3y7cPhQjKHY08mgb7dsD
         A+toiSm515T0M3WJ4IPAK5YYyueItpf4TIXyoog7mS33t3rouq9cRStKS62Ybn/He+3U
         UxOBWHQLJQEGJlNVPOIFYhsiuqplP4jFtfTUi94ctkX4If2YvPDVLV8z10bF64plQY7T
         2jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6/rJn+8xhiDdtoT8zt9NGiyO45qc2kyKdpwkUceDkg=;
        b=m1yUHox8kyViNouIbT9rCC8idupCd/s8FBdRMACNVEdIXbKcOooB3Z/CfByiDeP0kA
         +T2fL4Obpp9MFRP9t8EoBpv2fYMc9c76oAsG3rrTNRr8hZffOAEgin7IblalBNvbDHld
         r6bK0MMzzUf/nu/y7AVdx2w3ODDuALX4H86DdKN9irn8Qtchr7c/nty87n6bvOJFXVPl
         Sq9GqGS71AqFLQriSopc0vuiK67twOHmi9lj1051qkkO8Y6aXbNo7m1aVZWMG92Q9XTY
         VTw6eIcVDKSw1p86N0k5uGuR/iqCP6sCv8rk4zaoCV/5wf3BeBY4XEuKkFisfV749mAb
         kWFQ==
X-Gm-Message-State: ALoCoQkHqYVBRFSm4S9bAzB+csvx6BP7ENP+MZEvStvuBo7oJg/+VT4ziyc15UufBywx7xwwceZouggz+wvdDzh0pvEQqmdSvw==
X-Received: by 10.140.25.169 with SMTP id 38mr6608529qgt.73.1452788799226;
        Thu, 14 Jan 2016 08:26:39 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:38 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284040>

In the file-based backend, delete_refs has some special optimization
to deal with packed refs.  In other backends, we might be able to make
ref deletion faster by putting all deletions into a single
transaction.  So we need a special backend function for this.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 3 ++-
 refs/refs-internal.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f492fa3..f1c0601 100644
--- a/refs.c
+++ b/refs.c
@@ -1112,6 +1112,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return the_refs_backend->transaction_commit(transaction, err);
 }
 
+int delete_refs(struct string_list *refnames)
+{
+	return the_refs_backend->delete_refs(refnames);
+}
+
 const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 748993f..f1cb4c9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2362,7 +2362,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3557,6 +3557,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 26b707e..b9c9b1d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -236,6 +236,7 @@ typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct string_list *refnames);
 
 /* resolution methods */
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
@@ -280,6 +281,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.749.g730654d-twtrsrc
