From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] revert: refactor merge recursive code into its own
	function
Date: Wed, 31 Mar 2010 21:22:05 +0200
Message-ID: <20100331192209.5827.98522.chriscool@tuxfamily.org>
References: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:45:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx6fO-0003AX-Nw
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab0CaWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:45:36 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53005 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757110Ab0CaWpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:45:34 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 56615818078;
	Thu,  1 Apr 2010 00:45:26 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4DCD1818076;
	Thu,  1 Apr 2010 00:45:24 +0200 (CEST)
X-git-sha1: aea86b8cc96acae4605fa4d563c34352436d465d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143701>

The code that is used to do a recursive merge is extracted from
the revert_or_cherry_pick() function and put into a new
do_recursive_merge() function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |  105 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b8ee045..8219ee2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -302,17 +302,69 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 	return write_ref_sha1(ref_lock, to, "cherry-pick");
 }
 
+static void do_recursive_merge(struct commit *base, struct commit *next,
+			       const char *base_label, const char *next_label,
+			       unsigned char *head, struct strbuf *msgbuf,
+			       char *defmsg)
+{
+	struct merge_options o;
+	struct tree *result, *next_tree, *base_tree, *head_tree;
+	int clean, index_fd;
+	static struct lock_file index_lock;
+
+	index_fd = hold_locked_index(&index_lock, 1);
+
+	read_cache();
+	init_merge_options(&o);
+	o.ancestor = base ? base_label : "(empty tree)";
+	o.branch1 = "HEAD";
+	o.branch2 = next ? next_label : "(empty tree)";
+
+	head_tree = parse_tree_indirect(head);
+	next_tree = next ? next->tree : empty_tree();
+	base_tree = base ? base->tree : empty_tree();
+
+	clean = merge_trees(&o,
+			    head_tree,
+			    next_tree, base_tree, &result);
+
+	if (active_cache_changed &&
+	    (write_cache(index_fd, active_cache, active_nr) ||
+	     commit_locked_index(&index_lock)))
+		die("%s: Unable to write new index file", me);
+	rollback_lock_file(&index_lock);
+
+	if (!clean) {
+		int i;
+		strbuf_addstr(msgbuf, "\nConflicts:\n\n");
+		for (i = 0; i < active_nr;) {
+			struct cache_entry *ce = active_cache[i++];
+			if (ce_stage(ce)) {
+				strbuf_addch(msgbuf, '\t');
+				strbuf_addstr(msgbuf, ce->name);
+				strbuf_addch(msgbuf, '\n');
+				while (i < active_nr && !strcmp(ce->name,
+						active_cache[i]->name))
+					i++;
+			}
+		}
+		write_message(msgbuf, defmsg);
+		fprintf(stderr, "Automatic %s failed.%s\n",
+			me, help_msg(commit_name));
+		rerere(allow_rerere_auto);
+		exit(1);
+	}
+	write_message(msgbuf, defmsg);
+	fprintf(stderr, "Finished one %s.\n", me);
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
-	int i, index_fd, clean;
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
-	struct merge_options o;
-	struct tree *result, *next_tree, *base_tree, *head_tree;
-	static struct lock_file index_lock;
 	struct strbuf msgbuf = STRBUF_INIT;
 
 	git_config(git_default_config, NULL);
@@ -402,8 +454,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	if (action == REVERT) {
 		base = commit;
 		base_label = msg.label;
@@ -433,47 +483,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	read_cache();
-	init_merge_options(&o);
-	o.ancestor = base ? base_label : "(empty tree)";
-	o.branch1 = "HEAD";
-	o.branch2 = next ? next_label : "(empty tree)";
-
-	head_tree = parse_tree_indirect(head);
-	next_tree = next ? next->tree : empty_tree();
-	base_tree = base ? base->tree : empty_tree();
-
-	clean = merge_trees(&o,
-			    head_tree,
-			    next_tree, base_tree, &result);
-
-	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(&index_lock)))
-		die("%s: Unable to write new index file", me);
-	rollback_lock_file(&index_lock);
-
-	if (!clean) {
-		strbuf_addstr(&msgbuf, "\nConflicts:\n\n");
-		for (i = 0; i < active_nr;) {
-			struct cache_entry *ce = active_cache[i++];
-			if (ce_stage(ce)) {
-				strbuf_addch(&msgbuf, '\t');
-				strbuf_addstr(&msgbuf, ce->name);
-				strbuf_addch(&msgbuf, '\n');
-				while (i < active_nr && !strcmp(ce->name,
-						active_cache[i]->name))
-					i++;
-			}
-		}
-		write_message(&msgbuf, defmsg);
-		fprintf(stderr, "Automatic %s failed.%s\n",
-			me, help_msg(commit_name));
-		rerere(allow_rerere_auto);
-		exit(1);
-	}
-	write_message(&msgbuf, defmsg);
-	fprintf(stderr, "Finished one %s.\n", me);
+	do_recursive_merge(base, next, base_label, next_label,
+			   head, &msgbuf, defmsg);
 
 	/*
 	 *
-- 
1.7.0.3.454.gd9aeb
