From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 04/11] sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
Date: Sun, 25 Nov 2012 17:45:52 -0800
Message-ID: <1353894359-6733-5-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnn5-0007G5-5d
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2KZBrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:47:03 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56814 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab2KZBrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:47:01 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4643368pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SJ3JqXIkc395mTieYAlMEXf1P1KuZrqqmZM5YlbmLZ4=;
        b=f0zawb3GpNwqwQavSiZU5xllbXpeLoJidXsBssFbxTVD+LOt9QWc9XYCUKczWwz6L3
         lT6Fe+WeC3BC3AKHqnljW7lnJ0fAP1YjWdntwkJr7e4k/CrEPUoLSNYLH2EYdlYXTBaF
         RetDFn2taHl9wKnfhEa35DAmiU7KwseSTlSHNyp7yXHhokitqzX6rPiVfZly0N96d6d+
         ngpMdnYCU7REdw5upbZpv6Rn6NL8y6OG9czVBioYevodhanst4N1kWgeBRExvP2SxfgD
         02K0HgYOCGHZc51cWSccgWwu3HCMT7IWUosgObMAeBpdupP41moX9agk9lGkyYJwCntZ
         ni2Q==
Received: by 10.69.0.8 with SMTP id au8mr33366168pbd.58.1353894421193;
        Sun, 25 Nov 2012 17:47:01 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.46.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:47:00 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210394>

When 'cherry-pick -s' is used to append a signed-off-by line to a cherry
picked commit, it does not currently detect the "(cherry picked from..."
that may have been appended by a previous 'cherry-pick -x' as part of the
s-o-b footer and it will insert a blank line before appending a new s-o-b.

Let's detect "(cherry picked from...)" as part of the footer so that we
will produce this:

   Signed-off-by: A U Thor <author@example.com>
   (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
   Signed-off-by: C O Mitter <committer@example.com>

instead of this:

   Signed-off-by: A U Thor <author@example.com>
   (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)

   Signed-off-by: C O Mitter <committer@example.com>

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 42 ++++++++++++++++++++++++------------
 t/t3511-cherry-pick-x.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 656df6b..19eaf11 100644
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
@@ -1017,11 +1018,32 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
+static int is_cherry_pick_from_line(const char *buf, int len)
+{
+	return (strlen(cherry_picked_prefix) + 41) <= len &&
+		!prefixcmp(buf, cherry_picked_prefix);
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
 
@@ -1039,15 +1061,9 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		for (j = 0; i + j < len; j++) {
-			ch = buf[i + j];
-			if (ch == ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch == '-'))
-				continue;
+		if (!(is_rfc2822_line(buf+i, k-i) ||
+			is_cherry_pick_from_line(buf+i, k-i)))
 			return 0;
-		}
 	}
 	return 1;
 }
@@ -1064,7 +1080,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
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
1.8.0.284.g959048a
