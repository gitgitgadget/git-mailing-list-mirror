From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 10:44:57 +0100
Message-ID: <200903261044.58140.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <200903260929.58321.johan@herland.net> <49CB3FA0.8030408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmBW-0008HP-OT
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbZCZJpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756355AbZCZJpH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:45:07 -0400
Received: from mx.getmail.no ([84.208.15.66]:51590 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757258AbZCZJpE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 05:45:04 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300G06XR1WLB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 10:45:01 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300BJIXQY0Z70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 10:45:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.26.93426
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <49CB3FA0.8030408@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114759>

On Thursday 26 March 2009, Johannes Sixt wrote:
> You certainly meant to use the curr_*_name variants in the chmod lines,
> no?

Oops. Yes. My bad.

> This effectively undoes 33b65030, but that is not so good: On Windows
> we cannot rename read-only files.

What about this: Add a "mode" argument to move_temp_to_file(), used to
pass in the 0444, and then within move_temp_to_file() we can do the
chmod(foo, 0444) _after_ renaming the file, but _before_ calling
adjust_shared_perm().

Something like this on top of Junio's patch:

----------------------->8-------------8<-------------------
diff --git a/cache.h b/cache.h
index 9cf5a13..9b28b98 100644
--- a/cache.h
+++ b/cache.h
@@ -652,7 +652,8 @@ extern int do_check_packed_object_crc;
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
-extern int move_temp_to_file(const char *tmpfile, const char *filename);
+/* Set mode to -1 if you don't want to explicitly change the file mode */
+extern int finalize_temp_file(const char *tmpfile, const char *filename, int mode);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
diff --git a/fast-import.c b/fast-import.c
index beeac0d..a5556e9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -902,9 +902,6 @@ static char *keep_pack(char *curr_index_name)
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
-	chmod(pack_data->pack_name, 0444);
-	chmod(curr_index_name, 0444);
-
 	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
 	if (keep_fd < 0)
 		die("cannot create keep file");
@@ -914,12 +911,12 @@ static char *keep_pack(char *curr_index_name)
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (move_temp_to_file(pack_data->pack_name, name))
+	if (finalize_temp_file(pack_data->pack_name, name, 0444))
 		die("cannot store pack file");
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (move_temp_to_file(curr_index_name, name))
+	if (finalize_temp_file(curr_index_name, name, 0444))
 		die("cannot store index file");
 	return name;
 }
diff --git a/http-push.c b/http-push.c
index 6ce5a1d..5be6600 100644
--- a/http-push.c
+++ b/http-push.c
@@ -748,7 +748,6 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		fchmod(request->local_fileno, 0444);
 		close(request->local_fileno); request->local_fileno = -1;
 
 		if (request->curl_result != CURLE_OK &&
@@ -769,9 +768,10 @@ static void finish_request(struct transfer_request *request)
 				unlink(request->tmpfile);
 			} else {
 				request->rename =
-					move_temp_to_file(
+					finalize_temp_file(
 						request->tmpfile,
-						request->filename);
+						request->filename,
+						0444);
 				if (request->rename == 0) {
 					request->obj->flags |= (LOCAL | REMOTE);
 				}
@@ -794,8 +794,9 @@ static void finish_request(struct transfer_request *request)
 
 			fclose(request->local_stream);
 			request->local_stream = NULL;
-			if (!move_temp_to_file(request->tmpfile,
-					       request->filename)) {
+			if (!finalize_temp_file(request->tmpfile,
+					request->filename,
+					-1)) {
 				target = (struct packed_git *)request->userData;
 				target->pack_size = pack_size;
 				lst = &repo->packs;
@@ -1007,7 +1008,7 @@ static int fetch_index(unsigned char *sha1)
 	free(url);
 	fclose(indexfile);
 
-	return move_temp_to_file(tmpfile, filename);
+	return finalize_temp_file(tmpfile, filename, -1);
 }
 
 static int setup_index(unsigned char *sha1)
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..7da78e1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -231,7 +231,6 @@ static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;
 
-	fchmod(obj_req->local, 0444);
 	close(obj_req->local); obj_req->local = -1;
 
 	if (obj_req->http_code == 416) {
@@ -254,7 +253,7 @@ static void finish_object_request(struct object_request *obj_req)
 		return;
 	}
 	obj_req->rename =
-		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
+		finalize_temp_file(obj_req->tmpfile, obj_req->filename, 0444);
 
 	if (obj_req->rename == 0)
 		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
@@ -429,7 +428,7 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 
 	fclose(indexfile);
 
-	return move_temp_to_file(tmpfile, filename);
+	return finalize_temp_file(tmpfile, filename, -1);
 }
 
 static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
@@ -788,7 +787,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	target->pack_size = ftell(packfile);
 	fclose(packfile);
 
-	ret = move_temp_to_file(tmpfile, filename);
+	ret = finalize_temp_file(tmpfile, filename, -1);
 	if (ret)
 		return ret;
 
diff --git a/index-pack.c b/index-pack.c
index 7546822..237acd1 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -821,10 +821,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			final_pack_name = name;
 		}
