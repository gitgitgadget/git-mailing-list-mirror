From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 6/6] git-local-fetch: Avoid confusing error messages on packed repositories
Date: Fri, 23 Sep 2005 16:28:38 +0400 (MSD)
Message-ID: <20050923122838.5107AE010FC@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:29:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImfT-0007A0-2p
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVIWM2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVIWM2k
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:40 -0400
Received: from mivlgu.ru ([81.18.140.87]:17104 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750945AbVIWM2j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:39 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 5107AE010FC; Fri, 23 Sep 2005 16:28:38 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9181>

If the source repository was packed, and git-local-fetch needed to
fetch a pack file, it spewed a misleading error message about not
being able to find the unpacked object.  Fixed by adding the
warn_if_not_exists argument to copy_file(), which controls printing
of error messages in case the source file does not exist.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 local-fetch.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

3417063eaaf7a9293621a72c8b5df4653daf04ea
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -52,7 +52,8 @@ static int setup_indices(void)
 	return 0;
 }
 
-static int copy_file(const char *source, const char *dest, const char *hex)
+static int copy_file(const char *source, const char *dest, const char *hex,
+		     int warn_if_not_exists)
 {
 	if (use_link) {
 		if (!link(source, dest)) {
@@ -61,13 +62,16 @@ static int copy_file(const char *source,
 		}
 		/* If we got ENOENT there is no point continuing. */
 		if (errno == ENOENT) {
-			fprintf(stderr, "does not exist %s\n", source);
+			if (warn_if_not_exists)
+				fprintf(stderr, "does not exist %s\n", source);
 			return -1;
 		}
 	}
 	if (use_symlink) {
 		struct stat st;
 		if (stat(source, &st)) {
+			if (!warn_if_not_exists && errno == ENOENT)
+				return -1;
 			fprintf(stderr, "cannot stat %s: %s\n", source,
 				strerror(errno));
 			return -1;
@@ -83,8 +87,11 @@ static int copy_file(const char *source,
 		void *map;
 		ifd = open(source, O_RDONLY);
 		if (ifd < 0 || fstat(ifd, &st) < 0) {
+			int err = errno;
 			if (ifd >= 0)
 				close(ifd);
+			if (!warn_if_not_exists && err == ENOENT)
+				return -1;
 			fprintf(stderr, "cannot open %s\n", source);
 			return -1;
 		}
@@ -129,11 +136,11 @@ static int fetch_pack(const unsigned cha
 	sprintf(filename, "%s/objects/pack/pack-%s.pack", 
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_name(target->sha1),
-		  sha1_to_hex(target->sha1));
+		  sha1_to_hex(target->sha1), 1);
 	sprintf(filename, "%s/objects/pack/pack-%s.idx", 
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_index_name(target->sha1),
-		  sha1_to_hex(target->sha1));
+		  sha1_to_hex(target->sha1), 1);
 	install_packed_git(target);
 	return 0;
 }
@@ -154,7 +161,7 @@ static int fetch_file(const unsigned cha
 	filename[object_name_start+1] = hex[1];
 	filename[object_name_start+2] = '/';
 	strcpy(filename + object_name_start + 3, hex + 2);
-	return copy_file(filename, dest_filename, hex);
+	return copy_file(filename, dest_filename, hex, 0);
 }
 
 int fetch(unsigned char *sha1)
