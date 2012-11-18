From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] tree_entry_interesting: do basedir compare on wildcard patterns when possible
Date: Sun, 18 Nov 2012 16:13:09 +0700
Message-ID: <1353229989-13075-5-git-send-email-pclouds@gmail.com>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 10:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0wh-00064d-ND
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab2KRJN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:13:27 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:32812 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2KRJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 04:13:25 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so313271dak.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DaZqoVchNiQtcW2S9GLITcPi0PF7GiOETtV4mLrK/Pw=;
        b=vKuAhTXDVYKVSupsO1BgCIrAk10NRAOyveBLBcXDwed4NYj5vuUkKOHtBUcByJZZjb
         eh64+VRiBCLkAtD8PnYvJKjy2QzdLIXdwrtxXNhG6oCCQcpMllYY58RiJhBzNFge6Bxd
         QhRpxsq2Y9G1yIRvS/HC13o9UAjjDuRWaX6fPmWPxQ6XyrkVeTI4IMSaQTmUixTZXwic
         xY8A9r75ak3ljacV4KxK3+dkAdZhnRtqmbvIc70OArDDgdO8FcBr7XqDHTRvN0StvkM8
         HOlEbuihkyfvDNt9pA1hYwLj8wkMC4DJiddtcKk8rTH30i7T/NdDNEou+W1obxKIRoiz
         ZU/w==
Received: by 10.68.247.39 with SMTP id yb7mr24639751pbc.15.1353230005264;
        Sun, 18 Nov 2012 01:13:25 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id os5sm4240568pbc.15.2012.11.18.01.13.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 01:13:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 18 Nov 2012 16:13:32 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210001>

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
---
 tree-walk.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 42fe610..dcc1015 100644
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
