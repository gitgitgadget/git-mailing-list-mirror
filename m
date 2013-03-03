From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] branch: show more information when HEAD is detached
Date: Sun,  3 Mar 2013 16:41:21 +0700
Message-ID: <1362303681-6585-6-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 10:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5QE-00015R-FA
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab3CCJlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:41:06 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:34301 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab3CCJlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:41:05 -0500
Received: by mail-da0-f52.google.com with SMTP id x33so2074504dad.39
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+vAK605/fbhq0ItvPwVoqmApMVBJ5AQOujp7/D1I6vI=;
        b=R9wCO1h4HOa8PRu421GXNR6XeH5CpFOBz9bQQJUUwNh4uqGNsj2T1TO6p1k7be3+Z/
         RErhCtsJu0ZUtbW0kcSt0bDrTVGZYQOzp0sdg4jwnAQqlLpdpsYrCa8FIbZDBFDZQ/g1
         XzKf+VZnt1hVLUiF8RnCtyO5+2Ih8tmPTzaarsVPQG/PLefPBSqQENw+ycxAOM24XA3v
         WyOOEnGLfXwZ648UmSQYSCnW13Kk3pPXnSZBIAup+tPkuSlibctm2My/g5rGSGtRMJUI
         24tidK9NcQhoJaG7IjLNOXl2BOCi6YZyzE7BumnYjKdL7TTDOyF3flIWJxb8Hppbtspx
         DFPw==
X-Received: by 10.68.223.106 with SMTP id qt10mr22924322pbc.89.1362303664278;
        Sun, 03 Mar 2013 01:41:04 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id 1sm18298712pba.32.2013.03.03.01.41.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:41:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:42:08 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217347>

This prints more helpful info when HEAD is detached: is it detached
because of bisect or rebase? What is the original branch name in those
cases? Is it detached because the user checks out a remote ref or a
tag (and which one)?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c            | 25 ++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6371bf9..02dee0d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -18,6 +18,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "utf8.h"
+#include "wt-status.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	N_("git branch [options] [-r | -a] [--merged | --no-merged]"),
@@ -550,6 +551,28 @@ static int calc_maxwidth(struct ref_list *refs)
 	return w;
 }
=20
+static char *get_head_description()
+{
+	struct strbuf desc =3D STRBUF_INIT;
+	struct wt_status_state state;
+	wt_status_get_state(&state, 1);
+	if (state.rebase_in_progress ||
+	    state.rebase_interactive_in_progress)
+		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			    state.branch);
+	else if (state.bisect_in_progress)
+		strbuf_addf(&desc, _("(no branch, bisecting %s)"),
+			    state.branch);
+	else if (state.detached_from)
+		strbuf_addf(&desc, _("(detached from %s)"),
+			    state.detached_from);
+	else
+		strbuf_addstr(&desc, _("(no branch)"));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+	return strbuf_detach(&desc, NULL);
+}
=20
 static void show_detached(struct ref_list *ref_list)
 {
@@ -557,7 +580,7 @@ static void show_detached(struct ref_list *ref_list=
)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup(_("(no branch)"));
+		item.name =3D get_head_description();
 		item.width =3D utf8_strwidth(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3e0e15f..9b6f0d0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
+	test_i18ngrep "* (no branch, bisecting other)" branch.output > /dev/n=
ull &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
--=20
1.8.1.2.536.gf441e6d
