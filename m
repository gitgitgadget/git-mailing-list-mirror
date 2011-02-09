From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/16] ls: color output
Date: Wed,  9 Feb 2011 19:24:44 +0700
Message-ID: <1297254284-3729-17-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn99i-0008GI-4C
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab1BIM2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:28:20 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36557 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:28:19 -0500
Received: by gwj20 with SMTP id 20so38978gwj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=OXk0FCMeUn85rQIhroF9TeIcE1ZemPFmeVNYRSjorCM=;
        b=G+vkKpn3WZr/I++rOUPcBxjRzabGCS+aCTQHk1m7LjPRWFjoNobPYwMOJ4AD1e1RVY
         +94VQNNwNdiGATdicGkn/7AL8w3e4F2ZhZ6yeuw4Bftzsoc7bDERzcEEEZ2AWNR8lQN7
         9IuZ2i8Cs0Twi9CpqsM2hHoyOSB/NfTGH61ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DVDxl6+E1kC00yAtV8Y2KVuzlcbnwa6Oig/ak4ZGXIG3GvKVHj+arggnx/4N7Lkjv7
         q2P0nNdK758TNSqL65al8jp49r5pC3TOve+ZlSAApGNtjzF7lLmXINNB9AxWPTNIsjEj
         jvogx7NVs4zSCmkyeBW/HqjidqFyg+P6BF8AY=
Received: by 10.90.94.7 with SMTP id r7mr1359252agb.45.1297254498558;
        Wed, 09 Feb 2011 04:28:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id 37sm313056anr.24.2011.02.09.04.28.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:28:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:48 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166419>

The rules are currently hardcoded (the first item has highest priority)

 - If it's a modified entry, it's bold red.
 - If it's an executable, it's bold green.
 - If it's a directory, it's bold blue.

Personally I'm happy with just that. But people might want to separate
other entries from cached ones in "ls -co", anyone?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Bad bad bad hard coding.

 builtin/ls-files.c |   59 ++++++++++++++++++++++++++++++++++++++++++++=
--------
 1 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bc438b2..9c8179a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "column.h"
+#include "color.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -37,6 +38,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int use_color;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -50,12 +52,18 @@ static const char *tag_resolve_undo =3D "";
 static struct string_list output;
 static int column_mode;
=20
-static void write_name(const char* name, size_t len)
+static void write_name(const char* name, size_t len, const char *color=
)
 {
 	/* No quoting in column layout. It will be done by the end. */
 	if (column_mode & COL_MODE) {
 		struct strbuf sb =3D STRBUF_INIT;
-		strbuf_add(&sb, name, len);
+		if (color && use_color) {
+			strbuf_addstr(&sb, color);
+			strbuf_add(&sb, name, len);
+			strbuf_addstr(&sb, GIT_COLOR_RESET);
+		}
+		else
+			strbuf_add(&sb, name, len);
 		string_list_append(&output, strbuf_detach(&sb, NULL));
 		return;
 	}
@@ -81,16 +89,29 @@ static const char *path_too_deep(const char *name)
 	return strchr(name + common, '/');
 }
=20
+static int ansi_length(const char *s)
+{
+	const char *p =3D s;
+	while (p[0] =3D=3D '\033')
+		p +=3D strspn(p + 2, "0123456789;") + 3;
+	return p - s;
+}
+
 static int already_shown(const char *name)
 {
 	const char *last_item;
-	int len;
+	int len, ansi_len;
=20
 	if (!output.nr)
 		return 0;
=20
 	last_item =3D output.items[output.nr-1].string;
 	len =3D strlen(last_item);
+	ansi_len =3D ansi_length(last_item);
+	if (ansi_len) {
+		last_item +=3D ansi_len;
+		len -=3D ansi_len + strlen(GIT_COLOR_RESET);
+	}
 	return !strncmp(last_item, name, len) && name[len] =3D=3D '/';
 }
