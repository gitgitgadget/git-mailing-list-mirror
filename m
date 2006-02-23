From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Give no terminating LF to error() function.
Date: Wed, 22 Feb 2006 17:48:16 -0800
Message-ID: <7v64n6luan.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
	<87bqwzs07h.wl%cworth@cworth.org>
	<7vr75vmcod.fsf@assigned-by-dhcp.cox.net>
	<20060223003400.GA27800@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 02:48:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC5ah-0006Ie-5i
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 02:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWBWBsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWBWBsU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 20:48:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27529 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750922AbWBWBsT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 20:48:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223014705.QZEJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 20:47:05 -0500
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060223003400.GA27800@diku.dk> (Jonas Fonseca's message of
	"Thu, 23 Feb 2006 01:34:00 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16629>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Jonas Fonseca <fonseca@diku.dk> writes:

  > Junio C Hamano <junkio@cox.net> wrote Wed, Feb 22, 2006:
  >> +			error("unable to open object pack directory: %s: %s\n",
  >> +			      path, strerror(errno));
  >
  > No need for the ending \n.

  True.

 commit.c       |    3 ++-
 http-fetch.c   |    8 ++++----
 read-tree.c    |    4 ++--
 receive-pack.c |    4 ++--
 refs.c         |    2 +-
 sha1_file.c    |    7 ++++---
 6 files changed, 15 insertions(+), 13 deletions(-)

8cd486dcab93856c7eafe33338a3df85b79e4a3e
diff --git a/commit.c b/commit.c
index c550a00..06d5439 100644
--- a/commit.c
+++ b/commit.c
@@ -212,7 +212,8 @@ int parse_commit_buffer(struct commit *i
 	if (memcmp(bufptr, "tree ", 5))
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
 	if (get_sha1_hex(bufptr + 5, parent) < 0)
-		return error("bad tree pointer in commit %s\n", sha1_to_hex(item->object.sha1));
+		return error("bad tree pointer in commit %s",
+			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
 	if (item->tree)
 		n_refs++;
diff --git a/http-fetch.c b/http-fetch.c
index ce3df5f..8fd9de0 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -130,7 +130,7 @@ static void start_object_request(struct 
 
 	if (obj_req->local < 0) {
 		obj_req->state = ABORTED;
-		error("Couldn't create temporary file %s for %s: %s\n",
+		error("Couldn't create temporary file %s for %s: %s",
 		      obj_req->tmpfile, obj_req->filename, strerror(errno));
 		return;
 	}
@@ -830,9 +830,9 @@ static int fetch_object(struct alt_base 
 				    obj_req->errorstr, obj_req->curl_result,
 				    obj_req->http_code, hex);
 	} else if (obj_req->zret != Z_STREAM_END) {
-		ret = error("File %s (%s) corrupt\n", hex, obj_req->url);
+		ret = error("File %s (%s) corrupt", hex, obj_req->url);
 	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
-		ret = error("File %s has bad hash\n", hex);
+		ret = error("File %s has bad hash", hex);
 	} else if (obj_req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
 			    obj_req->filename);
@@ -854,7 +854,7 @@ int fetch(unsigned char *sha1)
 		fetch_alternates(alt->base);
 		altbase = altbase->next;
 	}
-	return error("Unable to find %s under %s\n", sha1_to_hex(sha1),
+	return error("Unable to find %s under %s", sha1_to_hex(sha1),
 		     alt->base);
 }
 
diff --git a/read-tree.c b/read-tree.c
index 52f06e3..8be307e 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -564,7 +564,7 @@ static int twoway_merge(struct cache_ent
 	struct cache_entry *oldtree = src[1], *newtree = src[2];
 
 	if (merge_size != 2)
-		return error("Cannot do a twoway merge of %d trees\n",
+		return error("Cannot do a twoway merge of %d trees",
 			     merge_size);
 
 	if (current) {
@@ -616,7 +616,7 @@ static int oneway_merge(struct cache_ent
 	struct cache_entry *a = src[1];
 
 	if (merge_size != 1)
-		return error("Cannot do a oneway merge of %d trees\n",
+		return error("Cannot do a oneway merge of %d trees",
 			     merge_size);
 
 	if (!a)
diff --git a/receive-pack.c b/receive-pack.c
index eae31e3..2a3db16 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -92,7 +92,7 @@ static int run_update_hook(const char *r
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
 		return error("waitpid is confused");
 	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		return error("%s died of signal\n", update_hook);
+		return error("%s died of signal", update_hook);
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 		return error("%s died strangely", update_hook);
 	default:
@@ -158,7 +158,7 @@ static int update(struct command *cmd)
 	if (run_update_hook(name, old_hex, new_hex)) {
 		unlink(lock_name);
 		cmd->error_string = "hook declined";
-		return error("hook declined to update %s\n", name);
+		return error("hook declined to update %s", name);
 	}
 	else if (rename(lock_name, name) < 0) {
 		unlink(lock_name);
diff --git a/refs.c b/refs.c
index d01fc39..826ae7a 100644
--- a/refs.c
+++ b/refs.c
@@ -268,7 +268,7 @@ static int write_ref_file(const char *fi
 	char term = '\n';
 	if (write(fd, hex, 40) < 40 ||
 	    write(fd, &term, 1) < 1) {
-		error("Couldn't write %s\n", filename);
+		error("Couldn't write %s", filename);
 		close(fd);
 		return -1;
 	}
diff --git a/sha1_file.c b/sha1_file.c
index 1fd5b79..a80d849 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -564,7 +564,7 @@ static void prepare_packed_git_one(char 
 	dir = opendir(path);
 	if (!dir) {
 		if (errno != ENOENT)
-			error("unable to open object pack directory: %s: %s\n",
+			error("unable to open object pack directory: %s: %s",
 			      path, strerror(errno));
 		return;
 	}
@@ -1513,7 +1513,8 @@ int write_sha1_from_fd(const unsigned ch
 
 	local = mkstemp(tmpfile);
 	if (local < 0)
-		return error("Couldn't open %s for %s\n", tmpfile, sha1_to_hex(sha1));
+		return error("Couldn't open %s for %s",
+			     tmpfile, sha1_to_hex(sha1));
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -1561,7 +1562,7 @@ int write_sha1_from_fd(const unsigned ch
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
 		unlink(tmpfile);
-		return error("File %s has bad hash\n", sha1_to_hex(sha1));
+		return error("File %s has bad hash", sha1_to_hex(sha1));
 	}
 
 	return move_temp_to_file(tmpfile, sha1_file_name(sha1));
-- 
1.2.3.g5978
