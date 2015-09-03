From: David Turner <dturner@twopensource.com>
Subject: [PATCH 10/43] refs.c: move warn_if_dangling_symref* to the common code
Date: Wed,  2 Sep 2015 21:54:40 -0400
Message-ID: <1441245313-11907-11-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJn3-0007fH-2h
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbbICB54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:56 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34658 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbbICBzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:36 -0400
Received: by qkfq186 with SMTP id q186so15070983qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65HgnHqHaxRvjHnnTz9G18BMeZ6Lw/8TMEgrNl891L0=;
        b=RAnz7+76hK5ECHvnsSPPdFp41+pm8TlGyvYOEC5ARaJYVNeX5wAuNfCFNPbQ8R3CRE
         xytAvI9VAbpEAaB1wBHfP17eP9Q3ZHoyi7fgeE8xLDjRBwVs9/4VTl4qf3iJGsNVkir5
         uoJLxdRMmy++0QpXhW1QPDeEGGS2JFK2PxNyv48f1dw6dr5yn7VTDzaPv32k0pTT5pEs
         xug2OzqHHXdsdkqyURmiC4XOV1Jundr86BdY+D/Apo2znnbPdJq98x9lNEW1QLF4vhFq
         Z+m6CC78e9n7HHVaKjV1FakwFXZUaOknZ5lBucVYfxJD3+f2vieh+XQl2G6ZwwVvtfdu
         t/XA==
X-Gm-Message-State: ALoCoQkX/C5s4kI8mv7MGUFzlhUsE0h16GNN7vdtecBZ6upgU9WGQpGN280f8Q6joxHqJ3RGZh2K
X-Received: by 10.55.192.130 with SMTP id v2mr33428295qkv.82.1441245336203;
        Wed, 02 Sep 2015 18:55:36 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277179>

From: Ronnie Sahlberg <sahlberg@google.com>

These functions do not use any backend specific code so we move
them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 52 ----------------------------------------------------
 refs.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 4f0e3c7..9c0dd5c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1953,58 +1953,6 @@ int peel_ref(const char *refname, unsigned char *sha1)
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
2.0.4.315.gad8727a-twtrsrc
