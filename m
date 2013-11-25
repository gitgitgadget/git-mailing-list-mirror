From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/28] shallow.c: add remove_reachable_shallow_points()
Date: Mon, 25 Nov 2013 10:55:33 +0700
Message-ID: <1385351754-9954-8-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDc-0001kW-2K
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab3KYDwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:12 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46424 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:09 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so4793243pbb.36
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5JvjZAcuQ8CcEDl97ckL3XfESVy8FOouMKKzhJnUB8M=;
        b=Kn0t+oNkxTnFpqmH9kDSP//qLtmAXuAFapZvZEm+67uwmeLCdB8TuMdKcYj5EDDDnp
         1ISNWpyLb+ZwJepb2i7svUuqxuhptCGS9P2VcvvbQZMiuc81uY+9Z0PksxqhSV4d2aXr
         zIszBQQVMM1rgzcTdlFKxj/qjroOXrh2/DrbzW9IunVkD81hTqQxYonydaTBs8Mw/CSg
         elk4Zzh0iV1HvpR1UNehWUy6QHcuFAyORkxIUBM5SV3ntj/Q5adD8sC+EqsSbDyrjoDI
         pKj0ChU5TYHdi7U3EFYNrTOOUWB56KCh28Dcmtb5tNoOVI+VxcXEoWFDEOnGgvnIjXCD
         s+yw==
X-Received: by 10.69.31.170 with SMTP id kn10mr15690868pbd.106.1385351529035;
        Sun, 24 Nov 2013 19:52:09 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id i10sm79027773pat.11.2013.11.24.19.52.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238279>

When we receive a pack and the shallow points from another repository,
we may want to add more shallow points to current repo to make sure no
commits point to nowhere. However we do not want to add unnecessary
shallow points and cut our history short because the other end is a
shallow version of this repo. The output shallow points may or may not
be added to .git/shallow, depending on whether they are actually
reachable in the new pack.

This function filters such shallow points out, leaving ones that might
potentially be added. A simple has_sha1_file won't do because we may
have incomplete object islands (i.e. not connected to any refs) and
the shallow points are on these islands. In that case we want to keep
the shallow points as candidates until we figure out if the new pack
connects to such object islands.

Typical cases that use remove_reachable_shallow_points() are:

 - fetch from a repo that has longer history: in this case all remote
   shallow roots do not exist in the client repo, this function will
   be cheap as it just does a few lookup_commit_graft and
   has_sha1_file.

 - fetch from a repo that has exactly the same shallow root set
   (e.g. a clone from a shallow repo): this case may trigger
   in_merge_bases_many all the way to roots. An exception is made to
   avoid such costly path with a faith that .git/shallow does not
   usually points to unreachable commit islands.

 - push from a shallow repo that has shorter history than the
   server's: in_merge_bases_many() is unavoidable, so the longer
   history the client has the higher the server cost is. The cost may
   be reduced with the help of pack bitmaps, or commit cache, though.

 - push from a shallow clone that has exactly the same shallow root
   set: the same as the second fetch case above, .i.e. cheap by
   exception.

The function must be called before the new pack is installed, or we
won't know which objects are ours, which theirs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  3 +++
 connect.c |  2 +-
 remote.h  |  1 +
 shallow.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index a879526..98044e6 100644
--- a/commit.h
+++ b/commit.h
@@ -193,6 +193,7 @@ extern struct commit_list *get_octopus_merge_bases(=
struct commit_list *in);
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
=20
+struct extra_have_objects;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
@@ -206,6 +207,8 @@ extern void setup_alternate_shallow(struct lock_fil=
e *shallow_lock,
 				    const char **alternate_shallow_file);
 extern char *setup_temporary_shallow(void);
 extern void advertise_shallow_grafts(int);
+extern void remove_reachable_shallow_points(struct extra_have_objects =
*out,
+					    const struct extra_have_objects *in);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/connect.c b/connect.c
index d0602b0..80e4360 100644
--- a/connect.c
+++ b/connect.c
@@ -45,7 +45,7 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, strlen(ref->name), flags);
 }
=20
-static void add_extra_have(struct extra_have_objects *extra, unsigned =
char *sha1)
+void add_extra_have(struct extra_have_objects *extra, unsigned char *s=
ha1)
 {
 	ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
 	hashcpy(&(extra->array[extra->nr][0]), sha1);
diff --git a/remote.h b/remote.h
index 773faa9..ff604ff 100644
--- a/remote.h
+++ b/remote.h
@@ -145,6 +145,7 @@ extern struct ref **get_remote_heads(int in, char *=
src_buf, size_t src_len,
 				     struct ref **list, unsigned int flags,
 				     struct extra_have_objects *have,
 				     struct extra_have_objects *shallow);
+extern void add_extra_have(struct extra_have_objects *extra, unsigned =
char *sha1);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_=
sha1);
diff --git a/shallow.c b/shallow.c
index 9552512..a974d2d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -2,6 +2,8 @@
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
+#include "remote.h"
+#include "refs.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -235,3 +237,46 @@ void advertise_shallow_grafts(int fd)
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
+
+struct commit_array {
+	struct commit **commits;
+	int nr, alloc;
+};
+
+static int add_ref(const char *refname,
+		   const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct commit_array *ca =3D cb_data;
+	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
+	ca->commits[ca->nr++] =3D lookup_commit(sha1);
+	return 0;
+}
+
+void remove_reachable_shallow_points(struct extra_have_objects *out,
+				     const struct extra_have_objects *in)
+{
+	struct commit_array ca;
+	int i;
+
+	memset(&ca, 0, sizeof(ca));
+	head_ref(add_ref, &ca);
+	for_each_ref(add_ref, &ca);
+	for (i =3D 0; i < in->nr; i++) {
+		struct commit_graft *graft =3D lookup_commit_graft(in->array[i]);
+		/*
+		 * For a clone from a shallow upstream, the clone has
+		 * the same shallow roots as upstream and it will
+		 * trigger in_merge_bases_many() all the way to roots.
+		 * Avoid that costly path and assume .git/shallow is
+		 * good most of the time.
+		 */
+		if (graft && graft->nr_parent < 0)
+			continue;
+		if (has_sha1_file(in->array[i]) &&
+		    in_merge_bases_many(lookup_commit(in->array[i]),
+					ca.nr, ca.commits))
+			continue;
+		add_extra_have(out, in->array[i]);
+	}
+	free(ca.commits);
+}
--=20
1.8.2.83.gc99314b
