From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Demo support for packs via HTTP
Date: Sun, 10 Jul 2005 15:56:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101555271.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 10 22:12:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dri9n-000130-8L
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVGJT7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGJT6j
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 15:58:39 -0400
Received: from iabervon.org ([66.92.72.58]:47876 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262096AbVGJT6E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 15:58:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrhuJ-0007Vn-00; Sun, 10 Jul 2005 15:56:07 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Support for downloading the pack file
"e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135" when appropriate. (Will
support other pack files when the repository has a list of them.)

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit 74132562a2f6cfce9690a5091de7e85bd51d88af
tree c0ae9cb936abac4412aa4a89928f4609d111fd2c
parent b686d7a0377c24e05dbed0dafe909dda6c3dfb48
author Daniel Barkalow <barkalow@iabervon.org> 1121024943 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1121024943 -0400

Index: http-pull.c
===================================================================
--- ce285b1a0adb4f8d415f72668a77bc1f1f92e1e1/http-pull.c  (mode:100644 sha1:1f9d60b9b1d5eed85b24d96c240666bbfc5a22ed)
+++ c0ae9cb936abac4412aa4a89928f4609d111fd2c/http-pull.c  (mode:100644 sha1:2a8d7e71d9447483668cb4a1eb01a096e736f8e3)
@@ -56,6 +56,126 @@
 	return size;
 }
 
+static int got_indices = 0;
+
+static struct packed_git *packs = NULL;
+
+static int fetch_index(unsigned char *sha1)
+{
+	char *filename;
+	char *url;
+
+	FILE *indexfile;
+
+	if (has_pack_index(sha1))
+		return 0;
+
+	if (get_verbosely)
+		fprintf(stderr, "Getting index for pack %s\n",
+			sha1_to_hex(sha1));
+	
+	url = xmalloc(strlen(base) + 64);
+	sprintf(url, "%s/objects/pack/pack-%s.idx",
+		base, sha1_to_hex(sha1));
+	
+	filename = sha1_pack_index_name(sha1);
+	indexfile = fopen(filename, "w");
+	if (!indexfile)
+		return error("Unable to open local file %s for pack index",
+			     filename);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, indexfile);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+	
+	if (curl_easy_perform(curl)) {
+		fclose(indexfile);
+		return error("Unable to get pack index %s", url);
+	}
+
+	fclose(indexfile);
+	return 0;
+}
+
+static int setup_index(unsigned char *sha1)
+{
+	struct packed_git *new_pack;
+	if (has_pack_file(sha1))
+		return 0; // don't list this as something we can get
+
+	if (fetch_index(sha1))
+		return -1;
+
+	new_pack = parse_pack_index(sha1);
+	new_pack->next = packs;
+	packs = new_pack;
+	return 0;
+}
+
+static int fetch_indices(void)
+{
+	unsigned char sha1[20];
+	if (got_indices)
+		return 0;
+	get_sha1_hex("e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135", sha1);
+	setup_index(sha1);
+	got_indices = 1;
+	return 0;
+}
+
+static int fetch_pack(unsigned char *sha1)
+{
+	char *url;
+	struct packed_git *target;
+	struct packed_git **lst;
+	FILE *packfile;
+	char *filename;
+
+	if (fetch_indices())
+		return -1;
+	target = find_sha1_pack(sha1, packs);
+	if (!target)
+		return error("Couldn't get %s: not separate or in any pack",
+			     sha1_to_hex(sha1));
+
+	if (get_verbosely) {
+		fprintf(stderr, "Getting pack %s\n",
+			sha1_to_hex(target->sha1));
+		fprintf(stderr, " which contains %s\n",
+			sha1_to_hex(sha1));
+	}
+
+	url = xmalloc(strlen(base) + 65);
+	sprintf(url, "%s/objects/pack/pack-%s.pack",
+		base, sha1_to_hex(target->sha1));
+
+	filename = sha1_pack_name(target->sha1);
+	packfile = fopen(filename, "w");
+	if (!packfile)
+		return error("Unable to open local file %s for pack",
+			     filename);
+
+	curl_easy_setopt(curl, CURLOPT_FILE, packfile);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+	
+	if (curl_easy_perform(curl)) {
+		fclose(packfile);
+		return error("Unable to get pack file %s", url);
+	}
+
+	fclose(packfile);
+
+	install_packed_git(target);
+
+	lst = &packs;
+	while (*lst != target)
+		lst = &((*lst)->next);
+	*lst = (*lst)->next;
+
+	return 0;
+}
+
 int fetch(unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
@@ -67,7 +187,7 @@
 	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
 
 	if (local < 0)
-		return error("Couldn't open %s\n", filename);
+		return error("Couldn't open local object %s\n", filename);
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -75,6 +195,7 @@
 
 	SHA1_Init(&c);
 
+	curl_easy_setopt(curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 
@@ -90,8 +211,12 @@
 
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 
-	if (curl_easy_perform(curl))
-		return error("Couldn't get %s for %s\n", url, hex);
+	if (curl_easy_perform(curl)) {
+		unlink(filename);
+		if (fetch_pack(sha1))
+			return error("Tried %s", url);
+		return 0;
+	}
 
 	close(local);
 	inflateEnd(&stream);
