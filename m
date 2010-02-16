From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add 'git format-patch --to=' option and 'format.to'
 configuration variable.
Date: Wed, 17 Feb 2010 12:39:34 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171238310.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX8g-0001Zg-IT
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623Ab0BPXr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:47:27 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:40117 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933612Ab0BPXrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:47:25 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id B6B56170AF6
	for <git@vger.kernel.org>; Wed, 17 Feb 2010 12:47:20 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140178>

Has the same functionality as the '--cc' option and 'format.cc'
configuration variable but for the "To:" email header.  Half of the code to
support this was already there.

With email the To: header usually more important than the Cc: header.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/git-format-patch.txt |   11 ++++++++---
 builtin-log.c                      |   16 ++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f1fd0df..e936d71 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix]
-		   [--cc=<email>]
+		   [--to=<email>] [--cc=<email>]
 		   [--cover-letter]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -162,6 +162,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
+--to=<email>::
+	Add a `To:` header to the email headers. This is in addition
+	to any configured headers, and may be used multiple times.
+
 --cc=<email>::
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
@@ -202,8 +206,8 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
 defaults for the subject prefix and file suffix, number patches when
-outputting more than one patch, add "Cc:" headers, configure attachments,
-and sign off patches with configuration variables.
+outputting more than one patch, add "To" or "Cc:" headers, configure
+attachments, and sign off patches with configuration variables.
 
 ------------
 [format]
@@ -211,6 +215,7 @@ and sign off patches with configuration variables.
 	subjectprefix = CHANGE
 	suffix = .txt
 	numbered = auto
+	to = <email>
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signoff = true
diff --git a/builtin-log.c b/builtin-log.c
index 41b6df4..89f8d60 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -501,6 +501,13 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.suffix"))
 		return git_config_string(&fmt_patch_suffix, var, value);
+	if (!strcmp(var, "format.to")) {
+		if (!value)
+			return config_error_nonbool(var);
+		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
+		extra_to[extra_to_nr++] = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -872,6 +879,13 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int to_callback(const struct option *opt, const char *arg, int unset)
+{
+	ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
+	extra_to[extra_to_nr++] = xstrdup(arg);
+	return 0;
+}
+
 static int cc_callback(const struct option *opt, const char *arg, int unset)
 {
 	ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
@@ -936,6 +950,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
 			    "add email header", PARSE_OPT_NONEG,
 			    header_callback },
+		{ OPTION_CALLBACK, 0, "to", NULL, "email", "add To: header",
+			    PARSE_OPT_NONEG, to_callback },
 		{ OPTION_CALLBACK, 0, "cc", NULL, "email", "add Cc: header",
 			    PARSE_OPT_NONEG, cc_callback },
 		OPT_STRING(0, "in-reply-to", &in_reply_to, "message-id",
-- 
1.6.6
