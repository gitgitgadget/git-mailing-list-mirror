From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 3/3] am: let --signoff override --no-signoff
Date: Tue,  4 Aug 2015 22:08:51 +0800
Message-ID: <1438697331-29948-4-git-send-email-pyokagan@gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
 <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:09:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcu8-0001T1-1U
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934391AbbHDOJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:09:10 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32841 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241AbbHDOJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:09:08 -0400
Received: by pdbnt7 with SMTP id nt7so4974245pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=251aED9lq70t/ASx/LPpUEqWvlrJDMhBSYYW95axlwE=;
        b=rY/Y5K6DvkyANvC9L4UiJsB0415u1bB8vHfgHjnwUrgQLttoqzaKfejTq6oSj6LrAS
         tXWkKsNuwOhKiEVAzW7PpT0TaLK4VeRqcU5TFtaTxT3CL4g3b88iaGUtQfzaAs4UQPts
         bKCPbKTgYL5QELc1dFLa0NFWxgwZRLiCftmpuWrjcksqo2S0R5mD/KQtCtOzy0bQw/hp
         9juheRJ9esSYeJyJXF6UoHYTIChCHCHfP6IcGSHUbLveioEOnJlRGSBXIF5/ar6m0NLj
         nUEY92y8V3PIhwzhBvb8J+f7aBp/d+lydZ/XITnomZAmpmzP/LQZnQlil9HqU5b86n90
         9O6g==
X-Received: by 10.70.54.103 with SMTP id i7mr8210096pdp.97.1438697347894;
        Tue, 04 Aug 2015 07:09:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id qc9sm561141pab.18.2015.08.04.07.09.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:09:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275325>

After resolving a conflicting patch, a user may wish to sign off the
patch to declare that the patch has been modified. As such, the user
will expect that running "git am --signoff --continue" will append the
signoff to the commit message.

However, the --signoff option is only taken into account during the
mail-parsing stage. If the --signoff option is set, then the signoff
will be appended to the commit message. Since the mail-parsing stage
comes before the patch application stage, the --signoff option, if
provided on the command-line when resuming, will have no effect at all.

We cannot move the append_signoff() call to the patch application stage
as the applypatch-msg hook and interactive mode, which run before patch
application, may expect the signoff to be there.

Fix this by taking note if the user explictly set the --signoff option
on the command-line, and append the signoff to the commit message when
resuming if so.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c                       | 28 +++++++++++++++++++++++++---
 t/t4153-am-resume-override-opts.sh | 20 ++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0961304..8c95aec 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,6 +98,12 @@ enum scissors_type {
 	SCISSORS_TRUE        /* pass --scissors to git-mailinfo */
 };
 
+enum signoff_type {
+	SIGNOFF_FALSE = 0,
+	SIGNOFF_TRUE = 1,
+	SIGNOFF_EXPLICIT /* --signoff was set on the command-line */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -123,7 +129,7 @@ struct am_state {
 	int interactive;
 	int threeway;
 	int quiet;
-	int signoff;
+	int signoff; /* enum signoff_type */
 	int utf8;
 	int keep; /* enum keep_type */
 	int message_id;
@@ -1184,6 +1190,18 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 }
 
 /**
+ * Appends signoff to the "msg" field of the am_state.
+ */
+static void am_append_signoff(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+	append_signoff(&sb, 0, 0);
+	state->msg = strbuf_detach(&sb, &state->msg_len);
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -2151,8 +2169,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
-		OPT_BOOL('s', "signoff", &state.signoff,
-			N_("add a Signed-off-by line to the commit message")),
+		OPT_SET_INT('s', "signoff", &state.signoff,
+			N_("add a Signed-off-by line to the commit message"),
+			SIGNOFF_EXPLICIT),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
 		OPT_SET_INT('k', "keep", &state.keep,
@@ -2265,6 +2284,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 		if (resume == RESUME_FALSE)
 			resume = RESUME_APPLY;
+
+		if (state.signoff == SIGNOFF_EXPLICIT)
+			am_append_signoff(&state);
 	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 39fac79..7c013d8 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -64,6 +64,26 @@ test_expect_success '--no-quiet overrides --quiet' '
 	test_i18ncmp expected out
 '
 
+test_expect_success '--signoff overrides --no-signoff' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+
+	test_must_fail git am --no-signoff side[12].eml &&
+	test_path_is_dir .git/rebase-apply &&
+	echo side1 >file &&
+	git add file &&
+	git am --signoff --continue &&
+
+	# Applied side1 will be signed off
+	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
+	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual &&
+
+	# Applied side2 will not be signed off
+	test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
+'
+
 test_expect_success TTY '--reject overrides --no-reject' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.280.gd88bd6e
