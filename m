From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] rev-list: fix --verify-objects --quiet becoming --objects
Date: Tue, 28 Feb 2012 21:00:00 +0700
Message-ID: <1330437600-9425-2-git-send-email-pclouds@gmail.com>
References: <1330437600-9425-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 15:01:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Nc5-0004sT-OU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 15:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab2B1OBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 09:01:04 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab2B1OBC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 09:01:02 -0500
Received: by pbcup15 with SMTP id up15so3315376pbc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 06:01:02 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.136.4 as permitted sender) client-ip=10.68.136.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.136.4 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.136.4])
        by 10.68.136.4 with SMTP id pw4mr33290901pbb.131.1330437662538 (num_hops = 1);
        Tue, 28 Feb 2012 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=twOj5OSyBo99aFCF5tf/bQSBk4E/X2sAji7GdXiFSPU=;
        b=lIWfM4D4y0P4bb5HxtOG4nmFINbnYjmR5dzMhCVmp0cOV3hMR4gbhywrbiephsHwkY
         gkLsa3kq4HxtOWGWBRvX1fxzZrYpz9M5ZmiZOxHcIcU/bJpPusLnUYmYjCJrAYJ8idzY
         Si0TQHdyard2jmRAlei8vkdgjZthR4/YK+v8M=
Received: by 10.68.136.4 with SMTP id pw4mr28332018pbb.131.1330437662404;
        Tue, 28 Feb 2012 06:01:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.186])
        by mx.google.com with ESMTPS id e8sm15754411pbg.47.2012.02.28.06.00.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 06:01:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Feb 2012 21:00:09 +0700
X-Mailer: git-send-email 1.7.9.2.304.g93efc
In-Reply-To: <1330437600-9425-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191734>

When --quiet is specified, finish_object() is called instead of
show_object(). The latter is in charge of --verify-objects and
will be skipped  if --quiet is specified.

Move the code up to finish_object(). Also pass the quiet flag along
and make it always call show_* functions to avoid similar problems in
future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.h           |    4 ++--
 builtin/rev-list.c |   26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/bisect.h b/bisect.h
index b06949e..ec3c3ff 100644
--- a/bisect.h
+++ b/bisect.h
@@ -15,12 +15,12 @@ extern void print_commit_list(struct commit_list *l=
ist,
 			      const char *format_cur,
 			      const char *format_last);
=20
-/* bisect_show_flags flags in struct rev_list_info */
 #define BISECT_SHOW_ALL		(1<<0)
+#define REV_LIST_QUIET		(1<<1)
=20
 struct rev_list_info {
 	struct rev_info *revs;
-	int bisect_show_flags;
+	int flags;
 	int show_timestamp;
 	int hdr_termination;
 	const char *header_prefix;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7a3f820..4c4d404 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -52,6 +52,11 @@ static void show_commit(struct commit *commit, void =
*data)
 	struct rev_list_info *info =3D data;
 	struct rev_info *revs =3D info->revs;
=20
+	if (info->flags & REV_LIST_QUIET) {
+		finish_commit(commit, data);
+		return;
+	}
+
 	graph_show_commit(revs->graph);
=20
 	if (revs->count) {
@@ -172,8 +177,11 @@ static void finish_object(struct object *obj,
 			  const struct name_path *path, const char *name,
 			  void *cb_data)
 {
+	struct rev_list_info *info =3D cb_data;
 	if (obj->type =3D=3D OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
+	if (info->revs->verify_objects && !obj->parsed && obj->type !=3D OBJ_=
COMMIT)
+		parse_object(obj->sha1);
 }
=20
 static void show_object(struct object *obj,
@@ -181,10 +189,9 @@ static void show_object(struct object *obj,
 			void *cb_data)
 {
 	struct rev_list_info *info =3D cb_data;
-
 	finish_object(obj, path, component, cb_data);
-	if (info->revs->verify_objects && !obj->parsed && obj->type !=3D OBJ_=
COMMIT)
-		parse_object(obj->sha1);
+	if (info->flags & REV_LIST_QUIET)
+		return;
 	show_object_with_name(stdout, obj, path, component);
 }
=20
@@ -254,7 +261,7 @@ static void print_var_int(const char *var, int val)
=20
 static int show_bisect_vars(struct rev_list_info *info, int reaches, i=
nt all)
 {
-	int cnt, flags =3D info->bisect_show_flags;
+	int cnt, flags =3D info->flags;
 	char hex[41] =3D "";
 	struct commit_list *tried;
 	struct rev_info *revs =3D info->revs;
@@ -305,7 +312,6 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 	int bisect_list =3D 0;
 	int bisect_show_vars =3D 0;
 	int bisect_find_all =3D 0;
-	int quiet =3D 0;
=20
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -318,7 +324,8 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 	if (revs.bisect)
 		bisect_list =3D 1;
=20
-	quiet =3D DIFF_OPT_TST(&revs.diffopt, QUICK);
+	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
+		info.flags |=3D REV_LIST_QUIET;
 	for (i =3D 1 ; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
@@ -337,7 +344,7 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list =3D 1;
 			bisect_find_all =3D 1;
-			info.bisect_show_flags =3D BISECT_SHOW_ALL;
+			info.flags |=3D BISECT_SHOW_ALL;
 			revs.show_decorations =3D 1;
 			continue;
 		}
@@ -388,10 +395,7 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
-	traverse_commit_list(&revs,
-			     quiet ? finish_commit : show_commit,
-			     quiet ? finish_object : show_object,
-			     &info);
+	traverse_commit_list(&revs, show_commit, show_object, &info);
=20
 	if (revs.count) {
 		if (revs.left_right && revs.cherry_mark)
--=20
1.7.8.36.g69ee2
