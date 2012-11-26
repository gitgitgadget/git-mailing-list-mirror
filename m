From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 06/11] sequencer.c: teach append_signoff how to detect duplicate s-o-b
Date: Sun, 25 Nov 2012 17:45:54 -0800
Message-ID: <1353894359-6733-7-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcnnQ-0007Td-V1
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab2KZBr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:47:26 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56814 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab2KZBrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:47:24 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4643368pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w48xtn9f4LrZO6nN94TfRDpRT9GLaqItc4nThk97f1A=;
        b=FoP0Ryno8KC0EfSOjwE6viILw41E+UdA7Fg1UCerw1R8BeM4B68o+fccp9wAbY1j0G
         6hM0toKnC4HWtp+k0UW0rWRkrt50Q1n5h+Y3D1+VUZa9GXeD+uXpI252l4pg8mdA9/Ji
         mZjNQZy825NNwjkyj5fifIVw/LPcr4bPd/F0X+WaTYiFQ1HesWJyl9N9mvJ41HDDWwZj
         NW/ioDoiHj1jIoc7YNRBJDLMX3knnc0NYghAqxjLUJ27qmTWs3wkhNSu/FQJWE2Mis9y
         cHH4++K1VEKwLXAGTNSwOnbRLPoHXp4AttsRbt5A5+1Btp2o2qThl08lLvsAIgMO+wPq
         S13Q==
Received: by 10.66.82.102 with SMTP id h6mr28503000pay.38.1353894444688;
        Sun, 25 Nov 2012 17:47:24 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.47.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:47:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210396>

Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
This is in preparation to unify the append_signoff implementations in
log-tree.c and sequencer.c.

Fixes test in t3511.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/commit.c         |  2 +-
 sequencer.c              | 43 +++++++++++++++++++++++++++++++------------
 sequencer.h              |  2 +-
 t/t3511-cherry-pick-x.sh |  2 +-
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1dd2ec5..7b9e2ac 100644
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
index 7c0852a..3062ad4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -42,12 +42,19 @@ static int is_cherry_pick_from_line(const char *buf, int len)
 		!prefixcmp(buf, cherry_picked_prefix);
 }
 
-static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
+/* Returns 0 for non-conforming footer
+ * Returns 1 for conforming footer
+ * Returns 2 when sob exists within conforming footer
+ * Returns 3 when sob exists within conforming footer as last entry
+ */
+static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
+	int ignore_footer)
 {
 	int hit = 0;
-	int i, k;
+	int i, k = 0;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
+	int found_sob = 0;
 
 	for (i = len - 1; i > 0; i--) {
 		if (hit && buf[i] == '\n')
@@ -63,14 +70,24 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 		i++;
 
 	for (; i < len; i = k) {
+		int found_rfc2822;
+
 		for (k = i; k < len && buf[k] != '\n'; k++)
 			; /* do nothing */
 		k++;
 
-		if (!(is_rfc2822_line(buf+i, k-i) ||
-			is_cherry_pick_from_line(buf+i, k-i)))
+		found_rfc2822 = is_rfc2822_line(buf+i, k-i);
+		if (found_rfc2822 && sob &&
+			!strncasecmp(buf+i, sob->buf, sob->len))
+			found_sob = k;
+
+		if (!(found_rfc2822 || is_cherry_pick_from_line(buf+i, k-i)))
 			return 0;
 	}
+	if (found_sob == i)
+		return 3;
+	if (found_sob)
+		return 2;
 	return 1;
 }
 
@@ -291,7 +308,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-		append_signoff(msgbuf, 0);
+		append_signoff(msgbuf, 0, 0);
 
 	if (!clean) {
 		int i;
@@ -547,7 +564,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, 0))
+			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -1074,9 +1091,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer)
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
 {
 	struct strbuf sob = STRBUF_INIT;
+	int has_footer = 0;
 	int i;
 
 	strbuf_addstr(&sob, sign_off_header);
@@ -1085,10 +1103,11 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	strbuf_addch(&sob, '\n');
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
-	}
+	if (!i || !(has_footer =
+		has_conforming_footer(msgbuf, &sob, ignore_footer)))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				sob.buf, sob.len);
 	strbuf_release(&sob);
 }
diff --git a/sequencer.h b/sequencer.h
index 9d57d57..c4c7132 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,6 @@ int sequencer_pick_revisions(struct replay_opts *opts);
 
 extern const char sign_off_header[];
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer);
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob);
 
 #endif
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9dd6d5d..4b67343 100755
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
1.8.0.284.g959048a
