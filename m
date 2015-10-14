From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 31/31] am: make direct call to mailinfo
Date: Wed, 14 Oct 2015 13:45:57 -0700
Message-ID: <1444855557-2127-32-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwn-0001mB-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbbJNUqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35864 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbbJNUqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:42 -0400
Received: by pabws5 with SMTP id ws5so157496pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=auv3dKnHmVdX2UqrhrESupD6DDeSMur4GG8k16il45M=;
        b=Cu3D9KerLxFSmsnTcF6FaaiEXmU5cFNfRFKAVYwoGiWyNME5ehmhjjBOh1rehkZfNP
         qcA9izOu2xV2TPhXwYhisMgUr9FYitoUyzC1n2kUf2iXbfccrCDWf4z5BVw2UWSDp18J
         VVHplxJ15sK+jJRHTllVRoGiC22GNwXGxYwNIoFpJ0aWENWhCgq+ucIOuItF4Wq8QMzF
         uCccIYHv6ai/4JIzI2uIAGMMxsiNtwMlp8jgaECC0/NK8GPFmSt4MhoRdjYquH0MbO83
         lGMW0LarUrZkQrS/ANgYT2jrAbsyhhypHn4fjYjslAR5NozWDYzPkfFZJjcZm77bgu6J
         Uv3g==
X-Received: by 10.67.30.136 with SMTP id ke8mr5820434pad.16.1444855601978;
        Wed, 14 Oct 2015 13:46:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id uc1sm11333747pab.20.2015.10.14.13.46.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:41 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279599>

And finally the endgame.  Instead of spawning "git mailinfo" via the
run_command() API the same number of times as there are incoming
patches, make direct internal call to the libified mailinfo() from
"git am" to reduce the spawning overhead, which would matter on some
platforms.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..1873307 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -27,6 +27,7 @@
 #include "notes-utils.h"
 #include "rerere.h"
 #include "prompt.h"
+#include "mailinfo.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1258,58 +1259,61 @@ static void am_append_signoff(struct am_state *state)
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
-
-	if (run_command(&cp) < 0)
+	mi.input = fopen(mail, "r");
+	if (!mi.input)
+		die("could not open input");
+	mi.output = fopen(am_path(state, "info"), "w");
+	if (!mi.output)
+		die("could not open output 'info'");
+	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
 		die("could not parse patch");
 
-	close(cp.in);
-	close(cp.out);
+	fclose(mi.input);
+	fclose(mi.output);
 
 	/* Extract message and author information */
 	fp = xfopen(am_path(state, "info"), "r");
@@ -1341,8 +1345,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	strbuf_addstr(&msg, "\n\n");
-	if (strbuf_read_file(&msg, am_path(state, "msg"), 0) < 0)
-		die_errno(_("could not read '%s'"), am_path(state, "msg"));
+	strbuf_addbuf(&msg, &mi.log_message);
 	stripspace(&msg, 0);
 
 	if (state->signoff)
@@ -1366,6 +1369,7 @@ finish:
 	strbuf_release(&author_email);
 	strbuf_release(&author_name);
 	strbuf_release(&sb);
+	clear_mailinfo(&mi);
 	return ret;
 }
 
-- 
2.6.1-320-g86a1181
