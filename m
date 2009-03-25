From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 7/7] Apply restricted permissions to loose objects and pack
 files
Date: Wed, 25 Mar 2009 22:42:02 +0100
Message-ID: <200903252242.02212.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmatM-0007ud-3b
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZCYVmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbZCYVmK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:42:10 -0400
Received: from mx.getmail.no ([84.208.15.66]:43963 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753148AbZCYVmI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:42:08 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300M8P0A6KZ00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:42:06 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH3002P50A22W00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:42:06 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212817
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114678>

Loose objects and pack files are normally created with mode 0444, but in a
repository that uses core.restrictedRepository to restrict file modes, we
further limit permissions on loose objects and pack files, according to the
restrictedRepository setting.

Signed-off-by: Johan Herland <johan@herland.net>
---
 cache.h       |    1 +
 fast-import.c |    4 ++--
 http-push.c   |    2 +-
 http-walker.c |    2 +-
 index-pack.c  |    4 ++--
 sha1_file.c   |    2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 4730f33..82e562b 100644
--- a/cache.h
+++ b/cache.h
@@ -509,6 +509,7 @@ extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern int restricted_repository;
+#define PERM_SHA1_FILE (0444 & ~restricted_repository)
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 extern int core_compression_level;
diff --git a/fast-import.c b/fast-import.c
index beeac0d..feafe6f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -902,8 +902,8 @@ static char *keep_pack(char *curr_index_name)
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
-	chmod(pack_data->pack_name, 0444);
-	chmod(curr_index_name, 0444);
+	chmod(pack_data->pack_name, PERM_SHA1_FILE);
+	chmod(curr_index_name, PERM_SHA1_FILE);
 
 	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
diff --git a/http-push.c b/http-push.c
index 6ce5a1d..e33044f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -748,7 +748,7 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		fchmod(request->local_fileno, 0444);
+		fchmod(request->local_fileno, PERM_SHA1_FILE);
 		close(request->local_fileno); request->local_fileno = -1;
 
 		if (request->curl_result != CURLE_OK &&
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..a0dd5d2 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -231,7 +231,7 @@ static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;
 
-	fchmod(obj_req->local, 0444);
+	fchmod(obj_req->local, PERM_SHA1_FILE);
 	close(obj_req->local); obj_req->local = -1;
 
 	if (obj_req->http_code == 416) {
diff --git a/index-pack.c b/index-pack.c
index 7546822..c82e60a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -825,7 +825,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			die("cannot store pack file");
 	}
 	if (from_stdin)
-		chmod(final_pack_name, 0444);
+		chmod(final_pack_name, PERM_SHA1_FILE);
 
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name) {
@@ -836,7 +836,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
-	chmod(final_index_name, 0444);
+	chmod(final_index_name, PERM_SHA1_FILE);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
diff --git a/sha1_file.c b/sha1_file.c
index a354f06..ad63fe1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2272,7 +2272,7 @@ static void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
-	fchmod(fd, 0444);
+	fchmod(fd, PERM_SHA1_FILE);
 	if (close(fd) != 0)
 		die("unable to write sha1 file");
 }
-- 
1.6.2.1.473.g92672
