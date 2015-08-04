From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 12/45] builtin-am: don't parse mail when resuming
Date: Tue,  4 Aug 2015 21:51:33 +0800
Message-ID: <1438696326-19590-13-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcew-0002IR-2P
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbbHDNxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:30 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36223 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbbHDNx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:28 -0400
Received: by pacgq8 with SMTP id gq8so9167639pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zApJ6anOuvTJS16VNpH5c6qmLCnLZbK5uR+sdGouyI=;
        b=FpNAxhNfrUjDpItlFrhKWMbhEFhlSKDpgexTRpF+rKby8mtjr3OJVP3+LpCwbZ/TNK
         311fNZXQ5A9tSKKLwXpxFkBBjke/kLnv7TmRMxOwIKHydw3VK5ZUrCwMNY8i96f6Yp/j
         CKqp44whWjOkv20fP10VNer3eGhfiXGHoiqH8OYCW7jswgz6Yw79iAHdJfokeDrwSiZW
         KQopXhfurxw5ZYreNB/bx/iI0rj1sUyBGKmqXdt/kN83LLNJChfIxXHLS3RxFmGg/4AA
         6o0DnGkX9PQwNLAX+PiuvsqGZqiO331reyhlr/nSRuf3MDnaltMzzXX6qsqI/VPE5Z2Y
         xqUQ==
X-Received: by 10.68.203.195 with SMTP id ks3mr7968475pbc.123.1438696408390;
        Tue, 04 Aug 2015 06:53:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275278>

Since 271440e (git-am: make it easier after fixing up an unapplicable
patch., 2005-10-25), when "git am" is run again after being paused, the
current mail message will not be re-parsed, but instead the contents of
the state directory's patch, msg and author-script files will be used
as-is instead.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index fd26721..ec579a6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -776,8 +776,12 @@ static void validate_resume_state(const struct am_state *state)
 
 /**
  * Applies all queued mail.
+ *
+ * If `resume` is true, we are "resuming". The "msg" and authorship fields, as
+ * well as the state directory's "patch" file is used as-is for applying the
+ * patch and committing it.
  */
-static void am_run(struct am_state *state)
+static void am_run(struct am_state *state, int resume)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	struct strbuf sb = STRBUF_INIT;
@@ -795,11 +799,16 @@ static void am_run(struct am_state *state)
 		if (!file_exists(mail))
 			goto next;
 
-		if (parse_mail(state, mail))
-			goto next; /* mail should be skipped */
+		if (resume) {
+			validate_resume_state(state);
+			resume = 0;
+		} else {
+			if (parse_mail(state, mail))
+				goto next; /* mail should be skipped */
 
-		write_author_script(state);
-		write_commit_msg(state);
+			write_author_script(state);
+			write_commit_msg(state);
+		}
 
 		printf_ln(_("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -855,7 +864,7 @@ static void am_resolve(struct am_state *state)
 	do_commit(state);
 
 	am_next(state);
-	am_run(state);
+	am_run(state, 0);
 }
 
 /**
@@ -875,6 +884,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
+	RESUME_APPLY,
 	RESUME_RESOLVED
 };
 
@@ -927,9 +937,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-	if (am_in_progress(&state))
+	if (am_in_progress(&state)) {
+		if (resume == RESUME_FALSE)
+			resume = RESUME_APPLY;
+
 		am_load(&state);
-	else {
+	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
@@ -950,7 +963,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	switch (resume) {
 	case RESUME_FALSE:
-		am_run(&state);
+		am_run(&state, 0);
+		break;
+	case RESUME_APPLY:
+		am_run(&state, 1);
 		break;
 	case RESUME_RESOLVED:
 		am_resolve(&state);
-- 
2.5.0.280.gd88bd6e
