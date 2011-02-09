From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/16] ls: immitate UNIX ls output style
Date: Wed,  9 Feb 2011 19:24:42 +0700
Message-ID: <1297254284-3729-15-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn99Y-00089j-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab1BIM2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:28:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58002 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:28:03 -0500
Received: by iyj8 with SMTP id 8so94087iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=kwWG7j8bCG3VqXYTm47bI1Ck5jF5I8LQOx1pohlzO8w=;
        b=Yqc/BKnA/rYv44RMyAiSvXH6d59FDXHFOaRzNXtZKMXJMhzuvVVZOdIRm+pqP3WLVY
         QWPAiUt2C8oIMFr2G02f2NgX1SBm+LtG28NQzk7gBFEH9loeSaYzsq4fU1MRK4TbTvdF
         2OZYJiSUB6ObXuMFpX6vWNSIpQu8u7b2rd7y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MLoTz3Bj1Zw50nO/eVfdp70tdEsW5WUuBH9WuAueqsy14qpGzjo9B5Lz7L0FGVmI7u
         v9x81ty1vAhpgTEZgTO4CiKfG8/WGspBuDY5njuvQ/na/AHRrkWNACr/3iKOHj7PgC3U
         QY0ypBBAQRAmgvs5NKlloSyWtJMnd/qRklCVw=
Received: by 10.42.170.202 with SMTP id g10mr2505807icz.489.1297254483411;
        Wed, 09 Feb 2011 04:28:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id ca7sm225093icb.0.2011.02.09.04.27.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:28:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:33 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166418>

Two points:

 - When input is a mixed of directories and files, files will be
   grouped and displayed first. Directory content will follow.

 - GNU ls when examining a directory will output files relative to
   that directory.

Index does not have directories. There nearest thing to that is
pathspecs that expand to more than one item. So in Git the rules become=
:

 - Multiple match pathspecs is printed with a header, the pathspec,
   then the content (its expansion). If there is only one pathspec, no
   header will be printed.

 - The common directory prefix of all files from a pathspec will be
   stripped (not yet implemented)

 - One-match pathspecs will be grouped and printed out first like
   the result of a virtual multiple match pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Mixing multiple entry types (others and cached) will result in
 duplicates and unsorted output. The command is a porcelain now,
 perhaps we should sort/uniq output?

 one_match_pathspec() needs better impl.

 builtin/ls-files.c |  101 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 87ee728..22e0c87 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -676,10 +676,46 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	return 0;
 }
=20
+static int one_match_pathspec(const char *pathspec)
+{
+	struct stat st;
+	int len =3D strlen(pathspec);
+
+	if (show_cached) {
+		char *new_path;
+		int pos =3D index_name_pos(&the_index, pathspec, len);
+		if (pos >=3D 0)
+			return 1;
+
+		new_path =3D xmalloc(len+2);
+		memcpy(new_path, pathspec, len);
+		new_path[len++] =3D '/';
+		new_path[len] =3D 0;
+		pos =3D index_name_pos(&the_index, pathspec, len);
+		if (pos >=3D 0)
+			die("BUG: Wait there are directories in index??");
+		pos =3D -pos-1;
+
+		/* dir match */
+		if (!strncmp(the_index.cache[pos]->name, new_path, len)) {
+			free(new_path);
+			return 0;
+		}
+		free(new_path);
+	}
+
+	if (!stat(pathspec, &st) && !S_ISDIR(st.st_mode))
+		return 1;
+
+	return 0;
+}
+
 int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
 {
+	int show_pathspec;
+	const char **pathspecs, **one_matches =3D NULL;
 	struct dir_struct dir;
-	int recursive =3D 0;
+	int recursive =3D 0, src, dst, len;
 	struct option builtin_ls_files_options[] =3D {
 		OPT_BOOLEAN('c', "cached", &show_cached,
 			"show cached files in the output (default)"),
@@ -720,20 +756,75 @@ int cmd_ls(int argc, const char **argv, const cha=
r *cmd_prefix)
 	if (dir.flags & DIR_SHOW_IGNORED || show_others)
 		setup_standard_excludes(&dir);
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	pathspecs =3D get_pathspec(prefix, argv);
=20
 	if (show_modified)
-		refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
+		refresh_index(&the_index, REFRESH_QUIET, pathspecs, NULL, NULL);
+
+	if (!pathspecs) {
+		static const char *spec[2];
+		spec[0] =3D ".";
+		spec[1] =3D NULL;
+		pathspecs =3D get_pathspec(prefix, spec);
+	}
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
 	      show_killed | show_modified | show_resolve_undo))
 		show_cached =3D 1;
=20
+	/*
+	 * Group one-match pathspecs together. Shell expansion may
+	 * turn foo* to fooa foob/ and fooc. List fooa and fooc, leave
+	 * foob for later.
+	 */
+	len =3D src =3D dst =3D 0;
+	while (pathspecs[src]) {
+		if (one_match_pathspec(pathspecs[src])) {
+			len++;
+			one_matches =3D xrealloc(one_matches, sizeof(*one_matches) * (len+1=
));
+			one_matches[len - 1] =3D pathspecs[src];
+			src++;
+			continue;
+		}
+		if (src !=3D dst)
+			pathspecs[dst] =3D pathspecs[src];
+		src++;
+		dst++;
+	}
+	pathspecs[dst] =3D NULL;
+
 	if (!recursive)
 		depth_limit =3D 1;
=20
-	show_files(&dir);
-	display_columns(&output, column_mode, term_columns(), 2, NULL);
+	if (len) {
+		one_matches[len] =3D NULL;
+		pathspec =3D one_matches;
+		show_files(&dir);
+		display_columns(&output, column_mode, term_columns(), 2, NULL);
+		string_list_clear(&output, 0);
+		if (dst)
+			printf("\n");
+	}
+
+	if (!pathspecs[0])
+		return 0;
+
+	show_pathspec =3D dst > 1 || len;
+	pathspec =3D xmalloc(sizeof(*pathspec)*2);
+	pathspec[1] =3D NULL;
+	while (*pathspecs) {
+		pathspec[0] =3D pathspecs[0];
+		pathspecs++;
+
+		show_files(&dir);
+		if (output.nr && show_pathspec)
+			printf("%s:\n", pathspec[0]);
+
+		display_columns(&output, column_mode, term_columns(), 2, NULL);
+		string_list_clear(&output, 0);
+		if (show_pathspec && pathspecs[0])
+			printf("\n");
+	}
 	return 0;
 }
--=20
1.7.2.2
