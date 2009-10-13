From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 03/16] fetch-pack: Use a strbuf to compose the want list
Date: Mon, 12 Oct 2009 19:25:02 -0700
Message-ID: <1255400715-10508-4-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXD8-0004cs-JU
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758822AbZJMCZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758811AbZJMCZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:25:57 -0400
Received: from george.spearce.org ([209.20.77.23]:35586 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZJMCZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:25:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 787D438260; Tue, 13 Oct 2009 02:25:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 17F9438200
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130108>

This change is being offered as a refactoring to make later
commits in the smart HTTP series easier.

By changing the enabled capabilities to be formatted in a strbuf
it is easier to add a new capability to the set of supported
capabilities.

By formatting the want portion of the request into a strbuf and
writing it as a whole block we can later decide to hold onto
the req_buf (instead of releasing it) to recycle in stateless
communications.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch-pack.c |   52 ++++++++++++++++++++++++++++++++-----------------
 commit.c             |   10 +++-----
 commit.h             |    2 +-
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..783c2b0 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -165,6 +165,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
+	struct strbuf req_buf = STRBUF_INIT;
 
 	if (marked)
 		for_each_ref(clear_marks, NULL);
@@ -175,6 +176,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
+		const char *remote_hex;
 		struct object *o;
 
 		/*
@@ -192,27 +194,36 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			continue;
 		}
 
-		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s%s\n",
-				     sha1_to_hex(remote),
-				     (multi_ack ? " multi_ack" : ""),
-				     (use_sideband == 2 ? " side-band-64k" : ""),
-				     (use_sideband == 1 ? " side-band" : ""),
-				     (args.use_thin_pack ? " thin-pack" : ""),
-				     (args.no_progress ? " no-progress" : ""),
-				     (args.include_tag ? " include-tag" : ""),
-				     (prefer_ofs_delta ? " ofs-delta" : ""));
-		else
-			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		remote_hex = sha1_to_hex(remote);
+		if (!fetching) {
+			struct strbuf c = STRBUF_INIT;
+			if (multi_ack)          strbuf_addstr(&c, " multi_ack");
+			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
+			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
+			if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
+			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
+			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
+			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
+			strbuf_release(&c);
+		} else
+			packet_buf_write(&req_buf, "want %s\n", remote_hex);
 		fetching++;
 	}
+
+	if (!fetching) {
+		strbuf_release(&req_buf);
+		packet_flush(fd[1]);
+		return 1;
+	}
+
 	if (is_repository_shallow())
-		write_shallow_commits(fd[1], 1);
+		write_shallow_commits(&req_buf, 1);
 	if (args.depth > 0)
-		packet_write(fd[1], "deepen %d", args.depth);
-	packet_flush(fd[1]);
-	if (!fetching)
-		return 1;
+		packet_buf_write(&req_buf, "deepen %d", args.depth);
+	packet_buf_flush(&req_buf);
+
+	safe_write(fd[1], req_buf.buf, req_buf.len);
 
 	if (args.depth > 0) {
 		char line[1024];
@@ -296,6 +307,8 @@ done:
 		multi_ack = 0;
 		flushes++;
 	}
+	strbuf_release(&req_buf);
+
 	while (flushes || multi_ack) {
 		int ack = get_ack(fd[0], result_sha1);
 		if (ack) {
@@ -809,6 +822,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 
 	if (args.depth > 0) {
 		struct cache_time mtime;
+		struct strbuf sb = STRBUF_INIT;
 		char *shallow = git_path("shallow");
 		int fd;
 
@@ -826,12 +840,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 
 		fd = hold_lock_file_for_update(&lock, shallow,
 					       LOCK_DIE_ON_ERROR);
-		if (!write_shallow_commits(fd, 0)) {
+		if (!write_shallow_commits(&sb, 0)
+		 || write_in_full(fd, sb.buf, sb.len) != sb.len) {
 			unlink_or_warn(shallow);
 			rollback_lock_file(&lock);
 		} else {
 			commit_lock_file(&lock);
 		}
+		strbuf_release(&sb);
 	}
 
 	reprepare_packed_git();
diff --git a/commit.c b/commit.c
index fedbd5e..471efb0 100644
--- a/commit.c
+++ b/commit.c
@@ -199,7 +199,7 @@ struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
 	return commit_graft[pos];
 }
 
-int write_shallow_commits(int fd, int use_pack_protocol)
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
 {
 	int i, count = 0;
 	for (i = 0; i < commit_graft_nr; i++)
@@ -208,12 +208,10 @@ int write_shallow_commits(int fd, int use_pack_protocol)
 				sha1_to_hex(commit_graft[i]->sha1);
 			count++;
 			if (use_pack_protocol)
-				packet_write(fd, "shallow %s", hex);
+				packet_buf_write(out, "shallow %s", hex);
 			else {
-				if (write_in_full(fd, hex,  40) != 40)
-					break;
-				if (write_str_in_full(fd, "\n") != 1)
-					break;
+				strbuf_addstr(out, hex);
+				strbuf_addch(out, '\n');
 			}
 		}
 	return count;
diff --git a/commit.h b/commit.h
index f4fc5c5..817c75c 100644
--- a/commit.h
+++ b/commit.h
@@ -131,7 +131,7 @@ extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-extern int write_shallow_commits(int fd, int use_pack_protocol);
+extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
-- 
1.6.5.52.g0ff2e
