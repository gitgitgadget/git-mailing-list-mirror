From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 32/44] builtin-am: invoke post-rewrite hook
Date: Sun, 28 Jun 2015 22:05:54 +0800
Message-ID: <1435500366-31700-33-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGU-0002qz-QX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbbF1OIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:53 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35277 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbbF1OI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:26 -0400
Received: by pactm7 with SMTP id tm7so91497843pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pvucXlBeVd2vbPL9OU/08zVOq1s4sqCoU7g8V+gmIKU=;
        b=vt7I0tgG4tBIa6bfx4wXQKRUNlPR/b4ySg5u0WoPZ4QiVM8RF0T0GqcDacxwEkeNYz
         wemUlMOiX89CgG7JAeayTflvdoCrBEixG8J1nk6ZG/wUKdAzUbGPrlhQBS27Mg8MFOAW
         Ux8dTORXFyXpx88IlNAMU7tw7IjZAx1hTNlG04+aawfZWOnSL9Sk756TseBvlQu0yIsW
         88Le1Zx0ucaY+i0wytDGJc6F6ejWSc7drvbSJu6MExMQF7V3cEvuAD/l1N8Tuxn6fYlJ
         EVuYb/NEk9XCgXeRTq5GTWv8PtD7pceznWE4L2MDO/rZI+uD1EYnVN4OBoGe8eMC5e3z
         n6HQ==
X-Received: by 10.66.161.135 with SMTP id xs7mr22992047pab.154.1435500505985;
        Sun, 28 Jun 2015 07:08:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272908>

Since 96e1948 (rebase: invoke post-rewrite hook, 2010-03-12), git-am.sh
will invoke the post-rewrite hook after it successfully finishes
applying all the queued patches.

To do this, when parsing a mail to extract its patch and metadata, in
--rebasing mode git-am.sh will also store the original commit ID in the
$state_dir/original-commit file. Once it applies and commits the patch,
the original commit ID, and the new commit ID, will be appended to the
$state_dir/rewritten file.

Once all of the queued mail have been processed, git-am.sh will then
invoke the post-rewrite hook with the contents of the
$state_dir/rewritten file.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index d44f5e2..27b79f7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -95,6 +95,9 @@ struct am_state {
 	char *msg;
 	size_t msg_len;
 
+	/* when --rebasing, records the original commit the patch came from */
+	unsigned char orig_commit[GIT_SHA1_RAWSZ];
+
 	/* number of digits in patch filename */
 	int prec;
 
@@ -432,6 +435,11 @@ static void am_load(struct am_state *state)
 
 	read_commit_msg(state);
 
+	if (read_state_file(&sb, state, "original-commit", 1) < 0)
+		hashclr(state->orig_commit);
+	else if (get_sha1_hex(sb.buf, state->orig_commit) < 0)
+		die(_("could not parse %s"), am_path(state, "original-commit"));
+
 	read_state_file(&sb, state, "threeway", 1);
 	state->threeway = !strcmp(sb.buf, "t");
 
@@ -487,6 +495,30 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Runs post-rewrite hook. Returns it exit code.
+ */
+static int run_post_rewrite_hook(const struct am_state *state)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *hook = find_hook("post-rewrite");
+	int ret;
+
+	if (!hook)
+		return 0;
+
+	argv_array_push(&cp.args, hook);
+	argv_array_push(&cp.args, "rebase");
+
+	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
+	cp.stdout_to_stderr = 1;
+
+	ret = run_command(&cp);
+
+	close(cp.in);
+	return ret;
+}
+
+/**
  * Determines if the file looks like a piece of RFC2822 mail by grabbing all
  * non-indented lines and checking if they look like they begin with valid
  * header field names.
@@ -764,6 +796,9 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "author-script"));
 	unlink(am_path(state, "final-commit"));
 
+	hashclr(state->orig_commit);
+	unlink(am_path(state, "original-commit"));
+
 	if (!get_sha1("HEAD", head))
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(head));
 	else
@@ -1083,6 +1118,8 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
  * directly. This is used in --rebasing mode to bypass git-mailinfo's munging
  * of patches.
  *
+ * state->orig_commit will be set to the original commit ID.
+ *
  * Will always return 0 as the patch should never be skipped.
  */
 static int parse_mail_rebase(struct am_state *state, const char *mail)
@@ -1099,6 +1136,10 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 
 	write_commit_patch(state, commit);
 
+	hashcpy(state->orig_commit, commit_sha1);
+	write_file(am_path(state, "original-commit"), 1, "%s",
+			sha1_to_hex(commit_sha1));
+
 	return 0;
 }
 
@@ -1290,6 +1331,15 @@ static void do_commit(const struct am_state *state)
 
 	update_ref(sb.buf, "HEAD", commit, ptr, 0, UPDATE_REFS_DIE_ON_ERR);
 
+	if (state->rebasing) {
+		FILE *fp = xfopen(am_path(state, "rewritten"), "a");
+
+		assert(!is_null_sha1(state->orig_commit));
+		fprintf(fp, "%s ", sha1_to_hex(state->orig_commit));
+		fprintf(fp, "%s\n", sha1_to_hex(commit));
+		fclose(fp);
+	}
+
 	strbuf_release(&sb);
 }
 
@@ -1372,6 +1422,11 @@ next:
 		am_next(state);
 	}
 
+	if (!is_empty_file(am_path(state, "rewritten"))) {
+		assert(state->rebasing);
+		run_post_rewrite_hook(state);
+	}
+
 	/*
 	 * In rebasing mode, it's up to the caller to take care of
 	 * housekeeping.
-- 
2.5.0.rc0.76.gb2c6e93
