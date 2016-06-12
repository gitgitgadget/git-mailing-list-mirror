From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/27] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Sun, 12 Jun 2016 17:53:57 +0700
Message-ID: <20160612105409.22156-16-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33n-0003ia-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbcFLK4C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:02 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34685 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcFLK4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:00 -0400
Received: by mail-pa0-f68.google.com with SMTP id ug1so8416596pab.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5yx8/s/LYCOLGJB/aCXgR0pWPvQ6WBGspE/c9sH1I8=;
        b=g1hOAXC5zRzrQ5s2WTyclLIBTFJLjysrAl58OhQZ9V06oK3eM6vamYmHyiFSC3xh82
         yHETLjjGRmQCkhIGtMZkulUn8skXdTlMZ3Oh7BddUQLXBivW19oxHcDsgehXylIRlULR
         VG0o/bsYeXvqk/y2Soky1zct9qRc4o6icW7VUXY46GIpnvZto/2iqONPQ0sAmRhamoCY
         XtXno+tBUewnlY+fD3m/R3AOOW/vDjkRjreR3XlHHx4bruxkecQEbzUvMU+v4uBahgGA
         OQiEh5zHH+xgtABVDBWIqRjplj2EazEHJKJU25uDL9DZ7Fq3dMsByL+MzFQ9HRzcbDLz
         AdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5yx8/s/LYCOLGJB/aCXgR0pWPvQ6WBGspE/c9sH1I8=;
        b=RslEJx1CE1tfMYHmoWkYrbhpXwd00RNubVjteuvZ80vEmS5dhvX+sBOb03eHlH7L71
         SVotgkoZ1Q73Q4+ru1TX2gXlJSFMzvJBoI13Gt7e1ZNjQvd/1p+HJ3/PS5/fkRvF/q73
         mYYMT/IEw7SX9wnmfb78C5a8osxMNHm4RqidRfe8+Y2yEuGOk5kLXisc+lfy9H89mMXB
         Q8n82yn1AJ+WdsWl+i/pEXjpN/tvczATC1mtWKDSallubpmkUuVj8z10k50zCMOCNQzb
         RmyCgXXj+r0VJxMzPNZwxut45gILp1J+BJXjYAc1A8XAdaVYynALs4oujiXD4cjISqRB
         RrLA==
X-Gm-Message-State: ALyK8tJyvD4lW4Z8wlAHR+W46LIGzbSsWtSjRmxRmki74YNNRxxMDeOVZCqvG9Gle8rCJA==
X-Received: by 10.66.127.47 with SMTP id nd15mr14570818pab.84.1465728959911;
        Sun, 12 Jun 2016 03:55:59 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id n10sm29805677pax.18.2016.06.12.03.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:55 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297122>

Instead of a custom commit walker like get_shallow_commits(), this new
function uses rev-list to mark NOT_SHALLOW to all reachable commits,
except borders. The definition of reachable is to be defined by the
protocol later. This makes it more flexible to define shallow boundary.

The way we find border is paint all reachable commits NOT_SHALLOW.  Any
of them that "touches" commits without NOT_SHALLOW flag are considered
shallow (e.g. zero parents via grafting mechanism). Shallow commits and
their true parents are all marked SHALLOW. Then NOT_SHALLOW is removed
from shallow commits at the end.

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.8.2.524.g6ff3d78
