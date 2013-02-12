From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 07/12] sequencer.c: always separate "(cherry picked from" from commit body
Date: Tue, 12 Feb 2013 02:17:34 -0800
Message-ID: <1360664260-11803-8-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cwp-0002O8-5c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955Ab3BLKS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:26 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:65385 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:24 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3208442dak.33
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+VTEQfwwyQhNzo23lpPChyReP6w2N6mZQk9hXBn1syw=;
        b=lHdrWrvB58YKhbQrF6ySXNmYID/as+rQgH/XnEoPbhCZYSmnvhOqWM+nGXV91RgT/c
         uPgYOWm6kDYPd2+kxKnY1nKJmgwvU6CpEJQXdNfulPhpxCKHXl6DhUb8npUdIVLPXtuw
         lWNwu6oCkzqLQdldM6O4fgtv+0ja9gEz1i3BqaHnZzbsZPLPNrvx7Gos99D4ueZRxtwv
         MSDG4W+WGDtbuFM4cjVtL7FFNPD92/a2TC6yqU+nzhOEcp2FBku8m/jEpzFCIyk2SbBw
         yzVR4CxmkTwbQ/bne7swZ2MEuRXiVqbmxFxnwUDrtedCIEmQ7drBzGih9xA1h692cQqE
         BUhw==
X-Received: by 10.66.85.103 with SMTP id g7mr50755176paz.45.1360664303615;
        Tue, 12 Feb 2013 02:18:23 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.21
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216136>

Start treating the "(cherry picked from" line added by cherry-pick -x
the same way that the s-o-b lines are treated.  Namely, separate them
from the main commit message body with an empty line.

Introduce tests to test this functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sequencer.c              | 128 ++++++++++++++++++++++++-----------------------
 t/t3511-cherry-pick-x.sh |  53 ++++++++++++++++++++
 2 files changed, 118 insertions(+), 63 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 178e84b..249c4a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,69 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+static int is_rfc2822_line(const char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int ch = buf[i];
+		if (ch == ':')
+			return 1;
+		if (!isalnum(ch) && ch != '-')
+			break;
+	}
+
+	return 0;
+}
+
+static int is_cherry_picked_from_line(const char *buf, int len)
+{
+	/*
+	 * We only care that it looks roughly like (cherry picked from ...)
+	 */
+	return len > strlen(cherry_picked_prefix) + 1 &&
+		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
+}
+
+static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
+{
+	char prev;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	const char *buf = sb->buf;
+
+	/* footer must end with newline */
+	if (!len || buf[len - 1] != '\n')
+		return 0;
+
+	prev = '\0';
+	for (i = len - 1; i > 0; i--) {
+		char ch = buf[i];
+		if (prev == '\n' && ch == '\n') /* paragraph break */
+			break;
+		prev = ch;
+	}
+
+	/* require at least one blank line */
+	if (prev != '\n' || buf[i] != '\n')
+		return 0;
+
+	/* advance to start of last paragraph */
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if (!is_rfc2822_line(buf + i, k - i - 1) &&
+		    !is_cherry_picked_from_line(buf + i, k - i - 1))
+			return 0;
+	}
+	return 1;
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -497,6 +560,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			if (!has_conforming_footer(&msgbuf, 0))
+				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -1022,69 +1087,6 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-static int is_rfc2822_line(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		int ch = buf[i];
-		if (ch == ':')
-			return 1;
-		if (!isalnum(ch) && ch != '-')
-			break;
-	}
-
-	return 0;
-}
-
-static int is_cherry_picked_from_line(const char *buf, int len)
-{
-	/*
-	 * We only care that it looks roughly like (cherry picked from ...)
-	 */
-	return len > strlen(cherry_picked_prefix) + 1 &&
-		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
-}
-
-static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
-{
-	char prev;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-
-	/* footer must end with newline */
-	if (!len || buf[len - 1] != '\n')
-		return 0;
-
-	prev = '\0';
-	for (i = len - 1; i > 0; i--) {
-		char ch = buf[i];
-		if (prev == '\n' && ch == '\n') /* paragraph break */
-			break;
-		prev = ch;
-	}
-
-	/* require at least one blank line */
-	if (prev != '\n' || buf[i] != '\n')
-		return 0;
-
-	/* advance to start of last paragraph */
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if (!is_rfc2822_line(buf + i, k - i - 1) &&
-		    !is_cherry_picked_from_line(buf + i, k - i - 1))
-			return 0;
-	}
-	return 1;
-}
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob = STRBUF_INIT;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 73da182..a845e45 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -57,6 +57,19 @@ test_expect_success setup '
 	test_commit conflicting unrelated
 '
 
+test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-one-line^0` &&
+	git cherry-pick -x mesg-one-line &&
+	cat <<-EOF >expect &&
+		$mesg_one_line
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s inserts blank line after one line subject' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-one-line &&
@@ -81,6 +94,19 @@ test_expect_failure 'cherry-pick -s inserts blank line after non-conforming foot
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x inserts blank line when conforming footer not found' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-no-footer^0` &&
+	git cherry-pick -x mesg-no-footer &&
+	cat <<-EOF >expect &&
+		$mesg_no_footer
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s inserts blank line when conforming footer not found' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-no-footer &&
@@ -93,6 +119,20 @@ test_expect_success 'cherry-pick -s inserts blank line when conforming footer no
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer not found' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-no-footer^0` &&
+	git cherry-pick -x -s mesg-no-footer &&
+	cat <<-EOF >expect &&
+		$mesg_no_footer
+
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-footer &&
@@ -163,4 +203,17 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse mesg-with-cherry-footer^0` &&
+	git cherry-pick -x -s mesg-with-cherry-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_cherry_footer
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.3.579.gd9af3b6
