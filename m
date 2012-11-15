From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 6/5] sequencer.c: refrain from adding duplicate s-o-b lines
Date: Thu, 15 Nov 2012 15:24:35 -0800
Message-ID: <1353021875-7552-1-git-send-email-drafnel@gmail.com>
References: <1352943474-15573-5-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 16 00:24:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ8nn-0002Pz-08
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 00:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab2KOXYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 18:24:41 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:52199 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2KOXYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 18:24:40 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so424633yen.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XzOHwNvbq4edSYJwKsuOWrpSiJj3ta5wr13N4KH8xvk=;
        b=KM1MFnjftGv64BAxmoJMfsMHcGvrOTy8AZxfzzvNH0HknuJGpAP6VtcW7LgZ8zWWZ+
         vcA4U0fukYPl6y9plpkJ+mdiWGiaPW3Rkp5iILHRm/S8pgN2y2tlxdDqHpi4YmXwd4qQ
         c+4r+SMS3si0VPnFO9b+yDW+Exv3QdaHKJHKD/FV5j+JA4/CS0L4/jK5EXxCkvt2G5TD
         0ysEIr0Zc1qxWL8bIk8QNpaqQFwzvgBUZJQyvXYSmJjxAQuf7CC0ZT/y46E6TWIby6qx
         KzI2ekT9sB4WXb3EVme4qRHvEEvxzlhWTWdi70mqhbGKUp89cM99v5mAFB378BAS89SZ
         MDuQ==
Received: by 10.236.151.51 with SMTP id a39mr2653805yhk.29.1353021879851;
        Thu, 15 Nov 2012 15:24:39 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id o66sm17236136yhi.19.2012.11.15.15.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 15:24:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-5-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209853>

Detect whether the s-o-b already exists in the commit footer and refrain
from adding a duplicate.

Update t3511 to test new behavior.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---


Hi Duy,

How about this patch on top of my series as a base for your patch to
unify the code paths that append signoff in format-patch, commit, and
sequencer?

-Brandon


 sequencer.c              | 28 ++++++++++++++++++----------
 t/t3511-cherry-pick-x.sh | 20 ++++++++++++++++++--
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7ad1163..546dacb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -42,13 +42,15 @@ static int is_cherry_pick_from_line(const char *buf, int len)
 		!prefixcmp(buf, cherry_picked_prefix);
 }
 
-static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
+static int ends_rfc2822_footer(struct strbuf *sb, struct strbuf *sob,
+	int ignore_footer)
 {
 	int hit = 0;
 	int i, k;
 	int len = sb->len - ignore_footer;
 	int last_was_rfc2822 = 0;
 	const char *buf = sb->buf;
+	int found_sob = 0;
 
 	for (i = len - 1; i > 0; i--) {
 		if (hit && buf[i] == '\n')
@@ -66,12 +68,15 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 
 		if (last_was_rfc2822 && (buf[i] == ' ' || buf[i] == '\t'))
 			continue;
+		if ((last_was_rfc2822 = is_rfc2822_line(buf+i, k-i)) &&
+			sob && !found_sob &&
+			!strncasecmp(buf+i, sob->buf, sob->len))
+			found_sob = 1;
 
-		if (!((last_was_rfc2822 = is_rfc2822_line(buf+i, k-i)) ||
-			is_cherry_pick_from_line(buf+i, k-i)))
+		if (!(last_was_rfc2822 || is_cherry_pick_from_line(buf+i, k-i)))
 			return 0;
 	}
-	return 1;
+	return 1 + found_sob;
 }
 
 static void remove_sequencer_state(void)
@@ -547,7 +552,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			if (!ends_rfc2822_footer(&msgbuf, 0))
+			if (!ends_rfc2822_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -1077,6 +1082,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob = STRBUF_INIT;
+	int has_footer = 0;
 	int i;
 
 	strbuf_addstr(&sob, sign_off_header);
@@ -1085,10 +1091,12 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	strbuf_addch(&sob, '\n');
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
-	}
+	if (!i || !(has_footer =
+		ends_rfc2822_footer(msgbuf, &sob, ignore_footer)))
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				"\n", 1);
+	if (has_footer != 2)
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf,
+			sob.len);
 	strbuf_release(&sob);
 }
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index af7a87c..a15b199 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -11,9 +11,10 @@ pristine_detach () {
 	git clean -d -f -f -q -x
 }
 
-non_rfc2822_mesg='base with footer
+non_rfc2822_mesg="base with footer
 
-Commit message body is here.'
+Commit message body is here.
+Not an s-o-b Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 
 rfc2822_mesg="$non_rfc2822_mesg
 
@@ -25,6 +26,9 @@ rfc2822_cherry_mesg="$rfc2822_mesg
 (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
 Tested-by: C.U. Thor <cuthor@example.com>"
 
+rfc2822_cherry_sob_mesg="$rfc2822_cherry_mesg
+Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+Signed-off-by: C.U. Thor <cuthor@example.com>"
 
 test_expect_success setup '
 	git config advice.detachedhead false &&
@@ -36,6 +40,8 @@ test_expect_success setup '
 	test_commit "$rfc2822_mesg" foo b rfc2822-base &&
 	git reset --hard initial &&
 	test_commit "$rfc2822_cherry_mesg" foo b rfc2822-cherry-base &&
+	git reset --hard initial &&
+	test_commit "$rfc2822_cherry_sob_mesg" foo b rfc2822-cherry-sob-base &&
 	pristine_detach initial &&
 	test_commit conflicting unrelated
 '
@@ -151,4 +157,14 @@ test_expect_success 'cherry-pick treats -x -s "(cherry picked from..." line as p
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -s detects committer s-o-b already exists' '
+	pristine_detach initial &&
+	git cherry-pick -s rfc2822-cherry-sob-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_cherry_sob_mesg
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.0
