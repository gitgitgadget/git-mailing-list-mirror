From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 12/45] builtin-am: don't parse mail when resuming
Date: Mon, 20 Jul 2015 00:10:04 +0800
Message-ID: <1437322237-29863-13-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBY-0006Bt-8P
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbGSQLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:23 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34974 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbbGSQLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:19 -0400
Received: by pdrg1 with SMTP id g1so89724569pdr.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tmmVRaiiuTTLPLwBwlBjLW7v/zvBgahmGUhxut+MqP4=;
        b=i6x+5WmUVETes96VMiyD/oyUqYCT1XJzknA8X1ULvjEuGV8XA9R0kQGtYb5P80TW+K
         +33lh8SQC8qrBVhqSTnUq3R0Vwq4p0Ve/KIUsGYwu0EcXIv29sFhCzAwQkasBb8yVa2w
         f4sYo6KDc4QhWSsEWSSXVON2hlDAncNc0gw80iYexBIwrUiKYGKeEBJdVjNwnLNn3Jac
         N6ZOx+noP9JRQPjpu5Wo+EWP1xhTfPCzQx1RBYPPR9WZelY4LrGwLPXzBWXvsnqZjP9t
         pfNpS0gu3tr+SlLX/HE4gBALznqIX2hyUJUzgCDgBOPu8S0povBQWCKyl2Z6g08ofA09
         Ufng==
X-Received: by 10.66.144.40 with SMTP id sj8mr49005346pab.55.1437322278958;
        Sun, 19 Jul 2015 09:11:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274236>

Since 271440e (git-am: make it easier after fixing up an unapplicable
patch., 2005-10-25), when "git am" is run again after being paused, the
current mail message will not be re-parsed, but instead the contents of
the state directory's patch, msg and author-script files will be used
as-is instead.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v6
    
    New patch. A test for this in t4150 would be something like this:
    
    test_expect_success 'do not parse mail when resuming' '
    	rm -fr .git/rebase-apply &&
    	git reset --hard &&
    	git checkout lorem2^^ &&
    	test_must_fail git am lorem-move.patch &&
    	test_path_is_dir .git/rebase-apply &&
    	test_cmp_rev lorem2^^ HEAD &&
    	echo resolved >file &&
    	git diff >.git/rebase-apply/patch &&
    	git reset --hard &&
    	git am <&6 &&
    	test_path_is_missing .git/rebase-apply &&
    	test resolved = "$(cat file)"
    '
    
    However, it relies on stdin being a TTY so I can't add it to the
    more-am-tests patch series :-/

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
2.5.0.rc2.110.gb39b692
