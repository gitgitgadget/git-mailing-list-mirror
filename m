From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 04/10] sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
Date: Mon, 21 Jan 2013 00:40:21 -0800
Message-ID: <1358757627-16682-5-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwJ-0002t2-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab3AUIkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:51 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:41159 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:50 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so2602281dac.12
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nt1q8mqpPhp3vA/b1FE5EbgRPklC6cipG/KZFhtR9N4=;
        b=Dv6BNV+vEmpWQb+jIFCbKZOWzKFmfgABmF7QmTpDl5Mvon62aE0+lggghK6tFcHSWt
         gY+ctK5n6f8uwCTzbs3zE3G7GFXphxUFxHVVjG3vqAExxa0jBEqi0Z/fWhiHHfM0m0WA
         gricsB5zaD7Ms8MaOkIuY9rQ0qFDygmyE2dfil+9ekmCk4YX6h0lLQLejjlKAIU2oLWa
         Ne7nLiWPX9cLLRqQNmSv4y1LjIBPtNWq3bnoOKKSgmX/0cjYAPVYMPIN0KrI6cPpgd4A
         YIg6PordB1hds7dMcgIoNjvJUq8TIy70qxL/mcIL6apNzC02pMVcyDJFlNco7xhJVh1L
         R1zw==
X-Received: by 10.66.77.200 with SMTP id u8mr45297201paw.43.1358757649680;
        Mon, 21 Jan 2013 00:40:49 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.48
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:49 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214099>

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
---
 sequencer.c              | 46 ++++++++++++++++++++++++++++------------
 t/t3511-cherry-pick-x.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fe25ef4..fe76a1d 100644
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
 	int hit = 0;
-	int i, j, k;
+	int i, k;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
 
@@ -1043,15 +1069,9 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
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
@@ -1068,7 +1088,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
 	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
+		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
 			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
 	}
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index a6c4168..32c0bb1 100755
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
1.8.1.1.252.gdb33759
