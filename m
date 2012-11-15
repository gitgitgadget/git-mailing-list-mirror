From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 4/5] sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
Date: Thu, 15 Nov 2012 09:55:27 -0800
Message-ID: <1353002127-15863-1-git-send-email-drafnel@gmail.com>
References: <1352943474-15573-4-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 18:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ3fP-00061E-PY
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 18:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768581Ab2KORzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 12:55:41 -0500
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41029 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768574Ab2KORzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 12:55:40 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so351834ggd.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ooe1kt+Hfjk2/trW3GqnW6AjJY3uwL6SIJJ6iUbSARI=;
        b=H2daI81Xhf7vGEPByPflUPqec1CvmnN8WNzsdCwXVIcCo8thImKSdjbLmlWrWh+lyw
         m2Dk/8Z+V88EWdgEuVITkT+v2REeFm+5eXtOrn/c43k3fL//Ndj3l5t3aMSMepSDxmAr
         FAktcu88/QnCY5w0cUtLCH/ZqRYUFpy1EO76XNSTnI9zXmBS2yc6cfyPJLj/iwMTc5KK
         H90PwA+Rj3ummv+73zuiH9uBdY5PZoKAzTC6SDIk8NNpcmFBxylqU5x1eVBuI9+O3TfO
         D8fa4QyEvGoY3h5hNZOIisBGh3oWwUGQA8/nJrxNpiUBHCM7LVROEoaIri8uo1NfIyES
         EtPQ==
Received: by 10.100.76.12 with SMTP id y12mr471542ana.72.1353002139886;
        Thu, 15 Nov 2012 09:55:39 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id n40sm14838314ani.16.2012.11.15.09.55.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 09:55:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-4-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209836>

Currently, if the s-o-b footer of a commit message contains a
"(cherry picked from ..." line that was added by a previous cherry-pick -x,
it is not recognized as a s-o-b footer and will cause a newline to be
inserted before an additional s-o-b is added.

So, rework ends_rfc2822_footer to recognize the "(cherry picked from ..."
string as part of the footer.  Plus mark the test in t3511 as fixed.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---

Declare cherry_picked_prefix variable as static.  This is the only change
with respect to v1.

-Brandon

 sequencer.c              | 44 +++++++++++++++++++++++++++++---------------
 t/t3511-cherry-pick-x.sh |  2 +-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 01edec2..213fa4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -18,6 +18,7 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
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
