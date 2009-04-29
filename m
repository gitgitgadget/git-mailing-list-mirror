From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] replace direct calls to unlink(2) with unlink_or_warn
Date: Wed, 29 Apr 2009 23:22:56 +0200
Message-ID: <20090429212256.GB12099@blimp.localdomain>
References: <9eb8d64313e3907449150b3a1310a2a6078c0c79.1241039463.git.raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHG9-0004uw-PL
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbZD2VXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbZD2VXK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:23:10 -0400
Received: from mout2.freenet.de ([195.4.92.92]:50931 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbZD2VXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:23:07 -0400
Received: from [195.4.92.18] (helo=8.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1LzHF8-0002EC-LK; Wed, 29 Apr 2009 23:23:02 +0200
Received: from x6432.x.pppool.de ([89.59.100.50]:58852 helo=tigra.home)
	by 8.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LzHF7-0008CW-Ji; Wed, 29 Apr 2009 23:23:02 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 66CCB277D8;
	Wed, 29 Apr 2009 23:22:56 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 56EDE36D28; Wed, 29 Apr 2009 23:22:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090429212146.GA12099@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117949>

This helps to notice when something's going wrong, especially on
systems which lock open files.

I used the following criteria when selecting the code for replacement:
- it was already printing a warning for the unlink failures
- it is in a function which already printing something or is
  called from such a function
- it is in a static function, returning void and the function is only
  called from a builtin main function (cmd_)
- it is in a function which handles emergency exit (signal handlers)
- it is in a function which is obvously cleaning up the lockfiles

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-apply.c        |    4 ++--
 builtin-fetch-pack.c   |    2 +-
 builtin-prune-packed.c |    4 ++--
 builtin-prune.c        |    4 ++--
 builtin-receive-pack.c |    2 +-
 builtin-remote.c       |    4 ++--
 builtin-rerere.c       |    2 +-
 builtin-tag.c          |    2 +-
 builtin-verify-tag.c   |    2 +-
 diff.c                 |    2 +-
 entry.c                |    2 +-
 fast-import.c          |    4 ++--
 http-push.c            |   12 ++++++------
 http-walker.c          |   14 +++++++-------
 ll-merge.c             |    2 +-
 lockfile.c             |    4 ++--
 pack-refs.c            |    2 +-
 refs.c                 |   15 +++++----------
 rerere.c               |    2 +-
 server-info.c          |    2 +-
 sha1_file.c            |    2 +-
 transport.c            |    2 +-
 unpack-trees.c         |    2 +-
 23 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7b404ef..8a3771e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2781,7 +2781,7 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 			if (rmdir(patch->old_name))
 				warning("unable to remove submodule %s",
 					patch->old_name);
-		} else if (!unlink(patch->old_name) && rmdir_empty) {
+		} else if (!unlink_or_warn(patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
@@ -2891,7 +2891,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 			if (!try_create_file(newpath, mode, buf, size)) {
 				if (!rename(newpath, path))
 					return;
-				unlink(newpath);
+				unlink_or_warn(newpath);
 				break;
 			}
 			if (errno != EEXIST)
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 5d134be..bd97cfd 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -814,7 +814,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		fd = hold_lock_file_for_update(&lock, shallow,
 					       LOCK_DIE_ON_ERROR);
 		if (!write_shallow_commits(fd, 0)) {
-			unlink(shallow);
+			unlink_or_warn(shallow);
 			rollback_lock_file(&lock);
 		} else {
 			commit_lock_file(&lock);
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 4942892..00590b1 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -28,8 +28,8 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		memcpy(pathname + len, de->d_name, 38);
 		if (opts & DRY_RUN)
 			printf("rm -f %s\n", pathname);
-		else if (unlink(pathname) < 0)
-			error("unable to unlink %s", pathname);
+		else
+			unlink_or_warn(pathname);
 		display_progress(progress, i + 1);
 	}
 	pathname[len] = 0;
diff --git a/builtin-prune.c b/builtin-prune.c
index 545e9c1..145ba83 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -27,7 +27,7 @@ static int prune_tmp_object(const char *path, const char *filename)
 	}
 	printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
-		unlink(fullpath);
+		unlink_or_warn(fullpath);
 	return 0;
 }
 
@@ -47,7 +47,7 @@ static int prune_object(char *path, const char *filename, const unsigned char *s
 		       (type > 0) ? typename(type) : "unknown");
 	}
 	if (!show_only)
