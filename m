From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Tue,  4 Sep 2012 17:39:35 +0700
Message-ID: <1346755175-31468-1-git-send-email-pclouds@gmail.com>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 12:46:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8qe8-0005OW-8j
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 12:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab2IDKqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 06:46:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64558 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2IDKqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 06:46:06 -0400
Received: by pbbrr13 with SMTP id rr13so9289608pbb.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=82tJtWxjEI+BafjudODRLEk1updCLzdsEProERj49Q8=;
        b=MgxJT11AP1F7ldRw4+eOjeFv59yX+Jd7d8SPKtsV6jVnbPCaKDzGob7WqqUKK2bsEe
         PCWNU0HsXXrPMN3uruj6fdDP7hnllswdlDBuv2XJz1m/LdXjKUHbfqVI1FjttYNI65Pi
         zgdkqdlcQdK9YOSX8coZ52+XAgXLbXoyhAGVWK0LVGp76oAti8882A7iLcJiGFtqZmoc
         LHlEyWT1knMUL2J3WWiDzjDXpMt4NMpUG7UDtr9Rb3QkklavHYXaH655EdY9D6eZysbE
         rH5deVCind4ot3QbzkBEUFzk78fHpk9aURE4Y1oezCVmi0J6Wq5qMPrD6i+zrY8PgYKQ
         rBrg==
Received: by 10.66.77.71 with SMTP id q7mr40460176paw.0.1346755566375;
        Tue, 04 Sep 2012 03:46:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id hr9sm11957443pbc.36.2012.09.04.03.46.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 03:46:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Sep 2012 17:39:36 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204735>

fetch does printf("%-*s", width, "foo") where "foo" can be a utf-8
string, but width is in bytes, not columns. For ASCII it's fine as one
byte takes one column. For utf-8, this may result in misaligned ref
summary table.

Introduce gettext_width() function that returns the string length in
columns (currently only supports utf-8 locales). Make the code use
TRANSPORT_SUMMARY(x) where the length is compensated properly in
non-English locales.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  - rename gettext_length() to gettext_width()
  - use "width" instead of letters
  - leave other "%-*s" places unchanged if they always take ascii
    strings (i.e. no _() calls)
  - note to self, may need to i18n-ize print_ref_status() in
    transport.c, looks like it's used by git-push only

 builtin/fetch.c | 15 +++++++--------
 gettext.c       | 15 +++++++++++++--
 gettext.h       |  5 +++++
 transport.h     |  1 +
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..85e291f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -255,9 +255,8 @@ static int update_local_ref(struct ref *ref,
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
 			strbuf_addf(display, "=3D %-*s %-*s -> %s",
-				    TRANSPORT_SUMMARY_WIDTH,
-				    _("[up to date]"), REFCOL_WIDTH,
-				    remote, pretty_ref);
+				    TRANSPORT_SUMMARY(_("[up to date]")),
+				    REFCOL_WIDTH, remote, pretty_ref);
 		return 0;
 	}
=20
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
 		r =3D s_update_ref("updating tag", ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '-',
-			    TRANSPORT_SUMMARY_WIDTH, _("[tag update]"),
+			    TRANSPORT_SUMMARY(_("[tag update]")),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
@@ -317,7 +316,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
-			    TRANSPORT_SUMMARY_WIDTH, what,
+			    TRANSPORT_SUMMARY(what),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
@@ -357,7 +356,7 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	} else {
 		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
-			    TRANSPORT_SUMMARY_WIDTH, _("[rejected]"),
+			    TRANSPORT_SUMMARY(_("[rejected]")),
 			    REFCOL_WIDTH, remote, pretty_ref,
 			    _("(non-fast-forward)"));
 		return 1;
@@ -554,7 +553,7 @@ static int prune_refs(struct refspec *refs, int ref=
_count, struct ref *ref_map)
 			result |=3D delete_ref(ref->name, NULL, 0);
 		if (verbosity >=3D 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY_WIDTH, _("[deleted]"),
+				TRANSPORT_SUMMARY(_("[deleted]")),
 				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
diff --git a/gettext.c b/gettext.c
index f75bca7..71e9545 100644
--- a/gettext.c
+++ b/gettext.c
@@ -4,6 +4,8 @@
=20
 #include "git-compat-util.h"
 #include "gettext.h"
+#include "strbuf.h"
+#include "utf8.h"
=20
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -27,10 +29,9 @@ int use_gettext_poison(void)
 #endif
=20
 #ifndef NO_GETTEXT
+static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
-	const char *charset;
-
 	/*
 	   This trick arranges for messages to be emitted in the user's
 	   requested encoding, but avoids setting LC_CTYPE from the
@@ -128,4 +129,14 @@ void git_setup_gettext(void)
 	init_gettext_charset("git");
 	textdomain("git");
 }
+
+/* return the number of columns of string 's' in current locale */
+int gettext_width(const char *s)
+{
+	static int is_utf8 =3D -1;
+	if (is_utf8 =3D=3D -1)
+		is_utf8 =3D !strcmp(charset, "UTF-8");
+
+	return is_utf8 ? utf8_strwidth(s) : strlen(s);
+}
 #endif
diff --git a/gettext.h b/gettext.h
index 57ba8bb..e44d8bc 100644
--- a/gettext.h
+++ b/gettext.h
@@ -30,10 +30,15 @@
=20
 #ifndef NO_GETTEXT
 extern void git_setup_gettext(void);
+extern int gettext_width(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
 }
+static inline int gettext_width(const char *s)
+{
+	return strlen(s);
+}
 #endif
=20
 #ifdef GETTEXT_POISON
diff --git a/transport.h b/transport.h
index b866c12..a5d375e 100644
--- a/transport.h
+++ b/transport.h
@@ -106,6 +106,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
=20
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+#define TRANSPORT_SUMMARY(x) (TRANSPORT_SUMMARY_WIDTH + strlen(x) - ge=
ttext_width(x)), (x)
=20
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
--=20
1.7.12.rc2.18.g61b472e
