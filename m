From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 21/23] pack v4: normalize pack name to properly generate the
 pack index file name
Date: Tue, 27 Aug 2013 00:26:05 -0400
Message-ID: <1377577567-27655-22-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArp-0007MP-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab3H0E0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab3H0E0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:35 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0I9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 339A12DA0669	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233054>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 73 +++++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index bb171c5..6801e21 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -949,56 +949,46 @@ static off_t packv4_write_object(struct sha1file *f, struct packed_git *p,
 	return hdrlen + size;
 }
 
-static struct packed_git *open_pack(const char *path)
+static char *normalize_pack_name(const char *path)
 {
-	char arg[PATH_MAX];
+	char buf[PATH_MAX];
 	int len;
-	struct packed_git *p;
 
-	len = strlcpy(arg, path, PATH_MAX);
-	if (len >= PATH_MAX) {
-		error("name too long: %s", path);
-		return NULL;
-	}
+	len = strlcpy(buf, path, PATH_MAX);
+	if (len >= PATH_MAX - 6)
+		die("name too long: %s", path);
 
 	/*
 	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
-	 * normalize these forms to "foo.idx" for add_packed_git().
+	 * normalize these forms to "foo.pack".
 	 */
-	if (has_extension(arg, ".pack")) {
-		strcpy(arg + len - 5, ".idx");
-		len--;
-	} else if (!has_extension(arg, ".idx")) {
-		if (len + 4 >= PATH_MAX) {
-			error("name too long: %s.idx", arg);
-			return NULL;
-		}
-		strcpy(arg + len, ".idx");
-		len += 4;
+	if (has_extension(buf, ".idx")) {
+		strcpy(buf + len - 4, ".pack");
+		len++;
+	} else if (!has_extension(buf, ".pack")) {
+		strcpy(buf + len, ".pack");
+		len += 5;
 	}
 
-	/*
-	 * add_packed_git() uses our buffer (containing "foo.idx") to
-	 * build the pack filename ("foo.pack").  Make sure it fits.
-	 */
-	if (len + 1 >= PATH_MAX) {
-		arg[len - 4] = '\0';
-		error("name too long: %s.pack", arg);
-		return NULL;
-	}
+	return xstrdup(buf);
+}
 
-	p = add_packed_git(arg, len, 1);
-	if (!p) {
-		error("packfile %s not found.", arg);
-		return NULL;
-	}
+static struct packed_git *open_pack(const char *path)
+{
+	char *packname = normalize_pack_name(path);
+	int len = strlen(packname);
+	struct packed_git *p;
+
+	strcpy(packname + len - 5, ".idx");
+	p = add_packed_git(packname, len - 1, 1);
+	if (!p)
+		die("packfile %s not found.", packname);
 
 	install_packed_git(p);
-	if (open_pack_index(p)) {
-		error("packfile %s index not opened", p->pack_name);
-		return NULL;
-	}
+	if (open_pack_index(p))
+		die("packfile %s index not opened", p->pack_name);
 
+	free(packname);
 	return p;
 }
 
@@ -1010,6 +1000,7 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	struct pack_idx_option idx_opts;
 	unsigned i, nr_objects;
 	off_t written = 0;
+	char *packname;
 	unsigned char pack_sha1[20];
 
 	p = open_pack(src_pack);
@@ -1024,7 +1015,8 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	sort_dict_entries_by_hits(commit_name_table);
 	sort_dict_entries_by_hits(tree_path_table);
 
-	f = packv4_open(dst_pack);
+	packname = normalize_pack_name(dst_pack);
+	f = packv4_open(packname);
 	if (!f)
 		die("unable to open destination pack");
 	written += packv4_write_header(f, nr_objects);
@@ -1046,7 +1038,10 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 
 	reset_pack_idx_option(&idx_opts);
 	idx_opts.version = 3;
-	write_idx_file(dst_pack, p_objs, nr_objects, &idx_opts, pack_sha1);
+	strcpy(packname + strlen(packname) - 5, ".idx");
+	write_idx_file(packname, p_objs, nr_objects, &idx_opts, pack_sha1);
+
+	free(packname);
 }
 
 static int git_pack_config(const char *k, const char *v, void *cb)
-- 
1.8.4.22.g54757b7
