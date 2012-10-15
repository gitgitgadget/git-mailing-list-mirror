From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/12] dir.c: refactor is_excluded_from_list()
Date: Mon, 15 Oct 2012 13:27:59 +0700
Message-ID: <1350282486-4646-5-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAm-00010I-L8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2JOG26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:28:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JOG25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:28:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XKL0rekH/g3U/5vMtz3NfHnLuRfjxzND/Qat61+Fv7M=;
        b=HvCwwIPvHLhdZMgTDmFh4a052JwE/J5aCZgNzw+ErT236QDBAunE5ODxnbDn6O7J67
         M1SJVqCEiOSyo/z9498se6/qIfuGoSyGV+DE2f1o7OCi5W+5cOoAsBMBNLLbUmD8Tk0h
         9Kg2uCQNDimxId4K0hlc4J/NTHylZPiRs9LB/paMk8/Lqq/PgoA5+KnbnSZ4nPigpDD8
         +DoC83C/F5Nxm4nGNJeuMZoo7URSrj1nfVZjJ7h6b3LE6vuEH6iauI2EOP9+FdIwprPT
         8+D/RjtwYOeZ3/roQLVArKxQTvsazA91q4vPqPxCFbUmOvtfKJCQ9Gcw8VUvMNT6MwgZ
         448A==
Received: by 10.68.229.138 with SMTP id sq10mr34748063pbc.126.1350282537146;
        Sun, 14 Oct 2012 23:28:57 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id j9sm8593755pav.15.2012.10.14.23.28.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:28:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:47 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207716>

=46rom: Adam Spiers <git@adamspiers.org>

The excluded function uses a new helper function called
last_exclude_matching_from_list() to perform the inner loop over all of
the exclude patterns.  The helper just tells us whether the path is
included, excluded, or undecided.

However, it may be useful to know _which_ pattern was triggered.  So
let's pass out the entire exclude match, which contains the status
information we were already passing out.

=46urther patches can make use of this.

This is a modified forward port of a patch from 2009 by Jeff King:
http://article.gmane.org/gmane.comp.version-control.git/108815

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 50381f8..859e0f9 100644
--- a/dir.c
+++ b/dir.c
@@ -596,22 +596,26 @@ int match_pathname(const char *pathname, int path=
len,
 	return fnmatch_icase(pattern, name, FNM_PATHNAME) =3D=3D 0;
 }
=20
-/* Scan the list and let the last match determine the fate.
- * Return 1 for exclude, 0 for include and -1 for undecided.
+/*
+ * Scan the given exclude list in reverse to see whether pathname
+ * should be ignored.  The first match (i.e. the last on the list), if
+ * any, determines the fate.  Returns the exclude_list element which
+ * matched, or NULL for undecided.
  */
-int is_excluded_from_list(const char *pathname,
-			  int pathlen, const char *basename, int *dtype,
-			  struct exclude_list *el)
+static struct exclude *last_exclude_matching_from_list(const char *pat=
hname,
+						       int pathlen,
+						       const char *basename,
+						       int *dtype,
+						       struct exclude_list *el)
 {
 	int i;
=20
 	if (!el->nr)
-		return -1;	/* undefined */
+		return NULL;	/* undefined */
=20
 	for (i =3D el->nr - 1; 0 <=3D i; i--) {
 		struct exclude *x =3D el->excludes[i];
 		const char *exclude =3D x->pattern;
-		int to_exclude =3D x->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 		int prefix =3D x->nowildcardlen;
=20
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
@@ -626,7 +630,7 @@ int is_excluded_from_list(const char *pathname,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
 					   x->flags))
-				return to_exclude;
+				return x;
 			continue;
 		}
=20
@@ -634,8 +638,23 @@ int is_excluded_from_list(const char *pathname,
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
 				   exclude, prefix, x->patternlen, x->flags))
-			return to_exclude;
+			return x;
 	}
+	return NULL; /* undecided */
+}
+
+/*
+ * Scan the list and let the last match determine the fate.
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_list(const char *pathname,
+			  int pathlen, const char *basename, int *dtype,
+			  struct exclude_list *el)
+{
+	struct exclude *exclude;
+	exclude =3D last_exclude_matching_from_list(pathname, pathlen, basena=
me, dtype, el);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
=20
--=20
1.8.0.rc0.29.g1fdd78f
