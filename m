From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11,13,14 v2] revert: clarify label on conflict hunks
Date: Wed, 17 Mar 2010 22:33:17 -0500
Message-ID: <20100318033316.GB18193@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
 <20100317121546.GK25641@progeny.tock>
 <780e0a6b1003171309k75b33d3cpb4b1c6370d67942f@mail.gmail.com>
 <20100318031638.GA18193@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 04:32:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns6Te-00028N-59
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 04:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0CRDct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 23:32:49 -0400
Received: from mail-yw0-f201.google.com ([209.85.211.201]:59589 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0CRDcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 23:32:48 -0400
Received: by ywh39 with SMTP id 39so786626ywh.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZbV77pchxREyA78Apk93IUPRP31owSeNRCWWpyIv42U=;
        b=J8GVP3vAU0lqJcnDVndtE8eUnYdgDCMH9QRvRVi4l5qJ+NgIBfnbdv6OIzRsv/OPVr
         P3Kyf16S/k4eelp1PKYP2dNpkABPh33MFAv0Q8v3wAOzf4j+zfkvuxSerjQGcW+iI/bm
         uVbHivki17IDq1EIN0TTj9ZlfPCLlgjX/9wNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MaxsJpnX9Kzr7kiDH8z1mu1I+5Sspg1zX8Oizft8g5+Tilhmn/d+iJK1mMdaWfRJBZ
         T3bTFZBHsrmfjD3tSE/a+QQlGcQQ6Iyx4+w+Nmg4Nrf75iHM3yS0IXh8hsJXe4cCYvRy
         Jt/OMVxNDEsbqhjIn1p74nvvWqJJVvNHtDZYo=
Received: by 10.90.219.6 with SMTP id r6mr1619649agg.55.1268883167045;
        Wed, 17 Mar 2010 20:32:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm7128367iwn.9.2010.03.17.20.32.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 20:32:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100318031638.GA18193@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142448>

When reverting a commit, the commit being merged is not the commit
to revert itself but its parent.  Clarify the text in conflict
hunks to explain this.

Example:

	<<<<<<< HEAD
	Something old.
	Something new.
	Something blue.
	=======
	Something old.
	Something rotten.
	Something blue.
	>>>>>>> parent of ac789a9... Remove rotten line

Also free a temporary buffer that was not freed before.  This is not
important because it is a small one-time allocation.  It would become a
memory leak if unnoticed when libifying cherry-pick.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This rearranges the code a little to make it easier to read and
manipulate.

 builtin/revert.c                |  100 ++++++++++++++++++++++++---------------
 t/t3507-cherry-pick-conflict.sh |    4 +-
 2 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..b314629 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -45,6 +45,8 @@ static const char *me;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+static char *get_encoding(const char *message);
+
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
@@ -73,33 +75,63 @@ static void parse_args(int argc, const char **argv)
 		exit(1);
 }
 
