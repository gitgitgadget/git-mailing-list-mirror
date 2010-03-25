From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/5] revert: use strbuf to refactor the code that writes
	the merge message
Date: Thu, 25 Mar 2010 05:58:13 +0100
Message-ID: <20100325045818.14832.29691.chriscool@tuxfamily.org>
References: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufE8-0002BG-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab0CYFDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49317 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab0CYFDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:22 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2FEB6818079;
	Thu, 25 Mar 2010 06:03:13 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2A5C4818002;
	Thu, 25 Mar 2010 06:03:11 +0100 (CET)
X-git-sha1: 71595a3f6ccbb8563b5c6fff97b49cdd8ebfdfd9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143153>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   70 ++++++++++++++++++++++++++---------------------------
 1 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0651e34..3cd62ae 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -138,28 +138,17 @@ static char *get_encoding(const char *message)
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
@@ -235,6 +224,19 @@ static char *help_msg(const char *name)
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
@@ -280,6 +282,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	static struct lock_file index_lock;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
@@ -368,9 +371,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 * reverse of it if we are revert.
 	 */
 
-	msg_fd = hold_lock_file_for_update(&msg_file, defmsg,
-					   LOCK_DIE_ON_ERROR);
-
 	encoding = get_encoding(message);
 	if (!encoding)
 		encoding = "UTF-8";
@@ -389,25 +389,25 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 		base = commit;
 		next = parent;
-		add_to_msg("Revert \"");
-		add_to_msg(oneline_body + 1);
-		add_to_msg("\"\n\nThis reverts commit ");
-		add_to_msg(sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(&msgbuf, "Revert \"");
+		strbuf_addstr(&msgbuf, oneline_body + 1);
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
 		next = commit;
 		set_author_ident_env(message);
-		add_message_to_msg(message);
+		add_message_to_msg(&msgbuf, message);
 		if (no_replay) {
-			add_to_msg("(cherry picked from commit ");
-			add_to_msg(sha1_to_hex(commit->object.sha1));
-			add_to_msg(")\n");
+			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+			strbuf_addstr(&msgbuf, ")\n");
 		}
 	}
 
@@ -431,27 +431,25 @@ static int revert_or_cherry_pick(int argc, const char **argv)
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
1.7.0.2.398.g89bc8ce
