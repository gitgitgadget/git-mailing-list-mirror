From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 05/11] sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
Date: Sun, 27 Jan 2013 17:11:49 -0800
Message-ID: <1359335515-13818-6-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdHI-0006QA-Ut
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112Ab3A1BM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:27 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64863 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093Ab3A1BMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:24 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so1146644pbc.36
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uqvh1K8dCIIC7te2TCTGryV5pwvLvtk2wrDJKOi+ALc=;
        b=Dn64KUc9xFh6XOwuD45L5JpCElydFOGxegEWzV9AUe7tFUGPjTgIowHz345T0J2ID2
         L8ONyUXMOBvJ+RbrLNEpgkESUHJ+/s0zgbAaNeUIborDn13MAmWFLd0WLSRg4OltZZ/z
         zftJOqhljiL+bkkZFP9G7gBE/zyWkwI2Kiwa0rdgRlx21hp2ShVUOgGIGN/bLRndzXjl
         Xq+2l/ELX1aYnDw9uy3ULrAd1BOXW9nwmDmClF7ofg0o3dP0+HEkInbxbQKhCrJnqesx
         j84lCNkHWvcVww+jgGHQlWzWvk7NaOvSjPaHJOLX3oTEpAGLgyCrk5IZrOPv5xxO3hVz
         roWg==
X-Received: by 10.68.233.196 with SMTP id ty4mr33797726pbc.23.1359335543769;
        Sun, 27 Jan 2013 17:12:23 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.21
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214768>

When 'cherry-pick -s' is used to append a signed-off-by line to a cherry
picked commit, it does not currently detect the "(cherry picked from..."
that may have been appended by a previous 'cherry-pick -x' as part of the
s-o-b footer and it will insert a blank line before appending a new s-o-b.

Let's detect "(cherry picked from...)" as part of the footer so that we
will produce this:

   Signed-off-by: A U Thor <author@example.com>
   (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
   Signed-off-by: C O Mmitter <committer@example.com>

instead of this:

   Signed-off-by: A U Thor <author@example.com>
   (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)

   Signed-off-by: C O Mmitter <committer@example.com>

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sequencer.c              | 46 ++++++++++++++++++++++++++++------------
 t/t3511-cherry-pick-x.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 39a752b..0b5cd18 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -18,6 +18,7 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 static void remove_sequencer_state(void)
 {
@@ -496,7 +497,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
@@ -1021,11 +1022,36 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
+static int is_rfc2822_line(const char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int ch = buf[i];
+		if (ch == ':')
+			break;
+		if (isalnum(ch) || (ch == '-'))
+			continue;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int is_cherry_picked_from_line(const char *buf, int len)
+{
+	/*
+	 * We only care that it looks roughly like (cherry picked from ...)
+	 */
+	return !prefixcmp(buf, cherry_picked_prefix) &&
+		(buf[len - 1] == ')' ||
+		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));
+}
+
+static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 {
-	int ch;
 	int last_char_was_nl, this_char_is_nl;
-	int i, j, k;
+	int i, k;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
 
@@ -1046,15 +1072,9 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		for (j = 0; i + j < len; j++) {
-			ch = buf[i + j];
-			if (ch == ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch == '-'))
-				continue;
+		if (!(is_rfc2822_line(buf + i, k - i) ||
+			is_cherry_picked_from_line(buf + i, k - i)))
 			return 0;
-		}
 	}
 	return 1;
 }
@@ -1071,7 +1091,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
 	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
+		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
 			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
 	}
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 2a040b7..73da182 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -32,6 +32,10 @@ Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 mesg_with_footer_sob="$mesg_with_footer
 Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 
+mesg_with_cherry_footer="$mesg_with_footer_sob
+(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Tested-by: C.U. Thor <cuthor@example.com>"
+
 
 test_expect_success setup '
 	git config advice.detachedhead false &&
@@ -47,6 +51,8 @@ test_expect_success setup '
 	test_commit "$mesg_with_footer" foo b mesg-with-footer &&
 	git reset --hard initial &&
 	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
+	git reset --hard initial &&
+	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
 	pristine_detach initial &&
 	test_commit conflicting unrelated
 '
@@ -98,6 +104,19 @@ test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committe
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match committer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-with-footer^0` &&
+	git cherry-pick -x -s mesg-with-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_footer
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s refrains from adding duplicate trailing sob' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-footer-sob &&
@@ -108,4 +127,40 @@ test_expect_success 'cherry-pick -s refrains from adding duplicate trailing sob'
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists for committer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-with-footer-sob^0` &&
+	git cherry-pick -x -s mesg-with-footer-sob &&
+	cat <<-EOF >expect &&
+		$mesg_with_footer_sob
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-with-cherry-footer^0` &&
+	git cherry-pick -x mesg-with-cherry-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_cherry_footer
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	git cherry-pick -s mesg-with-cherry-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_cherry_footer
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.1.450.g0327af3
