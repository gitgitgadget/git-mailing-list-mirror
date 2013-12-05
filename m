From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 08/28] shallow.c: the 8 steps to select new commits for .git/shallow
Date: Thu,  5 Dec 2013 20:02:35 +0700
Message-ID: <1386248575-10206-9-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWO-0001kT-DP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab3LEM7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:07 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:64567 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab3LEM7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:06 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so24585150pdj.31
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=K0AY7hiPSvrRJmRvLj0AhJPSLg+cEemvoQXxWQJBeCY=;
        b=SRvT/lSB++c9aA5OTKqrDhdeiKFAZJfSuM+UbIg3U5AgEFaUVn9fyafuhiA6RGNxn/
         n72j3DVAwm5fV83YpdrmcH7oN0CjB3zPxRBiEyYaxHBF6Lr26jJ2TNjo6T9mlN1VhfuP
         S9QQH+/0uMM/b2Bjs3FUnjA7Xm7nRAyRwQCC4ON/Htp/XdzZuio62vSk0KRRYyPovtj/
         TedURbli73eXNCHPDxayBwyNG+1xO+DvmhYsqo1nRTr2wmCd+v609q0KIHnG474eJ2Dz
         CiUpZ3bg4ykKN18bCr0Tih1HGDZwBb3z31EvRFbLwHjlqqaOoyQgU6ucIcVTrkzd1LoY
         x40A==
X-Received: by 10.68.185.68 with SMTP id fa4mr52692158pbc.136.1386248345618;
        Thu, 05 Dec 2013 04:59:05 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ae5sm161726951pac.18.2013.12.05.04.59.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:49 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238864>

Suppose a fetch or push is requested between two shallow repositories
(with no history deepening or shortening). A pack that contains
necessary objects is transferred over together with .git/shallow of
the sender. The receiver has to determine whether it needs to update
=2Egit/shallow if new refs needs new shallow comits.

The rule here is avoid updating .git/shallow by default. But we don't
want to waste the received pack. If the pack contains two refs, one
needs new shallow commits installed in .git/shallow and one does not,
we keep the latter and reject/warn about the former.

Even if .git/shallow update is allowed, we only add shallow commits
strictly necessary for the former ref (remember the sender can send
more shallow commits than necessary) and pay attention not to
accidentally cut the receiver history short (no history shortening is
asked for)

So the steps to figure out what ref need what new shallow commits are:

1. Split the sender shallow commit list into "ours" and "theirs" list
   by has_sha1_file. Those that exist in current repo in "ours", the
   remaining in "theirs".

2. Check the receiver .git/shallow, remove from "ours" the ones that
   also exist in .git/shallow.

3. Fetch the new pack. Either install or unpack it.

4. Do has_sha1_file on "theirs" list again. Drop the ones that fail
   has_sha1_file. Obviously the new pack does not need them.

5. If the pack is kept, remove from "ours" the ones that do not exist
   in the new pack.

6. Walk the new refs to answer the question "what shallow commits,
   both ours and theirs, are required in .git/shallow in order to add
   this ref?". Shallow commits not associated to any refs are removed
   from their respective list.

7. (*) Check reachability (from the current refs) of all remaining
   commits in "ours". Those reachable are removed. We do not want to
   cut any part of our (reachable) history. We only check up
   commits. True reachability test is done by
   check_everything_connected() at the end as usual.

8. Combine the final "ours" and "theirs" and add them all to
   .git/shallow. Install new refs. The case where some hook rejects
   some refs on a push is explained in more detail in the push
   patches.

Of these steps, #6 and #7 are expensive. Both require walking through
some commits, or in the worst case all commits. And we rather avoid
them in at least common case, where the transferred pack does not
contain any shallow commits that the sender advertises. Let's look at
each scenario:

1) the sender has longer history than the receiver

   All shallow commits from the sender will be put into "theirs" list
   at step 1 because none of them exists in current repo. In the
   common case, "theirs" becomes empty at step 4 and exit early.

2) the sender has shorter history than the receiver

   All shallow commits from the sender are likely in "ours" list at
   step 1. In the common case, if the new pack is kept, we could empty
   "ours" and exit early at step 5.

   If the pack is not kept, we hit the expensive step 6 then exit
   after "ours" is emptied. There'll be only a handful of objects to
   walk in fast-forward case. If it's forced update, we may need to
   walk to the bottom.

3) the sender has same .git/shallow as the receiver

   This is similar to case 2 except that "ours" should be emptied at
   step 2 and exit early.

A fetch after "clone --depth=3DX" is case 1. A fetch after "clone" (fro=
m
a shallow repo) is case 3. Luckily they're cheap for the common case.

A push from "clone --depth=3DX" falls into case 2, which is expensive.
Some more work may be done at the sender/client side to avoid more
work on the server side: if the transferred pack does not contain any
shallow commits, send-pack should not send any shallow commits to the
receive-pack, effectively turning it into a normal push and avoid all
steps.

This patch implements all steps except #3, already handled by
fetch-pack and receive-pack, #6 and #7, which has their own patch due
to their size.

