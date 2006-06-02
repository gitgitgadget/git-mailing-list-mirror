From: Jeff King <peff@peff.net>
Subject: [PATCH] handle concurrent pruning of packed objects
Date: Fri, 2 Jun 2006 11:32:23 -0400
Message-ID: <20060602153223.GA4223@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 02 17:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmBdV-0001m3-4n
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 17:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFBPc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 11:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWFBPcZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 11:32:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:42938 "HELO
	peff.net") by vger.kernel.org with SMTP id S932177AbWFBPcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 11:32:25 -0400
Received: (qmail 29858 invoked from network); 2 Jun 2006 11:32:23 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Jun 2006 11:32:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  2 Jun 2006 11:32:23 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21162>

This patch causes read_sha1_file and sha1_object_info to re-examine the
list of packs if an object cannot be found. It works by re-running
prepare_packed_git() after an object fails to be found.

It does not attempt to clean up the old pack list. Old packs which are in
use can continue to be used (until unused by lru selection).  New packs
are placed at the front of the list and will thus be examined before old
packs.

Signed-off-by: Jeff King <peff@peff.net>
---

This is a repost, since there was no response last time. Linus
indicated this approach was reasonable; see:
  <Pine.LNX.4.64.0605300752430.5623@g5.osdl.org>

I tested this by making a simple repo with three commits: a, b, and c.
I ran git diff-tree --stdin, and then did the following:
  1. fed 'a b' to diff-tree
  2. ran git repack -a -d
  3. fed 'b c' to diff-tree
Vanilla git complains about the lack of object, whereas this version
provides the correct diff-tree output.

 sha1_file.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f77c189..696e53f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -626,12 +626,12 @@ static void prepare_packed_git_one(char 
 	closedir(dir);
 }
 
+static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
-	static int run_once = 0;
 	struct alternate_object_database *alt;
 
-	if (run_once)
+	if (prepare_packed_git_run_once)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -640,7 +640,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->base, 0);
 		alt->name[-1] = '/';
 	}
-	run_once = 1;
+	prepare_packed_git_run_once = 1;
+}
+
+static void reprepare_packed_git(void)
+{
+	prepare_packed_git_run_once = 0;
+	prepare_packed_git();
 }
 
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
@@ -1212,9 +1218,12 @@ int sha1_object_info(const unsigned char
 	if (!map) {
 		struct pack_entry e;
 
-		if (!find_pack_entry(sha1, &e))
-			return error("unable to find %s", sha1_to_hex(sha1));
-		return packed_object_info(&e, type, sizep);
+		if (find_pack_entry(sha1, &e))
+			return packed_object_info(&e, type, sizep);
+		reprepare_packed_git();
+		if (find_pack_entry(sha1, &e))
+			return packed_object_info(&e, type, sizep);
+		return error("unable to find %s", sha1_to_hex(sha1));
 	}
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
@@ -1256,6 +1265,9 @@ void * read_sha1_file(const unsigned cha
 		munmap(map, mapsize);
 		return buf;
 	}
+	reprepare_packed_git();
+	if (find_pack_entry(sha1, &e))
+		return read_packed_sha1(sha1, type, size);
 	return NULL;
 }
 
-- 
1.3.3.g331f

-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

----- End forwarded message -----
