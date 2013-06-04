From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/15] pretty: extend pretty_print_context with callback
Date: Tue,  4 Jun 2013 18:05:27 +0530
Message-ID: <1370349337-20938-6-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRS-0006ui-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab3FDMeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:34:08 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:54712 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3FDMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:04 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so171410pde.32
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/1O9Zh6zmP12E/1eJ1V1s8DVgwL4jnK0Bnup5Y8tvbY=;
        b=DS3DruG/yFtz1bddwVYMKUIcB2CCg7pgV5Wfd0FGbeg6+E77EZ6LvObaVkE8ANcKVJ
         wOk0/jo/n7e3Mt6S4ikyODJPoeUPrqimv8UQIDXGO5ZMmqs0G7R+7gnssBRVOoh8dwlI
         f8Fqdgw0f6b3TdWVhMIFNnTeJwuttQR+IoHZzBbV7MdZPsi4amFM/a7JNhL57hkx81Xi
         JIHN0vGnGV87SiRkoiXaBpGWBe6TjwJSMUoZ+21K+hw2d8laCEkX8U+r21nfMtwNF3sF
         a9eemYY4fY0F1+/dZPS9qXZFFP6xJVKw4iF70/s/MeHMWuiiY7cNQeWrXM6krnYcbF6r
         en9w==
X-Received: by 10.66.146.65 with SMTP id ta1mr2766463pab.7.1370349243977;
        Tue, 04 Jun 2013 05:34:03 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226348>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The struct pretty_print_context contains the context in which the
placeholders in format_commit_one() should be parsed.  Although
format_commit_one() primarily acts as a parser, there is no way for a
caller to plug in custom callbacks.  Now, callers can:

1. Parse a custom placeholder that is not supported by
   format_commit_one(), and act on it independently of the pretty
   machinery.

2. Parse a custom placeholder to substitute the custom placeholder with
   a placeholder that format_commit_one() understands.  This is
   especially useful for supporting %>(*), where * is substituted with =
a
   length computed by the caller.

To support these two usecases, the interface for the function looks
like:

typedef size_t (*format_message_fn)(struct strbuf *sb,
				const char *placeholder,
				void *format_context,
				void *user_data,
				struct strbuf *placeholder_subst)

It is exactly like format_commit_one(), except that there are two
additional fields: user_data (to pass custom data to the callback), and
placeholder_subst (to set the substitution).  The callback should retur=
n
the length of the original string parsed, and optionally set
placeholder_subst.

[rr: commit message, minor modifications]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 commit.h |  8 ++++++++
 pretty.c | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/commit.h b/commit.h
index 67bd509..04bd935 100644
--- a/commit.h
+++ b/commit.h
@@ -78,6 +78,12 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED
 };
=20
+typedef size_t (*format_message_fn)(struct strbuf *sb,
+				const char *placeholder,
+				void *format_context,
+				void *user_data,
+				struct strbuf *placeholder_subst);
+
 struct pretty_print_context {
 	enum cmit_fmt fmt;
 	int abbrev;
@@ -92,6 +98,8 @@ struct pretty_print_context {
 	const char *output_encoding;
 	struct string_list *mailmap;
 	int color;
+	format_message_fn format;
+	void *user_data;
 };
=20
 struct userformat_want {
diff --git a/pretty.c b/pretty.c
index 9e43154..095e5ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1069,6 +1069,31 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 	struct commit_list *p;
 	int h1, h2;
=20
+	if (c->pretty_ctx->format) {
+		struct strbuf subst =3D STRBUF_INIT;
+		int ret =3D c->pretty_ctx->format(sb, placeholder, context,
+						c->pretty_ctx->user_data,
+						&subst);
+		if (ret && subst.len) {
+			/*
+			 * Something was parsed by format(), and a
+			 * placeholder-substitution was set.
+			 * Recursion is required to override the
+			 * return value of format_commit_one() with
+			 * ret: the length of the original string
+			 * before substitution.
+			 */
+			ret =3D format_commit_one(sb, subst.buf, context) ? ret : 0;
+			strbuf_release(&subst);
+			return ret;
+		} else if (ret)
+			/*
+			 * Something was parsed by format(), but
+			 * no placeholder-substitution was set.
+			 */
+			return ret;
+	}
+
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
--=20
1.8.3.GIT
