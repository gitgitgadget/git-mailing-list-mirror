From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] tree_entry_interesting: do basedir compare on wildcard patterns when possible
Date: Sat, 24 Nov 2012 11:33:51 +0700
Message-ID: <1353731631-20593-5-git-send-email-pclouds@gmail.com>
References: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:34:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc7S1-0005r6-RQ
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 05:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754Ab2KXEea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 23:34:30 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2KXEe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 23:34:29 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6867625pbc.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 20:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V56xiYnIqwyMHGhAluCKnx160jSpn18Yh+v3N/u2Jt0=;
        b=fYtf3pzriUyeXjy8Olc+xIY+a1zRi2z+VjxyHH4OsCCT+WRNvTMFnu/DsIFDr5xTAw
         3IZGoFSTzYUDDI3WgMtvJVm2VRe0n5azE7F1A17VpyLYfTyw/0F9VREtdlGGkLfqGWiD
         IbFHwjiXsU6M9PxaVAYn4eGeuS8kDOsGpezftuFBREVyyTWVxsIJgyt5EhuX5I5y5pnc
         BVV++6G8vrV6i/fK6hY8WMD/5afwhbxXUJtdtL7lrp2LG+QDqGLUvUx8DYARJ8SQmci6
         a8Cu05cciCae34XXcAwJQLIrjkcq9uETwlTB9ylv+4nEF4KkHiALTFKrARXHDPBhLtBP
         TS9g==
Received: by 10.68.252.133 with SMTP id zs5mr19203867pbc.152.1353731668925;
        Fri, 23 Nov 2012 20:34:28 -0800 (PST)
Received: from lanh ([115.74.35.242])
        by mx.google.com with ESMTPS id s1sm4768975paz.0.2012.11.23.20.34.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 20:34:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 24 Nov 2012 11:34:23 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210315>

Currently we treat "*.c" and "path/to/*.c" the same way. Which means
we check all possible paths in repo against "path/to/*.c". One could
see that "path/elsewhere/foo.c" obviously cannot match "path/to/*.c"
and we only need to check all paths _inside_ "path/to/" against that
pattern.

This patch checks the leading fixed part of a pathspec against base
directory and exit early if possible. We could even optimize further
in "path/to/something*.c" case (i.e. check the fixed part against
name_entry as well) but that's more complicated and probably does not
gain us much.

-O2 build on linux-2.6, without and with this patch respectively:

$ time git rev-list --quiet HEAD -- 'drivers/*.c'

real    1m9.484s
user    1m9.128s
sys     0m0.181s

$ time ~/w/git/git rev-list --quiet HEAD -- 'drivers/*.c'

real    0m15.710s
user    0m15.564s
sys     0m0.107s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tree-walk.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 585899e..9d6e59b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -573,6 +573,52 @@ static int match_dir_prefix(const char *base,
 }
=20
 /*
+ * Perform matching on the leading non-wildcard part of
+ * pathspec. item->nowildcard_len must be greater than zero. Return
+ * non-zero if base is matched.
+ */
+static int match_wildcard_base(const struct pathspec_item *item,
+			       const char *base, int baselen,
+			       int *matched)
+{
+	const char *match =3D item->match;
+	/* the wildcard part is not considered in this function */
+	int matchlen =3D item->nowildcard_len;
+
+	if (baselen) {
+		int dirlen;
+		/*
+		 * Return early if base is longer than the
+		 * non-wildcard part but it does not match.
+		 */
+		if (baselen >=3D matchlen) {
+			*matched =3D matchlen;
+			return !strncmp(base, match, matchlen);
+		}
+
+		dirlen =3D matchlen;
+		while (dirlen && match[dirlen - 1] !=3D '/')
+			dirlen--;
+
+		/* Return early if base is shorter than the
+		   non-wildcard part but it does not match. Note that
+		   base ends with '/' so we are sure it really matches
+		   directory */
+		if (strncmp(base, match, baselen))
+			return 0;
+		*matched =3D baselen;
+	} else
+		*matched =3D 0;
+	/*
+	 * we could have checked entry against the non-wildcard part
+	 * that is not in base and does similar never_interesting
+	 * optimization as in match_entry. For now just be happy with
+	 * base comparison.
+	 */
+	return entry_interesting;
+}
+
+/*
  * Is a tree entry interesting given the pathspec we have?
  *
  * Pre-condition: either baselen =3D=3D base_offset (i.e. empty path)
@@ -602,7 +648,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
 		const char *base_str =3D base->buf + base_offset;
-		int matchlen =3D item->len;
+		int matchlen =3D item->len, matched =3D 0;
=20
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
@@ -647,9 +693,24 @@ match_wildcards:
 		if (item->nowildcard_len =3D=3D item->len)
 			continue;
=20
+		if (item->nowildcard_len &&
+		    !match_wildcard_base(item, base_str, baselen, &matched))
+			return entry_not_interesting;
+
 		/*
 		 * Concatenate base and entry->path into one and do
 		 * fnmatch() on it.
+		 *
+		 * While we could avoid concatenation in certain cases
+		 * [1], which saves a memcpy and potentially a
+		 * realloc, it turns out not worth it. Measurement on
+		 * linux-2.6 does not show any clear improvements,
+		 * partly because of the nowildcard_len optimization
+		 * in git_fnmatch(). Avoid micro-optimizations here.
+		 *
+		 * [1] if match_wildcard_base() says the base
+		 * directory is already matched, we only need to match
+		 * the rest, which is shorter so _in theory_ faster.
 		 */
=20
 		strbuf_add(base, entry->path, pathlen);
--=20
1.8.0.rc2.23.g1fb49df
