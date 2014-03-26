From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/17] ls: sort output and remove duplicates
Date: Wed, 26 Mar 2014 20:48:15 +0700
Message-ID: <1395841697-11742-16-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCn-0000jK-RO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbaCZNtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:49:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47589 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbaCZNtP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:49:15 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so1960466pab.20
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GnEqLee0tg4D9WmqE9Hp+8oYmH3Vir2I2kpgg8zIlhw=;
        b=YC9EtVhDAT2zt8XngBFLmMB1ysF9O4BT0ugIPSJqAaxbrcniZfcJGvnn+fRJiFOnmF
         mz+X+MhcYQ3w8pt7tcdRQwnEzDMKtt8YSBibC2ibqzddl1aJL8HuSiBKhJckqkPUld+t
         ioV/71oGcYKnNslFecz+EeT9jRXnIbjrU7gMiHCbI+FR96GZRpaSsEdtV+TEm+RAxmNt
         xZtq5zLun/CucQ7pm9vL68bAvgJRxbPlI5ltXECt3NAQKhhfw2Nr2lQxQP+o3LvEAKrL
         hSObRcqkkyFq3+5109ujK4UbQMpiHxheZTt8Tyqvl51MDH/adfjL/PahryFKFvbWy9/E
         E9KQ==
X-Received: by 10.66.13.138 with SMTP id h10mr4766411pac.148.1395841754579;
        Wed, 26 Mar 2014 06:49:14 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id pv4sm58543286pbb.55.2014.03.26.06.49.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:49:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:50:08 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245194>

When you mix different file types, with ls-files you may get separate
listing. For example, "ls-files -cm" will show file "abc" twice: one
as part of cached list, one of modified list. With "ls" (and this
patch) they will be in a single sorted list (easier for the eye).

Duplicate entries are also removed. Note that display content is
compared, so if you have "-t" on, or you color file types differently,
you will get duplicate textual entries. This is good imo.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 392d273..709d8b1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -57,6 +57,13 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
+static int compare_output(const void *a_, const void *b_)
+{
+	const struct string_list_item *a =3D a_;
+	const struct string_list_item *b =3D b_;
+	return strcmp(a->util, b->util);
+}
+
 static void write_name(struct strbuf *sb, const char *name)
 {
 	/*
@@ -72,10 +79,12 @@ static void write_name(struct strbuf *sb, const cha=
r *name)
 		quote_path_relative(name, real_prefix, sb);
 }
=20
-static void strbuf_fputs(struct strbuf *sb, FILE *fp)
+static void strbuf_fputs(struct strbuf *sb, const char *full_name, FIL=
E *fp)
 {
-	if (column_active(colopts)) {
-		string_list_append(&output, strbuf_detach(sb, NULL));
+	if (column_active(colopts) || porcelain) {
+		struct string_list_item *it;
+		it =3D string_list_append(&output, strbuf_detach(sb, NULL));
+		it->util =3D (void*)full_name;
 		return;
 	}
 	fwrite(sb->buf, sb->len, 1, fp);
@@ -110,7 +119,7 @@ static void show_dir_entry(const char *tag, struct =
dir_entry *ent)
 	strbuf_reset(&sb);
 	strbuf_addstr(&sb, tag);
 	write_dir_entry(&sb, ent);
-	strbuf_fputs(&sb, stdout);
+	strbuf_fputs(&sb, ent->name, stdout);
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -227,7 +236,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 			    ce_stage(ce));
 	}
 	write_ce_name(&sb, ce);
-	strbuf_fputs(&sb, stdout);
+	strbuf_fputs(&sb, ce->name, stdout);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
=20
@@ -535,7 +544,7 @@ static int ls_files(const char **argv, const char *=
prefix)
 		if (debug_mode)
 			die(_("--column and --debug are incompatible"));
 	}
-	if (column_active(colopts))
+	if (column_active(colopts) || porcelain)
 		line_terminator =3D 0;
=20
 	if (require_work_tree && !is_inside_work_tree())
@@ -601,10 +610,13 @@ static int ls_files(const char **argv, const char=
 *prefix)
 	if (show_resolve_undo)
 		show_ru_info();
=20
-	if (column_active(colopts)) {
-		print_columns(&output, colopts, NULL);
-		string_list_clear(&output, 0);
+	if (porcelain) {
+		qsort(output.items, output.nr, sizeof(*output.items),
+		      compare_output);
+		string_list_remove_duplicates(&output, 0);
 	}
+	print_columns(&output, colopts, NULL);
+	string_list_clear(&output, 0);
=20
 	if (ps_matched) {
 		int bad;
--=20
1.9.1.345.ga1a145c
