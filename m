From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/25] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Thu,  4 Feb 2016 16:03:50 +0700
Message-ID: <1454576641-29615-15-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrR-00070p-BC
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965564AbcBDJFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:52 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35557 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965482AbcBDJFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:34 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so38494831pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CBCRz/IEgsbKzMnmnUuTZrqYlI8ZinpiPLQo45fa69E=;
        b=uIUYOhXAXdLY1GYsd2NQZj30Z3NyjvsoVchVxmQRC6syT4G6vB2+WIUrFgbzHinDSN
         x+krpc5kE9yCxJVnmTZ/ba5hyDhIXc9KHXZMWwq5IYvDknVrCzCZIhKLGiR6vBHp9Jd2
         ovSLp/W8M1m+viDtgdedd2B3qbiPKpC5sVGloqmN5BhYmTZmedq0zOvdNEqMVmx5nRr+
         rgEYnhgRJuQ6DIq/+1PS33Yn0GkxZQDkNQa5G66txlMkjAPWyZE/JyEx2Kb+6Ymct129
         oGHkYTb+qBuDjrbFS8vjpZAT9Y8s5YiHx0YP6SJQ5iLzt7iSEZM/c50bCmZv26seWsu6
         aOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CBCRz/IEgsbKzMnmnUuTZrqYlI8ZinpiPLQo45fa69E=;
        b=e0NsaN4j0IKN6zgp980nT+OnFo9dP8bwSyXeSi94geUYbE+8lQrGqBvsGSCdsAxOjs
         oi0VPItm5u41tm0s2ZFKtMBdGZBbGchPfnoivtQSK/a/a2uhSxSd3AFMNdrMC8FPSpwM
         KRQhwevvlOfCT3Qx7PRfSBFqIzWQ62cif4nEcBxZgnbq4ax0YJYrbexi4bh38TNmNypk
         d+ZCzYwITQlvOP/iNG1ZwCaOn1FS998/8KdNDdzVU4jlJ6RYoe9HFNrmwGb3yvKs4MtT
         obAPlPEzwgQRrPH7mWXLuIR6sN4vOJLRjIo2i/JQuyQO56muTpgG/rfnNrvJT4+tsdYM
         ZdUA==
X-Gm-Message-State: AG10YOQWGw0bGJxp/nUP0HwrmM9m65cS92RurHTp6nRcxqzrbM0jedRgfadesV2D3Ij21A==
X-Received: by 10.98.64.83 with SMTP id n80mr9286942pfa.149.1454576734547;
        Thu, 04 Feb 2016 01:05:34 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id fa3sm15279529pab.45.2016.02.04.01.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:47 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285427>

Instead of a custom commit walker like get_shallow_commits(), this new
function uses rev-list to mark NOT_SHALLOW to all reachable commits,
except borders. The definition of reachable is to be defined by the
protocol later. This makes it more flexible to define shallow boundary.

Note: if a commit has one NOT_SHALLOW parent and one SHALLOW parent,
then it's considered the boundary. Which means in the client side, this
commit has _no_ parents. This could lead to surprising cuts if we're no=
t
careful.

Another option is to include more commits and only mark commits whose
all parents are SHALLOW as boundary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  2 ++
 shallow.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 87 insertions(+)

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
index 60f1505..f5d5c1d 100644
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
@@ -137,6 +139,89 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
 	return result;
 }
=20
+static void show_commit(struct commit *commit, void *data)
+{
+	commit->object.flags |=3D *(int *)data;
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
+	struct rev_info revs;
+	unsigned int i, nr;
+
+	/*
+	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
+	 * set at this point. But better be safe than sorry.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		if (!o || o->type !=3D OBJ_COMMIT)
+			continue;
+		o->flags &=3D ~(shallow_flag | not_shallow_flag);
+	}
+
+	is_repository_shallow(); /* make sure shallows are read */
+
+	init_revisions(&revs, NULL);
+	save_commit_buffer =3D 0;
+	setup_revisions(ac, av, &revs, NULL);
+
+	/* Mark all reachable commits as NOT_SHALLOW */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_flag);
+
+	/*
+	 * mark border commits SHALLOW + NOT_SHALLOW.
+	 * We cannot clear NOT_SHALLOW right now. Imagine border
+	 * commit A is processed first, then commit B, whose parent is
+	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
+	 * itself is considered border at step 2, which is incorrect.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		struct commit *c =3D (struct commit *)o;
+
+		if (!o || o->type !=3D OBJ_COMMIT ||
+		    !(o->flags & not_shallow_flag))
+			continue;
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    oid_to_hex(&c->object.oid));
+
+		for (p =3D c->parents; p; p =3D p->next)
+			if (!(p->item->object.flags & not_shallow_flag)) {
+				o->flags |=3D shallow_flag;
+				commit_list_insert(c, &result);
+				break;
+			}
+	}
+
+	/*
+	 * Now we can clean up NOT_SHALLOW on border commits. Having
+	 * both flags set can confuse the caller.
+	 */
+	for (p =3D result; p; p =3D p->next) {
+		struct object *ro =3D &p->item->object;
+		if ((ro->flags & not_shallow_flag) &&
+		    (ro->flags & shallow_flag))
+			ro->flags &=3D ~not_shallow_flag;
+	}
+	return result;
+}
+
 static void check_shallow_file_for_update(void)
 {
 	if (is_shallow =3D=3D -1)
--=20
2.7.0.377.g4cd97dd
