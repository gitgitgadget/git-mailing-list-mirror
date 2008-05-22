From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add log.date config variable
Date: Thu, 22 May 2008 18:24:07 +0300
Message-ID: <20080522152406.GA20556@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 17:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzCfB-0002jj-Hz
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 17:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYEVPYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYEVPYM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 11:24:12 -0400
Received: from zakalwe.fi ([80.83.5.154]:40915 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYEVPYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 11:24:10 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 1080F2BBF0; Thu, 22 May 2008 18:24:07 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82632>

log.date config variable sets the default date-time mode for the log
command. Setting log.date value is similar to using git log's --date
option.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
Version 2 of the log.date patch. Changes to the first version:

* use log.date instead of format.date

* Do not add the missing rev-list option as it does not logically belong
  to the same commit

 Documentation/config.txt           |    6 ++++++
 Documentation/rev-list-options.txt |    3 ++-
 builtin-log.c                      |   10 ++++++++++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 217980f..e9d9b95 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -815,6 +815,12 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
 
+log.date::
+	Set default date-time mode for the log command. Setting log.date
+	value is similar to using git log's --date option. The value is one of
+	following alternatives: {relative,local,default,iso,rfc,short}.
+	See linkgit:git-log[1].
+
 log.showroot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ce6a101..631e9f4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -16,7 +16,8 @@ include::pretty-options.txt[]
 --date={relative,local,default,iso,rfc}::
 
 	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty".
+	as when using "--pretty". log.date config variable sets a default
+	value for log command's --date option.
 +
 `--date=relative` shows dates relative to the current time,
 e.g. "2 hours ago".
diff --git a/builtin-log.c b/builtin-log.c
index 9d046b2..543855b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -18,6 +18,9 @@
 #include "run-command.h"
 #include "shortlog.h"
 
+/* Set a default date-time format for git log ("log.date" config variable) */
+static const char *default_date_mode = NULL;
+
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
@@ -61,7 +64,12 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+
+	if (default_date_mode)
+		rev->date_mode = parse_date_format(default_date_mode);
+
 	argc = setup_revisions(argc, argv, rev, "HEAD");
+
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
@@ -232,6 +240,8 @@ static int git_log_config(const char *var, const char *value)
 		fmt_patch_subject_prefix = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "log.date"))
+		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
-- 
1.5.4.1
