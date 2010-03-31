From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] revert: use strbuf to refactor the code that writes the
	merge message
Date: Wed, 31 Mar 2010 21:22:04 +0200
Message-ID: <20100331192209.5827.46978.chriscool@tuxfamily.org>
References: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:46:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx6fh-0003M3-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab0CaWpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:45:35 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53000 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab0CaWpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:45:34 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 00762818073;
	Thu,  1 Apr 2010 00:45:26 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0248B81807F;
	Thu,  1 Apr 2010 00:45:23 +0200 (CEST)
X-git-sha1: fe0a89816e6cc4e6cc7ea154c0cdceb9cd915e8e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143703>

The code in this commit was written by Stephan Beyer for the sequencer
GSoC project:

    git://repo.or.cz/git/sbeyer.git

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   69 ++++++++++++++++++++++++++---------------------------
 1 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 778a56e..b8ee045 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -169,28 +169,17 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static struct lock_file msg_file;
-static int msg_fd;
-
-static void add_to_msg(const char *string)
-{
-	int len = strlen(string);
-	if (write_in_full(msg_fd, string, len) < 0)
-		die_errno ("Could not write to MERGE_MSG");
-}
-
-static void add_message_to_msg(const char *message)
+static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 {
 	const char *p = message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
 
 	if (!*p)
-		add_to_msg(sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
 
 	p += 2;
-	add_to_msg(p);
-	return;
+	strbuf_addstr(msgbuf, p);
 }
 
 static void set_author_ident_env(const char *message)
@@ -266,6 +255,19 @@ static char *help_msg(const char *name)
 	return strbuf_detach(&helpbuf, NULL);
 }
 
+static void write_message(struct strbuf *msgbuf, const char *filename)
+{
+	static struct lock_file msg_file;
+
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
+					       LOCK_DIE_ON_ERROR);
+	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
+		die_errno("Could not write to %s.", filename);
+	strbuf_release(msgbuf);
+	if (commit_lock_file(&msg_file) < 0)
+		die("Error wrapping up %s", filename);
+}
+
 static struct tree *empty_tree(void)
 {
 	struct tree *tree = xcalloc(1, sizeof(struct tree));
@@ -311,6 +313,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	static struct lock_file index_lock;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -398,8 +401,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 */
 
 	defmsg = git_pathdup("MERGE_MSG");
-	msg_fd = hold_lock_file_for_update(&msg_file, defmsg,
-					   LOCK_DIE_ON_ERROR);
 
 	index_fd = hold_locked_index(&index_lock, 1);
 
@@ -408,27 +409,27 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		add_to_msg("Revert \"");
-		add_to_msg(msg.subject);
-		add_to_msg("\"\n\nThis reverts commit ");
-		add_to_msg(sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(&msgbuf, "Revert \"");
+		strbuf_addstr(&msgbuf, msg.subject);
+		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
+		strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 
 		if (commit->parents->next) {
-			add_to_msg(", reversing\nchanges made to ");
-			add_to_msg(sha1_to_hex(parent->object.sha1));
+			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
+			strbuf_addstr(&msgbuf, sha1_to_hex(parent->object.sha1));
 		}
-		add_to_msg(".\n");
+		strbuf_addstr(&msgbuf, ".\n");
 	} else {
 		base = parent;
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
 		set_author_ident_env(msg.message);
-		add_message_to_msg(msg.message);
+		add_message_to_msg(&msgbuf, msg.message);
 		if (no_replay) {
-			add_to_msg("(cherry picked from commit ");
-			add_to_msg(sha1_to_hex(commit->object.sha1));
-			add_to_msg(")\n");
+			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+			strbuf_addstr(&msgbuf, ")\n");
 		}
 	}
 
@@ -453,27 +454,25 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
-		add_to_msg("\nConflicts:\n\n");
+		strbuf_addstr(&msgbuf, "\nConflicts:\n\n");
 		for (i = 0; i < active_nr;) {
 			struct cache_entry *ce = active_cache[i++];
 			if (ce_stage(ce)) {
-				add_to_msg("\t");
-				add_to_msg(ce->name);
-				add_to_msg("\n");
+				strbuf_addch(&msgbuf, '\t');
+				strbuf_addstr(&msgbuf, ce->name);
+				strbuf_addch(&msgbuf, '\n');
 				while (i < active_nr && !strcmp(ce->name,
 						active_cache[i]->name))
 					i++;
 			}
 		}
-		if (commit_lock_file(&msg_file) < 0)
-			die ("Error wrapping up %s", defmsg);
+		write_message(&msgbuf, defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit_name));
 		rerere(allow_rerere_auto);
 		exit(1);
 	}
-	if (commit_lock_file(&msg_file) < 0)
-		die ("Error wrapping up %s", defmsg);
+	write_message(&msgbuf, defmsg);
 	fprintf(stderr, "Finished one %s.\n", me);
 
 	/*
-- 
1.7.0.3.454.gd9aeb
