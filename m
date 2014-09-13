From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] make update-server-info more robust
Date: Sat, 13 Sep 2014 16:19:20 -0400
Message-ID: <20140913201920.GB27082@peff.net>
References: <20140913201538.GA24854@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XStn4-0003Me-Tu
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 22:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaIMUTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 16:19:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:47802 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752263AbaIMUTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 16:19:22 -0400
Received: (qmail 8830 invoked by uid 102); 13 Sep 2014 20:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 15:19:22 -0500
Received: (qmail 10278 invoked by uid 107); 13 Sep 2014 20:19:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:19:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 16:19:20 -0400
Content-Disposition: inline
In-Reply-To: <20140913201538.GA24854@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256974>

Since "git update-server-info" may be called automatically
as part of a push or a "gc --auto", we should be robust
against two processes trying to update it simultaneously.
However, we currently use a fixed tempfile, which means that
two simultaneous writers may step on each other's toes and
end up renaming junk into place.

Let's instead switch to using a unique tempfile via mkstemp.
We do not want to use a lockfile here, because it's OK for
two writers to simultaneously update (one will "win" the
rename race, but that's OK; they should be writing the same
information).

While we're there, let's clean up a few other things:

  1. Detect write errors. Report them and abort the update
     if any are found.

  2. Free path memory rather than leaking it (and clean up
     the tempfile when necessary).

  3. Use the pathdup functions consistently rather than
     static buffers or manually calculated lengths.

This last one fixes a potential overflow of "infofile" in
update_info_packs (e.g., by putting large junk into
$GIT_OBJECT_DIRECTORY). However, this overflow was probably
not an interesting attack vector for two reasons:

  a. The attacker would need to control the environment to
     do this, in which case it was already game-over.

  b. During its setup phase, git checks that the directory
     actually exists, which means it is probably shorter
     than PATH_MAX anyway.

Because both update_info_refs and update_info_packs share
these same failings (and largely duplicate each other), this
patch factors out the improved error-checking version into a
helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess point (b) may not apply on systems that have a really small
PATH_MAX that does not reflect what you can actually create in the
filesystem (Windows?). But I think point (a) still applies, so this is
not really a big deal security-wise (though it is certainly a bugfix for
such systems).

 server-info.c | 116 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/server-info.c b/server-info.c
index 9ec744e..d54a3d6 100644
--- a/server-info.c
+++ b/server-info.c
@@ -4,45 +4,80 @@
 #include "commit.h"
 #include "tag.h"
 
-/* refs */
-static FILE *info_ref_fp;
+/*
+ * Create the file "path" by writing to a temporary file and renaming
+ * it into place. The contents of the file come from "generate", which
+ * should return non-zero if it encounters an error.
+ */
+static int update_info_file(char *path, int (*generate)(FILE *))
+{
+	char *tmp = mkpathdup("%s_XXXXXX", path);
+	int ret = -1;
+	int fd = -1;
+	FILE *fp = NULL;
+
+	safe_create_leading_directories(path);
+	fd = mkstemp(tmp);
+	if (fd < 0)
+		goto out;
+	fp = fdopen(fd, "w");
+	if (!fp)
+		goto out;
+	ret = generate(fp);
+	if (ret)
+		goto out;
+	if (fclose(fp))
+		goto out;
+	if (adjust_shared_perm(tmp) < 0)
+		goto out;
+	if (rename(tmp, path) < 0)
+		goto out;
+	ret = 0;
+
+out:
+	if (ret) {
+		error("unable to update %s: %s", path, strerror(errno));
+		if (fp)
+			fclose(fp);
+		else if (fd >= 0)
+			close(fd);
+		unlink(tmp);
+	}
+	free(tmp);
+	return ret;
+}
 
 static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
+	FILE *fp = cb_data;
 	struct object *o = parse_object(sha1);
 	if (!o)
 		return -1;
 
-	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
+	if (fprintf(fp, "%s	%s\n", sha1_to_hex(sha1), path) < 0)
+		return -1;
+
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, path, 0);
 		if (o)
-			fprintf(info_ref_fp, "%s	%s^{}\n",
-				sha1_to_hex(o->sha1), path);
+			if (fprintf(fp, "%s	%s^{}\n",
+				sha1_to_hex(o->sha1), path) < 0)
+				return -1;
 	}
 	return 0;
 }
 
+static int generate_info_refs(FILE *fp)
+{
+	return for_each_ref(add_info_ref, fp);
+}
+
 static int update_info_refs(int force)
 {
-	char *path0 = git_pathdup("info/refs");
-	int len = strlen(path0);
-	char *path1 = xmalloc(len + 2);
-
-	strcpy(path1, path0);
-	strcpy(path1 + len, "+");
-
-	safe_create_leading_directories(path0);
-	info_ref_fp = fopen(path1, "w");
-	if (!info_ref_fp)
-		return error("unable to update %s", path1);
-	for_each_ref(add_info_ref, NULL);
-	fclose(info_ref_fp);
-	adjust_shared_perm(path1);
-	rename(path1, path0);
-	free(path0);
-	free(path1);
-	return 0;
+	char *path = git_pathdup("info/refs");
+	int ret = update_info_file(path, generate_info_refs);
+	free(path);
+	return ret;
 }
 
 /* packs */
@@ -198,36 +233,27 @@ static void init_pack_info(const char *infofile, int force)
 		info[i]->new_num = i;
 }
 
-static void write_pack_info_file(FILE *fp)
+static int write_pack_info_file(FILE *fp)
 {
 	int i;
-	for (i = 0; i < num_pack; i++)
-		fprintf(fp, "P %s\n", info[i]->p->pack_name + objdirlen + 6);
-	fputc('\n', fp);
+	for (i = 0; i < num_pack; i++) {
+		if (fprintf(fp, "P %s\n", info[i]->p->pack_name + objdirlen + 6) < 0)
+			return -1;
+	}
+	if (fputc('\n', fp) == EOF)
+		return -1;
+	return 0;
 }
 
 static int update_info_packs(int force)
 {
-	char infofile[PATH_MAX];
-	char name[PATH_MAX];
-	int namelen;
-	FILE *fp;
-
-	namelen = sprintf(infofile, "%s/info/packs", get_object_directory());
-	strcpy(name, infofile);
-	strcpy(name + namelen, "+");
+	char *infofile = mkpathdup("%s/info/packs", get_object_directory());
+	int ret;
 
 	init_pack_info(infofile, force);
-
-	safe_create_leading_directories(name);
-	fp = fopen(name, "w");
-	if (!fp)
-		return error("cannot open %s", name);
-	write_pack_info_file(fp);
-	fclose(fp);
-	adjust_shared_perm(name);
-	rename(name, infofile);
-	return 0;
+	ret = update_info_file(infofile, write_pack_info_file);
+	free(infofile);
+	return ret;
 }
 
 /* public */
-- 
2.1.0.373.g91ca799
