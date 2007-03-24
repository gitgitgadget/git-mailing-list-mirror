From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make it more obvious that temporary files are temporary files
Date: Sat, 24 Mar 2007 11:58:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703241151010.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 16:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV8dR-0000EG-05
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 16:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbXCXP6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 11:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbXCXP6Z
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 11:58:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57998 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbXCXP6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 11:58:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFF00BRP0DAGWC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Mar 2007 11:58:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43007>

When some operations are interrupted (or "die()'d" or crashed) then the 
partial object/pack/index file may remain around.  Make it more obvious 
in their name that those files are temporary stuff and can be cleaned up 
if no operation is in progress.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/fast-import.c b/fast-import.c
index 55ffae4..bea1215 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -630,7 +630,7 @@ static void start_packfile(void)
 	int pack_fd;
 
 	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/pack_XXXXXX", get_object_directory());
+		"%s/tmp_pack_XXXXXX", get_object_directory());
 	pack_fd = mkstemp(tmpfile);
 	if (pack_fd < 0)
 		die("Can't create %s: %s", tmpfile, strerror(errno));
@@ -730,7 +730,7 @@ static char *create_index(void)
 	}
 
 	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/index_XXXXXX", get_object_directory());
+		"%s/tmp_idx_XXXXXX", get_object_directory());
 	idx_fd = mkstemp(tmpfile);
 	if (idx_fd < 0)
 		die("Can't create %s: %s", tmpfile, strerror(errno));
diff --git a/index-pack.c b/index-pack.c
index 61eb20e..6284fe3 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -139,7 +139,7 @@ static const char *open_pack_file(const char *pack_name)
 		if (!pack_name) {
 			static char tmpfile[PATH_MAX];
 			snprintf(tmpfile, sizeof(tmpfile),
-				 "%s/pack_XXXXXX", get_object_directory());
+				 "%s/tmp_pack_XXXXXX", get_object_directory());
 			output_fd = mkstemp(tmpfile);
 			pack_name = xstrdup(tmpfile);
 		} else
@@ -690,7 +690,7 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 	if (!index_name) {
 		static char tmpfile[PATH_MAX];
 		snprintf(tmpfile, sizeof(tmpfile),
-			 "%s/index_XXXXXX", get_object_directory());
+			 "%s/tmp_idx_XXXXXX", get_object_directory());
 		fd = mkstemp(tmpfile);
 		index_name = xstrdup(tmpfile);
 	} else {
diff --git a/sha1_file.c b/sha1_file.c
index 940bab5..0897b94 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1979,7 +1979,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		return error("sha1 file %s: %s\n", filename, strerror(errno));
 	}
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	snprintf(tmpfile, sizeof(tmpfile), "%s/tmp_obj_XXXXXX", get_object_directory());
 
 	fd = mkstemp(tmpfile);
 	if (fd < 0) {
@@ -2105,7 +2105,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	int ret;
 	SHA_CTX c;
 
-	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
+	snprintf(tmpfile, sizeof(tmpfile), "%s/tmp_obj_XXXXXX", get_object_directory());
 
 	local = mkstemp(tmpfile);
 	if (local < 0) {
