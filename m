From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/7] diff_opt: track whether flags have been set explicitly
Date: Fri, 10 May 2013 17:10:11 +0200
Message-ID: <88fb8906050411d0fe8b56cea160a4bfa1abb699.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaoz1-0006zX-7z
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab3EJPLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51670 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753805Ab3EJPLd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:33 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 20F5220ACF;
	Fri, 10 May 2013 11:11:29 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 10 May 2013 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=AS
	ReQgVU5JA0YfdN5eWagmCosPQ=; b=Rk3Yc49TnVLRjHSKYwivkbn85FFyj3FWbm
	XQaAQupMCWRBGEYKm440QoR2Bq7uorcWh/nIfy9UV7SlQJDBUMFbXQpS9xdooEe5
	Hqn3hIOV5wc0+6oSefnN/WmCeReav8A9mEFjYl5NAfZzZrO9DmvYqU2Ek9z5B6Ua
	nHjECxgmY=
X-Sasl-enc: NRuUDj1nMvMqd8cFSnv3IwaS9qYrSCMg5UzEVfE41Cx9 1368198689
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 67D35C80013;
	Fri, 10 May 2013 11:11:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223867>

From: Junio C Hamano <gitster@pobox.com>

The diff_opt infrastructure sets flags based on defaults and command
line options. Currently, it is impossible to detect whether a flag has
been set as a default or on explicit request.

Amend the structure so that this detection is possible:

 * There is an extra "opt->touched_flags" that keeps track of all
   the fields that have been touched by DIFF_OPT_SET and
   DIFF_OPT_CLR;

 * You may continue setting the default values to the flags, like
   commands in the "log" family do in cmd_log_init_defaults(), but
   after you finished setting the defaults, you clear the
   touched_flags field;

 * And then you let the usual callchain call diff_opt_parse(),
   allowing the opt->flags be set or unset, while keeping track of
   which bits the user touched;

 * There is an optional callback "opt->set_default" that is called
   at the very beginning to lets you inspect touched_flags and
   update opt->flags appropriately, before the remainder of the
   diffcore machinery is set up, taking the opt->flags value into
   account.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/api-diff.txt | 10 +++++++++-
 builtin/log.c                        |  1 +
 diff.c                               |  3 +++
 diff.h                               |  8 ++++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 2d2ebc0..8b001de 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -28,7 +28,8 @@ Calling sequence
 
 * Call `diff_setup_done()`; this inspects the options set up so far for
   internal consistency and make necessary tweaking to it (e.g. if
-  textual patch output was asked, recursive behaviour is turned on).
+  textual patch output was asked, recursive behaviour is turned on);
+  the callback set_default in diff_options can be used to tweak this more.
 
 * As you find different pairs of files, call `diff_change()` to feed
   modified files, `diff_addremove()` to feed created or deleted files,
@@ -115,6 +116,13 @@ Notable members are:
 	operation, but some do not have anything to do with the diffcore
 	library.
 
+`touched_flags`::
+	Records whether a flag has been changed due to user request
+	(rather than just set/unset by default).
+
+`set_default`::
+	Callback which allows tweaking the options in diff_setup_done().
+
 BINARY, TEXT;;
 	Affects the way how a file that is seemingly binary is treated.
 
diff --git a/builtin/log.c b/builtin/log.c
index 9e21232..f19d779 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -111,6 +111,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
+	rev->diffopt.touched_flags = 0;
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff.c b/diff.c
index f0b3e7c..7c24872 100644
--- a/diff.c
+++ b/diff.c
@@ -3213,6 +3213,9 @@ void diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
 
+	if (options->set_default)
+		options->set_default(options);
+
 	if (options->output_format & DIFF_FORMAT_NAME)
 		count++;
 	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
diff --git a/diff.h b/diff.h
index 78b4091..e995ae1 100644
--- a/diff.h
+++ b/diff.h
@@ -87,8 +87,9 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
+#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
@@ -109,6 +110,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	unsigned touched_flags;
 	int use_color;
 	int context;
 	int interhunkcontext;
@@ -145,6 +147,8 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	void (*set_default)(struct diff_options *);
+
 	FILE *file;
 	int close_file;
 
-- 
1.8.3.rc1.406.gf4dce7e
