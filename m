X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] allow deepening of a shallow repository
Date: Mon, 30 Oct 2006 20:09:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:19:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30509>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecWi-0006Cp-Ew for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161433AbWJ3TKK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbWJ3TKK
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:10:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:902 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161467AbWJ3TKH (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:10:07 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:10:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 30 Oct 2006 20:10:00 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Now, by saying "git fetch -depth <n> <repo>" you can deepen
a shallow repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c      |   13 +++++++++++++
 commit.h      |    3 ++-
 fetch-pack.c  |   22 ++++++++++++++++------
 git-fetch.sh  |   12 +++++++++++-
 shallow.c     |    8 ++++++--
 upload-pack.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 6 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/commit.c b/commit.c
index bffa278..d5103cd 100644
--- a/commit.c
+++ b/commit.c
@@ -255,6 +255,19 @@ int write_shallow_commits(int fd, int us
 	return count;
 }
 
+int unregister_shallow(const unsigned char *sha1)
+{
+	int pos = commit_graft_pos(sha1);
+	if (pos < 0)
+		return -1;
+	if (pos + 1 < commit_graft_nr)
+		memcpy(commit_graft + pos, commit_graft + pos + 1,
+				sizeof(struct commit_graft *)
+				* (commit_graft_nr - pos - 1));
+	commit_graft_nr--;
+	return 0;
+}
+
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 {
 	char *tail = buffer;
diff --git a/commit.h b/commit.h
index c559510..e9e158f 100644
--- a/commit.h
+++ b/commit.h
@@ -108,9 +108,10 @@ int read_graft_file(const char *graft_fi
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
 extern int register_shallow(const unsigned char *sha1);
+extern int unregister_shallow(const unsigned char *sha1);
 extern int write_shallow_commits(int fd, int use_pack_protocol);
 extern int is_repository_shallow();
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
-		int depth);
+		int depth, int shallow_flag, int not_shallow_flag);
 
 #endif /* COMMIT_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index 9619d6e..a82a5ba 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -199,7 +199,17 @@ static int find_common(int fd[2], unsign
 				if (lookup_object(sha1))
 					continue;
 				register_shallow(sha1);
-			}
+			}  else if (!strncmp("unshallow ", line, 10)) {
+				if (get_sha1_hex(line + 10, sha1))
+					die("invalid unshallow line: %s", line);
+				if (!lookup_object(sha1))
+					die("object not found: %s", line);
+				/* make sure that it is parsed as shallow */
+				parse_object(sha1);
+				if (unregister_shallow(sha1))
+					die("no shallow found: %s", line);
+			} else
+				die("expected shallow/unshallow, got %s", line);
 		}
 	}
 
@@ -388,9 +398,11 @@ static int everything_local(struct ref *
 		}
 	}
 
