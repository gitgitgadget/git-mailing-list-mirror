From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/21] list-files: show directories as well as files
Date: Sun,  8 Feb 2015 16:01:35 +0700
Message-ID: <1423386099-19994-18-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmg-0006PP-M0
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbbBHJD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:56 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41639 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbbBHJDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:52 -0500
Received: by pdno5 with SMTP id o5so2147187pdn.8
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9WjNAi1b+bx40kgsANp8Qzyft1vpvfcTo/pj8g27Ir4=;
        b=cP2MCaOCIxK9dA4BGcZCEULuvtkZ1wD/R7Ov+TPSRc7ehDtaZX7hn/MpvQhDsTbdkD
         QB708BW36WDv8EWs0KvCvEHK0zouzHqB3ivmTD6R3LQxHScamhw1jvR7dhV05c9L9c6C
         knn5seL2p+5cEDUhuYoFfqpBPH0Z8Zz3MvkFchWiVM1qneXiyxZ7LoyyjgUWrHM55djn
         rkeq7KFeVdlCIdCbbpCCm+MjzLHUxBHaVrvEq9zNPuJakLFNAvlWOQOHh0384Q/GsYQm
         1mTtedmmoC7/HbOKoiY42Oom2Y21JfAKWaORg4u0mqlwBtN1Ubzxf1LLd52ZTOFxlVIu
         QDUA==
X-Received: by 10.68.136.137 with SMTP id qa9mr19269930pbb.127.1423386232181;
        Sun, 08 Feb 2015 01:03:52 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id q3sm12951516pdr.63.2015.02.08.01.03.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:04:00 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263504>

The index does not store directories explicitly (except submodules) so
we have to figure them out from file list when output lis depth-limited=
=2E

The function show_as_directory() deliberately generates duplicate
directories and expects the previous patch to remove duplicates.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 457d067..6be08fb 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,8 @@ static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_tag;
+static int show_dirs;
 static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
@@ -179,6 +181,35 @@ static void show_killed_files(struct dir_struct *d=
ir)
 	}
 }
=20
+static int show_as_directory(const struct cache_entry *ce)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p;
+
+	strbuf_add(&sb, ce->name, ce_namelen(ce));
+	while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_setlen(&sb, p - sb.buf);
+		if (!match_pathspec(&pathspec, sb.buf, sb.len,
+				    max_prefix_len, NULL, 1))
+			continue;
+		write_name(&sb2, sb.buf);
+		if (want_color(use_color)) {
+			struct strbuf sb3 =3D STRBUF_INIT;
+			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
+			strbuf_swap(&sb2, &sb3);
+			strbuf_release(&sb3);
+		}
+		if (show_tag)
+			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		strbuf_fputs(&sb2, strbuf_detach(&sb, NULL), NULL);
+		strbuf_release(&sb2);
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
 static void write_ce_name(struct strbuf *sb, const struct cache_entry =
*ce)
 {
 	struct strbuf quoted =3D STRBUF_INIT;
@@ -191,17 +222,40 @@ static void write_ce_name(struct strbuf *sb, cons=
t struct cache_entry *ce)
 	strbuf_release(&quoted);
 }
=20
+static int match_pathspec_with_depth(struct pathspec *ps,
+				     const char *name, int namelen,
+				     int prefix, char *seen, int is_dir,
+				     const int *custom_depth)
+{
+	int saved_depth =3D ps->max_depth;
+	int result;
+
+	if (custom_depth)
+		ps->max_depth =3D *custom_depth;
+	result =3D match_pathspec(ps, name, namelen, prefix, seen, is_dir);
+	if (custom_depth)
+		ps->max_depth =3D saved_depth;
+	return result;
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
+	static const int infinite_depth =3D -1;
 	int len =3D max_prefix_len;
=20
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
+	if (!match_pathspec_with_depth(&pathspec, ce->name, ce_namelen(ce),
+				       len, ps_matched,
+				       S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode),
+				       show_dirs ? &infinite_depth : NULL))
+		return;
+
+	if (show_dirs &&strchr(ce->name, '/') &&
+	    !match_pathspec(&pathspec, ce->name, ce_namelen(ce), prefix_len, =
NULL, 1) &&
+	    show_as_directory(ce))
 		return;
=20
 	if (tag && *tag && show_valid_bit &&
@@ -575,7 +629,7 @@ static int git_ls_config(const char *var, const cha=
r *value, void *cb)
=20
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree =3D 0, show_tag =3D 0, i;
+	int require_work_tree =3D 0, i;
 	int max_depth =3D -1;
 	const char *max_prefix;
 	struct dir_struct dir;
@@ -744,6 +798,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		       prefix, argv);
 	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
+	show_dirs =3D porcelain && max_depth !=3D -1;
+
=20
 	/* Find common prefix for all pathspec's */
 	max_prefix =3D common_prefix(&pathspec);
--=20
2.3.0.rc1.137.g477eb31