(*) in previous versions step 7 was put before step 3. I reorder it so
    that the common case that keeps the pack does not need to walk
    commits at all. In future if we implement faster commit
    reachability check (maybe with the help of pack bitmaps or commit
    cache), step 7 could become cheap and be moved up before 6 again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 ++
 commit.h  | 15 +++++++++++++
 shallow.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 trace.c   |  2 +-
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index ce377e1..55dd4e3 100644
--- a/cache.h
+++ b/cache.h
@@ -1236,6 +1236,8 @@ __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, .=
=2E.);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
+__attribute__((format (printf, 2, 3)))
+extern void trace_printf_key(const char *key, const char *fmt, ...);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
=20
 void packet_trace_identity(const char *prog);
diff --git a/commit.h b/commit.h
index 1faf717..9ead93b 100644
--- a/commit.h
+++ b/commit.h
@@ -193,6 +193,8 @@ extern struct commit_list *get_octopus_merge_bases(=
struct commit_list *in);
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
=20
+struct sha1_array;
+struct ref;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
@@ -209,6 +211,19 @@ extern void setup_alternate_shallow(struct lock_fi=
le *shallow_lock,
 extern char *setup_temporary_shallow(const struct sha1_array *extra);
 extern void advertise_shallow_grafts(int);
=20
+struct shallow_info {
+	struct sha1_array *shallow;
+	int *ours, nr_ours;
+	int *theirs, nr_theirs;
+	struct sha1_array *ref;
+};
+
+extern void prepare_shallow_info(struct shallow_info *, struct sha1_ar=
ray *);
+extern void clear_shallow_info(struct shallow_info *);
+extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
+extern void remove_nonexistent_ours_in_pack(struct shallow_info *,
+					    struct packed_git *);
+
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
 int in_merge_bases_many(struct commit *, int, struct commit **);
diff --git a/shallow.c b/shallow.c
index f9d1633..a6547ca 100644
--- a/shallow.c
+++ b/shallow.c
@@ -2,6 +2,12 @@
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
+#include "remote.h"
+#include "refs.h"
+#include "sha1-array.h"
+#include "diff.h"
+#include "revision.h"
+#include "commit-slab.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -245,3 +251,69 @@ void advertise_shallow_grafts(int fd)
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
+
+#define TRACE_KEY "GIT_TRACE_SHALLOW"
+
+/*
+ * Step 1, split sender shallow commits into "ours" and "theirs"
+ * Step 2, clean "ours" based on .git/shallow
+ */
+void prepare_shallow_info(struct shallow_info *info, struct sha1_array=
 *sa)
+{
+	int i;
+	trace_printf_key(TRACE_KEY, "shallow: prepare_shallow_info\n");
+	memset(info, 0, sizeof(*info));
+	info->shallow =3D sa;
+	if (!sa)
+		return;
+	info->ours =3D xmalloc(sizeof(*info->ours) * sa->nr);
+	info->theirs =3D xmalloc(sizeof(*info->theirs) * sa->nr);
+	for (i =3D 0; i < sa->nr; i++) {
+		if (has_sha1_file(sa->sha1[i])) {
+			struct commit_graft *graft;
+			graft =3D lookup_commit_graft(sa->sha1[i]);
+			if (graft && graft->nr_parent < 0)
+				continue;
+			info->ours[info->nr_ours++] =3D i;
+		} else
+			info->theirs[info->nr_theirs++] =3D i;
+	}
+}
+
+void clear_shallow_info(struct shallow_info *info)
+{
+	free(info->ours);
+	free(info->theirs);
+}
+
+/* Step 4, remove non-existent ones in "theirs" after getting the pack=
 */
+
+void remove_nonexistent_theirs_shallow(struct shallow_info *info)
+{
+	unsigned char (*sha1)[20] =3D info->shallow->sha1;
+	int i, dst;
+	trace_printf_key(TRACE_KEY, "shallow: remove_nonexistent_theirs_shall=
ow\n");
+	for (i =3D dst =3D 0; i < info->nr_theirs; i++) {
+		if (i !=3D dst)
+			info->theirs[dst] =3D info->theirs[i];
+		if (has_sha1_file(sha1[info->theirs[i]]))
+			dst++;
+	}
+	info->nr_theirs =3D dst;
+}
+
+/* Step 5, remove non-existent ones in "ours" in the pack */
+void remove_nonexistent_ours_in_pack(struct shallow_info *info,
+				     struct packed_git *p)
+{
+	unsigned char (*sha1)[20] =3D info->shallow->sha1;
+	int i, dst;
+	trace_printf_key(TRACE_KEY, "shallow: remove_nonexistent_ours_in_pack=
\n");
+	for (i =3D dst =3D 0; i < info->nr_ours; i++) {
+		if (i !=3D dst)
+			info->ours[dst] =3D info->ours[i];
+		if (find_pack_entry_one(sha1[info->ours[i]], p))
+			dst++;
+	}
+	info->nr_ours =3D dst;
+}
diff --git a/trace.c b/trace.c
index 3d744d1..08180a9 100644
--- a/trace.c
+++ b/trace.c
@@ -76,7 +76,7 @@ static void trace_vprintf(const char *key, const char=
 *fmt, va_list ap)
 }
=20
 __attribute__((format (printf, 2, 3)))
-static void trace_printf_key(const char *key, const char *fmt, ...)
+void trace_printf_key(const char *key, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
--=20
1.8.5.1.25.g8667982
