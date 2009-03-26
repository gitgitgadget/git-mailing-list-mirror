From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] Move chmod(foo, 0444) into move_temp_to_file()
Date: Thu, 26 Mar 2009 16:16:47 +0100
Message-ID: <200903261616.47185.johan@herland.net>
References: <200903250105.05808.johan@herland.net> <49CB51E2.9010903@viscovery.net> <200903261602.37857.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:18:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmrLw-000158-Ad
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbZCZPQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbZCZPQy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:16:54 -0400
Received: from sam.opera.com ([213.236.208.81]:48539 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbZCZPQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:16:53 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n2QFGlMH009199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Mar 2009 15:16:47 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200903261602.37857.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114788>

When writing out a loose object or a pack (index), move_temp_to_file() is
called to finalize the resulting file. These files (loose files and packs)
should all have permission mode 0444 (modulo adjust_shared_perm()).
Therefore, instead of doing chmod(foo, 0444) explicitly from each callsite
(or even forgetting to chmod() at all), do the chmod() call from within
move_temp_to_file().

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c |    3 ---
 http-push.c   |    1 -
 http-walker.c |    1 -
 index-pack.c  |    7 +++----
 sha1_file.c   |    3 +--
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index db44da3..23c496d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -903,9 +903,6 @@ static char *keep_pack(char *curr_index_name)
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
-	chmod(pack_data->pack_name, 0444);
-	chmod(curr_index_name, 0444);
-
 	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
 		die("cannot create keep file");
diff --git a/http-push.c b/http-push.c
index 6ce5a1d..e465b20 100644
--- a/http-push.c
+++ b/http-push.c
@@ -748,7 +748,6 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		fchmod(request->local_fileno, 0444);
 		close(request->local_fileno); request->local_fileno = -1;
 
 		if (request->curl_result != CURLE_OK &&
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..c5a3ea3 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -231,7 +231,6 @@ static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;
 
-	fchmod(obj_req->local, 0444);
 	close(obj_req->local); obj_req->local = -1;
 
 	if (obj_req->http_code == 416) {
diff --git a/index-pack.c b/index-pack.c
index 7546822..6e93ee6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -823,8 +823,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
 			die("cannot store pack file");
-	}
-	if (from_stdin)
+	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
 
 	if (final_index_name != curr_index_name) {
@@ -835,8 +834,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
-	}
-	chmod(final_index_name, 0444);
+	} else
+		chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
diff --git a/sha1_file.c b/sha1_file.c
index 12e0dfd..87ac53b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2252,7 +2252,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
-	if (adjust_shared_perm(filename))
+	if (chmod(filename, 0444) || adjust_shared_perm(filename))
 		return error("unable to set permission to '%s'", filename);
 	return 0;
 }
@@ -2278,7 +2278,6 @@ static void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
-	fchmod(fd, 0444);
 	if (close(fd) != 0)
 		die("error when closing sha1 file (%s)", strerror(errno));
 }
-- 
1.6.1.2.461.g5bad6
