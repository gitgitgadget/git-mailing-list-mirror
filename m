From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] local-fetch.c: some error printing cleanup
Date: Fri, 16 Mar 2007 13:20:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161318210.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:20:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSG6K-0003BM-1s
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965712AbXCPRUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965757AbXCPRUV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:20:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65218 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965712AbXCPRUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:20:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF000DEBATVEA20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 13:20:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42383>

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/local-fetch.c b/local-fetch.c
index 7cfe8b3..4b650ef 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -64,9 +64,9 @@ static int copy_file(const char *source, char *dest, const char *hex,
 		}
 		/* If we got ENOENT there is no point continuing. */
 		if (errno == ENOENT) {
-			if (warn_if_not_exists)
-				fprintf(stderr, "does not exist %s\n", source);
-			return -1;
+			if (!warn_if_not_exists)
+				return -1;
+			return error("does not exist %s", source);
 		}
 	}
 	if (use_symlink) {
@@ -74,9 +74,8 @@ static int copy_file(const char *source, char *dest, const char *hex,
 		if (stat(source, &st)) {
 			if (!warn_if_not_exists && errno == ENOENT)
 				return -1;
-			fprintf(stderr, "cannot stat %s: %s\n", source,
-				strerror(errno));
-			return -1;
+			return error("cannot stat %s: %s", source,
+				     strerror(errno));
 		}
 		if (!symlink(source, dest)) {
 			pull_say("symlink %s\n", hex);
@@ -90,25 +89,21 @@ static int copy_file(const char *source, char *dest, const char *hex,
 		if (ifd < 0) {
 			if (!warn_if_not_exists && errno == ENOENT)
 				return -1;
-			fprintf(stderr, "cannot open %s\n", source);
-			return -1;
+			return error("cannot open %s", source);
 		}
 		ofd = open(dest, O_WRONLY | O_CREAT | O_EXCL, 0666);
 		if (ofd < 0) {
-			fprintf(stderr, "cannot open %s\n", dest);
 			close(ifd);
-			return -1;
+			return error("cannot open %s", dest);
 		}
 		status = copy_fd(ifd, ofd);
 		close(ofd);
 		if (status)
-			fprintf(stderr, "cannot write %s\n", dest);
-		else
-			pull_say("copy %s\n", hex);
-		return status;
+			return error("cannot write %s", dest);
+		pull_say("copy %s\n", hex);
+		return 0;
 	}
-	fprintf(stderr, "failed to copy %s with given copy methods.\n", hex);
-	return -1;
+	return error("failed to copy %s with given copy methods.", hex);
 }
 
 static int fetch_pack(const unsigned char *sha1)
@@ -181,13 +176,11 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	ifd = open(filename, O_RDONLY);
 	if (ifd < 0) {
 		close(ifd);
-		fprintf(stderr, "cannot open %s\n", filename);
-		return -1;
+		return error("cannot open %s", filename);
 	}
 	if (read_in_full(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
 		close(ifd);
-		fprintf(stderr, "cannot read from %s\n", filename);
-		return -1;
+		return error("cannot read from %s", filename);
 	}
 	close(ifd);
 	pull_say("ref %s\n", sha1_to_hex(sha1));
