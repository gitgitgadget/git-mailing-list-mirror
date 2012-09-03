From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch: align new ref summary printout in UTF-8 locales
Date: Mon,  3 Sep 2012 18:10:09 +0700
Message-ID: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 13:17:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Ueg-0004GF-GR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 13:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab2ICLRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 07:17:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2ICLRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 07:17:05 -0400
Received: by dady13 with SMTP id y13so3631398dad.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ELw+68RbAD9oCJ5Dd9c/DGmf7JOlt1KCgiidzQsnmSI=;
        b=uDaRhndCTa17RGpmTZRXEdXBCT1Y3/N6sV1qJ4lGC5Xk6rhnCuTsKjvMbhROnA+od5
         8YCu/cjxhJbSJ01S+BHcWFAWKBA0t7oexFEW/SeaOFE9buXEiRRvuW/BezEMUcIga+4W
         Youpn0B9rNmJZU2qpldkMVAzHn7WMIqI9FOGnvRWYU47YYMJjegOssiW9xOw+5q2/Fa3
         onKwTFoXjVnAguyAZ0WjcaK1gAXGQZcsJcCgNDFEIS/TMNDix08oSwley7ZNpQItRS81
         cEg6fUAzPIBnfkyggoLxzpXlo86HRZfayYn2YPo48uX/3/dPHzaEkjvd9m48H0weYexn
         uBrg==
Received: by 10.68.138.135 with SMTP id qq7mr37840315pbb.167.1346671024968;
        Mon, 03 Sep 2012 04:17:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id tq4sm9737056pbc.11.2012.09.03.04.17.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Sep 2012 04:17:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 03 Sep 2012 18:10:39 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204686>

fetch does printf("%-*s", width, "foo") where "foo" can be an utf-8
string, but width is bytes, not letters. This results in misaligned
ref summary table.

Introduce gettext_length() function that returns the string length in
letters. Make the code use TRANSPORT_SUMMARY(x) where the length is
compensated properly in utf-8 locales.
---
 gettext_length() can be made to support other charsets too. But I'm
 on utf-8, it's not my itch.

 Grepping through '%-*s' does not reveal any other places that obviously
 need adjustment like this (apply and remote might, but pathnames and
 remote names are usually in ascii)

 builtin/fetch.c | 22 ++++++++++------------
 gettext.c       | 14 ++++++++++++--
 gettext.h       |  5 +++++
 transport.c     |  2 +-
 transport.h     |  1 +
 5 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..d7406d2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -255,9 +255,8 @@ static int update_local_ref(struct ref *ref,
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
 			strbuf_addf(display, "= %-*s %-*s -> %s",
-				    TRANSPORT_SUMMARY_WIDTH,
-				    _("[up to date]"), REFCOL_WIDTH,
-				    remote, pretty_ref);
+				    TRANSPORT_SUMMARY(_("[up to date]")),
+				    REFCOL_WIDTH, remote, pretty_ref);
 		return 0;
 	}
 
@@ -271,7 +270,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		strbuf_addf(display,
 			    _("! %-*s %-*s -> %s  (can't fetch in current branch)"),
-			    TRANSPORT_SUMMARY_WIDTH, _("[rejected]"),
+			    TRANSPORT_SUMMARY(_("[rejected]")),
 			    REFCOL_WIDTH, remote, pretty_ref);
 		return 1;
 	}
@@ -282,7 +281,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("updating tag", ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '-',
-			    TRANSPORT_SUMMARY_WIDTH, _("[tag update]"),
+			    TRANSPORT_SUMMARY(_("[tag update]")),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
@@ -317,7 +316,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref(msg, ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
-			    TRANSPORT_SUMMARY_WIDTH, what,
+			    TRANSPORT_SUMMARY(what),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
@@ -335,7 +334,7 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("fast-forward", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : ' ',
-			    TRANSPORT_SUMMARY_WIDTH, quickref,
+			    TRANSPORT_SUMMARY(quickref),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
@@ -351,13 +350,13 @@ static int update_local_ref(struct ref *ref,
 		r = s_update_ref("forced-update", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
 			    r ? '!' : '+',
-			    TRANSPORT_SUMMARY_WIDTH, quickref,
+			    TRANSPORT_SUMMARY(quickref),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("unable to update local ref") : _("forced update"));
 		return r;
 	} else {
 		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
-			    TRANSPORT_SUMMARY_WIDTH, _("[rejected]"),
+			    TRANSPORT_SUMMARY(_("[rejected]")),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    _("(non-fast-forward)"));
 		return 1;
@@ -479,8 +478,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				free(ref);
 			} else
 				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-					    TRANSPORT_SUMMARY_WIDTH,
-					    *kind ? kind : "branch",
+					    TRANSPORT_SUMMARY(*kind ? kind : "branch"),
 					    REFCOL_WIDTH,
 					    *what ? what : "HEAD");
 			if (note.len) {
@@ -554,7 +552,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 			result |= delete_ref(ref->name, NULL, 0);
 		if (verbosity >= 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY_WIDTH, _("[deleted]"),
+				TRANSPORT_SUMMARY(_("[deleted]")),
 				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
diff --git a/gettext.c b/gettext.c
index f75bca7..e9f0f0d 100644
--- a/gettext.c
+++ b/gettext.c
@@ -4,6 +4,8 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
+#include "strbuf.h"
+#include "utf8.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -27,10 +29,9 @@ int use_gettext_poison(void)
 #endif
 
 #ifndef NO_GETTEXT
+static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
-	const char *charset;
-
 	/*
 	   This trick arranges for messages to be emitted in the user's
 	   requested encoding, but avoids setting LC_CTYPE from the
@@ -128,4 +129,13 @@ void git_setup_gettext(void)
 	init_gettext_charset("git");
 	textdomain("git");
 }
+
+int gettext_length(const char *s)
+{
+	static int is_utf8 = -1;
+	if (is_utf8 == -1)
+		is_utf8 = !strcmp(charset, "UTF-8");
+
+	return is_utf8 ? utf8_strwidth(s) : strlen(s);
+}
 #endif
diff --git a/gettext.h b/gettext.h
index 57ba8bb..7ea6db4 100644
--- a/gettext.h
+++ b/gettext.h
@@ -30,10 +30,15 @@
 
 #ifndef NO_GETTEXT
 extern void git_setup_gettext(void);
+extern int gettext_length(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
 }
+static inline int gettext_length(const char *s)
+{
+	return strlen(s);
+}
 #endif
 
 #ifdef GETTEXT_POISON
diff --git a/transport.c b/transport.c
index 1811b50..863aaa6 100644
--- a/transport.c
+++ b/transport.c
@@ -629,7 +629,7 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summary);
+		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY(summary));
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
diff --git a/transport.h b/transport.h
index b866c12..1c95a8c 100644
--- a/transport.h
+++ b/transport.h
@@ -106,6 +106,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+#define TRANSPORT_SUMMARY(x) (TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_length(x)), (x)
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.7.12.rc2.18.g61b472e
