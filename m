From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] format-patch: Add configuration and off switch for
	--numbered
Date: Sat, 3 Nov 2007 23:38:24 -0400
Message-ID: <20071104033824.GA56097@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 04:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoWJy-0000zh-R9
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 04:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbXKDDi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 23:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbXKDDi1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 23:38:27 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37483 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbXKDDi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 23:38:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id C90001FFC12F
	for <git@vger.kernel.org>; Sun,  4 Nov 2007 03:38:25 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63338>

format.numbered is a tri-state variable.  Boolean values enable or
disable numbering by default and "auto" enables number when outputting
more than one patch.

--no-numbered (short: -N) will disable numbering.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Pick your own numbering adventure.  Should make everyone happy, but
 will probably do the exact opposite.  So it goes.

 Documentation/config.txt           |    6 ++++++
 Documentation/git-format-patch.txt |   12 ++++++++----
 builtin-log.c                      |   19 ++++++++++++++++++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index edf50cd..c2f9f14 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -432,6 +432,12 @@ fetch.unpackLimit::
 	pack from a push can make the push operation complete faster,
 	especially on slow filesystems.
 
+format.numbered::
+	A boolean which can enable sequence numbers in patch subjects.
+	Seting this option to "auto" will enable it only if there is
+	more than one patch.  See --numbered option in
+	gitlink:git-format-patch[1].
+
 format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See gitlink:git-format-patch[1].
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f0617ef..92c0ab6 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--thread]
+'git-format-patch' [-n | -N | -k] [-o <dir> | --stdout] [--thread]
                    [--attach[=<boundary>] | --inline[=<boundary>]]
                    [-s | --signoff] [<common diff options>]
                    [--start-number <n>] [--numbered-files]
@@ -77,6 +77,9 @@ include::diff-options.txt[]
 -n|--numbered::
 	Name output in '[PATCH n/m]' format.
 
+-N|--no-numbered::
+	Name output in '[PATCH]' format.
+
 --start-number <n>::
 	Start numbering the patches at <n> instead of 1.
 
@@ -142,15 +145,16 @@ not add any suffix.
 
 CONFIGURATION
 -------------
-You can specify extra mail header lines to be added to each
-message in the repository configuration.  You can also specify
-new defaults for the subject prefix and file suffix.
+You can specify extra mail header lines to be added to each message
+in the repository configuration, new defaults for the subject prefix
+and file suffix, and number patches when outputting more than one.
 
 ------------
 [format]
         headers = "Organization: git-foo\n"
         subjectprefix = CHANGE
         suffix = .txt
+        numbered = auto
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index e8b982d..22afa1a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -273,6 +273,8 @@ static int istitlechar(char c)
 static char *extra_headers = NULL;
 static int extra_headers_size = 0;
 static const char *fmt_patch_suffix = ".patch";
+static int numbered = 0;
+static int auto_number = 0;
 
 static int git_format_config(const char *var, const char *value)
 {
@@ -297,6 +299,15 @@ static int git_format_config(const char *var, const char *value)
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
+	if (!strcmp(var, "format.numbered")) {
+		if (!strcasecmp(value, "auto")) {
+			auto_number = 1;
+			return 0;
+		}
+
+		numbered = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value);
 }
@@ -466,7 +477,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	int nr = 0, total, i, j;
 	int use_stdout = 0;
-	int numbered = 0;
 	int start_number = -1;
 	int keep_subject = 0;
 	int numbered_files = 0;		/* _just_ numbers */
@@ -503,6 +513,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[i], "-n") ||
 				!strcmp(argv[i], "--numbered"))
 			numbered = 1;
+		else if (!strcmp(argv[i], "-N") ||
+				!strcmp(argv[i], "--no-numbered")) {
+			numbered = 0;
+			auto_number = 0;
+		}
 		else if (!prefixcmp(argv[i], "--start-number="))
 			start_number = strtol(argv[i] + 15, NULL, 10);
 		else if (!strcmp(argv[i], "--numbered-files"))
@@ -642,6 +657,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (!keep_subject && auto_number && total > 1)
+		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
 	rev.add_signoff = add_signoff;
-- 
1.5.3.5.529.ge3d6d-dirty