-		unlink(fullpath);
+		unlink_or_warn(fullpath);
 	return 0;
 }
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index a970b39..035b723 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -702,7 +702,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unpack_status = unpack();
 		execute_commands(unpack_status);
 		if (pack_lockfile)
-			unlink(pack_lockfile);
+			unlink_or_warn(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
 		run_receive_hook(post_receive_hook);
diff --git a/builtin-remote.c b/builtin-remote.c
index 2ed752c..71abf68 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -525,8 +525,8 @@ static int migrate_file(struct remote *remote)
 		path = git_path("remotes/%s", remote->name);
 	else if (remote->origin == REMOTE_BRANCHES)
 		path = git_path("branches/%s", remote->name);
-	if (path && unlink(path))
-		warning("failed to remove '%s'", path);
+	if (path)
+		unlink_or_warn(path);
 	return 0;
 }
 
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 020af73..adfb7b5 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -116,7 +116,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
-		unlink(git_path("rr-cache/MERGE_RR"));
+		unlink_or_warn(git_path("rr-cache/MERGE_RR"));
 	} else if (!strcmp(argv[1], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[1], "status"))
diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..e544430 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -338,7 +338,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 		exit(128);
 	}
 	if (path) {
-		unlink(path);
+		unlink_or_warn(path);
 		free(path);
 	}
 }
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 729a159..7f7fda4 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -55,7 +55,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	close(gpg.in);
 	ret = finish_command(&gpg);
 
-	unlink(path);
+	unlink_or_warn(path);
 
 	return ret;
 }
diff --git a/diff.c b/diff.c
index 3ac7168..6802f5a 100644
--- a/diff.c
+++ b/diff.c
@@ -189,7 +189,7 @@ static void remove_tempfile(void)
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
 		if (diff_temp[i].name == diff_temp[i].tmp_path)
-			unlink(diff_temp[i].name);
+			unlink_or_warn(diff_temp[i].name);
 		diff_temp[i].name = NULL;
 	}
 }
diff --git a/entry.c b/entry.c
index 915514a..cc841ed 100644
--- a/entry.c
+++ b/entry.c
@@ -35,7 +35,7 @@ static void create_directories(const char *path, int path_len,
 		 */
 		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST && state->force &&
-			    !unlink(buf) && !mkdir(buf, 0777))
+			    !unlink_or_warn(buf) && !mkdir(buf, 0777))
 				continue;
 			die("cannot create directory at %s", buf);
 		}
diff --git a/fast-import.c b/fast-import.c
index 8d959af..6a618e9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -931,7 +931,7 @@ static void unkeep_all_packs(void)
 		struct packed_git *p = all_packs[k];
 		snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
 			 get_object_directory(), sha1_to_hex(p->sha1));
-		unlink(name);
+		unlink_or_warn(name);
 	}
 }
 
@@ -981,7 +981,7 @@ static void end_packfile(void)
 	}
 	else {
 		close(old_p->pack_fd);
-		unlink(old_p->pack_name);
+		unlink_or_warn(old_p->pack_name);
 	}
 	free(old_p);
 
diff --git a/http-push.c b/http-push.c
index 5138224..29e8ebf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -315,9 +315,9 @@ static void start_fetch_loose(struct transfer_request *request)
 		 "%s.temp", filename);
 
 	snprintf(prevfile, sizeof(prevfile), "%s.prev", request->filename);
-	unlink(prevfile);
+	unlink_or_warn(prevfile);
 	rename(request->tmpfile, prevfile);
-	unlink(request->tmpfile);
+	unlink_or_warn(request->tmpfile);
 
 	if (request->local_fileno != -1)
 		error("fd leakage in start: %d", request->local_fileno);
