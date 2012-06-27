From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 3/3] fast-import: disallow "merge $itself" command
Date: Wed, 27 Jun 2012 23:40:25 +0600
Message-ID: <1340818825-13754-4-git-send-email-divanorama@gmail.com>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 19:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjwDd-0000ud-SC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 19:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab2F0Rjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 13:39:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62882 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339Ab2F0Rjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 13:39:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so1242963bkc.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=anF9FPoorN5iv26xUwQWafQ19DaL+2ZwXCwzPNyAPlg=;
        b=0S6tYpJi7+hWZxlXviOhkRhOXyezTu30V/Iel5xcU5M+pgVd3ucIJZLlRDYmOdl0nP
         YzHeZFYKmDMWTSqWPYE4h4wEr5nkzFpTw0LXaRDJWVSxz5aEZxZKLoM2/OfWDJlq2Yh8
         LtdGyese8Jmx2j0UcuQT9JkLr9y+aWoJ5+lWgq1ABpYCW35ZrHKa8Uk4b7yQuvljs7+A
         q8/gt6ATJJqXC5pjIHbr/Mgi5KA4dbnNFAEspQH0F151J1ZrOh5cFausvdjWdo23qnLP
         RJC+C2U2v0IvkD+u/9NjILZzvYo6gRTg/Jq1kPfQ3hjjta0BrnHHapgWN6orrcbcR5xp
         zJyw==
Received: by 10.152.132.40 with SMTP id or8mr21542994lab.24.1340818792036;
        Wed, 27 Jun 2012 10:39:52 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id pp2sm84780930lab.3.2012.06.27.10.39.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:39:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200732>

"merge $itself" may be used to create commits with previous branch tip
being repeated as n-th parent or even moved from being 1-st to be just
n-th. This is not a documented use case and doesn't look like a common
one.

In presence of "from $some" command "merge $itself" acts the same as
"merge $some" would. Which is completely undocumented and looks like
a bug (caused by parse_from() temporarily rewriting b->sha1 with $some).

Just deny "merge $itself" for now. It was a bit broken and btw "from
$itself" was and is a forbidden command too.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   12 +++++++++---
 t/t9300-fast-import.sh |   13 +++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f03da1e..781c614 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2611,7 +2611,7 @@ static int parse_from(struct branch *b)
 	return 1;
 }
 
-static struct hash_list *parse_merge(unsigned int *count)
+static struct hash_list *parse_merge(unsigned int *count, struct branch *b)
 {
 	struct hash_list *list = NULL, *n, *e = e;
 	const char *from;
@@ -2622,7 +2622,13 @@ static struct hash_list *parse_merge(unsigned int *count)
 		from = strchr(command_buf.buf, ' ') + 1;
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
-		if (s)
+		if (b == s)
+			/*
+			 * Also if there were a 'from' command, b will point to
+			 * 'from' commit, because parse_from stores it there.
+			 */
+			die("Can't merge a branch with itself: %s", b->name);
+		else if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from == ':') {
 			uintmax_t idnum = parse_mark_ref_eol(from);
@@ -2686,7 +2692,7 @@ static void parse_new_commit(void)
 	parse_data(&msg, 0, NULL);
 	read_next_command();
 	parse_from(b);
-	merge_list = parse_merge(&merge_count);
+	merge_list = parse_merge(&merge_count, b);
 
 	/* ensure the branch is active/loaded */
 	if (!b->branch_tree.tree || !max_active_branches) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6f4c988..79cb72a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -872,6 +872,19 @@ test_expect_success \
 	'git fast-import <input &&
 	git rev-parse --verify J5 &&
 	test_must_fail git rev-parse --verify J5^'
+
+cat >input <<INPUT_END
+commit refs/heads/J5
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+Merge J5 with itself.
+COMMIT
+merge refs/heads/J5
+
+INPUT_END
+test_expect_success \
+	'J: disallow merge with itself' \
+	'test_must_fail git fast-import <input'
 ###
 ### series K
 ###
-- 
1.7.3.4
