From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Support packs in local-pull
Date: Tue, 16 Aug 2005 00:10:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508160010050.23242@iabervon.org>
References: <Pine.LNX.4.63.0508160004460.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 06:07:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4sjQ-0003hO-Mt
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 06:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVHPEHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 00:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVHPEHO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 00:07:14 -0400
Received: from iabervon.org ([66.92.72.58]:21002 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932599AbVHPEHN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 00:07:13 -0400
Received: (qmail 24334 invoked by uid 1000); 16 Aug 2005 00:10:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 00:10:32 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508160004460.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If it doesn't find an object, it looks for an index that contains it
and uses the same methods on that instead.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 local-pull.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 91 insertions(+), 21 deletions(-)

aafbc7fb9ae059b9c9afa42e8d2c0548ea960f9f
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -15,34 +15,54 @@ void prefetch(unsigned char *sha1)
 {
 }
 
-int fetch(unsigned char *sha1)
+static struct packed_git *packs = NULL;
+
+void setup_index(unsigned char *sha1)
 {
-	static int object_name_start = -1;
-	static char filename[PATH_MAX];
-	char *hex = sha1_to_hex(sha1);
-	const char *dest_filename = sha1_file_name(sha1);
+	struct packed_git *new_pack;
+	char filename[PATH_MAX];
+	strcpy(filename, path);
+	strcat(filename, "/objects/pack/pack-");
+	strcat(filename, sha1_to_hex(sha1));
+	strcat(filename, ".idx");
+	new_pack = parse_pack_index_file(sha1, filename);
+	new_pack->next = packs;
+	packs = new_pack;
+}
 
-	if (object_name_start < 0) {
-		strcpy(filename, path); /* e.g. git.git */
-		strcat(filename, "/objects/");
-		object_name_start = strlen(filename);
+int setup_indices()
+{
+	DIR *dir;
+	struct dirent *de;
+	char filename[PATH_MAX];
+	unsigned char sha1[20];
+	sprintf(filename, "%s/objects/pack/", path);
+	dir = opendir(filename);
+	while ((de = readdir(dir)) != NULL) {
+		int namelen = strlen(de->d_name);
+		if (namelen != 50 || 
+		    strcmp(de->d_name + namelen - 5, ".pack"))
+			continue;
+		get_sha1_hex(sha1, de->d_name + 5);
+		setup_index(sha1);
 	}
-	filename[object_name_start+0] = hex[0];
-	filename[object_name_start+1] = hex[1];
-	filename[object_name_start+2] = '/';
-	strcpy(filename + object_name_start + 3, hex + 2);
+	return 0;
+}
+
+int copy_file(const char *source, const char *dest, const char *hex)
+{
 	if (use_link) {
-		if (!link(filename, dest_filename)) {
+		if (!link(source, dest)) {
 			pull_say("link %s\n", hex);
 			return 0;
 		}
 		/* If we got ENOENT there is no point continuing. */
 		if (errno == ENOENT) {
-			fprintf(stderr, "does not exist %s\n", filename);
+			fprintf(stderr, "does not exist %s\n", source);
 			return -1;
 		}
 	}
-	if (use_symlink && !symlink(filename, dest_filename)) {
+	if (use_symlink && !symlink(source, dest)) {
 		pull_say("symlink %s\n", hex);
 		return 0;
 	}
@@ -50,25 +70,25 @@ int fetch(unsigned char *sha1)
 		int ifd, ofd, status;
 		struct stat st;
 		void *map;
-		ifd = open(filename, O_RDONLY);
+		ifd = open(source, O_RDONLY);
 		if (ifd < 0 || fstat(ifd, &st) < 0) {
 			close(ifd);
-			fprintf(stderr, "cannot open %s\n", filename);
+			fprintf(stderr, "cannot open %s\n", source);
 			return -1;
 		}
 		map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
 		close(ifd);
 		if (map == MAP_FAILED) {
-			fprintf(stderr, "cannot mmap %s\n", filename);
+			fprintf(stderr, "cannot mmap %s\n", source);
 			return -1;
 		}
-		ofd = open(dest_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		ofd = open(dest, O_WRONLY | O_CREAT | O_EXCL, 0666);
 		status = ((ofd < 0) ||
 			  (write(ofd, map, st.st_size) != st.st_size));
 		munmap(map, st.st_size);
 		close(ofd);
 		if (status)
-			fprintf(stderr, "cannot write %s\n", dest_filename);
+			fprintf(stderr, "cannot write %s\n", dest);
 		else
 			pull_say("copy %s\n", hex);
 		return status;
@@ -77,6 +97,56 @@ int fetch(unsigned char *sha1)
 	return -1;
 }
 
+int fetch_pack(unsigned char *sha1)
+{
+	struct packed_git *target;
+	char filename[PATH_MAX];
+	if (setup_indices())
+		return -1;
+	target = find_sha1_pack(sha1, packs);
+	if (!target)
+		return error("Couldn't find %s: not separate or in any pack", 
+			     sha1_to_hex(sha1));
+	if (get_verbosely) {
+		fprintf(stderr, "Getting pack %s\n",
+			sha1_to_hex(target->sha1));
+		fprintf(stderr, " which contains %s\n",
+			sha1_to_hex(sha1));
+	}
+	sprintf(filename, "%s/objects/pack/pack-%s.pack", 
+		path, sha1_to_hex(sha1));
+	copy_file(filename, sha1_pack_name(sha1), sha1_to_hex(sha1));
+	sprintf(filename, "%s/objects/pack/pack-%s.idx", 
+		path, sha1_to_hex(sha1));
+	copy_file(filename, sha1_pack_index_name(sha1), sha1_to_hex(sha1));
+	install_packed_git(target);
+	return 0;
+}
+
+int fetch_file(unsigned char *sha1)
+{
+	static int object_name_start = -1;
+	static char filename[PATH_MAX];
+	char *hex = sha1_to_hex(sha1);
+	const char *dest_filename = sha1_file_name(sha1);
+
+ 	if (object_name_start < 0) {
+		strcpy(filename, path); /* e.g. git.git */
+		strcat(filename, "/objects/");
+		object_name_start = strlen(filename);
+	}
+	filename[object_name_start+0] = hex[0];
+	filename[object_name_start+1] = hex[1];
+	filename[object_name_start+2] = '/';
+	strcpy(filename + object_name_start + 3, hex + 2);
+	return copy_file(filename, dest_filename, hex);
+}
+
+int fetch(unsigned char *sha1)
+{
+	return fetch_file(sha1) && fetch_pack(sha1);
+}
+
 int fetch_ref(char *ref, unsigned char *sha1)
 {
 	static int ref_name_start = -1;