-static char *get_oneline(const char *message)
+struct commit_message {
+	char *parent_label;
+	const char *label;
+	const char *subject;
+	char *reencoded_message;
+	const char *message;
+};
+
+static int get_message(const char *raw_message, struct commit_message *out)
 {
-	char *result;
-	const char *p = message, *abbrev, *eol;
+	const char *encoding;
+	const char *p, *abbrev, *eol;
+	char *q;
 	int abbrev_len, oneline_len;
 
-	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
+	if (!raw_message)
+		return -1;
+	encoding = get_encoding(raw_message);
+	if (!encoding)
+		encoding = "UTF-8";
+	if (!git_commit_encoding)
+		git_commit_encoding = "UTF-8";
+	if ((out->reencoded_message = reencode_string(raw_message,
+					git_commit_encoding, encoding)))
+		out->message = out->reencoded_message;
+
+	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev_len = strlen(abbrev);
+
+	/* Find beginning and end of commit subject. */
+	p = out->message;
 	while (*p && (*p != '\n' || p[1] != '\n'))
 		p++;
-
 	if (*p) {
 		p += 2;
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
 		eol = p;
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	abbrev_len = strlen(abbrev);
 	oneline_len = eol - p;
-	result = xmalloc(abbrev_len + 5 + oneline_len);
-	memcpy(result, abbrev, abbrev_len);
-	memcpy(result + abbrev_len, "... ", 4);
-	memcpy(result + abbrev_len + 4, p, oneline_len);
-	result[abbrev_len + 4 + oneline_len] = '\0';
-	return result;
+
+	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
+			      strlen("... ") + oneline_len + 1);
+	q = out->parent_label;
+	q = mempcpy(q, "parent of ", strlen("parent of "));
+	out->label = q;
+	q = mempcpy(q, abbrev, abbrev_len);
+	q = mempcpy(q, "... ", strlen("... "));
+	out->subject = q;
+	q = mempcpy(q, p, oneline_len);
+	*q = '\0';
+	return 0;
+}
+
+static void free_message(struct commit_message *msg) {
+	free(msg->parent_label);
+	free(msg->reencoded_message);
 }
 
 static char *get_encoding(const char *message)
@@ -248,9 +280,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
+	const char *next_label;
 	int i, index_fd, clean;
-	char *oneline, *reencoded_message = NULL;
-	const char *message, *encoding;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+
 	char *defmsg = git_pathdup("MERGE_MSG");
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
@@ -314,14 +347,14 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	else
 		parent = commit->parents->item;
 
-	if (!(message = commit->buffer))
-		die ("Cannot get commit message for %s",
-				sha1_to_hex(commit->object.sha1));
-
 	if (parent && parse_commit(parent) < 0)
 		die("%s: cannot parse parent commit %s",
 		    me, sha1_to_hex(parent->object.sha1));
 
+	if (get_message(commit->buffer, &msg) != 0)
+		die ("Cannot get commit message for %s",
+				sha1_to_hex(commit->object.sha1));
+
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -332,24 +365,12 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	msg_fd = hold_lock_file_for_update(&msg_file, defmsg,
 					   LOCK_DIE_ON_ERROR);
 
-	encoding = get_encoding(message);
-	if (!encoding)
-		encoding = "UTF-8";
-	if (!git_commit_encoding)
-		git_commit_encoding = "UTF-8";
-	if ((reencoded_message = reencode_string(message,
-					git_commit_encoding, encoding)))
-		message = reencoded_message;
-
-	oneline = get_oneline(message);
-
 	if (action == REVERT) {
-		char *oneline_body = strchr(oneline, ' ');
-
 		base = commit;
 		next = parent;
+		next_label = msg.parent_label;
 		add_to_msg("Revert \"");
-		add_to_msg(oneline_body + 1);
+		add_to_msg(msg.subject);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
 
@@ -361,8 +382,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	} else {
 		base = parent;
 		next = commit;
-		set_author_ident_env(message);
-		add_message_to_msg(message);
+		next_label = msg.label;
+		set_author_ident_env(msg.message);
+		add_message_to_msg(msg.message);
 		if (no_replay) {
 			add_to_msg("(cherry picked from commit ");
 			add_to_msg(sha1_to_hex(commit->object.sha1));
@@ -373,7 +395,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	read_cache();
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
-	o.branch2 = oneline;
+	o.branch2 = next ? next_label : "(empty tree)";
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
@@ -437,7 +459,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		args[i] = NULL;
 		return execv_git_cmd(args);
 	}
-	free(reencoded_message);
+	free_message(&msg);
 	free(defmsg);
 
 	return 0;
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index e856356..6a20817 100644
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -138,7 +138,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 	a
 	=======
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
 	{
 		git checkout picked -- foo &&
@@ -183,7 +183,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	c
 	=======
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
 
 	git update-index --refresh &&
-- 
1.7.0
