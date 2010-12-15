From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/21] pathspec: add match_pathspec_depth()
Date: Wed, 15 Dec 2010 22:02:48 +0700
Message-ID: <1292425376-14550-14-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvM-00013J-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0LOPFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:05:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0LOPFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:05:33 -0500
Received: by mail-iy0-f174.google.com with SMTP id 12so937470iyi.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sG7kBYK2pJVfDsnFgmTJ8frl+v6Kwm9j5KgIdFNTUoc=;
        b=u6N4IwaXxMaX67btvM7QYIWBUutpHUpodBASC48a7Mb+krBoIBWy68A8t/OgxZPj1q
         Jugzz1SgoB47s8b3L3uhgBQz6YSnUXxqlOoHZgtdPObhiPA+tRPbHKd3Hj6UdzK8aage
         G8F3KWQ95j6itniKf7CtzmWEXimc4MOdW+a7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VghmIDR/YtI62quPNzMM4EtBgmtqh7OPRkw0rl5SAFR24BDfs6m34Aq+vwPzsmBNON
         1Bck0lrcy2ebkTM0LQ5IEORL/hco/lb1ykaj7Qc6/eF+33DdRmsm1XRe+tNO3Jk1ATSP
         HhUrpj2/GjB7f9ct5CRz7HX/lNv14hi/3Whx4=
Received: by 10.42.226.136 with SMTP id iw8mr5892682icb.462.1292425533374;
        Wed, 15 Dec 2010 07:05:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id d21sm1036055ibg.15.2010.12.15.07.05.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:40 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163765>

match_pathspec_depth() is a clone of match_pathspec() except that it
can take depth limit. Computation is a bit lighter compared to
match_pathspec() because it's usually precomputed and stored in struct
pathspec.

In long term, match_pathspec() and match_one() should be removed in
favor of this function.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dir.h |    3 ++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 66c163f..b1407a5 100644
--- a/dir.c
+++ b/dir.c
@@ -169,6 +169,95 @@ int match_pathspec(const char **pathspec, const ch=
ar *name, int namelen,
 	return retval;
 }
=20
+/*
+ * Does 'match' match the given name?
+ * A match is found if
+ *
+ * (1) the 'match' string is leading directory of 'name', or
+ * (2) the 'match' string is a wildcard and matches 'name', or
+ * (3) the 'match' string is exactly the same as 'name'.
+ *
+ * and the return value tells which case it was.
+ *
+ * It returns 0 when there is no match.
+ */
+static int match_pathspec_item(const struct pathspec_item *item, int p=
refix,
+			       const char *name, int namelen)
+{
+	/* name/namelen has prefix cut off by caller */
+	const char *match =3D item->match + prefix;
+	int matchlen =3D item->len - prefix;
+
+	/* If the match was just the prefix, we matched */
+	if (!*match)
+		return MATCHED_RECURSIVELY;
+
+	if (matchlen <=3D namelen && !strncmp(match, name, matchlen)) {
+		if (matchlen =3D=3D namelen)
+			return MATCHED_EXACTLY;
+
+		if (match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D '/')
+			return MATCHED_RECURSIVELY;
+	}
+
+	if (item->has_wildcard && !fnmatch(match, name, 0))
+		return MATCHED_FNMATCH;
+
+	return 0;
+}
+
+/*
+ * Given a name and a list of pathspecs, see if the name matches
+ * any of the pathspecs.  The caller is also interested in seeing
+ * all pathspec matches some names it calls this function with
+ * (otherwise the user could have mistyped the unmatched pathspec),
+ * and a mark is left in seen[] array for pathspec element that
+ * actually matched anything.
+ */
+int match_pathspec_depth(const struct pathspec *ps,
+			 const char *name, int namelen,
+			 int prefix, char *seen)
+{
+	int i, retval =3D 0;
+
+	if (!ps->nr) {
+		if (!ps->recursive || ps->max_depth =3D=3D -1)
+			return MATCHED_RECURSIVELY;
+
+		if (within_depth(name, namelen, 0, ps->max_depth))
+			return MATCHED_EXACTLY;
+		else
+			return 0;
+	}
+
+	name +=3D prefix;
+	namelen -=3D prefix;
+
+	for (i =3D ps->nr - 1; i >=3D 0; i--) {
+		int how;
+		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
+			continue;
+		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
+		if (ps->recursive && ps->max_depth !=3D -1 &&
+		    how && how !=3D MATCHED_FNMATCH) {
+			int len =3D ps->items[i].len;
+			if (name[len] =3D=3D '/')
+				len++;
+			if (within_depth(name+len, namelen-len, 0, ps->max_depth))
+				how =3D MATCHED_EXACTLY;
+			else
+				how =3D 0;
+		}
+		if (how) {
+			if (retval < how)
+				retval =3D how;
+			if (seen && seen[i] < how)
+				seen[i] =3D how;
+		}
+	}
+	return retval;
+}
+
 static int no_wildcard(const char *string)
 {
 	return string[strcspn(string, "*?[{\\")] =3D=3D '\0';
diff --git a/dir.h b/dir.h
index c71de08..ddb4147 100644
--- a/dir.h
+++ b/dir.h
@@ -65,6 +65,9 @@ struct dir_struct {
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
+extern int match_pathspec_depth(const struct pathspec *pathspec,
+				const char *name, int namelen,
+				int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
--=20
1.7.3.3.476.g10a82
