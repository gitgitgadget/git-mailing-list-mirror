From: David Turner <dturner@twopensource.com>
Subject: [PATCH 07/16] refs: add method for delete_refs
Date: Wed,  2 Dec 2015 19:35:12 -0500
Message-ID: <1449102921-7707-8-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Hsl-00078r-CK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927AbbLCAgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:16 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34637 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbbLCAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:47 -0500
Received: by ioir85 with SMTP id r85so64748631ioi.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1ik9V+R2udnpzdmoGQA3Bqlx6GJxyziQDSuvl9rT8M=;
        b=qElqDbg3iFKwbLgj9uHB1mKGkoPx4lvGsTa4gR1l6mNslbcTPUBwFlyxw6g6HADTrC
         onDtRE7ukdT1zsN2I1QUDPYDjrxRecz6kgqrGzrsBZrk/M7CiM09kMuHFFN0GF8RyWOR
         IqS8H3M3RNmOyeqSIIcDoiNDbti6+CY8+7IfDUZuKdDgcMP72bRS3FD9klgYwQoABvp5
         4I4K1SZcQ4bPMpmyjnRDV0DtSqu+sTARLUQrCNuXen8WPHLtLkBMKHi9Pt7Pi2pzL3O/
         GKKz6bu7dJIlbiowFXHy6HRVZw0dJsgCSlwdpEWkD7vkt+T4vw+k2LGtPRgr49infJOL
         Lf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1ik9V+R2udnpzdmoGQA3Bqlx6GJxyziQDSuvl9rT8M=;
        b=FhV/hks5/lG7snCxWcjYD3bHTOqXiY4silYkXgwiLYF2+Iee/WPUdE0Q1Ony2RqF26
         CUFVmrrUrnCL+pKWWUVG+y7TJFw5qpCAXEce4CfthbKOcS4NgaeUGXrwyrYU5x7f5xVF
         gwBN6oVI8BBLmA/+ce5+wZrdcXRCNcK1TTn3xSxddPn6sP5SQ4KySI8f+hfQVu/h6ogT
         PbAvAWLAxj+LCFqc14QOUWlSCuSROkd9OUUW0sJz/CNsl29dRwWYV52I3qMhL+/IbBzv
         i8twyz+3nRJ9uyNLv38vh5aaALvpN+YWwA7lUM4sT39H/McCuv8XXxpTe588ePOnI5bx
         wiVg==
X-Gm-Message-State: ALoCoQmXxVeefszWEryVMCvVIdhy8x3ZOdPKHR61uAnjSnbHcfSupQhZyOlJ8kem18Am1N09y5NE
X-Received: by 10.107.138.21 with SMTP id m21mr7512146iod.115.1449102946629;
        Wed, 02 Dec 2015 16:35:46 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281929>

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
index e50516c..9a2fed7 100644
--- a/refs.c
+++ b/refs.c
@@ -1115,6 +1115,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 44ad632..e769242 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2356,7 +2356,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3551,6 +3551,7 @@ struct ref_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 74bd44b..478ad54 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -236,6 +236,7 @@ typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct string_list *refnames);
 
 /* resolution methods */
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
@@ -280,6 +281,7 @@ struct ref_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.749.g0ed01d8-twtrsrc
