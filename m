From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 10/43] refs.c: move warn_if_dangling_symref* to the common code
Date: Mon, 28 Sep 2015 18:01:45 -0400
Message-ID: <1443477738-32023-11-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXe-0002pk-QB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbbI1WE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:58 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33874 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbI1WDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:07 -0400
Received: by qgez77 with SMTP id z77so134277972qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C79tNbk+FLqsItOydp+kZ+MA1yBaq+zITE8Ai4LXKPE=;
        b=Sa5Bpc2YbbGTqtEzfP/4xHV1Kbb9DJ05USLJWO32wgQuTrr0S6xwMlPHMN3KkzSU8c
         Nop00MRaDaH/dX329S8ILJAd9+pEdssbWZGaTIamrKvvLM53buOLBfk5sGvTAQWulLSd
         02JCHpQQTjpGaEI+pRvzSSb1T/UAr/bERA5V717KzN1i8Z409ZWhTzLxjy50j3vLrNXW
         H7aB+Jo2vBMMkeytTM3yh6m+LPY3+EP6txRwesB5VgvN+qMSl0ZrDVSIjLabzPNMapXO
         NvQ5Dk30TD+mesZZ/Vv9BKGBN48gB/ToHjbSR9FYZuiK/gyIs9FkBdpAL51FAngkXGQf
         EUFw==
X-Gm-Message-State: ALoCoQlQzdTIx+25RU2SGZdwQKixBEk+qbuEqpvRWj3J+OPL6pmIB+sOpte9yrIXpoieWSPP2nz8
X-Received: by 10.140.96.84 with SMTP id j78mr25683086qge.94.1443477786517;
        Mon, 28 Sep 2015 15:03:06 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278792>

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
index eb660bb..2495d42 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1956,58 +1956,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
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
