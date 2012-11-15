From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 4/5] sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
Date: Wed, 14 Nov 2012 17:37:53 -0800
Message-ID: <1352943474-15573-4-git-send-email-drafnel@gmail.com>
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
	id 1TYoPa-0006t8-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992578Ab2KOBiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:38:16 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:42040 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992567Ab2KOBiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:38:14 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so243438yen.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZPnXVHeAaC6c63vaWEdHQ59k+IaXnmqvElW2ZqDkLvw=;
        b=C4GGf3IKWtsEG7iWqsp7Lm4LsyF1WupGs8ACibsl1Ztt6U2o/0YYfI8iam8Rrc+5Xb
         gudgZGo9e1Fv3XrKQovsUaUT2zWF4SV7sKdqVA3IrWG6rgssSYuVmDMoX4+9aUuQsTRB
         zZX5P2+aJBp56xBIUCBNUIINWNm22TCDlH7njUGHM6sE1txVrt7DcqZCi4hjDBVbQZXY
         EA7rly/u7GKF9xU6FlvdI4JughKXhCLfcGL3Tk+0h02p27H/hlyjXUiGCIq3jj6wQN7o
         gkK6lJcZuZvV3PfnHGL/ZH5CXZhETD0+SUyEuR/Pmbx3SUik1RZ/hQm1Dm4r2lfRTMN4
         Emcg==
Received: by 10.236.77.229 with SMTP id d65mr28054597yhe.124.1352943493974;
        Wed, 14 Nov 2012 17:38:13 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id y9sm4775632anh.20.2012.11.14.17.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:38:13 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209783>

Currently, if the s-o-b footer of a commit message contains a
"(cherry picked from ..." line that was added by a previous cherry-pick -x,
it is not recognized as a s-o-b footer and will cause a newline to be
inserted before an additional s-o-b is added.

So, rework ends_rfc2822_footer to recognize the "(cherry picked from ..."
string as part of the footer.  Plus mark the test in t3511 as fixed.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 44 +++++++++++++++++++++++++++++---------------
 t/t3511-cherry-pick-x.sh |  2 +-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 01edec2..27e684c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -18,6 +18,7 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
+const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 static void remove_sequencer_state(void)
 {
@@ -492,7 +493,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
@@ -1017,13 +1018,34 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
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
 static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 {
-	int ch;
 	int hit = 0;
-	int i, j, k;
+	int i, k;
 	int len = sb->len - ignore_footer;
-	int first = 1;
+	int last_was_rfc2822 = 0;
 	const char *buf = sb->buf;
 
 	for (i = len - 1; i > 0; i--) {
@@ -1040,20 +1062,12 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if ((buf[i] == ' ' || buf[i] == '\t') && !first)
+		if (last_was_rfc2822 && (buf[i] == ' ' || buf[i] == '\t'))
 			continue;
 
-		first = 0;
-
-		for (j = 0; i + j < len; j++) {
-			ch = buf[i + j];
-			if (ch == ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch == '-'))
-				continue;
+		if (!((last_was_rfc2822 = is_rfc2822_line(buf+i, k-i)) ||
+			is_cherry_pick_from_line(buf+i, k-i)))
 			return 0;
-		}
 	}
 	return 1;
 }
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index b2098e0..785486e 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -63,7 +63,7 @@ test_expect_success 'cherry-pick -s not confused by rfc2822 continuation line' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick treats -s "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick treats -s "(cherry picked from..." line as part of footer' '
 	pristine_detach initial &&
 	git cherry-pick -s rfc2822-cherry-base &&
 	cat <<-EOF >expect &&
-- 
1.8.0
