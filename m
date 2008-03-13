From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: proper pack time stamping with --max-pack-size
Date: Thu, 13 Mar 2008 14:59:29 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803131440590.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsfG-0004KH-Kx
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 20:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbYCMS7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbYCMS7b
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:59:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34058 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYCMS7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:59:30 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXO004ZFNF57PF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Mar 2008 14:59:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77128>

Runtime pack access is done in the pack file mtime order since recent 
packs are more likely to contain frequently used objects than old packs.
However the --max-pack-size option can produce multiple packs with mtime 
in the reversed order as newer objects are always written first.

Let's modify mtime of later pack files (when any) so they appear older 
than preceding ones when a repack creates multiple packs.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f504cff..4c2ed70 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,6 +17,8 @@
 #include "progress.h"
 #include "refs.h"
 
+#include <utime.h>
+
 #ifdef THREADED_DELTA_SEARCH
 #include "thread-utils.h"
 #include <pthread.h>
@@ -454,6 +456,7 @@ static void write_pack_file(void)
 	struct pack_header hdr;
 	int do_progress = progress >> pack_to_stdout;
 	uint32_t nr_remaining = nr_result;
+	time_t last_mtime = 0;
 
 	if (do_progress)
 		progress_state = start_progress("Writing objects", nr_result);
@@ -504,6 +507,7 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			mode_t mode = umask(0);
+			struct stat st;
 			char *idx_tmp_name, tmpname[PATH_MAX];
 
 			umask(mode);
@@ -511,6 +515,7 @@ static void write_pack_file(void)
 
 			idx_tmp_name = write_idx_file(NULL, written_list,
 						      nr_written, sha1);
+
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(pack_tmp_name, mode))
@@ -519,6 +524,28 @@ static void write_pack_file(void)
 			if (rename(pack_tmp_name, tmpname))
 				die("unable to rename temporary pack file: %s",
 				    strerror(errno));
+
+			/*
+			 * Packs are runtime accessed in their mtime
+			 * order since newer packs are more likely to contain
+			 * younger objects.  So if we are creating multiple
+			 * packs then we should modify the mtime of later ones
+			 * to preserve this property.
+			 */
+			if (stat(tmpname, &st) < 0) {
+				warning("failed to stat %s: %s",
+					tmpname, strerror(errno));
+			} else if (!last_mtime) {
+				last_mtime = st.st_mtime;
+			} else {
+				struct utimbuf utb;
+				utb.actime = st.st_atime;
+				utb.modtime = --last_mtime;
+				if (utime(tmpname, &utb) < 0)
+					warning("failed utime() on %s: %s",
+						tmpname, strerror(errno));
+			}
+
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
 				 base_name, sha1_to_hex(sha1));
 			if (adjust_perm(idx_tmp_name, mode))
@@ -527,6 +554,7 @@ static void write_pack_file(void)
 			if (rename(idx_tmp_name, tmpname))
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
+
 			free(idx_tmp_name);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
