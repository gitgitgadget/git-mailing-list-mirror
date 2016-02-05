From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 07/21] refs: add method for delete_refs
Date: Fri,  5 Feb 2016 14:44:08 -0500
Message-ID: <1454701462-3817-8-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmKY-0002V2-3D
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbcBETqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:46:03 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34361 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbcBETov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:51 -0500
Received: by mail-qg0-f46.google.com with SMTP id u30so76278201qge.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WognZEdnJqun5peDX4ga2E9YaYBfVXL2HkZKk82qrZM=;
        b=1MNXPuJe+uU0ubwoIZUK69e/3YQyp44fScBRi+KToEWOhWjcmGIMejL7xdJb/OIlew
         nITPDciwS/HVkgOzbhLELy5CtDUTzOiN+iN+nCNNtK3+fk38VWiz/j5X5QnpCZDfYxd7
         tI2smt/aQyOqtM2QsddesClUja5pfJ+2UuHR1eNgVJBmqqTNa5AgUsu0Hl6u0R+QAJxe
         aulGQpUwXmF/wT+7BKZ0QhVxV4uv5/sdjtV5ZDWa+xRBKrc+OvQr3EXa8DraBTwobMhl
         4W8LdlVl5Nnr9rsubTJaGzBVy5GzxLPgxyCaiElJCzx0DRElZzL5G40kpL8dMRcqw5Ap
         e09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WognZEdnJqun5peDX4ga2E9YaYBfVXL2HkZKk82qrZM=;
        b=NSAooXhELxScUsHVvH7MO/GXagahos99RLJ0dP8lrehttbC05QA2RrWWLiULCQAZuQ
         KEIQI76yd53VZI1433xExXRo0hl6XopEghqJoYE+Vd93XdFfyz74hhHQoj4sk0d/kNff
         T3L/sM1zCAhyHGxfQJORfZqgeiSKGVlV7nVI3JPqXZxmEGBoQrrBz1SbhpieStkiUbk6
         AyZc2El3dR0hWAURpljWHVB1Z6JYb/VZ2vA+KPC+eWBExgycvedX5D8TLxh85u7qi8F4
         aAYVxl4YfXVDr5JD7rPq+H+IxUPNmOwCzO0Pt3PR1+lCkqltoXXe9+qnOhJ+IqX3eLT5
         cB0w==
X-Gm-Message-State: AG10YOT06ADLqvdvsyrCccPhvcNeiGJXjMIu4tYapHAg9jYHJVfonVLvBGhpdFStdJpTwA==
X-Received: by 10.140.91.66 with SMTP id y60mr18637331qgd.20.1454701490807;
        Fri, 05 Feb 2016 11:44:50 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285623>

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
index d481a94..5fbe794 100644
--- a/refs.c
+++ b/refs.c
@@ -1123,6 +1123,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
index 723127e..e86849c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2380,7 +2380,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3575,6 +3575,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 142c663..1d9e5e0 100644
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
