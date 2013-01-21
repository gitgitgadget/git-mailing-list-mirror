From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect duplicate s-o-b
Date: Mon, 21 Jan 2013 00:40:23 -0800
Message-ID: <1358757627-16682-7-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwU-0002yZ-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3AUIk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:56 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:50432 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:55 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so2596806dad.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=N/v33b3x5VtmgWmXbcJvcimpGX4861uE/m+KSVaW3LQ=;
        b=YMxNvVqqZgBSqWZ8uqvinyEo9Y4NaxSFPO9viDFSgGyUE8NN9m9GnbNYCeZcMMutet
         +grxjWh2hsic1b46li1WKSIWYmqlH62qzONfPWFXmtDY4uSb8JYw+zgYVqShZFm1asp0
         V28qmSCWSOwe//ONYIIBRSEmBjokov854hvmZ0h9BHgWrKeFi0XV9iaTsr5lfylhs6BK
         xJeV/X/e2v91721niSH2XCoXceAmxSgrfLnKabeQCEj7Jh4ARSKnAZkNwP1K8Im9Gc+u
         +lUUEyGEcAmbST1q/kfIami0mYsAzwQeeYMUlkFFMTFwiMxmscvKHz+pbM5A3Bk0ZkHe
         9i8w==
X-Received: by 10.68.143.162 with SMTP id sf2mr27772238pbb.137.1358757654399;
        Mon, 21 Jan 2013 00:40:54 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.53
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:53 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214100>

Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
This is in preparation to unify the append_signoff implementations in
log-tree.c and sequencer.c.

Fixes test in t3511.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/commit.c         |  2 +-
 sequencer.c              | 46 ++++++++++++++++++++++++++++++++++++----------
 sequencer.h              |  2 +-
 t/t3511-cherry-pick-x.sh |  2 +-
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7c2a3d4..081ff66 100644
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
index 163dc12..d4a2ece 100644
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
 	int hit = 0;
 	int i, k;
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
+	int found_sob = 0;
 
 	for (i = len - 1; i > 0; i--) {
 		if (hit && buf[i] == '\n')
@@ -67,14 +75,25 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
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
 
@@ -296,7 +315,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-		append_signoff(msgbuf, 0);
+		append_signoff(msgbuf, 0, 0);
 
 	if (!clean) {
 		int i;
@@ -555,7 +574,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, 0))
+			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
@@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer)
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
 {
 	struct strbuf sob = STRBUF_INIT;
+	int has_footer = 0;
 	int i;
 
 	strbuf_addstr(&sob, sign_off_header);
@@ -1093,10 +1113,16 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
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
1.8.1.1.252.gdb33759
