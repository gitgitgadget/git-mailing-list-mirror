From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 06/11] sequencer.c: always separate "(cherry picked from" from commit body
Date: Sun, 27 Jan 2013 17:11:50 -0800
Message-ID: <1359335515-13818-7-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdHJ-0006QA-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab3A1BMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:30 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45530 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab3A1BM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:26 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so1189652pad.31
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=138LAQINCMy6jlxtcQcfji8OUCjduzkLp6j2epnGr7E=;
        b=yJgAkAGXTkpOogK9ojPpSq5yg+8v+KY8FqVfPMcFRN7nCW0R0IjN+J9qqohkelKYVZ
         nRu3xEFOYM6aOyKTYKuP8/QqqA+rgPyub6eDWvaaRPQ/Mgsv0XDSMpArmB5A+AIeSJ3h
         ct9Vdzbbl8hX9PXQyKcsVRZ9tzahv8RF0RhfsdkghYPTnJoeRES2OtKkT7iFFd5ooyU5
         NxVHogA+gX+wvVkiEfrGFe5QYhY6PP6jEkX3vHjhh0+slfUQtzDVLaE5W5PFblDsDCT1
         Q2q9FKejQDtCO0GnguEOfQk74js7km7ZpuLi0EbdRijpo/GzxVHXiO+B55HqGQqs8Hga
         mOAg==
X-Received: by 10.66.75.3 with SMTP id y3mr31984059pav.71.1359335545868;
        Sun, 27 Jan 2013 17:12:25 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:24 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214770>

Start treating the "(cherry picked from" line added by cherry-pick -x
the same way that the s-o-b lines are treated.  Namely, separate them
from the main commit message body with an empty line.

This commit is mostly a code movement, but notice that
has_conforming_footer() was modified, in addition to being moved.

Introduce tests to test this functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 120 +++++++++++++++++++++++++----------------------
 t/t3511-cherry-pick-x.sh |  53 +++++++++++++++++++++
 2 files changed, 116 insertions(+), 57 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0b5cd18..46d51b2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,67 @@
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
+	int last_char_was_nl, this_char_is_nl;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	const char *buf = sb->buf;
+
+	/* find start of last paragraph */
+	last_char_was_nl = 0;
+	for (i = len - 1; i > 0; i--) {
+		this_char_is_nl = (buf[i] == '\n');
+		if (last_char_was_nl && this_char_is_nl)
+			break;
+		last_char_was_nl = this_char_is_nl;
+	}
+
+	/* require at least one blank line */
+	if (!last_char_was_nl || buf[i] != '\n')
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
@@ -497,6 +558,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			if (!has_conforming_footer(&msgbuf, 0))
+				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -1022,63 +1085,6 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
-	int last_char_was_nl, this_char_is_nl;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-
-	/* find start of last paragraph */
-	last_char_was_nl = 0;
-	for (i = len - 1; i > 0; i--) {
-		this_char_is_nl = (buf[i] == '\n');
-		if (last_char_was_nl && this_char_is_nl)
-			break;
-		last_char_was_nl = this_char_is_nl;
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
1.8.1.1.450.g0327af3