@@ -372,7 +372,7 @@ static void start_fetch_loose(struct transfer_request *request)
 		} while (prev_read > 0);
 		close(prevlocal);
 	}
-	unlink(prevfile);
+	unlink_or_warn(prevfile);
 
 	/* Reset inflate/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
@@ -784,7 +784,7 @@ static void finish_request(struct transfer_request *request)
 		    request->http_code != 416) {
 			if (stat(request->tmpfile, &st) == 0) {
 				if (st.st_size == 0)
-					unlink(request->tmpfile);
+					unlink_or_warn(request->tmpfile);
 			}
 		} else {
 			if (request->http_code == 416)
@@ -793,9 +793,9 @@ static void finish_request(struct transfer_request *request)
 			git_inflate_end(&request->stream);
 			git_SHA1_Final(request->real_sha1, &request->c);
 			if (request->zret != Z_STREAM_END) {
-				unlink(request->tmpfile);
+				unlink_or_warn(request->tmpfile);
 			} else if (hashcmp(request->obj->sha1, request->real_sha1)) {
-				unlink(request->tmpfile);
+				unlink_or_warn(request->tmpfile);
 			} else {
 				request->rename =
 					move_temp_to_file(
diff --git a/http-walker.c b/http-walker.c
index c5a3ea3..7321ccc 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -111,9 +111,9 @@ static void start_object_request(struct walker *walker,
 	struct walker_data *data = walker->data;
 
 	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
-	unlink(prevfile);
+	unlink_or_warn(prevfile);
 	rename(obj_req->tmpfile, prevfile);
-	unlink(obj_req->tmpfile);
+	unlink_or_warn(obj_req->tmpfile);
 
 	if (obj_req->local != -1)
 		error("fd leakage in start: %d", obj_req->local);
@@ -177,7 +177,7 @@ static void start_object_request(struct walker *walker,
 		} while (prev_read > 0);
 		close(prevlocal);
 	}
-	unlink(prevfile);
+	unlink_or_warn(prevfile);
 
 	/* Reset inflate/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
@@ -238,18 +238,18 @@ static void finish_object_request(struct object_request *obj_req)
 	} else if (obj_req->curl_result != CURLE_OK) {
 		if (stat(obj_req->tmpfile, &st) == 0)
 			if (st.st_size == 0)
-				unlink(obj_req->tmpfile);
+				unlink_or_warn(obj_req->tmpfile);
 		return;
 	}
 
 	git_inflate_end(&obj_req->stream);
 	git_SHA1_Final(obj_req->real_sha1, &obj_req->c);
 	if (obj_req->zret != Z_STREAM_END) {
-		unlink(obj_req->tmpfile);
+		unlink_or_warn(obj_req->tmpfile);
 		return;
 	}
 	if (hashcmp(obj_req->sha1, obj_req->real_sha1)) {
-		unlink(obj_req->tmpfile);
+		unlink_or_warn(obj_req->tmpfile);
 		return;
 	}
 	obj_req->rename =
@@ -809,7 +809,7 @@ static void abort_object_request(struct object_request *obj_req)
 		close(obj_req->local);
 		obj_req->local = -1;
 	}
-	unlink(obj_req->tmpfile);
+	unlink_or_warn(obj_req->tmpfile);
 	if (obj_req->slot) {
 		release_active_slot(obj_req->slot);
 		obj_req->slot = NULL;
diff --git a/ll-merge.c b/ll-merge.c
index fa2ca52..81c02ad 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -219,7 +219,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	close(fd);
  bad:
 	for (i = 0; i < 3; i++)
-		unlink(temp[i]);
+		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
 	return status;
 }
diff --git a/lockfile.c b/lockfile.c
index 3dbb2d1..984eb32 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -16,7 +16,7 @@ static void remove_lock_file(void)
 		    lock_file_list->filename[0]) {
 			if (lock_file_list->fd >= 0)
 				close(lock_file_list->fd);
-			unlink(lock_file_list->filename);
+			unlink_or_warn(lock_file_list->filename);
 		}
 		lock_file_list = lock_file_list->next;
 	}
@@ -259,7 +259,7 @@ void rollback_lock_file(struct lock_file *lk)
 	if (lk->filename[0]) {
 		if (lk->fd >= 0)
 			close(lk->fd);
-		unlink(lk->filename);
+		unlink_or_warn(lk->filename);
 	}
 	lk->filename[0] = 0;
 }
diff --git a/pack-refs.c b/pack-refs.c
index 2c76fb1..301fc60 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -66,7 +66,7 @@ static void prune_ref(struct ref_to_prune *r)
 	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
 
 	if (lock) {
-		unlink(git_path("%s", r->name));
+		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
 	}
 }
diff --git a/refs.c b/refs.c
index e65a3b4..2b1f0f0 100644
--- a/refs.c
+++ b/refs.c
@@ -1002,12 +1002,10 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 		} else {
 			path = git_path("%s", refname);
 		}
-		err = unlink(path);
-		if (err && errno != ENOENT) {
+		err = unlink_or_warn(path);
+		if (err && errno != ENOENT)
 			ret = 1;
-			error("unlink(%s) failed: %s",
-			      path, strerror(errno));
-		}
+
 		if (!(delopt & REF_NODEREF))
 			lock->lk->filename[i] = '.';
 	}
@@ -1017,10 +1015,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	 */
 	ret |= repack_without_ref(refname);
 
