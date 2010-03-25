From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/5] revert: refactor merge recursive code into its own
	function
Date: Thu, 25 Mar 2010 05:58:14 +0100
Message-ID: <20100325045818.14832.94770.chriscool@tuxfamily.org>
References: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufEU-0002Gs-1a
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab0CYFDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49324 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab0CYFDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:22 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B2C4481807C;
	Thu, 25 Mar 2010 06:03:14 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 79E86818052;
	Thu, 25 Mar 2010 06:03:11 +0100 (CET)
X-git-sha1: e1df944973e7044bb6d074ee92710b01c0d8ea2c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143158>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |  101 +++++++++++++++++++++++++++++------------------------
 1 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3cd62ae..054f442 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -271,17 +271,67 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 	return write_ref_sha1(ref_lock, to, "cherry-pick");
 }
 
+static void do_recursive_merge(struct commit *base, struct commit *next,
+			       unsigned char *head, char *oneline,
+			       struct strbuf *msgbuf, char *defmsg)
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
+	o.branch1 = "HEAD";
+	o.branch2 = oneline;
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
-	int i, index_fd, clean;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
 	char *defmsg = git_pathdup("MERGE_MSG");
-	struct merge_options o;
-	struct tree *result, *next_tree, *base_tree, *head_tree;
-	static struct lock_file index_lock;
 	struct strbuf msgbuf = STRBUF_INIT;
 
 	git_config(git_default_config, NULL);
@@ -382,8 +432,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	oneline = get_oneline(message);
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	if (action == REVERT) {
 		char *oneline_body = strchr(oneline, ' ');
 
@@ -411,46 +459,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	read_cache();
-	init_merge_options(&o);
-	o.branch1 = "HEAD";
-	o.branch2 = oneline;
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
+	do_recursive_merge(base, next, head, oneline, &msgbuf, defmsg);
 
 	/*
 	 *
-- 
1.7.0.2.398.g89bc8ce
