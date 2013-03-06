From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2+ 4/4] branch: show more information when HEAD is detached
Date: Wed,  6 Mar 2013 19:26:13 +0700
Message-ID: <1362572773-20809-2-git-send-email-pclouds@gmail.com>
References: <1362572482-20570-5-git-send-email-pclouds@gmail.com>
 <1362572773-20809-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 13:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDDPx-0002nh-TI
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 13:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab3CFMZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 07:25:32 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:59493 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab3CFMZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 07:25:31 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so5937752pbc.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 04:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=syBxoniK2gijcEBEN3oKwqtgMmzHoztUXE6/roUA9MQ=;
        b=grClWmmqN1fgw2tScdhPEbC1Gbv1A9yAJaffmL/YgdXHyNevtxyHZMC1drpTdBBvj7
         WiciDRY0mgcplqPOxTY8+SKVWkzW3dQD/Ec0qeHG86oPHWinypwJTYzfUVyA64fD6M83
         tcdq967CmjVnRn8h94ssO7nF2Rr3nwkZaTm5HwFIFI6mdvFSn6ZSqmE7RyOcLRRXAgzL
         oLkXCWF7rrgSbUMZYz1TvcfTtx9k0NZQRuTqj3CX1Pue0cIdk3KIjZcnvb4sJpknyLrR
         uKT6l2yOKKaNtdbcdx9ymDhh9uLaJnOnkkoiLpwWuF1CulHfT1RIAmKv2ViAgsqb6p2i
         NC9w==
X-Received: by 10.68.213.132 with SMTP id ns4mr47155932pbc.84.1362572731230;
        Wed, 06 Mar 2013 04:25:31 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id c6sm7460714pbm.45.2013.03.06.04.25.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 04:25:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:26:39 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362572773-20809-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217522>

This prints more helpful info when HEAD is detached: is it detached
because of bisect or rebase? What is the original branch name in those
cases? Is it detached because the user checks out a remote ref or a
tag (and which one)?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Oops, the previous one did not do

  s/\(get_head_description\)()$/\1(void)/
=20
 This one does.

 builtin/branch.c            | 25 ++++++++++++++++++++++++-
 t/t3203-branch-output.sh    |  6 +++---
 t/t6030-bisect-porcelain.sh |  2 +-
 3 files changed, 28 insertions(+), 5 deletions(-)

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
+static char *get_head_description(void)
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
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 76fe7e0..ba4f98e 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -94,13 +94,13 @@ test_expect_success 'git branch -v pattern does not=
 show branch summaries' '
 	test_must_fail git branch -v branch*
 '
=20
-cat >expect <<'EOF'
-* (no branch)
+test_expect_success 'git branch shows detached HEAD properly' '
+	cat >expect <<EOF &&
+* (detached from $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
   master
 EOF
-test_expect_success 'git branch shows detached HEAD properly' '
 	git checkout HEAD^0 &&
 	git branch >actual &&
 	test_i18ncmp expect actual
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
