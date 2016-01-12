From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 07/21] refs: add method for delete_refs
Date: Mon, 11 Jan 2016 20:22:06 -0500
Message-ID: <1452561740-8668-8-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngj-0003yT-0h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761954AbcALBXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:23:52 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35788 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761770AbcALBWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:37 -0500
Received: by mail-qk0-f176.google.com with SMTP id n135so233501899qka.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1wkI1wvuT+EgdZ9SE60RfAp6j58huUtPEndVaj9Cic=;
        b=11gEQzNFgB/HSktqrGpriTqZwfaVYfhoO0KQGc8atofFtkiTqtpm7zf56IcwdC1V4T
         pMlPp+MxOvHoqDHNFxo4JbfzPQcG/iewpysvoNIT2y/GZBw3HgL6BbOge8nJEmpRKlmR
         zz8zIRr0c0I/KOWpgoMiPfsa7H6u8KqgbPn6aetVO9eodC6dchnI6P9csVEQvaf4USgx
         pGJo1WSfcYfWUq9kIV0xxi2AYa31DkiJ4qq+LHRTqSVun+ITC7nXrri0d7LTYEDwHjA0
         K7gG3b/rLoTCiqzSj2/M27R3H7TLc/3yYHNHQDLMTVIs93p+YQx1Fb/47JyjuVDmrMY2
         1KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1wkI1wvuT+EgdZ9SE60RfAp6j58huUtPEndVaj9Cic=;
        b=ZR5pzA64SqPeKU72db98OMHiV0AkBHHxfMjTWVmqK1ZRkY91q7DiEtdojO3ya7I9vJ
         rWyNSYVUvanJJpwSBO+vEakvDZnU4nW13r94ir55g2eXVP4OisB0x41pDC1RtPP3lZ6n
         Gsnnb3v2xn/zf23rAU6Yf3iUx95ao+TQMWCkeVOeX7ziSb5CjjH2IO9sLlARaqEpQmaN
         gDT9apqU6SrPBOVkLYllFCR8oaqkn88OwIAjhiQf56eQTR+ugOP+uBNqAF3vkrauaJyl
         o5/OS8iYL9Z9PGBqcLTYIXiO7Ie7PCiWMCHfZW/DZJkykd709ggJki5Uj2uoHU6ABE73
         k9VA==
X-Gm-Message-State: ALoCoQnQSpn2pNY3+8mCpSJ67G0jmSpWQmKxlRfrhApvZ+PmU//zT0A+W3w5hyDodWvEsm0/XJbI0G4YBeG4e5aY0uPdW6pq6A==
X-Received: by 10.55.73.74 with SMTP id w71mr169608643qka.60.1452561757042;
        Mon, 11 Jan 2016 17:22:37 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:36 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283759>

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
index ccbec52..0c61be5 100644
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
index 1a1d0fc..b9c4604 100644
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
@@ -3551,6 +3551,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5ec5ede..c26ce6b 100644
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