-	err = unlink(git_path("logs/%s", lock->ref_name));
-	if (err && errno != ENOENT)
-		warning("unlink(%s) failed: %s",
-			git_path("logs/%s", lock->ref_name), strerror(errno));
+	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	invalidate_cached_refs();
 	unlock_ref(lock);
 	return ret;
@@ -1381,7 +1376,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	if (adjust_shared_perm(git_HEAD)) {
 		error("Unable to fix permissions on %s", lockpath);
 	error_unlink_return:
-		unlink(lockpath);
+		unlink_or_warn(lockpath);
 	error_free_return:
 		free(git_HEAD);
 		return -1;
diff --git a/rerere.c b/rerere.c
index 713c6e1..87360dc 100644
--- a/rerere.c
+++ b/rerere.c
@@ -173,7 +173,7 @@ static int handle_file(const char *path,
 		git_SHA1_Final(sha1, &ctx);
 	if (hunk != RR_CONTEXT) {
 		if (output)
-			unlink(output);
+			unlink_or_warn(output);
 		return error("Could not parse conflict hunks in %s", path);
 	}
 	if (wrerror)
diff --git a/server-info.c b/server-info.c
index 66b0d9d..d096dc7 100644
--- a/server-info.c
+++ b/server-info.c
@@ -246,7 +246,7 @@ int update_server_info(int force)
 	errs = errs | update_info_packs(force);
 
 	/* remove leftover rev-cache file if there is any */
-	unlink(git_path("info/rev-cache"));
+	unlink_or_warn(git_path("info/rev-cache"));
 
 	return errs;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 11969fc..5620b71 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2247,7 +2247,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 			goto out;
 		ret = errno;
 	}
-	unlink(tmpfile);
+	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
 			return error("unable to write sha1 filename %s: %s\n", filename, strerror(ret));
diff --git a/transport.c b/transport.c
index 3dfb03c..efecb65 100644
--- a/transport.c
+++ b/transport.c
@@ -1069,7 +1069,7 @@ int transport_fetch_refs(struct transport *transport, const struct ref *refs)
 void transport_unlock_pack(struct transport *transport)
 {
 	if (transport->pack_lockfile) {
-		unlink(transport->pack_lockfile);
+		unlink_or_warn(transport->pack_lockfile);
 		free(transport->pack_lockfile);
 		transport->pack_lockfile = NULL;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index e4eb8fa..aaacaf1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,7 +61,7 @@ static void unlink_entry(struct cache_entry *ce)
 {
 	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return;
-	if (unlink(ce->name))
+	if (unlink_or_warn(ce->name))
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
-- 
1.6.3.rc3.39.g49fd5
