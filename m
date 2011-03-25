From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Improve tree_entry_interesting() handling code
Date: Fri, 25 Mar 2011 16:34:20 +0700
Message-ID: <1301045660-25053-3-git-send-email-pclouds@gmail.com>
References: <7vlj048f97.fsf@alter.siamese.dyndns.org>
 <1301045660-25053-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:35:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33Q8-0004N4-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934062Ab1CYJe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 05:34:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57512 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab1CYJe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:34:58 -0400
Received: by pzk9 with SMTP id 9so121746pzk.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jENF3c4yStRwXff1XS9s5dY64MLSZlLnwn4T5VjC+go=;
        b=YnyAnOiub+oAuFjbTgGPpX6ynRGPm51uhGwaDIvwxr8jzArIFf2kU6SVtpahHQG5Wt
         WfUCJ8n8F6peDOkqMEJBRpM602O/R9CfaqyuHITcXMAhO00WWBwA9yg5foJ7tH2/DNAI
         hcXLh8nk0PN898g9/Xic8i2LM/9kpZuaLI8sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YPCLmLSl59MxiJpKzC6J2BTlCXtZsda7NRQtX9HFJqVQRJ6aGRqiOBw+42RQy2CcpU
         IfRuJS1SskuMz/Yu7u6rGIHZcdZOBDoKr+UBymKUD7SGEmOOCqxIi5nLQ/KRU5IB4/hl
         aDt9oOZst0vG5c9Jkdyvfg5aY4Xr8h4MuytGk=
Received: by 10.142.199.2 with SMTP id w2mr485079wff.293.1301045697858;
        Fri, 25 Mar 2011 02:34:57 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id y2sm1090098wfd.8.2011.03.25.02.34.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 02:34:56 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 25 Mar 2011 16:34:46 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1301045660-25053-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169972>

t_e_i() can return -1 or 2 to early shortcut a search. Current code
may use up to two variables to handle it. One for saving return value
from t_e_i temporarily, one for saving return code 2.

The second variable is not needed. If we make sure the first variable
does not change until the next t_e_i() call, then we can do something
like this:

int ret =3D 0;

while (...) {
	if (ret !=3D 2) {
		ret =3D t_e_i();
		if (ret < 0) /* no longer interesting */
			break;
		if (ret =3D=3D 0) /* skip this round */
			continue;
	}
	/* ret > 0, interesting */
}

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |   12 ++++++------
 list-objects.c |   18 +++++++-----------
 tree-diff.c    |   53 ++++++++++++++++++++----------------------------=
-----
 3 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0bf8c01..9cb1f32 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -520,18 +520,18 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len)
 {
-	int hit =3D 0, matched =3D 0;
+	int hit =3D 0, match =3D 0;
 	struct name_entry entry;
 	int old_baselen =3D base->len;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(entry.path, entry.sha1);
=20
-		if (matched !=3D 2) {
-			matched =3D tree_entry_interesting(&entry, base, tn_len, pathspec);
-			if (matched =3D=3D -1)
-				break; /* no more matches */
-			if (!matched)
+		if (match !=3D 2) {
+			match =3D tree_entry_interesting(&entry, base, tn_len, pathspec);
+			if (match < 0)
+				break;
+			if (match =3D=3D 0)
 				continue;
 		}
=20
diff --git a/list-objects.c b/list-objects.c
index 838b6a7..0fb44e7 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -68,7 +68,7 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
-	int all_interesting =3D (revs->diffopt.pathspec.nr =3D=3D 0);
+	int match =3D revs->diffopt.pathspec.nr =3D=3D 0 ? 2 : 0;
 	int baselen =3D base->len;
=20
 	if (!revs->tree_objects)
@@ -85,7 +85,7 @@ static void process_tree(struct rev_info *revs,
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
=20
-	if (!all_interesting) {
+	if (!match) {
 		strbuf_addstr(base, name);
 		if (base->len)
 			strbuf_addch(base, '/');
@@ -94,17 +94,13 @@ static void process_tree(struct rev_info *revs,
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
-		if (!all_interesting) {
-			int showit =3D tree_entry_interesting(&entry,
-							    base, 0,
-							    &revs->diffopt.pathspec);
-
-			if (showit < 0)
+		if (match !=3D 2) {
+			match =3D tree_entry_interesting(&entry, base, 0,
+						       &revs->diffopt.pathspec);
+			if (match < 0)
 				break;
-			else if (!showit)
+			if (match =3D=3D 0)
 				continue;
-			else if (showit =3D=3D 2)
-				all_interesting =3D 1;
 		}
=20
 		if (S_ISDIR(entry.mode))
diff --git a/tree-diff.c b/tree-diff.c
index 3954281..f291069 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -65,23 +65,17 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2,
 static void show_tree(struct diff_options *opt, const char *prefix,
 		      struct tree_desc *desc, struct strbuf *base)
 {
-	int all_interesting =3D 0;
-	while (desc->size) {
-		int show;
-
-		if (all_interesting)
-			show =3D 1;
-		else {
-			show =3D tree_entry_interesting(&desc->entry, base, 0,
-						      &opt->pathspec);
-			if (show =3D=3D 2)
-				all_interesting =3D 1;
+	int match =3D 0;
+	for (; desc->size; update_tree_entry(desc)) {
+		if (match !=3D 2) {
+			match =3D tree_entry_interesting(&desc->entry, base, 0,
+						       &opt->pathspec);
+			if (match < 0)
+				break;
+			if (match =3D=3D 0)
+				continue;
 		}
-		if (show < 0)
-			break;
-		if (show)
-			show_entry(opt, prefix, desc, base);
-		update_tree_entry(desc);
+		show_entry(opt, prefix, desc, base);
 	}
 }
=20
@@ -121,20 +115,16 @@ static void show_entry(struct diff_options *opt, =
const char *prefix,
 }
=20
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
-			       struct diff_options *opt, int *all_interesting)
+			       struct diff_options *opt, int *match)
 {
 	while (t->size) {
-		int show =3D tree_entry_interesting(&t->entry, base, 0, &opt->pathsp=
ec);
-		if (show =3D=3D 2)
-			*all_interesting =3D 1;
-		if (!show) {
-			update_tree_entry(t);
-			continue;
+		*match =3D tree_entry_interesting(&t->entry, base, 0, &opt->pathspec=
);
+		if (*match) {
+			if (*match < 0)
+				t->size =3D 0;
+			break;
 		}
-		/* Skip it all? */
-		if (show < 0)
-			t->size =3D 0;
-		return;
+		update_tree_entry(t);
 	}
 }
=20
@@ -143,8 +133,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 {
 	struct strbuf base;
 	int baselen =3D strlen(base_str);
-	int all_t1_interesting =3D 0;
-	int all_t2_interesting =3D 0;
+	int t1_match =3D 0, t2_match =3D 0;
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
@@ -158,10 +147,8 @@ int diff_tree(struct tree_desc *t1, struct tree_de=
sc *t2,
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->pathspec.nr) {
-			if (!all_t1_interesting)
-				skip_uninteresting(t1, &base, opt, &all_t1_interesting);
-			if (!all_t2_interesting)
-				skip_uninteresting(t2, &base, opt, &all_t2_interesting);
+			skip_uninteresting(t1, &base, opt, &t1_match);
+			skip_uninteresting(t2, &base, opt, &t2_match);
 		}
 		if (!t1->size) {
 			if (!t2->size)
--=20
1.7.4.74.g639db
