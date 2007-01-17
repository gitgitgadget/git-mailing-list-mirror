From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 11:18:13 -0800
Message-ID: <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 17 20:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GIe-0007Gh-6o
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbXAQTSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbXAQTSP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:18:15 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:44547 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648AbXAQTSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:18:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117191814.HQG25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 14:18:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CKJW1W01g1kojtg0000000; Wed, 17 Jan 2007 14:18:31 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 17 Jan 2007 14:49:50 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37025>

The default can also be changed with "format.suffix" configuration.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

  > Why not
  >
  > 	static const char *file_extension = ".txt"
  >
  > Hmm?

  Let's do this instead.  By the way, there is a bug in the
  configuration parsing for format.headers from commit 20ff0680,
  which needs to be check NULLness of the value the same way as
  this one deals with format.suffix, which I've already fixed in
  my tree.

 Documentation/git-format-patch.txt |   13 ++++++++++++-
 builtin-log.c                      |   19 ++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 67425dc..34abd2f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
-		   [--in-reply-to=Message-Id]
+		   [--in-reply-to=Message-Id] [--suffix=<sfx>]
 		   <since>[..<until>]
 
 DESCRIPTION
@@ -78,6 +78,12 @@ OPTIONS
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
 
+--suffix=<sfx>::
+	Instead of using `txt` as the suffix for generated
+	filenames, use specifed suffix.  A common alternative is
+	`--suffix=patch`.
+
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
@@ -86,6 +92,11 @@ message in the repository configuration as follows:
 [format]
         headers = "Organization: git-foo\n"
 
+You can specify default suffix used:
+
+[format]
+        suffix = patch
+
 
 EXAMPLES
 --------
diff --git a/builtin-log.c b/builtin-log.c
index a59b4ac..04e3144 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -197,6 +197,7 @@ static int istitlechar(char c)
 
 static char *extra_headers = NULL;
 static int extra_headers_size = 0;
+static const char *fmt_patch_suffix = "txt";
 
 static int git_format_config(const char *var, const char *value)
 {
@@ -208,6 +209,12 @@ static int git_format_config(const char *var, const char *value)
 		strcat(extra_headers, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.suffix")) {
+		if (!value)
+			die("format.suffix without value");
+		fmt_patch_suffix = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
@@ -223,9 +230,10 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 	char filename[1024];
 	char *sol;
 	int len = 0;
+	int suffix_len = strlen(fmt_patch_suffix) + 10; /* ., NUL and slop */
 
 	if (output_directory) {
-		strlcpy(filename, output_directory, 1010);
+		strlcpy(filename, output_directory, 1000);
 		len = strlen(filename);
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
@@ -249,7 +257,10 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 			}
 		}
 
-		for (j = 0; len < 1024 - 6 && sol[j] && sol[j] != '\n'; j++) {
+		for (j = 0;
+		     len < sizeof(filename) - suffix_len &&
+			     sol[j] && sol[j] != '\n';
+		     j++) {
 			if (istitlechar(sol[j])) {
 				if (space) {
 					filename[len++] = '-';
@@ -265,7 +276,7 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 		while (filename[len - 1] == '.' || filename[len - 1] == '-')
 			len--;
 	}
-	strcpy(filename + len, ".txt");
+	sprintf(filename + len, ".%s", fmt_patch_suffix);
 	fprintf(realstdout, "%s\n", filename);
 	freopen(filename, "w", stdout);
 }
@@ -436,6 +447,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				die("Need a Message-Id for --in-reply-to");
 			in_reply_to = argv[i];
 		}
+		else if (!strncmp(argv[i], "--suffix=", 9))
+			fmt_patch_suffix = argv[i] + 9;
 		else
 			argv[j++] = argv[i];
 	}
-- 
1.5.0.rc1.g5e1a2-dirty
