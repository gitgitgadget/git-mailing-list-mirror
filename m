From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/26] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Wed, 13 Apr 2016 19:54:58 +0700
Message-ID: <1460552110-5554-15-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLW-0004O3-C7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030772AbcDMM42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:28 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35853 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030757AbcDMM40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:26 -0400
Received: by mail-pa0-f67.google.com with SMTP id k3so3875959pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMi4QSWQNpZPz1tRHbTLrQM+vsXJZW2stIDQr9zZEa0=;
        b=PWSq5m+jG1hxFzaWLpXqiqswbFc8szXuA1E5dY7hARIfw7TaAvLGbhyvHEp7KaWMXC
         4Ue33QHhiMXoIgFbmdfGXdxIexuo2tjmNHk2OxTeEDZqrBjt0XTggsKRHv7KuLOF35uz
         VTS7G2OInWrb0BMw4auDZsGfK69OulFKdm2fgQ5sHpD6mJqbIzxrDwDgB4XSvytYUkeI
         c5BnEzVBm2j4eL4d5J6yrZWb6V3FxGkWQvS/pb1YC1DYj31tGjOC1ZfYnzrYHUvpGCJ4
         xlMSfl4JmaWsxDvqnnzF1cZv8NsI0sKAFtNd3ojwzDqosxa+wfqRC16wRxNH6ZDNrdKl
         1M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMi4QSWQNpZPz1tRHbTLrQM+vsXJZW2stIDQr9zZEa0=;
        b=aGvgZGsQ0H5uiAcPAMMQ6t5nTiBQ6V1Tle+RTNhdM77OevvjPIo+Jsc1brHI1suxKG
         Mh0+Xcmgkcv6DItzh90l7/MCINFi1JkwW4Oc+81KqZifgAt05jiEy1THwcKMEtfQCdBa
         w09p+q3TAOHRde8pviSpAhaWpLNgAvRrxXwcnvvJah+dQyIxUhBWr6tgxDg2hMC0rMEO
         zwrfOUTutiONe0vmZGfnMuBOAgwbB9psJGb5lLGTs0nrwHfIXmLdC17iGWdFSOJrT77l
         6gtwFVCfku8mdAuJJ2eHs6FlAZlsknSx9ZFnVYYDnD1PLfxahYsZQfPlnlW6/TjEEt5V
         a24w==
X-Gm-Message-State: AOPr4FW6IOYiTStOTxCZX4LaPN3Rna3jiSqjZ8uAywW2pWyip9s1nxyrkArYfNw/I54Sdg==
X-Received: by 10.66.157.129 with SMTP id wm1mr12791835pab.159.1460552185737;
        Wed, 13 Apr 2016 05:56:25 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id r17sm30184518pfj.39.2016.04.13.05.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291408>

Instead of a custom commit walker like get_shallow_commits(), this new
function uses rev-list to mark NOT_SHALLOW to all reachable commits,
except borders. The definition of reachable is to be defined by the
protocol later. This makes it more flexible to define shallow boundary.

The way we find find border is paint all reachable commits NOT_SHALLOW.
Any of them that "touches" commits without NOT_SHALLOW flag are
considered shallow (e.g. zero parents via grafting mechanism). Shallow
commits and their true parents are all marked SHALLOW. Then NOT_SHALLOW
is removed from shallow commits at the end.

There is an interesting observation. With a generic walker, we can
produce all kinds of shallow cutting. In the following graph, every
commit but "x" is reachable. "b" is a parent of "a".

           x -- a -- o
          /    /
    x -- c -- b -- o

After this function is run, "a" and "c" are both considered shallow
commits. After grafting occurs at the client side, what we see is

                a -- o
                    /
         c -- b -- o

Notice that because of grafting, "a" has zero parents, so "b" is no
longer a parent of "a".

