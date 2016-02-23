From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/25] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Tue, 23 Feb 2016 20:44:51 +0700
Message-ID: <1456235103-26317-14-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIB-0000Ym-QN
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcBWNqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:12 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34700 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcBWNqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id fy10so110561602pac.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lndgGikk3xsVQfUuLfxNyAWEwoSQPlc7Ew/fdjzVJyw=;
        b=bH3AZltZiDebVhwz3d+uKxZJPv3vDuibVBL6CrRnrbcPqv7YFb9g/6j0XWIsTp6S4F
         GUJgghBxN6f3lgEYSFHx3a9q9xqmK84beALlb6OJk6y3p+RrbH7SHg449p0qFhfgmDz7
         H+gY5gW/mi6xm7Ea7fKecF8WTPTXRxXfT8UVyg9wH/3LJNamqEsVWp/8AqzCqIQvv1Ut
         xlzqvKJHCGslMsao0KjLQiKBXaf5OVqQuPlDSbOHv0YUiJWTYKsW01rKunWe8Fok8AO0
         uPM2KbZDpXsY2M4uXi7FGXaQ2dagr6Wuk1nUIsDQ5FPU5wtncUdB1xYTQ/EQPYdb6qXm
         +/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lndgGikk3xsVQfUuLfxNyAWEwoSQPlc7Ew/fdjzVJyw=;
        b=R2L9m7HiYMNAvMv0BvTFBsu4+Ul4F6Nd39v1a+bgt45Ijr3h0sxyv/ycL5p0NHBnOo
         KWYL/9pncqQB0+jEZtaInE/J6nXdSgGQTBiL3idccA1ohlcCwnTdPN1NK0tJjXvVJjT/
         UxwvFzOI7w4tMKGdDD2Ld8mre4i4ekMs6UiCX1v0lzIfQaMHvd7WplqXhglO+vkIXcAt
         ay3/0y3zOyFSQ28VW5wLMjgNvGoaxNBnpTA8ZUfHpUjySqrY7Hr8v5VCJ7GO0YzImk9L
         yZfCOhIz2bxjCM4R5mmyRovSV9d51A+48ZRhUGu0Gz9MJGhz6YfD2aZs7LEH95BmWWoq
         QP6w==
X-Gm-Message-State: AG10YOShakq6RmDsWU+D3OVZRgNpurt6b7cD6ONY0KYd7XqP3tZMh1mujYp73yDbCtb4DQ==
X-Received: by 10.66.102.8 with SMTP id fk8mr46529502pab.12.1456235168911;
        Tue, 23 Feb 2016 05:46:08 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x13sm44415259pfa.72.2016.02.23.05.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:38 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287064>

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
 shallow.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 79 insertions(+)

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
index 60f1505..5dca743 100644
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
@@ -137,6 +139,81 @@ struct commit_list *get_shallow_commits(struct obj=
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
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    oid_to_hex(&c->object.oid));
+
+		for (p =3D c->parents; p; p =3D p->next)
+			if (!(p->item->object.flags & not_shallow_flag)) {
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
2.7.1.532.gd9e3aaa
