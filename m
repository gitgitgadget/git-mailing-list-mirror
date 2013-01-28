From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 07/11] sequencer.c: teach append_signoff how to detect duplicate s-o-b
Date: Sun, 27 Jan 2013 17:11:51 -0800
Message-ID: <1359335515-13818-8-git-send-email-drafnel@gmail.com>
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
	id 1TzdHK-0006QA-1a
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab3A1BMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:32 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47876 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab3A1BM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:28 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1190600pad.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oj8dgHz7tQkz+Aov7PO7whaIdNJdKCuOGAMRdMYi+h8=;
        b=bNBMDT/0EC/ihPL/U2j72+XDbbEXufNaX7V+dGbhi8UjPx7UWQcEVALQpOKKD+76TE
         y0I0qJFDNJWNY0xvYVgqJSzfdHH6llJrmejT1/BEM0yfbzdex5Nd6yogiWKurisklI3S
         Rcds+X2p21o/QldvqXYK6GbfJcOd/17F0G1ISi9qnRRLeaBhJZHCrcdVymGk2Eq/yuv2
         /059363VbspsOn9B6dl6OsyHzqR8ol/8MQdXOeq/H5v/1VeiVHJOcZ+tvxIt6206fybL
         6UoFTmnTEAH2vtG0f7sPYwyBSr9x6pINL4Zhfwa8E35SKJ8ruh4xMtPCf8rOK7AEDyJW
         JmFw==
X-Received: by 10.68.134.130 with SMTP id pk2mr33623227pbb.125.1359335547878;
        Sun, 27 Jan 2013 17:12:27 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.25
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:27 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214772>

Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
This is in preparation to unify the append_signoff implementations in
log-tree.c and sequencer.c.

Fixes test in t3511.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/commit.c         |  2 +-
 sequencer.c              | 47 +++++++++++++++++++++++++++++++++++++----------
 sequencer.h              |  4 +++-
 t/t3511-cherry-pick-x.sh |  2 +-
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 38b9a9c..67ea9e7 100644
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
index 46d51b2..015cb58 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -46,12 +46,20 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));
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
 	int last_char_was_nl, this_char_is_nl;
 	int i, k;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
+	int found_sob = 0;
 
 	/* find start of last paragraph */
 	last_char_was_nl = 0;
@@ -70,14 +78,25 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 		i++;
 
 	for (; i < len; i = k) {
+		int found_rfc2822;
+
 		for (k = i; k < len && buf[k] != '\n'; k++)
 			; /* do nothing */
 		k++;
 
-		if (!(is_rfc2822_line(buf + i, k - i) ||
+		found_rfc2822 = is_rfc2822_line(buf + i, k - i);
+		if (found_rfc2822 && sob &&
+			!strncmp(buf + i, sob->buf, sob->len))
+			found_sob = k;
+
+		if (!(found_rfc2822 ||
 			is_cherry_picked_from_line(buf + i, k - i)))
 			return 0;
 	}
+	if (found_sob == i)
+		return 3;
+	if (found_sob)
+		return 2;
 	return 1;
 }
 
@@ -299,7 +318,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-		append_signoff(msgbuf, 0);
+		append_signoff(msgbuf, 0, 0);
 
 	if (!clean) {
 		int i;
@@ -558,7 +577,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, 0))
+			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -1085,9 +1104,11 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer)
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 {
+	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
 	struct strbuf sob = STRBUF_INIT;
+	int has_footer = 0;
 	int i;
 
 	strbuf_addstr(&sob, sign_off_header);
@@ -1096,10 +1117,16 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	strbuf_addch(&sob, '\n');
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
-	}
+
+	if (i)
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
1.8.1.1.450.g0327af3
