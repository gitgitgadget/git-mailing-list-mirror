From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 3/5] difftool: Move option values into a hash
Date: Tue, 24 Jul 2012 19:59:31 -0700
Message-ID: <1343185173-48278-4-git-send-email-davvid@gmail.com>
References: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrpC-00024D-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab2GYC7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:59:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32923 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2GYC7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:59:37 -0400
Received: by pbbrp8 with SMTP id rp8so634455pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/q/qIZ5S/DabKLcYZi38YG65TG2+E9SNs4BcAEmiXfQ=;
        b=Rt1C7cSOAwONm+ndH4BLjFpaOZ2CZ+uJcfRGKfdbVFG3D347lnCkuaTZiWxxI+KnC5
         vFoYbD6QYCOZ6UNzQOeT8P8hb9li0OjmRY132XiLxR8Nm+HpBFBrsbtYMRRKAlFX4qLv
         9CLeL03WM1pMSzNMDNRbfJwUcmEKS3XzkO1bR0CELCJkgjfCnt85hqJgzVR1y9xFD2M+
         UGK8oaPg2ZA+GbtrWr7FqAWiMhATHEnivauP+dz34E95cDHruF5MkoCxCvXYhlT3ijdY
         sDMNWSTFl1ipQnqeLaih0OJbZqsLzjWPEIiTGq8gUfXEL6ysSiWK9KmEskhhu7ZejYm+
         P8dw==
Received: by 10.68.213.225 with SMTP id nv1mr21512968pbc.89.1343185177527;
        Tue, 24 Jul 2012 19:59:37 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kh1sm13382996pbc.23.2012.07.24.19.59.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 19:59:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.15.g8157c39
In-Reply-To: <1343185173-48278-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202096>

Shorten the "my" declaration for all of the option-specific variables
by wrapping all of them in a hash.  This also gives us a place to
specify default values, should we need them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Same as last time, rebased

 git-difftool.perl | 55 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index fa787d6..685887d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -279,41 +279,48 @@ sub main
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
@@ -323,10 +330,10 @@ sub main
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
1.7.12.rc0.15.g8157c39
