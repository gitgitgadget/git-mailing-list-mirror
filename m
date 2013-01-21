From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 05/10] sequencer.c: always separate "(cherry picked from" from commit body
Date: Mon, 21 Jan 2013 00:40:22 -0800
Message-ID: <1358757627-16682-6-git-send-email-drafnel@gmail.com>
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
	id 1TxCwK-0002t2-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab3AUIkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:53 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40361 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:52 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so3261831pad.20
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KD3MfAXwIykTkk+Lt8d0WvXNaPhGYIrXlH0cMeVKqTU=;
        b=hGQKmEv/0duEee/T1wanhTFyrdt8hkZmeAFhQ82DpyCfyVptVlRsGww82pjg6Miw1R
         RZGPpN+PEVBAPWvANSDBsFbdRX0J9nl1OqHDohsRZ3dOnbf1P2jxftgVbmDgEHA6c+Qm
         Wyjjj/LHs2UMK0kOYY27Lwiv0oiE/aCIjydsWTyZ0o36FJdS7omqQoIj32UhmWHeatiK
         byrUTwFgTZv6R9rPO/GOUYc0EMXVOVwyPlWcF8R54W+Fe7miti+tm7rdFB6UILwKMyWj
         gW39Rqg0Kh5rYyEOSZ/Tq/iDLy+Itp4lFTyUrdDXv8YhPeWC9PYDgB9hieu2bwYEXPzc
         33JQ==
X-Received: by 10.69.1.65 with SMTP id be1mr28071268pbd.66.1358757651941;
        Mon, 21 Jan 2013 00:40:51 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.50
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:51 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214097>

Start treating the "(cherry picked from" line added by cherry-pick -x
the same way that the s-o-b lines are treated.  Namely, separate them
from the main commit message body with an empty line.

Introduce tests to test this functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 114 +++++++++++++++++++++++++----------------------
 t/t3511-cherry-pick-x.sh |  53 ++++++++++++++++++++++
 2 files changed, 113 insertions(+), 54 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fe76a1d..163dc12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,64 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
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
+{
+	int hit = 0;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	const char *buf = sb->buf;
+
+	for (i = len - 1; i > 0; i--) {
+		if (hit && buf[i] == '\n')
+			break;
+		hit = (buf[i] == '\n');
+	}
+
+	/* require at least one blank line */
+	if (!hit || buf[i] != '\n')
+		return 0;
+
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if (!(is_rfc2822_line(buf + i, k - i) ||
+			is_cherry_picked_from_line(buf + i, k - i)))
+			return 0;
+	}
+	return 1;
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -497,6 +555,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			if (!has_conforming_footer(&msgbuf, 0))
+				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -1022,60 +1082,6 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-static int is_rfc2822_line(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		int ch = buf[i];
-		if (ch == ':')
-			break;
-		if (isalnum(ch) || (ch == '-'))
-			continue;
-		return 0;
-	}
-
-	return 1;
-}
-
-static int is_cherry_picked_from_line(const char *buf, int len)
-{
-	/*
-	 * We only care that it looks roughly like (cherry picked from ...)
-	 */
-	return !prefixcmp(buf, cherry_picked_prefix) &&
-		(buf[len - 1] == ')' ||
-		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));
-}
-
-static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
-{
-	int hit = 0;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-
-	for (i = len - 1; i > 0; i--) {
-		if (hit && buf[i] == '\n')
-			break;
-		hit = (buf[i] == '\n');
-	}
-
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if (!(is_rfc2822_line(buf + i, k - i) ||
-			is_cherry_picked_from_line(buf + i, k - i)))
-			return 0;
-	}
-	return 1;
-}
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob = STRBUF_INIT;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 32c0bb1..9dd6d5d 100755
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
1.8.1.1.252.gdb33759
