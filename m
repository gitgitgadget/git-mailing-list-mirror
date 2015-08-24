From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] builtin/am: introduce write_state_*() helper functions
Date: Mon, 24 Aug 2015 10:09:42 -0700
Message-ID: <1440436186-7894-2-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvG8-0005OO-96
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbbHXRJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:09:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35474 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbbHXRJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:49 -0400
Received: by pacdd16 with SMTP id dd16so101312828pac.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=y6P9OpU45BDMk9N26DxkVS8Oyem8KdiBFdE3uEKc9Fk=;
        b=Mx4dQXzJzLYfo2vxHZvBJThK4mCZFtipZ5lE947Z/1w8cEECHqi+agRI5H6b0UqHmi
         KpSpUwUpKNCfb13oW+x8eJv8Yi9weM0WZQfv1FUHV/zTuMQjagUk+c8Trkbsfc0G94E2
         4COo84WlHdTsNSTyhTjwNbcreyeqZWETXs18HVDgV0BZOhOkmuRC8V8SRKlp+LuelKkw
         x7WNO/UdyGyI48wa2ml6yThP9M2x0txf7Ck/bVQjJhaamanLQkm/SZyxo8bCnBSW8O+i
         rBLiw4elUxQ5YGAbsTKgm0zMp5Wd1W5TYZb5kpXgw/Dzl9zEXMwYTFFye2cSvwtlcXDC
         4mdQ==
X-Received: by 10.66.249.101 with SMTP id yt5mr47329759pac.116.1440436188842;
        Mon, 24 Aug 2015 10:09:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id nt6sm18062132pdb.73.2015.08.24.10.09.48
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276465>

There are many calls to write_file() that repeats the same pattern
in the implementation of the builtin version of "am", and they all
share the same traits, i.e they

 - produce a text file with a single string in it;

 - have enough information to produce the entire contents of that
   file;

 - generate the pathname of the file by making a call to am_path(); and

 - they ask write_file() to die() upon failure.

The slight differences among the call sites throw them into roughly
three variants:

 - many write either "t" or "f" based on a boolean value to a file;

 - some write the integer value in decimal text;

 - some others write more general string, e.g. an object name in
   hex, an empty string (i.e. the presense of the file itself serves
   as a flag), etc.

Introduce three helpers, write_state_bool(), write_state_count() and
write_state_text(), to reduce direct calls to write_file().

This is a preparatory step for the next step to ensure that no
"state" file this command leaves in $GIT_DIR is with an incomplete
line at the end.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 68 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 634f7a7..4d34dc5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -194,6 +194,27 @@ static inline const char *am_path(const struct am_state *state, const char *path
 }
 
 /**
+ * For convenience to call write_file()
+ */
+static int write_state_text(const struct am_state *state,
+			    const char *name, const char *string)
+{
+	return write_file(am_path(state, name), 1, "%s", string);
+}
+
+static int write_state_count(const struct am_state *state,
+			     const char *name, int value)
+{
+	return write_file(am_path(state, name), 1, "%d", value);
+}
+
+static int write_state_bool(const struct am_state *state,
+			    const char *name, int value)
+{
+	return write_state_text(state, name, value ? "t" : "f");
+}
+
+/**
  * If state->quiet is false, calls fprintf(fp, fmt, ...), and appends a newline
  * at the end.
  */
@@ -362,7 +383,7 @@ static void write_author_script(const struct am_state *state)
 	sq_quote_buf(&sb, state->author_date);
 	strbuf_addch(&sb, '\n');
 
-	write_file(am_path(state, "author-script"), 1, "%s", sb.buf);
+	write_state_text(state, "author-script", sb.buf);
 
 	strbuf_release(&sb);
 }
@@ -1000,13 +1021,10 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (state->rebasing)
 		state->threeway = 1;
 
-	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
-
-	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
-
-	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
-
-	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+	write_state_bool(state, "threeway", state->threeway);
+	write_state_bool(state, "quiet", state->quiet);
+	write_state_bool(state, "sign", state->signoff);
+	write_state_bool(state, "utf8", state->utf8);
 
 	switch (state->keep) {
 	case KEEP_FALSE:
@@ -1022,9 +1040,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die("BUG: invalid value for state->keep");
 	}
 
-	write_file(am_path(state, "keep"), 1, "%s", str);
-
-	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+	write_state_text(state, "keep", str);
+	write_state_bool(state, "messageid", state->message_id);
 
 	switch (state->scissors) {
 	case SCISSORS_UNSET:
@@ -1039,24 +1056,23 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	default:
 		die("BUG: invalid value for state->scissors");
 	}
-
-	write_file(am_path(state, "scissors"), 1, "%s", str);
+	write_state_text(state, "scissors", str);
 
 	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
-	write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
+	write_state_text(state, "apply-opt", sb.buf);
 
 	if (state->rebasing)
-		write_file(am_path(state, "rebasing"), 1, "%s", "");
+		write_state_text(state, "rebasing", "");
 	else
-		write_file(am_path(state, "applying"), 1, "%s", "");
+		write_state_text(state, "applying", "");
 
 	if (!get_sha1("HEAD", curr_head)) {
-		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
+		write_state_text(state, "abort-safety", sha1_to_hex(curr_head));
 		if (!state->rebasing)
 			update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
 					UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		write_file(am_path(state, "abort-safety"), 1, "%s", "");
+		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
 			delete_ref("ORIG_HEAD", NULL, 0);
 	}
@@ -1066,9 +1082,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	 * session is in progress, they should be written last.
 	 */
 
-	write_file(am_path(state, "next"), 1, "%d", state->cur);
-
-	write_file(am_path(state, "last"), 1, "%d", state->last);
+	write_state_count(state, "next", state->cur);
+	write_state_count(state, "last", state->last);
 
 	strbuf_release(&sb);
 }
@@ -1101,12 +1116,12 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "original-commit"));
 
 	if (!get_sha1("HEAD", head))
-		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(head));
+		write_state_text(state, "abort-safety", sha1_to_hex(head));
 	else
-		write_file(am_path(state, "abort-safety"), 1, "%s", "");
+		write_state_text(state, "abort-safety", "");
 
 	state->cur++;
-	write_file(am_path(state, "next"), 1, "%d", state->cur);
+	write_state_count(state, "next", state->cur);
 }
 
 /**
@@ -1479,8 +1494,7 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 	write_commit_patch(state, commit);
 
 	hashcpy(state->orig_commit, commit_sha1);
-	write_file(am_path(state, "original-commit"), 1, "%s",
-			sha1_to_hex(commit_sha1));
+	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
 
 	return 0;
 }
@@ -1782,7 +1796,7 @@ static void am_run(struct am_state *state, int resume)
 	refresh_and_write_cache();
 
 	if (index_has_changes(&sb)) {
-		write_file(am_path(state, "dirtyindex"), 1, "t");
+		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
 
-- 
2.5.0-568-g53a3e28