-	for_each_ref(mark_complete, NULL);
-	if (cutoff)
-		mark_recent_complete_commits(cutoff);
+	if (!depth) {
+		for_each_ref(mark_complete, NULL);
+		if (cutoff)
+			mark_recent_complete_commits(cutoff);
+	}
 
 	/*
 	 * Mark all complete remote refs as common refs.
@@ -550,8 +562,6 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	if (is_repository_shallow() && depth > 0)
-		die("Deepening of a shallow repository not yet supported!");
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
diff --git a/git-fetch.sh b/git-fetch.sh
index 539dff6..2a4b7a0 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -21,6 +21,7 @@ update_head_ok=
 exec=
 upload_pack=
 keep=--thin
+depth=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -56,6 +57,13 @@ do
 	--reflog-action=*)
 		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
 		;;
+	--depth=*)
+		depth="--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`"
+		;;
+	--depth)
+		shift
+		depth="--depth=$1"
+		;;
 	-*)
 		usage
 		;;
@@ -296,6 +304,7 @@ fetch_main () {
       # There are transports that can fetch only one head at a time...
       case "$remote" in
       http://* | https://* | ftp://*)
+	  test -n "$depth" && die "shallow clone with http not supported"
 	  proto=`expr "$remote" : '\([^:]*\):'`
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
@@ -324,6 +333,7 @@ fetch_main () {
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
       rsync://*)
+	  test -n "$depth" && die "shallow clone with rsync not supported"
 	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
 	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
 	  head=$(git-rev-parse --verify TMP_HEAD)
@@ -370,7 +380,7 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
+	  git-fetch-pack $exec $keep $depth "$remote" $rref || echo failed "$remote"
       ) |
       while read sha1 remote_name
       do
diff --git a/shallow.c b/shallow.c
index 3cf2127..58a7b20 100644
--- a/shallow.c
+++ b/shallow.c
@@ -41,7 +41,8 @@ int is_repository_shallow()
 	return is_shallow;
 }
 
-struct commit_list *get_shallow_commits(struct object_array *heads, int depth)
+struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
+		int shallow_flag, int not_shallow_flag)
 {
 	int i = 0, cur_depth = 0;
 	struct commit_list *result = NULL;
@@ -67,6 +68,7 @@ struct commit_list *get_shallow_commits(
 			}
 		}
 		parse_commit(commit);
+		commit->object.flags |= not_shallow_flag;
 		cur_depth++;
 		for (p = commit->parents, commit = NULL; p; p = p->next) {
 			if (!p->item->util) {
@@ -87,8 +89,10 @@ struct commit_list *get_shallow_commits(
 					commit = p->item;
 					cur_depth = *(int *)commit->util;
 				}
-			} else
+			} else {
 				commit_list_insert(p->item, &result);
+				p->item->object.flags |= shallow_flag;
+			}
 		}
 	}
 
diff --git a/upload-pack.c b/upload-pack.c
index ebe1e5a..162dd34 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -134,6 +134,7 @@ static void create_pack_file(void)
 		} else {
 			for (i = 0; i < want_obj.nr; i++) {
 				struct object *o = want_obj.objects[i].item;
+				o->flags &= ~UNINTERESTING;
 				add_pending_object(&revs, o, NULL);
 			}
 			for (i = 0; i < have_obj.nr; i++) {
@@ -490,6 +491,9 @@ static void receive_needs(void)
 	static char line[1000];
 	int len, depth = 0;
 
+#define SHALLOW (1u<<8)
+#define NOT_SHALLOW (1u<<9)
+#define CLIENT_SHALLOW (1u<<10)
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
@@ -501,16 +505,19 @@ static void receive_needs(void)
 		if (!strncmp("shallow ", line, 8)) {
 			unsigned char sha1[20];
 			struct object *object;
+			use_thin_pack = 0;
 			if (get_sha1(line + 8, sha1))
 				die("invalid shallow line: %s", line);
 			object = parse_object(sha1);
 			if (!object)
 				die("did not find object for %s", line);
+			object->flags |= CLIENT_SHALLOW;
 			add_object_array(object, NULL, &shallows);
 			continue;
 		}
 		if (!strncmp("deepen ", line, 7)) {
 			char *end;
+			use_thin_pack = 0;
 			depth = strtol(line + 7, &end, 0);
 			if (end == line + 7 || depth <= 0)
 				die("Invalid deepen: %s", line);
@@ -547,23 +554,51 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (depth == 0 && shallows.nr == 0)
+		return;
 	if (depth > 0) {
 		struct commit_list *result, *backup;
-		if (shallows.nr > 0)
-			die("Deepening a shallow repository not yet supported");
-		backup = result = get_shallow_commits(&want_obj, depth);
+		int i;
+		backup = result = get_shallow_commits(&want_obj, depth,
+			SHALLOW, NOT_SHALLOW);
 		while (result) {
-			packet_write(1, "shallow %s",
-					sha1_to_hex(result->item->object.sha1));
+			struct object *object = &result->item->object;
+			if (!(object->flags & CLIENT_SHALLOW)) {
+				packet_write(1, "shallow %s",
+						sha1_to_hex(object->sha1));
+				register_shallow(object->sha1);
+			}
 			result = result->next;
 		}
 		free_commit_list(backup);
-	}
-	if (shallows.nr > 0) {
-		int i;
-		for (i = 0; i < shallows.nr; i++)
-			register_shallow(shallows.objects[i].item->sha1);
-	}
+		for (i = 0; i < shallows.nr; i++) {
+			struct object *object = shallows.objects[i].item;
+			if (object->flags & NOT_SHALLOW) {
+				struct commit_list *parents;
+				packet_write(1, "unshallow %s",
+					sha1_to_hex(object->sha1));
+				object->flags &= ~CLIENT_SHALLOW;
+				/* make sure the real parents are parsed */
+				unregister_shallow(object->sha1);
+				parse_commit((struct commit *)object);
+				parents = ((struct commit *)object)->parents;
+				while (parents) {
+					add_object_array(&parents->item->object,
+							NULL, &want_obj);
+					parents = parents->next;
+				}
+			}
+			/* make sure commit traversal conforms to client */
+			register_shallow(object->sha1);
+		}
+		packet_flush(1);
+	} else
+		if (shallows.nr > 0) {
+			int i;
+			for (i = 0; i < shallows.nr; i++)
+				register_shallow(shallows.objects[i].item->sha1);
+		}
+	free(shallows.objects);
 }
 
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-- 
1.4.3.3.gca42
