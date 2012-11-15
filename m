From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH/RFC 5/5] sequencer.c: always separate "(cherry picked from" from commit body
Date: Wed, 14 Nov 2012 17:37:54 -0800
Message-ID: <1352943474-15573-5-git-send-email-drafnel@gmail.com>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoPb-0006t8-E7
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992594Ab2KOBiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:38:19 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:56141 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992567Ab2KOBiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:38:16 -0500
Received: by mail-yh0-f46.google.com with SMTP id m54so238531yhm.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ssRaqIK5B6sgX0aavq3siJmQiRWIaT+xQb5xMTtsIeo=;
        b=Yip58+A2qBzFu8+72qKuKWaSEmqwR1ybWMX0D1D34FWxavBZg3m+J+KuXVfQc54sp1
         z8PCYfaYLt1G2hoKLBGwh/Bd9pwQR+AryWUti8uudL2dyHQPFiX6JzKoUhB4LW4zWUW2
         dEyyjlmwBU7r63j0lX20HvFw/ao8zTtI4f7i4oyhv5vsO3k/e3uLnLRrdTZjsq4jOkIG
         V9Z7sFdzC36SiKCkSn2nClXcN5SB5Rsuigjhdl80n7NBzsCFQVUY1k7K9x4UbJhyNOwh
         xbxknVpeCF4JzIZUf5YqcrMZX8Ik6J7EGhku24MGBquymB2kCiJQg9bQlBwNWobWNwx3
         x0Og==
Received: by 10.236.77.39 with SMTP id c27mr3727382yhe.102.1352943495918;
        Wed, 14 Nov 2012 17:38:15 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id y9sm4775632anh.20.2012.11.14.17.38.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:38:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209784>

Start treating the "(cherry picked from" line added by cherry-pick -x
the same way that the s-o-b lines are treated.  Namely, separate them
from the main commit message body with an empty line.

Also, introduce tests to test this functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---


This seems like the right thing to do, but it's more of a change in
policy than the others, so I marked it as RFC.  Any disagreement here?

-Brandon


 sequencer.c              | 110 ++++++++++++++++++++++++-----------------------
 t/t3511-cherry-pick-x.sh |  77 +++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 54 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 27e684c..0da0538 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,60 @@
 const char sign_off_header[] = "Signed-off-by: ";
 const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
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
+static int is_cherry_pick_from_line(const char *buf, int len)
+{
+	return (strlen(cherry_picked_prefix) + 41) <= len &&
+		!prefixcmp(buf, cherry_picked_prefix);
+}
+
+static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
+{
+	int hit = 0;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	int last_was_rfc2822 = 0;
+	const char *buf = sb->buf;
+
+	for (i = len - 1; i > 0; i--) {
+		if (hit && buf[i] == '\n')
+			break;
+		hit = (buf[i] == '\n');
+	}
+
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if (last_was_rfc2822 && (buf[i] == ' ' || buf[i] == '\t'))
+			continue;
+
+		if (!((last_was_rfc2822 = is_rfc2822_line(buf+i, k-i)) ||
+			is_cherry_pick_from_line(buf+i, k-i)))
+			return 0;
+	}
+	return 1;
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -493,6 +547,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
+			if (!ends_rfc2822_footer(&msgbuf, 0))
+				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -1018,60 +1074,6 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
-static int is_cherry_pick_from_line(const char *buf, int len)
-{
-	return (strlen(cherry_picked_prefix) + 41) <= len &&
-		!prefixcmp(buf, cherry_picked_prefix);
-}
-
-static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
-{
-	int hit = 0;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	int last_was_rfc2822 = 0;
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
-		if (last_was_rfc2822 && (buf[i] == ' ' || buf[i] == '\t'))
-			continue;
-
-		if (!((last_was_rfc2822 = is_rfc2822_line(buf+i, k-i)) ||
-			is_cherry_pick_from_line(buf+i, k-i)))
-			return 0;
-	}
-	return 1;
-}
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 {
 	struct strbuf sob = STRBUF_INIT;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 785486e..af7a87c 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -40,6 +40,19 @@ test_expect_success setup '
 	test_commit conflicting unrelated
 '
 
+test_expect_success 'cherry-pick -x inserts blank line after non-rfc2822 footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse non-rfc2822-base^0` &&
+	git cherry-pick -x non-rfc2822-base &&
+	cat <<-EOF >expect &&
+		$non_rfc2822_mesg
+
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s inserts blank line after non-rfc2822 footer' '
 	pristine_detach initial &&
 	git cherry-pick -s non-rfc2822-base &&
@@ -52,6 +65,32 @@ test_expect_success 'cherry-pick -s inserts blank line after non-rfc2822 footer'
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s inserts blank line after non-rfc2822 footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse non-rfc2822-base^0` &&
+	git cherry-pick -x -s non-rfc2822-base &&
+	cat <<-EOF >expect &&
+		$non_rfc2822_mesg
+
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -x not confused by rfc2822 continuation line' '
+	pristine_detach initial &&
+	sha1=`git rev-parse rfc2822-base^0` &&
+	git cherry-pick -x rfc2822-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_mesg
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -s not confused by rfc2822 continuation line' '
 	pristine_detach initial &&
 	git cherry-pick -s rfc2822-base &&
@@ -63,6 +102,31 @@ test_expect_success 'cherry-pick -s not confused by rfc2822 continuation line' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x -s not confused by rfc2822 continuation line' '
+	pristine_detach initial &&
+	sha1=`git rev-parse rfc2822-base^0` &&
+	git cherry-pick -x -s rfc2822-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_mesg
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick treats -x "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse rfc2822-cherry-base^0` &&
+	git cherry-pick -x rfc2822-cherry-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_cherry_mesg
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick treats -s "(cherry picked from..." line as part of footer' '
 	pristine_detach initial &&
 	git cherry-pick -s rfc2822-cherry-base &&
@@ -74,4 +138,17 @@ test_expect_success 'cherry-pick treats -s "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick treats -x -s "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	sha1=`git rev-parse rfc2822-cherry-base^0` &&
+	git cherry-pick -x -s rfc2822-cherry-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_cherry_mesg
+		(cherry picked from commit $sha1)
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.0
