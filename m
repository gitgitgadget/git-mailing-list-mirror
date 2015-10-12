From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 10/44] refs.c: move warn_if_dangling_symref* to the common code
Date: Mon, 12 Oct 2015 17:51:30 -0400
Message-ID: <1444686725-27660-11-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2x-00068h-KN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbbJLVwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:25 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33068 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbJLVwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:24 -0400
Received: by qkas79 with SMTP id s79so63027391qka.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SarI8fk80inzFXS/eqBkmNuGxCSlQKLgw03niSz/LcA=;
        b=M4qlALSEuwiuYEoBGXprYHMYar5iLao3q5w6PEYzm8rPUlitDOXmWBE4IyafdpZDsK
         ccr9L2FYm4+N7EsaENq/aptpzL8wZ+jlRD6xy/9mE5Z+RM3ZsUKfY+jGqPPPL8+esa+q
         snwDm5cqoZOQ/GFPHYJqOCWgOmUhPAmVuawX8RBi9urHt/Z9fTSDESRpxzezOpM7iXB2
         nbDXs6i7gOzbi7Pkbukdj0ZegOMiOVY6HN8p2bKz+gg2xq1plokVyYOHuPCFZefyYUUG
         l1yVNbpURmvswHagjrGlT0qkDybH/dUBUh+Gk21WUdM//CP0Y66MHmKhQ6UkM4vV+r4I
         C3FQ==
X-Gm-Message-State: ALoCoQmtFnpECdbio0akldVaY2JhYC21g4VPNIaOluIFYLOnguwckymm+o/51ieMLonXgtGI5wm1
X-Received: by 10.55.198.217 with SMTP id s86mr35180073qkl.75.1444686743594;
        Mon, 12 Oct 2015 14:52:23 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279459>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not use any backend specific code so we move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 52 ----------------------------------------------------
 refs.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 37772a7..7d82864 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1944,58 +1944,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	return peel_object(base, sha1);
 }
 
-struct warn_if_dangling_data {
-	FILE *fp;
-	const char *refname;
-	const struct string_list *refnames;
-	const char *msg_fmt;
-};
-
-static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
-				   int flags, void *cb_data)
-{
-	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
-	struct object_id junk;
-
-	if (!(flags & REF_ISSYMREF))
-		return 0;
-
-	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
-	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
-		return 0;
-	}
-
-	fprintf(d->fp, d->msg_fmt, refname);
-	fputc('\n', d->fp);
-	return 0;
-}
-
-void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = refname;
-	data.refnames = NULL;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
-void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
-{
-	struct warn_if_dangling_data data;
-
-	data.fp = fp;
-	data.refname = NULL;
-	data.refnames = refnames;
-	data.msg_fmt = msg_fmt;
-	for_each_rawref(warn_if_dangling_symref, &data);
-}
-
 /*
  * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of base.  fn is called for all
diff --git a/refs.c b/refs.c
index 310b7f5..24d5e28 100644
--- a/refs.c
+++ b/refs.c
@@ -581,3 +581,55 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
+
+struct warn_if_dangling_data {
+	FILE *fp;
+	const char *refname;
+	const struct string_list *refnames;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	struct object_id junk;
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
+	if (!resolves_to
+	    || (d->refname
+		? strcmp(resolves_to, d->refname)
+		: !string_list_has_string(d->refnames, resolves_to))) {
+		return 0;
+	}
+
+	fprintf(d->fp, d->msg_fmt, refname);
+	fputc('\n', d->fp);
+	return 0;
+}
+
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = refname;
+	data.refnames = NULL;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp = fp;
+	data.refname = NULL;
+	data.refnames = refnames;
+	data.msg_fmt = msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
-- 
2.4.2.644.g97b850b-twtrsrc