=20
@@ -98,6 +119,7 @@ static void show_dir_entry(const char *tag, struct d=
ir_entry *ent)
 {
 	int len =3D max_prefix_len;
 	const char *too_deep;
+	struct stat st;
=20
 	if (len >=3D ent->len)
 		die("git ls-files: internal error - directory entry not superset of =
prefix");
@@ -111,7 +133,9 @@ static void show_dir_entry(const char *tag, struct =
dir_entry *ent)
=20
 	len =3D too_deep ? too_deep - ent->name : ent->len;
 	fputs(tag, stdout);
-	write_name(ent->name, len);
+	write_name(ent->name, len,
+		   len < ent->len ? GIT_COLOR_BOLD_BLUE :
+		   (!stat(ent->name, &st) && st.st_mode & S_IXUSR ? GIT_COLOR_BOLD_G=
REEN : NULL));
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -179,6 +203,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 {
 	int len =3D max_prefix_len;
 	const char *too_deep;
+	struct stat st;
 	int namelen;
=20
 	if (len >=3D ce_namelen(ce))
@@ -218,7 +243,10 @@ static void show_ce_entry(const char *tag, struct =
cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name, namelen);
+	write_name(ce->name, namelen,
+		   namelen < ce_namelen(ce) ? GIT_COLOR_BOLD_BLUE :
+		   (!stat(ce->name, &st) && ce_modified(ce, &st, 0) ? GIT_COLOR_BOLD=
_RED :
+		    (ce_permissions(ce->ce_mode) =3D=3D 0755 ? GIT_COLOR_BOLD_GREEN =
: NULL)));
 	if (debug_mode) {
 		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
 		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
@@ -251,7 +279,7 @@ static void show_ru_info(void)
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(ui->sha1[i], abbrev),
 			       i + 1);
-			write_name(path, len);
+			write_name(path, len, NULL);
 		}
 	}
 }
@@ -676,6 +704,16 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	return 0;
 }
=20
+static int ls_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "color.ls"))
+		use_color =3D git_config_colorbool(var, value, -1);
+	else
+		return git_color_default_config(var, value, cb);
+
+	return 0;
+}
+
 static int one_match_pathspec(const char *pathspec)
 {
 	struct stat st;
@@ -724,11 +762,13 @@ static void remove_common_prefix()
 	 */
=20
 	s1 =3D output.items[output.nr-1].string;
-	len =3D strlen(s1);
+	len =3D strlen(s1) - ansi_length(s1);
 	for (i =3D 1; i < output.nr; i++) {
 		int j =3D 0;
 		s1 =3D output.items[i-1].string;
+		s1 +=3D ansi_length(s1);
 		s2 =3D output.items[i].string;
+		s2 +=3D ansi_length(s2);
 		while (j < len && s1[j] =3D=3D s2[j])
 			j++;
 		len =3D j;
@@ -740,6 +780,7 @@ static void remove_common_prefix()
 	if (len) {
 		for (i =3D 0; i < output.nr; i++) {
 			char *s =3D output.items[i].string;
+			s +=3D ansi_length(s);
 			memcpy(s, s+len, strlen(s) - len + 1);
 		}
 	}
@@ -778,12 +819,12 @@ int cmd_ls(int argc, const char **argv, const cha=
r *cmd_prefix)
 	prefix =3D cmd_prefix;
 	if (prefix)
 		prefix_len =3D strlen(prefix);
-	git_config(git_default_config, NULL);
+	git_config(ls_config, NULL);
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
=20
-	column_mode =3D core_column;
+	column_mode =3D core_column | COL_ANSI;
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
@@ -793,7 +834,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
=20
 	pathspecs =3D get_pathspec(prefix, argv);
=20
-	if (show_modified)
+	if (show_modified || use_color)
 		refresh_index(&the_index, REFRESH_QUIET, pathspecs, NULL, NULL);
=20
 	if (!pathspecs) {
