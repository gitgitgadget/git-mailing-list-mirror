From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/5] difftool: Move option values into a hash
Date: Sun, 22 Jul 2012 20:42:18 -0700
Message-ID: <1343014940-16439-3-git-send-email-davvid@gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9YO-0006PU-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab2GWDm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:42:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54753 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2GWDmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:42:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so10148794pbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qmE0paL1aeg/KvCZYMeDv/1+GHfz8UYnFXLrBHyO+pg=;
        b=oXWi9AYIH9R3hdStsxc4C5fwtDhcJ9/JDHtUV0ddEJsaQtnz074piKiel2zcmr1FTD
         hP1bs44tTMMnRolP/uZ4otU9DgZfgJPWrkZIUqRRa9428+/rNiT9C+LMUmiC/rE8+Mdd
         dJjuxKDjA+lrkd1npRbBDdJBvn4VcyqEr854NQU7HCc9i5WUWkgcTQn2LDqzmtlmNo+D
         BT+JGk+MoSvtTlU+m68gQ/JY+VyU/MiDV5xwhm5Inw9tXPrjDJBHrGWJX+ZhgF4K9kML
         +ZWplilfpZ1mnTuEvEonHEmrlPmc1tiyEDp9MZy2VWTb8lS0vCKPqGsVSaQaMgnhHyuW
         T4PQ==
Received: by 10.68.217.226 with SMTP id pb2mr31544134pbc.105.1343014937796;
        Sun, 22 Jul 2012 20:42:17 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ru10sm9051189pbc.50.2012.07.22.20.42.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 20:42:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.255.g5f133da
In-Reply-To: <1343014940-16439-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201883>

Shorten the "my" declaration for all of the option-specific variables
by wrapping all of them in a hash.  This makes also gives us a place
to specify default values, should we need them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 55 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 41ba932..0ce6168 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -264,41 +264,48 @@ sub main
 {
 	# parse command-line options. all unrecognized options and arguments
 	# are passed through to the 'git diff' command.
-	my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
-	GetOptions('g|gui!' => \$gui,
-		'd|dir-diff' => \$dirdiff,
-		'h' => \$help,
-		'prompt!' => \$prompt,
-		'y' => sub { $prompt = 0; },
-		't|tool:s' => \$difftool_cmd,
-		'tool-help' => \$tool_help,
-		'x|extcmd:s' => \$extcmd);
-
-	if (defined($help)) {
+	my %opts = (
+		difftool_cmd => undef,
+		dirdiff => undef,
+		extcmd => undef,
+		gui => undef,
+		help => undef,
+		prompt => undef,
+		tool_help => undef,
+	);
+	GetOptions('g|gui!' => \$opts{gui},
+		'd|dir-diff' => \$opts{dirdiff},
+		'h' => \$opts{help},
+		'prompt!' => \$opts{prompt},
+		'y' => sub { $opts{prompt} = 0; },
+		't|tool:s' => \$opts{difftool_cmd},
+		'tool-help' => \$opts{tool_help},
+		'x|extcmd:s' => \$opts{extcmd});
+
+	if (defined($opts{help})) {
 		usage(0);
 	}
-	if (defined($tool_help)) {
+	if (defined($opts{tool_help})) {
 		print_tool_help();
 	}
-	if (defined($difftool_cmd)) {
-		if (length($difftool_cmd) > 0) {
-			$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
+	if (defined($opts{difftool_cmd})) {
+		if (length($opts{difftool_cmd}) > 0) {
+			$ENV{GIT_DIFF_TOOL} = $opts{difftool_cmd};
 		} else {
 			print "No <tool> given for --tool=<tool>\n";
 			usage(1);
 		}
 	}
-	if (defined($extcmd)) {
-		if (length($extcmd) > 0) {
-			$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
+	if (defined($opts{extcmd})) {
+		if (length($opts{extcmd}) > 0) {
+			$ENV{GIT_DIFFTOOL_EXTCMD} = $opts{extcmd};
 		} else {
 			print "No <cmd> given for --extcmd=<cmd>\n";
 			usage(1);
 		}
 	}
-	if ($gui) {
-		my $guitool = '';
-		$guitool = Git::config('diff.guitool');
+	if ($opts{gui}) {
+		my $guitool = Git::config('diff.guitool');
 		if (length($guitool) > 0) {
 			$ENV{GIT_DIFF_TOOL} = $guitool;
 		}
@@ -308,10 +315,10 @@ sub main
 	# to compare the a/b directories.  In file diff mode, 'git diff'
 	# will invoke a separate instance of 'git-difftool--helper' for
 	# each file that changed.
-	if (defined($dirdiff)) {
-		dir_diff($extcmd);
+	if (defined($opts{dirdiff})) {
+		dir_diff($opts{extcmd});
 	} else {
-		file_diff($prompt);
+		file_diff($opts{prompt});
 	}
 }
 
-- 
1.7.11.2.255.g5f133da
