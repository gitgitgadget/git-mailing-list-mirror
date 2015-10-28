From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 06/26] refs.c: move delete_pseudoref and delete_ref to the common code
Date: Tue, 27 Oct 2015 22:14:07 -0400
Message-ID: <1445998467-11511-7-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGV-00011F-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbbJ1COz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:55 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33055 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbbJ1COu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:50 -0400
Received: by iodd200 with SMTP id d200so78971423iod.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jrjze3Z6U9hvEVKSIl+2PzQnJb8gXe9EwaO61jdRcX8=;
        b=x0tSI+1Hfuz24tn9V+oZxxcAtRQPLBN2FwueYODb4+hDQZRVLHTeuTgO8cgISwNHuL
         Dqifad/9BNV+gY2xtSNJBh6kEhqh3IXNPPtogDHqZ2/YAfPx0ByrTEaScMnqGFlT8N3f
         XN+WLWc8/ty52DlFgdy+TWOVs1JaqZxI533UY4U4LyfdQctzwoZRFlpoUqSGsvDi9GV9
         GpI6Z7n/FPe1dTGcFIflutuHMWlrnkR0TKol5B3/CUtGzcwZXURFEO6+D+CbZRST9F2p
         SnN/UhdnEbMiOE5b1lTB4w2PE7QWbZsRB3OSZG0aH3SK+aA0IMQqjdo6ZW2fiwiXy3au
         LWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jrjze3Z6U9hvEVKSIl+2PzQnJb8gXe9EwaO61jdRcX8=;
        b=N6YYd/sNVcx/jy8Iha0WFESyr3vx0KwogniAYPsUthuL5elEKIo0V01yqp/quxHikb
         ipe5xOGbxfg+cMxKzkOojROYn7t87arTaX56TmxQjh1L20h+B0RtnZ2xqPopTy3FsVTQ
         Ery6n0E+ZHoOtT8HevyZOFWPDRF4uCkmsOIXAOsjkr98rJQu8VJ2fBUg/hicEgoVVDaj
         kyhuxaDalBzSRgqi9WesWk1OQEo37SyqnRddgZuF0tirPTS8e2D2bSfJgmKaquOLgeqI
         i9YH6lJNMYF/57Dll4VL8+IQ9Gzmx4LagXRQfyaVYHzD/idnjJ7WcMq9OKNhJ1vafeOj
         gJWg==
X-Gm-Message-State: ALoCoQnJssme0RorJyv2SFtv1A4Euy4/nb01aY8rd3ZKSs4i50rmia1i8lQZ267Itk+QQ8KB3riV
X-Received: by 10.107.39.135 with SMTP id n129mr25868313ion.14.1445998489892;
        Tue, 27 Oct 2015 19:14:49 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280330>

From: Ronnie Sahlberg <sahlberg@google.com>

Move delete_pseudoref() and delete_ref() to the refs.c file since
these functions do not contain any backend specific code.  We can't
move delete_refs yet because it depends on the files-backend-specific
repack_without_refs.

Based on a patch by Ronnie Sahlberg.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 56 --------------------------------------------------------
 refs.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index f03d68c..de99c93 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2884,62 +2884,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
-{
-	static struct lock_file lock;
-	const char *filename;
-
-	filename = git_path("%s", pseudoref);
-
-	if (old_sha1 && !is_null_sha1(old_sha1)) {
-		int fd;
-		unsigned char actual_old_sha1[20];
-
-		fd = hold_lock_file_for_update(&lock, filename,
-					       LOCK_DIE_ON_ERROR);
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"), filename);
-		if (read_ref(pseudoref, actual_old_sha1))
-			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
-			warning("Unexpected sha1 when deleting %s", pseudoref);
-			rollback_lock_file(&lock);
-			return -1;
-		}
-
-		unlink(filename);
-		rollback_lock_file(&lock);
-	} else {
-		unlink(filename);
-	}
-
-	return 0;
-}
-
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags)
-{
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
-
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
-		return delete_pseudoref(refname, old_sha1);
-
-	transaction = ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, old_sha1,
-				   flags, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
-		return 1;
-	}
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return 0;
-}
-
 int delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 610fab0..d9a713b 100644
--- a/refs.c
+++ b/refs.c
@@ -117,3 +117,59 @@ int update_ref(const char *msg, const char *refname,
 		ref_transaction_free(t);
 	return 0;
 }
+
+static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
+{
+	static struct lock_file lock;
+	const char *filename;
+
+	filename = git_path("%s", pseudoref);
+
+	if (old_sha1 && !is_null_sha1(old_sha1)) {
+		int fd;
+		unsigned char actual_old_sha1[20];
+
+		fd = hold_lock_file_for_update(&lock, filename,
+					       LOCK_DIE_ON_ERROR);
+		if (fd < 0)
+			die_errno(_("Could not open '%s' for writing"), filename);
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			warning("Unexpected sha1 when deleting %s", pseudoref);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+
+		unlink(filename);
+		rollback_lock_file(&lock);
+	} else {
+		unlink(filename);
+	}
+
+	return 0;
+}
+
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
+{
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+		return delete_pseudoref(refname, old_sha1);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, old_sha1,
+				   flags, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
+		return 1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return 0;
+}
-- 
2.4.2.658.g6d8523e-twtrsrc
