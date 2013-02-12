From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 08/12] sequencer.c: teach append_signoff how to detect duplicate s-o-b
Date: Tue, 12 Feb 2013 02:17:35 -0800
Message-ID: <1360664260-11803-9-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cx2-0002yo-2s
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963Ab3BLKS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:29 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55734 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:27 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so7837pab.33
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=p6fwBzzj5RWLm+c9/ZORpx41xzX8gbmkP3Yt52fRgjs=;
        b=PpWO9BWRxnqym2sLJkx+AMzd6eWVp2mt+aoAsE3APO4nTR6hCUBUx3ei/PSkN6g4ue
         uEdrkGxXCUbPM6k0lo5Wud2JeAE/Gp44NfHeLlT8aqP/Ol+3A3SWTK3YFF5drGXeW/Wx
         O6fBSKjLk9ldFA88u9gjTF63gYt50Gk6kq+HkEUkcFdzHSaJ8TOzujIHHN4rd4uK6cio
         2IcWMnIdHmQ57n5S0lZv43xAm9x5fGT1sxl+nW6k2rOFdx5HjYNDrN/wnU+yKJnRIiW1
         z5+XPL5E/5zHoLMzLpFaKwJiDg4ua8Ev+B0QKfHRrOW44YDIfWoiNvB5oykWjXCtRwj5
         shrA==
X-Received: by 10.66.76.42 with SMTP id h10mr50888351paw.59.1360664306522;
        Tue, 12 Feb 2013 02:18:26 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.24
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216137>

Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
This is in preparation to unify the append_signoff implementations in
log-tree.c and sequencer.c.

Fixes test in t3511.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/commit.c         |  2 +-
 sequencer.c              | 59 ++++++++++++++++++++++++++++++++++++------------
 sequencer.h              |  4 +++-
 t/t3511-cherry-pick-x.sh |  2 +-
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0e5f1..94c96b7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -700,7 +700,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			previous = eol;
 		}
 
-		append_signoff(&sb, ignore_footer);
+		append_signoff(&sb, ignore_footer, 0);
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
diff --git a/sequencer.c b/sequencer.c
index 249c4a0..3364faa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -44,12 +44,20 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
 }
 
-static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
+/*
+ * Returns 0 for non-conforming footer
+ * Returns 1 for conforming footer
+ * Returns 2 when sob exists within conforming footer
+ * Returns 3 when sob exists within conforming footer as last entry
+ */
+static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
+	int ignore_footer)
 {
 	char prev;
 	int i, k;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
+	int found_sob = 0;
 
 	/* footer must end with newline */
 	if (!len || buf[len - 1] != '\n')
@@ -72,14 +80,25 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 		i++;
 
 	for (; i < len; i = k) {
+		int found_rfc2822;
+
 		for (k = i; k < len && buf[k] != '\n'; k++)
 			; /* do nothing */
 		k++;
 
-		if (!is_rfc2822_line(buf + i, k - i - 1) &&
-		    !is_cherry_picked_from_line(buf + i, k - i - 1))
+		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
+		if (found_rfc2822 && sob &&
+		    !strncmp(buf + i, sob->buf, sob->len))
+			found_sob = k;
+
+		if (!(found_rfc2822 ||
+		      is_cherry_picked_from_line(buf + i, k - i - 1)))
 			return 0;
 	}
+	if (found_sob == i)
+		return 3;
+	if (found_sob)
+		return 2;
 	return 1;
 }
 
@@ -301,7 +320,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-		append_signoff(msgbuf, 0);
+		append_signoff(msgbuf, 0, 0);
 
 	if (!clean) {
 		int i;
@@ -560,7 +579,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, 0))
+			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -1087,21 +1106,33 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer)
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 {
+	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
 	struct strbuf sob = STRBUF_INIT;
-	int i;
+	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
 	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 				getenv("GIT_COMMITTER_EMAIL")));
 	strbuf_addch(&sob, '\n');
-	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
-		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!has_conforming_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
-	}
+
+	/*
+	 * If the whole message buffer is equal to the sob, pretend that we
+	 * found a conforming footer with a matching sob
+	 */
+	if (msgbuf->len - ignore_footer == sob.len &&
+	    !strncmp(msgbuf->buf, sob.buf, sob.len))
+		has_footer = 3;
+	else
+		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
+
+	if (!has_footer)
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+
+	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				sob.buf, sob.len);
+
 	strbuf_release(&sob);
 }
diff --git a/sequencer.h b/sequencer.h
index 9d57d57..1fc22dc 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -6,6 +6,8 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
+#define APPEND_SIGNOFF_DEDUP (1u << 0)
+
 enum replay_action {
 	REPLAY_REVERT,
 	REPLAY_PICK
@@ -48,6 +50,6 @@ int sequencer_pick_revisions(struct replay_opts *opts);
 
 extern const char sign_off_header[];
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer);
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 
 #endif
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index a845e45..f977279 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -82,7 +82,7 @@ test_expect_success 'cherry-pick -s inserts blank line after one line subject' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick -s inserts blank line after non-conforming footer' '
+test_expect_success 'cherry-pick -s inserts blank line after non-conforming footer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-broken-footer &&
 	cat <<-EOF >expect &&
-- 
1.8.1.3.579.gd9af3b6