-		if (move_temp_to_file(curr_pack_name, final_pack_name))
+		if (finalize_temp_file(curr_pack_name, final_pack_name, 0444))
 			die("cannot store pack file");
-	}
-	if (from_stdin)
+	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
 
 	if (final_index_name != curr_index_name) {
@@ -833,10 +832,10 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			final_index_name = name;
 		}
-		if (move_temp_to_file(curr_index_name, final_index_name))
+		if (finalize_temp_file(curr_index_name, final_index_name, 0444))
 			die("cannot store index file");
-	}
-	chmod(final_index_name, 0444);
+	} else
+		chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
diff --git a/sha1_file.c b/sha1_file.c
index 12e0dfd..3c611f4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2215,13 +2215,8 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA1_Final(sha1, &c);
 }
 
-/*
- * Move the just written object into its final resting place.
- * NEEDSWORK: this should be renamed to finalize_temp_file() as
- * "moving" is only a part of what it does, when no patch between
- * master to pu changes the call sites of this function.
- */
-int move_temp_to_file(const char *tmpfile, const char *filename)
+/* Move the just written object into its final resting place. */
+int finalize_temp_file(const char *tmpfile, const char *filename, int mode)
 {
 	int ret = 0;
 
@@ -2252,8 +2247,10 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
+	if (mode > 0 && chmod(filename, mode))
+		return error("unable to set permission %04o on '%s'", mode, filename);
 	if (adjust_shared_perm(filename))
-		return error("unable to set permission to '%s'", filename);
+		return error("unable to adjust permission on '%s'", filename);
 	return 0;
 }
 
@@ -2278,7 +2275,6 @@ static void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
-	fchmod(fd, 0444);
 	if (close(fd) != 0)
 		die("error when closing sha1 file (%s)", strerror(errno));
 }
@@ -2386,7 +2382,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 				tmpfile, strerror(errno));
 	}
 
-	return move_temp_to_file(tmpfile, filename);
+	return finalize_temp_file(tmpfile, filename, 0444);
 }
 
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
----------------------->8-------------8<-------------------


In the above patch, I've passed mode == -1 to finalize_temp_file() from all
callsites where there was no corresponding (f)chmod(foo, 0444). However,
after looking at the context (these are all either packs or loose objects),
I'm wondering if we shouldn't pass mode == 0444 for all of these. At which
point we could replace the above patch with this much simpler version:

----------------------->8-------------8<-------------------
diff --git a/fast-import.c b/fast-import.c
index beeac0d..1df3e86 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -902,9 +902,6 @@ static char *keep_pack(char *curr_index_name)
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
----------------------->8-------------8<-------------------


(We could also add an optional "mode" argument to adjust_shared_perm(), to
get rid of the double chmod().)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
