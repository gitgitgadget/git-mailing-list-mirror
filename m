From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 28/26] am: make direct call to mailinfo
Date: Tue, 13 Oct 2015 18:46:06 -0700
Message-ID: <xmqqsi5e8boh.fsf_-_@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-20-git-send-email-gitster@pobox.com>
	<xmqq4mhu9qmn.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 03:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmB8w-0002mS-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 03:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbbJNBqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 21:46:11 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33929 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbbJNBqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 21:46:08 -0400
Received: by pabws5 with SMTP id ws5so6945704pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6COdzUa5rpxJsYiSKVkfoa/eVUf4ThhqIczuTBJgwz4=;
        b=ZR+78DH5LbLRHsgpyXUua3Z/M7q9eAdTWu2P/MwFsPyQAAGkWfOQ49aP3g8ZMwm3Wz
         kg27aaGzzVDkOz0xS8QnrRDsJ6QbJ7R0il/d3aGuKuH2qN2PEfxMkJTlNGds66clM1Ub
         +tKdcPTaQg3d+6aGzGuwDo4g38tBHzkfNeSF6RCR0yjgyH9h7BOYn38xFzCDZ0pj/62s
         bNUjGnlFYNDGNUm98rgWpXmu8Mymlx6Kj3HjfoP6KymiqAMXcn6LWQAFt7/6ljHLv8Qm
         6NVhq4MEO2Cg29I2B1rRh4ZItVa9wimPeS/eq7sKAZnahaoi7egBb7m0ddH30cgNAYjD
         2OEQ==
X-Received: by 10.68.223.34 with SMTP id qr2mr672470pbc.97.1444787168275;
        Tue, 13 Oct 2015 18:46:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id st5sm6202499pab.42.2015.10.13.18.46.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 18:46:07 -0700 (PDT)
In-Reply-To: <xmqq4mhu9qmn.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Tue, 13 Oct 2015 18:37:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279560>

And finally the endgame.  Instead of spawning "git mailinfo" via the
run_command() API the same number of times as there are incoming
patches, make direct internal call to the libified mailinfo() from
"git am" to reduce the spawning overhead, which would matter on some
platforms.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This is to be applied on top of a merge across

  - jc/am-3-fallback-regression-fix
  - jc/mailinfo-lib (i.e. the 27-patch series)

 As I do not have ready access to such a platform with slow
 run_command(), it would be nice to see some numbers produced on
 such platform by other people.

 Thanks.

 builtin/am.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c869796..0471355 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -27,6 +27,7 @@
 #include "notes-utils.h"
 #include "rerere.h"
 #include "prompt.h"
+#include "mailinfo.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1258,58 +1259,57 @@ static void am_append_signoff(struct am_state *state)
 static int parse_mail(struct am_state *state, const char *mail)
 {
 	FILE *fp;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf author_name = STRBUF_INIT;
 	struct strbuf author_date = STRBUF_INIT;
 	struct strbuf author_email = STRBUF_INIT;
 	int ret = 0;
+	struct mailinfo mi;
 
-	cp.git_cmd = 1;
-	cp.in = xopen(mail, O_RDONLY, 0);
-	cp.out = xopen(am_path(state, "info"), O_WRONLY | O_CREAT, 0777);
+	setup_mailinfo(&mi);
 
-	argv_array_push(&cp.args, "mailinfo");
-	argv_array_push(&cp.args, state->utf8 ? "-u" : "-n");
+	if (state->utf8)
+		mi.metainfo_charset = get_commit_output_encoding();
+	else
+		mi.metainfo_charset = NULL;
 
 	switch (state->keep) {
 	case KEEP_FALSE:
 		break;
 	case KEEP_TRUE:
-		argv_array_push(&cp.args, "-k");
+		mi.keep_subject = 1;
 		break;
 	case KEEP_NON_PATCH:
-		argv_array_push(&cp.args, "-b");
+		mi.keep_non_patch_brackets_in_subject = 1;
 		break;
 	default:
 		die("BUG: invalid value for state->keep");
 	}
-
 	if (state->message_id)
-		argv_array_push(&cp.args, "-m");
+		mi.add_message_id = 1;
 
 	switch (state->scissors) {
 	case SCISSORS_UNSET:
 		break;
 	case SCISSORS_FALSE:
-		argv_array_push(&cp.args, "--no-scissors");
+		mi.use_scissors = 0;
 		break;
 	case SCISSORS_TRUE:
-		argv_array_push(&cp.args, "--scissors");
+		mi.use_scissors = 1;
 		break;
 	default:
 		die("BUG: invalid value for state->scissors");
 	}
 
-	argv_array_push(&cp.args, am_path(state, "msg"));
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	mi.input = fopen(mail, "r");
+	mi.output = fopen(am_path(state, "info"), "w");
 
-	if (run_command(&cp) < 0)
+	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
 		die("could not parse patch");
 
-	close(cp.in);
-	close(cp.out);
+	fclose(mi.input);
+	fclose(mi.output);
 
 	/* Extract message and author information */
 	fp = xfopen(am_path(state, "info"), "r");
@@ -1341,8 +1341,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	strbuf_addstr(&msg, "\n\n");
-	if (strbuf_read_file(&msg, am_path(state, "msg"), 0) < 0)
-		die_errno(_("could not read '%s'"), am_path(state, "msg"));
+	strbuf_addbuf(&msg, &mi.log_message);
 	stripspace(&msg, 0);
 
 	if (state->signoff)
@@ -1366,6 +1365,7 @@ finish:
 	strbuf_release(&author_email);
 	strbuf_release(&author_name);
 	strbuf_release(&sb);
+	clear_mailinfo(&mi);
 	return ret;
 }
 
-- 
2.6.1-320-g86a1181
