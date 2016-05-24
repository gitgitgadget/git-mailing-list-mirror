From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 38/49] builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:15 +0200
Message-ID: <20160524081126.16973-39-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Sm-00018M-EF
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbcEXINE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36564 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbcEXIMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id q62so3640592wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZ3at0cCtrGd1QfpXxrBwFwUChZpg3kJ2nKsKfTnQbc=;
        b=adSYpSVTAiYXuImo1SulKwB/wpnWkUTW9OnfIVpzZfWS1aDGTqWT3WEj15bhQ8quAc
         m9VeaDbKSCRcdNBs5tSqN3vobXGKZsl90bKYZ47Y15CO8zG4Qe+2tvDAEmQrIXR6z72R
         JDo67v/fRK1B/kk9PYR0sh3Rrpa2BlOqCxJRjBvX023RcbDq+//s3HiMktfHxJrThNCB
         8o5rzPSj4TlOX7unfxKgfWQ2JGoak+iJlWXxMOubC+XokEDYK0qTUEaderUhv0vRmOy7
         Febr0pSFbHHjbgnagm5rAeU5Uv6dpPKQ5LsZ9TuYS8fqWRE1TEkczXINGJsgM9VgZf93
         EEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZ3at0cCtrGd1QfpXxrBwFwUChZpg3kJ2nKsKfTnQbc=;
        b=cq+OoCVy9EMpf4v7GTaEJx0WwHeMmPO0qsPsqzrl/dGHwb0gqy8twSNwIbMz/k482X
         yb+2jkYHSlMLwTd5XTCHutd2LTwg/wWCjaOUcoVy4+cwNIx6Nkbd5cO14rTv7E5BrxPj
         HwYbO6PscDqsBzgvVeI04k3L7IJX08+pVmtlrFexXaXZAPltT0tdWgr4VHaoHMFve4NK
         TU5/9XIlUv+TmdRjR9E9NvYhG3Tj3o4zEsOuQU5OHsrwes+ZjYEqXXZldGq02zrUOQnY
         NrkpwF0nNlCnb0oo4rWKaYRkSSNrrmjjzFNZZX5W86Rwybg8z/780wrCH7u3O8d+70fO
         qleQ==
X-Gm-Message-State: AOPr4FV8Zgc/vQsAnAAILcDpNAV5XWsJHO1YcblNu1JRqRCFOkpMXclLRxTfIs6mDPFrmw==
X-Received: by 10.28.15.79 with SMTP id 76mr22283946wmp.53.1464077558221;
        Tue, 24 May 2016 01:12:38 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:37 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295445>

To libify the apply functionality the 'squelch_whitespace_errors' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 523ed74..619b8fb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -63,6 +63,7 @@ struct apply_state {
 	/* These control whitespace errors */
 	const char *whitespace_option;
 	int whitespace_error;
+	int squelch_whitespace_errors;
 };
 
 static int newfd = -1;
@@ -78,7 +79,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
 static enum ws_ignore {
@@ -87,7 +87,7 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static void parse_whitespace_option(const char *option)
+static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		ws_error_action = warn_on_ws_error;
@@ -107,7 +107,7 @@ static void parse_whitespace_option(const char *option)
 	}
 	if (!strcmp(option, "error-all")) {
 		ws_error_action = die_on_ws_error;
-		squelch_whitespace_errors = 0;
+		state->squelch_whitespace_errors = 0;
 		return;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
@@ -1599,8 +1599,8 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	state->whitespace_error++;
-	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < state->whitespace_error)
+	if (state->squelch_whitespace_errors &&
+	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -4620,9 +4620,8 @@ static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
-
 	state->whitespace_option = arg;
-	parse_whitespace_option(arg);
+	parse_whitespace_option(state, arg);
 	return 0;
 }
 
@@ -4645,11 +4644,12 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->line_termination = '\n';
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
-		parse_whitespace_option(apply_default_whitespace);
+		parse_whitespace_option(state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 }
@@ -4792,10 +4792,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-		if (squelch_whitespace_errors &&
-		    squelch_whitespace_errors < state.whitespace_error) {
+		if (state.squelch_whitespace_errors &&
+		    state.squelch_whitespace_errors < state.whitespace_error) {
 			int squelched =
-				state.whitespace_error - squelch_whitespace_errors;
+				state.whitespace_error - state.squelch_whitespace_errors;
 			warning(Q_("squelched %d whitespace error",
 				   "squelched %d whitespace errors",
 				   squelched),
-- 
2.8.3.443.gaeee61e
