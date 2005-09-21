From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make object creation in http fetch a bit safer.
Date: Wed, 21 Sep 2005 02:55:49 -0700
Message-ID: <7vd5n2ycbe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 11:58:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI1KZ-0003C8-L6
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 11:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIUJzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 05:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIUJzv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 05:55:51 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49030 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750799AbVIUJzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 05:55:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921095549.HYMS11628.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 05:55:49 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9035>

Unlike write_sha1_file() that tries to create the object file in a
temporary location and then move it to the final location, fetch_object
could have been interrupted in the middle, leaving a corrupt file.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 I think the packfile side is safer -- the index is verified
 with the call to parse_pack_index() which eventually calls
 check_packed_git_idx() to validate it, and the pack file is
 checked when it is first used, just like any pack file we
 originally had.  Ideally, we should validate the pair after
 downloading with git-verify-pack, though.

 http-fetch.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

09d920831edba17fe983269a9d0d85e592dd4bb3
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -350,13 +350,18 @@ int fetch_object(struct alt_base *repo, 
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
 	unsigned char real_sha1[20];
+	char tmpfile[PATH_MAX];
+	int ret;
 	char *url;
 	char *posn;
 
-	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX",
+		 get_object_directory());
 
+	local = mkstemp(tmpfile);
 	if (local < 0)
-		return error("Couldn't open local object %s\n", filename);
+		return error("Couldn't create temporary file %s for %s: %s\n",
+			     tmpfile, filename, strerror(errno));
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -386,18 +391,32 @@ int fetch_object(struct alt_base *repo, 
 		return -1;
 	}
 
+	fchmod(local, 0444);
 	close(local);
 	inflateEnd(&stream);
 	SHA1_Final(real_sha1, &c);
 	if (zret != Z_STREAM_END) {
-		unlink(filename);
+		unlink(tmpfile);
 		return error("File %s (%s) corrupt\n", hex, url);
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(filename);
+		unlink(tmpfile);
 		return error("File %s has bad hash\n", hex);
 	}
-	
+	ret = link(tmpfile, filename);
+	if (ret < 0) {
+		/* Same Coda hack as in write_sha1_file(sha1_file.c) */
+		ret = errno;
+		if (ret == EXDEV && !rename(tmpfile, filename))
+			goto out;
+	}
+	unlink(tmpfile);
+	if (ret) {
+		if (ret != EEXIST)
+			return error("unable to write sha1 filename %s: %s",
+				     filename, strerror(ret));
+	}
+ out:
 	pull_say("got %s\n", hex);
 	return 0;
 }
