From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/16] ls: add --recursive and turn default to non-recursive mode
Date: Wed,  9 Feb 2011 19:24:41 +0700
Message-ID: <1297254284-3729-14-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn99Q-00083J-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab1BIM16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:58 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:57 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so74477iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+TuPr9I80Mu9TLwJs9ouzCtRT7P39lV7A7l0VKWqnNY=;
        b=HWHJ69CMsB5TPnBAV4edikWWkNYpVoN5nWPB06IzM+zXrwsEQYcU6aqIJ9Mwt9ueQX
         j23maeX3DY0BTZThX4PTXuHDQPEz82wB1X/8s7uDCtMcIdjhG3UpOb3vZdJ/xUDbCxFG
         KrX12PTBvyI2q/yLTOFXqTRElfDxBXS8HGJ04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Wvl/ReC8wmStvHnXlomH8nED7JhOHDsIz0wBATmGGSEgG4/c4F0V6pBDriDO5d48Ac
         hdKZ6fks8QJQ4am0E7SN9YNiw+Ja4IK5201O+6lHNkrraLoa1+NbfLccrYPn2RQU4F2z
         jekbtqUSy7J3GgAlEEUHYnELDZ24PGVoDoWhU=
Received: by 10.42.175.4 with SMTP id ay4mr21697964icb.394.1297254476116;
        Wed, 09 Feb 2011 04:27:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id i16sm245871ibl.18.2011.02.09.04.27.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:25 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166417>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This patch should be after 14/16. Otherwise the requirement in path_to=
o_deep()
 is just wrong. Too late to reorder the series for sending.

 builtin/ls-files.c |   54 ++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3195f75..87ee728 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,7 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
+static int depth_limit;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -63,18 +64,54 @@ static void write_name(const char* name, size_t len=
)
 			line_terminator);
 }
=20
+static const char *path_too_deep(const char *name)
+{
+	int common =3D 0;
+	if (!depth_limit)
+		return NULL;
+
+	/* When depth_limit is set, pathspec contains exactly 1 item */
+	while (name[common] &&
+	       name[common] =3D=3D pathspec[0][common])
+		common++;
+	while (common && name[common] !=3D '/')
+		common--;
+	if (name[common] =3D=3D '/')
+		common++;
+	return strchr(name + common, '/');
+}
+
+static int already_shown(const char *name)
+{
+	const char *last_item;
+	int len;
+
+	if (!output.nr)
+		return 0;
+
+	last_item =3D output.items[output.nr-1].string;
+	len =3D strlen(last_item);
+	return !strncmp(last_item, name, len) && name[len] =3D=3D '/';
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len =3D max_prefix_len;
+	const char *too_deep;
=20
 	if (len >=3D ent->len)
 		die("git ls-files: internal error - directory entry not superset of =
prefix");
=20
+	if (already_shown(ent->name))
+		return;
+
+	too_deep =3D path_too_deep(ent->name);
 	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
 		return;
=20
+	len =3D too_deep ? too_deep - ent->name : ent->len;
 	fputs(tag, stdout);
-	write_name(ent->name, ent->len);
+	write_name(ent->name, len);
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -141,12 +178,19 @@ static void show_killed_files(struct dir_struct *=
dir)
 static void show_ce_entry(const char *tag, struct cache_entry *ce)
 {
 	int len =3D max_prefix_len;
+	const char *too_deep;
+	int namelen;
=20
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
+	if (already_shown(ce->name))
+		return;
+
+	too_deep =3D path_too_deep(ce->name);
 	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_match=
ed))
 		return;
+	namelen =3D too_deep ? too_deep - ce->name : ce_namelen(ce);
=20
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
@@ -174,7 +218,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, ce_namelen(ce));
+	write_name(ce->name, namelen);
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
@@ -635,6 +679,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
 {
 	struct dir_struct dir;
+	int recursive =3D 0;
 	struct option builtin_ls_files_options[] =3D {
 		OPT_BOOLEAN('c', "cached", &show_cached,
 			"show cached files in the output (default)"),
@@ -647,6 +692,8 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 		OPT_BIT('i', "ignored", &dir.flags,
 			"show ignored files in the output",
 			DIR_SHOW_IGNORED),
+		OPT_BOOLEAN('r', "recursive", &recursive,
+			    "list recursively"),
 		OPT_BOOLEAN('k', "killed", &show_killed,
 			"show files on the filesystem that need to be removed"),
 		OPT_COLUMN(0, "column", &column_mode, "show files in columns" ),
@@ -683,6 +730,9 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 	      show_killed | show_modified | show_resolve_undo))
 		show_cached =3D 1;
=20
+	if (!recursive)
+		depth_limit =3D 1;
+
 	show_files(&dir);
 	display_columns(&output, column_mode, term_columns(), 2, NULL);
 	return 0;
--=20
1.7.2.2
