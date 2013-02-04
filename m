From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] count-objects: report garbage files in .git/objects/pack directory too
Date: Mon,  4 Feb 2013 19:49:05 +0700
Message-ID: <1359982145-10792-2-git-send-email-pclouds@gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2LTq-0003sa-Lg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 13:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3BDMsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 07:48:37 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:38560 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab3BDMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 07:48:36 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so2679524dae.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Q9PveN6hnogeFHAW6zhIEdUidn1bS7L6cixzyVZpGp0=;
        b=X592+EKwexHank9NzKc2/js3nntv0wc0rDRbadPEQ8gM0AO/9oKn3iTV+psCZeRqd9
         KcbGFX9/S/xtX60eeX4KmAJQccQicn/PQn5zYb6vSzBGzdEu0p2iHcupXtguEhYqN9nw
         cs9kkOzlDpJbBY8akCd/FiI1+bgkPcBHqlvmDPVQC/cua7uip5yal0DLZqTmMRch4jh1
         LWHL6uywXOaYKW3wWXdV5b927A10MoB6OSSHLq8+0gDyCCtcrg2sBCQpipdUiaoaIQfg
         IFARYWKqKdEjgVBwSoxJzQfNXZlwhsNJmL6+jTdAlWslowYADapGGyI5CyfZIhBP1q5e
         sNgA==
X-Received: by 10.66.81.166 with SMTP id b6mr52648192pay.7.1359982115535;
        Mon, 04 Feb 2013 04:48:35 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id l5sm21151979pax.10.2013.02.04.04.48.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 04:48:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 04 Feb 2013 19:49:13 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215379>

While it's unusual to have strange files in loose object database,
=2Egit/objects/pack/tmp_* is normal after a broken fetch and they
can eat up a lot of disk space if the user does not pay attention.
Report them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The hook in prepare_packed_git_one is ugly, but I don't want to
 duplicate the search file logic there in count-objects. Maybe I'm
 wrong.

 Interestingly it reports .commits file in my repo too. A nice
 reminder to myself to remind Jeff about count-objects improvements
 for his commit-cache work :)

 Way may also need a more friendly format than this one, which I
 assume is plumbing. Something that average git user can understand
 without looking up the document. If "git stats" is too much for this
 purpose, perhaps "git gc --stats"?

 Documentation/git-count-objects.txt |  4 ++--
 builtin/count-objects.c             | 27 ++++++++++++++++++++++++++-
 sha1_file.c                         | 23 ++++++++++++++++++++---
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index e816823..1611d7c 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
-garbage: the number of files in loose object database that are not
-valid loose objects
+garbage: the number of files in object database that are not valid
+loose objects nor valid packs
=20
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9afaa88..e8fabcf 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,8 @@
 #include "builtin.h"
 #include "parse-options.h"
=20
+static unsigned long garbage;
+
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
@@ -65,6 +67,27 @@ static void count_objects(DIR *d, char *path, int le=
n, int verbose,
 	}
 }
=20
+extern void (*report_pack_garbage)(const char *path, int len, const ch=
ar *name);
+static void real_report_pack_garbage(const char *path, int len, const =
char *name)
+{
+	if (is_dot_or_dotdot(name))
+		return;
+	if (has_extension(name, ".pack")) {
+		struct strbuf idx_file =3D STRBUF_INIT;
+		struct stat st;
+
+		strbuf_addf(&idx_file, "%.*s/%.*s.idx", len, path,
+			    (int)strlen(name) - 5, name);
+		if (!stat(idx_file.buf, &st) && S_ISREG(st.st_mode)) {
+			strbuf_release(&idx_file);
+			return;
+		}
+		strbuf_release(&idx_file);
+	}
+	error("garbage found: %.*s/%s", len, path, name);
+	garbage++;
+}
+
 static char const * const count_objects_usage[] =3D {
 	N_("git count-objects [-v]"),
 	NULL
@@ -76,7 +99,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	const char *objdir =3D get_object_directory();
 	int len =3D strlen(objdir);
 	char *path =3D xmalloc(len + 50);
-	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0, garbage =
=3D 0;
+	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0;
 	off_t loose_size =3D 0;
 	struct option opts[] =3D {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -87,6 +110,8 @@ int cmd_count_objects(int argc, const char **argv, c=
onst char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+	if (verbose)
+		report_pack_garbage =3D real_report_pack_garbage;
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..6045946 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1000,6 +1000,17 @@ void install_packed_git(struct packed_git *pack)
 	packed_git =3D pack;
 }
=20
+static void dummy_report_pack_garbage(const char *path,
+				      int len,
+				      const char *name)
+{
+}
+
+void (*report_pack_garbage)(const char *path,
+			    int len,
+			    const char *name) =3D
+	dummy_report_pack_garbage;
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	/* Ensure that this buffer is large enough so that we can
@@ -1024,11 +1035,15 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (!has_extension(de->d_name, ".idx"))
+		if (!has_extension(de->d_name, ".idx")) {
+			report_pack_garbage(path, len - 1, de->d_name);
 			continue;
+		}
=20
-		if (len + namelen + 1 > sizeof(path))
+		if (len + namelen + 1 > sizeof(path)) {
+			report_pack_garbage(path, len - 1, de->d_name);
 			continue;
+		}
=20
 		/* Don't reopen a pack we already have. */
 		strcpy(path + len, de->d_name);
@@ -1042,8 +1057,10 @@ static void prepare_packed_git_one(char *objdir,=
 int local)
 		 * .pack file that we can map.
 		 */
 		p =3D add_packed_git(path, len + namelen, local);
-		if (!p)
+		if (!p) {
+			report_pack_garbage(path, len - 1, de->d_name);
 			continue;
+		}
 		install_packed_git(p);
 	}
 	closedir(dir);
--=20
1.8.1.2.536.gf441e6d
