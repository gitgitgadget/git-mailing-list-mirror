From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 09/27] refs: add method for delete_refs
Date: Thu, 18 Feb 2016 00:17:32 -0500
Message-ID: <1455772670-21142-10-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzK-0001Hk-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424889AbcBRFSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:45 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34748 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424477AbcBRFSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:38 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so29443124qgb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qy1cvO01mVx4CVfNwT/w9W98LMblRy5SVl7/drT8Bn0=;
        b=f2Ml1X9pxR6RmK17Q1opFRbBLt3Iv8jxYW9TPTF88nD+CQlyAmlKXxSc3ePiasii5/
         cSJzyI2dFffUkoRl/xN9QuVk0ZKT2CLsjcVgPFRJac7n5W/9wwY6YpXjYfa4OYk+uayN
         o7YLZ4Qzhvsaae1VSgrnSxZDLfY0wJHEfxysM2k0CMUpt4wzkUlvvhgnABcM0yfc33Dz
         0IE54vNl3dUg+l9JqPpeinuUxhlno9fbhl9mz/2vH5hzJ0WXy0ii95NK92sqHbnYnHjg
         q6lOHdA9fzJ8eB2WY4wCvtNuOjYEjR3l7U15mvyeOfKCA3PHNfe/+cubE2GVwNchMdwd
         AVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qy1cvO01mVx4CVfNwT/w9W98LMblRy5SVl7/drT8Bn0=;
        b=myIZDfVE02R6lxFRv+8fn6SUeVg0idGECcd2DnklV43zG7eN/pB3P1MFYAcXtSkklD
         Mx2AqD0fqIUemryHFF1LjiKO7WmIrFLhrjj+PjXR8pfvPxDDGOi+qMieLfd+/vgI7vtK
         iwsYcYrn1gLIu1ekcbgJ2s5H7c5LjLaYaFYNhpOit6yJbMvGQ/UCNvLxLnAx75fgLVz1
         sleViY1fDQh+IM98sbFCs/UoHHmVwjAy930XBo3nVrcHIHRjZ4gDYtUlN9w5ZecF/V5Q
         YqSF3lfJ28UgVw8+PTsQcZa1fQQs7mv3A1nq+gc9AKmc8dlewy4YLaNBO37c5oi4r5UV
         KFxQ==
X-Gm-Message-State: AG10YOTH+mvcP3MgqV1M9M+TKUwQbdbdlTaB8Wvt4/hWeNsWkJsbSS9iF1BQ/mmjHRor2A==
X-Received: by 10.140.106.165 with SMTP id e34mr6705025qgf.23.1455772718086;
        Wed, 17 Feb 2016 21:18:38 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286578>

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
index 970729c..1a24046 100644
--- a/refs.c
+++ b/refs.c
@@ -1293,3 +1293,8 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->initial_transaction_commit(transaction, err);
 }
+
+int delete_refs(struct string_list *refnames)
+{
+	return the_refs_backend->delete_refs(refnames);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2a663af..e3e2b03 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2302,7 +2302,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3497,6 +3497,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f9acd36..466dd34 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -242,6 +242,7 @@ typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct string_list *refnames);
 
 /* resolution methods */
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
@@ -271,6 +272,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.767.g62658d5-twtrsrc
