From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [5/5] Make fsck-cache read heads out of .git/refs/*/*
Date: Thu, 28 Apr 2005 01:17:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280113560.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1Jy-0007uC-K2
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVD1FRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVD1FRk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:17:40 -0400
Received: from iabervon.org ([66.92.72.58]:773 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262001AbVD1FRZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:17:25 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1Ou-0001mm-00; Thu, 28 Apr 2005 01:17:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes fsck-cache expect the root set of the reachability graph (i.e.,
your heads and tags) to be .git/refs/*/*, which contain hex versions of
hashs of roots (like .get/HEAD has always been).

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: fsck-cache.c
===================================================================
--- ca8a271be1370ab0795a869c15114e566bdd15d8/fsck-cache.c  (mode:100644 sha1:280a104050b665515418c00c33af8e6b0b0e2101)
+++ c53109e78c0b0d8925a4198fdec8295620f8f349/fsck-cache.c  (mode:100644 sha1:c4ff5bf3d71c35236e769d30035b00acf08d452b)
@@ -135,6 +135,67 @@
 	return 0;
 }
 
+int read_refs_dirs(char *path)
+{
+	DIR *dir = opendir(path);
+	char filename[NAME_MAX+1];
+	struct dirent *de;
+	int total = 0;
+	char *base;
+
+	if (!dir) {
+		error("missing refs directory '%s'", path);
+		return 0;
+	}
+	strcpy(filename, path);
+	base = filename + strlen(path);
+	*(base++) = '/';
+	while ((de = readdir(dir)) != NULL) {
+		DIR *subdir;
+		char *subbase;
+		if (de->d_name[0] == '.')
+			continue;
+		strcpy(base, de->d_name);
+		subbase = base + strlen(de->d_name);
+		subdir = opendir(filename);
+		if (!subdir) {
+			fprintf(stderr, "can't open subdir %s\n", filename);
+			continue;
+		}
+		*(subbase++) = '/';
+		while ((de = readdir(subdir)) != NULL) {
+			char hex[41];
+			char sha1[20];
+			int fd;
+			struct object *obj;
+			if (de->d_name[0] == '.')
+				continue;
+			strcpy(subbase, de->d_name);
+			fd = open(filename, O_RDONLY);
+			if (fd < 0) {
+				fprintf(stderr, "Couldn't open %s\n", filename);
+				continue;
+			}
+			if ((read(fd, hex, 41) < 41) ||
+			    (hex[40] != '\n') ||
+			    get_sha1_hex(hex, sha1)) {
+				fprintf(stderr, "Couldn't read a hash from %s\n",
+					filename);
+				continue;
+			}
+			obj = parse_object(sha1);
+			obj->used = 1;
+			mark_reachable(obj, REACHABLE);
+			
+			total++;
+		}
+		closedir(subdir);
+	}
+	closedir(dir);
+
+	return total;
+}
+
 int main(int argc, char **argv)
 {
 	int i, heads;
@@ -183,6 +244,8 @@
 		error("expected sha1, got %s", arg);
 	}
 
+	heads += read_refs_dirs(".git/refs");
+
 	if (!heads) {
 		if (show_unreachable) {
 			fprintf(stderr, "unable to do reachability without a head\n");