This is unfortunate and may be solved in two ways. The first is change
the way shallow grafting works and keep "a -- b" connection if "b"
exists and always ends at shallow commits (iow, no loose ends). This is
hard to detect, or at least not cheap to do.

The second way is mark one "x" as shallow commit instead of "a" and
produce this graph at client side:

           x -- a -- o
               /    /
         c -- b -- o

More commits, but simpler grafting rules.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  2 ++
 shallow.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 80 insertions(+)

diff --git a/commit.h b/commit.h
index 5d58be0..b717be1 100644
--- a/commit.h
+++ b/commit.h
@@ -258,6 +258,8 @@ extern int for_each_commit_graft(each_commit_graft_=
fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
+extern struct commit_list *get_shallow_commits_by_rev_list(
+		int ac, const char **av, int shallow_flag, int not_shallow_flag);
 extern void set_alternate_shallow_file(const char *path, int override)=
;
 extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol,
 				 const struct sha1_array *extra);
diff --git a/shallow.c b/shallow.c
index 60f1505..40c2485 100644
--- a/shallow.c
+++ b/shallow.c
@@ -10,6 +10,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
+#include "revision.h"
+#include "list-objects.h"
=20
 static int is_shallow =3D -1;
 static struct stat_validity shallow_stat;
@@ -137,6 +139,82 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
 	return result;
 }
=20
+static void show_commit(struct commit *commit, void *data)
+{
+	commit_list_insert(commit, data);
+}
+
+/*
+ * Given rev-list arguments, run rev-list. All reachable commits
+ * except border ones are marked with not_shallow_flag. Border commits
+ * are marked with shallow_flag. The list of border/shallow commits
+ * are also returned.
+ */
+struct commit_list *get_shallow_commits_by_rev_list(int ac, const char=
 **av,
+						    int shallow_flag,
+						    int not_shallow_flag)
+{
+	struct commit_list *result =3D NULL, *p;
+	struct commit_list *not_shallow_list =3D NULL;
+	struct rev_info revs;
+	int both_flags =3D shallow_flag | not_shallow_flag;
+
+	/*
+	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
+	 * set at this point. But better be safe than sorry.
+	 */
+	clear_object_flags(both_flags);
+
+	is_repository_shallow(); /* make sure shallows are read */
+
+	init_revisions(&revs, NULL);
+	save_commit_buffer =3D 0;
+	setup_revisions(ac, av, &revs, NULL);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_list);
+
+	/* Mark all reachable commits as NOT_SHALLOW */
+	for (p =3D not_shallow_list; p; p =3D p->next)
+		p->item->object.flags |=3D not_shallow_flag;
+
+	/*
+	 * mark border commits SHALLOW + NOT_SHALLOW.
+	 * We cannot clear NOT_SHALLOW right now. Imagine border
+	 * commit A is processed first, then commit B, whose parent is
+	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
+	 * itself is considered border at step 2, which is incorrect.
+	 */
+	for (p =3D not_shallow_list; p; p =3D p->next) {
+		struct commit *c =3D p->item;
+		struct commit_list *parent;
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    oid_to_hex(&c->object.oid));
+
+		for (parent =3D c->parents; parent; parent =3D parent->next)
+			if (!(parent->item->object.flags & not_shallow_flag)) {
+				c->object.flags |=3D shallow_flag;
+				commit_list_insert(c, &result);
+				break;
+			}
+	}
+	free_commit_list(not_shallow_list);
+
+	/*
+	 * Now we can clean up NOT_SHALLOW on border commits. Having
+	 * both flags set can confuse the caller.
+	 */
+	for (p =3D result; p; p =3D p->next) {
+		struct object *o =3D &p->item->object;
+		if ((o->flags & both_flags) =3D=3D both_flags)
+			o->flags &=3D ~not_shallow_flag;
+	}
+	return result;
+}
+
 static void check_shallow_file_for_update(void)
 {
 	if (is_shallow =3D=3D -1)
--=20
2.8.0.rc0.210.gd302cd2
