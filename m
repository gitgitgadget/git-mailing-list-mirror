From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 12/32] refs: add method for delete_refs
Date: Wed, 24 Feb 2016 17:58:44 -0500
Message-ID: <1456354744-8022-13-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPL-0003fn-Es
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759147AbcBXW7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:31 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35985 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101AbcBXW71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:27 -0500
Received: by mail-qg0-f42.google.com with SMTP id y9so27391419qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H88YGVrXM2J4oqgt7hfvQ+bEeTQwQLfJ/6fvXTVN4qA=;
        b=WsjjfWDKGFO9HVKXgRwPEgXDsRO8CAeBej73lgqRmHL3h32IngWR2wFzeqp70oKLH0
         /YG9SG0L2QmR4FRrummTzwCQF6flBZwKPWE9M2fmUjCkvy+QyYxLs+d1AcV1NXV9akuz
         kDYbY6Veh40yG23HFkXzfO8WMi/LHd++0Al90uEUufuA1ZdR/ErJsn3G+G5xZ/4OUwY3
         lmEo6MPYgt9xJr8BVebc5Vvc6j4YysLua1xcGw9qa8Ex1Nzihipa64aYhJuTj6xydKtL
         GdmYRZnnik/X/MicmIwxeLurFXeZL/8zoo6GuIaDUULp6jWQcX9CUFtlj3JenHACB2WV
         XlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H88YGVrXM2J4oqgt7hfvQ+bEeTQwQLfJ/6fvXTVN4qA=;
        b=i5OC4OUDjPoeS8bLBKrjftp80PfStUN6bYCJ+RsdgZZoXUlz3Nk5qf2cbsHwYJ+QcE
         zhbX1B9o/KxMMgb9kPbd5vidh49XlJNvwYs4gQxP7L1smpS9DFJFnxKiQDS2ESWVrbKg
         tJ3QSX2JzjjJGBaII8vMTNHc2qQqidmWixyZqfwp6/zszqF/g7PKieI7sZoiGm2sSgyc
         dlhvImEYbcM7kiRFc8/lMkD2SND7Ghc5jLVp4fwMyAM4wUTHCTMffpQA5rVeuyoDwIMU
         gmXMa0+iOauFiOJbTXF80ABmR8kNUJZGH62m3CVG1Y/Hc9gb1ertnMYOO0Ms40fHp95C
         zUaA==
X-Gm-Message-State: AG10YOSqWPnl+xWUV2heyz3gCY+0Fb/R8JvW/k2JOLhnbmMNmVFbokG+am0qc4Dn6GRCUg==
X-Received: by 10.140.233.85 with SMTP id e82mr52396060qhc.86.1456354766264;
        Wed, 24 Feb 2016 14:59:26 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:25 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287246>

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
index 5ae1903..21b103c 100644
--- a/refs.c
+++ b/refs.c
@@ -1402,3 +1402,8 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->initial_transaction_commit(transaction, err);
 }
+
+int delete_refs(struct string_list *refnames)
+{
+	return the_refs_backend->delete_refs(refnames);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7621a41..6b15a2e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2246,7 +2246,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3441,6 +3441,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_read_raw_ref,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5aa3fa0..beef457 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -239,6 +239,7 @@ typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct string_list *refnames);
 
 /* resolution methods */
 typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
@@ -268,6 +269,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.767.g62658d5-twtrsrc
