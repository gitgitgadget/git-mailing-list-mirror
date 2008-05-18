From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add format.date config variable
Date: Sun, 18 May 2008 20:13:06 +0300
Message-ID: <20080518171306.GA12948@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 19:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxmSp-00086j-RE
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 19:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbYERRNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbYERRNP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 13:13:15 -0400
Received: from zakalwe.fi ([80.83.5.154]:51594 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbYERRNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 13:13:14 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 04A2E2BBE5; Sun, 18 May 2008 20:13:07 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82393>

format.date config variable sets the default date-time mode for the log
command. Setting format.date value is similar to using git log's --date
option.

Also, add missing "short" alternative to --date in rev-list-options.txt.
---
I wanted to read all the logs in ISO 8601 time format so I decided to 
implement this option.

 Documentation/config.txt           |    6 ++++++
 Documentation/rev-list-options.txt |    5 +++--
 builtin-log.c                      |   10 ++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 217980f..ddc68bd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -573,6 +573,12 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+format.date::
+	Set default date-time mode for the log command. Setting format.date
+	value is similar to using git log's --date option. The value is one of
+	following alternatives: {relative,local,default,iso,rfc,short}.
+	See linkgit:git-log[1].
+
 format.numbered::
 	A boolean which can enable sequence numbers in patch subjects.
 	Setting this option to "auto" will enable it only if there is
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2648a55..3d47dc9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,10 +13,11 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc}::
+--date={relative,local,default,iso,rfc,short}::
 
 	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty".
+	as when using "--pretty". format.date config variable sets a default
+	value for log command's --date option.
 +
 `--date=relative` shows dates relative to the current time,
 e.g. "2 hours ago".
diff --git a/builtin-log.c b/builtin-log.c
index 9d046b2..d3ff8f6 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -18,6 +18,9 @@
 #include "run-command.h"
 #include "shortlog.h"
 
+/* Set a default date-time format for git log */
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
@@ -224,6 +232,8 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "format.date"))
+		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix")) {
-- 
1.5.4.4
