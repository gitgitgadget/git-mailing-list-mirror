From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 10/9 v5] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 11:02:19 -0400
Message-ID: <1332428541-24878-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 16:08:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAjcs-00082c-BK
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 16:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267Ab2CVPIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 11:08:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43136 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964878Ab2CVPIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 11:08:23 -0400
Received: by qcqw6 with SMTP id w6so1367266qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QpizwOOVjNH7Y8C4Etx3y71PWlLQnxw0g5RIdsXgPQE=;
        b=bPKabgyGGgwzIDMD5vPr+KIB1eNXbkO5euXQQOjiAnf/QpDED0jYlJ1FVQ8x/XFUsC
         FoG8LPN1E6Z+VUT4/Hu+ijp9o4nlbIfXK9rIwdog1C6efMnrulma/m6dyRSONFnijKWf
         I26s77MXbRBHaW0JnL9RQjeyc5L2vcUr3OAj7Hy/aBb79hvUKZh+NKOdYiDp485wDQDv
         tbhgoGmR+Gfq6YDvACoobf50EkS6okoIkAW0ci+hrUy4hlQfn9+yt0udN43bq/S5QJXL
         Kg4L3oaDOvGvhd3ekrFfx/lHrAjLssuuXDXBMwOhUSjtX76MBVSEO6uPClRD+1PH49GO
         KktA==
Received: by 10.224.71.19 with SMTP id f19mr1364724qaj.0.1332428903201;
        Thu, 22 Mar 2012 08:08:23 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id cw5sm8763942qab.20.2012.03.22.08.08.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 08:08:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.40.g756bbcd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193661>

When difftool was changed to use Getopt::Long, it changed the way
that the '--prompt' and '--no-prompt' options were handled. The
expected behavior is that the two options may be given any number
of times. The last option given "wins".

For example, if a user sets "[alias] mdt = difftool --prompt", the
following must still run without error:

$ git mdt --no-prompt

The changes made during the switch to Getopt::Long broke this
behavior. This commit teaches difftool to handle them properly
again.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 10/9 in the previous version of the series.

Changes in v5:
  - Based on an example provided by Thomas Rast on the Git dev list,
    the '--[no-]prompt' options are parsed by Getopt::Long again.


 git-difftool.perl |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 9f0f9a9..9892d1e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -29,8 +29,8 @@ sub usage
 	my $exitcode = shift;
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [--tool-help]
-                    [-x|--extcmd=<cmd>]
-                    [-y|--no-prompt]   [-g|--gui]
+                    [-x|--extcmd=<cmd>] [-g|--gui]
+                    [--prompt] [-y|--no-prompt]
                     [-d|--dir-diff]
                     ['git diff' options]
 USAGE
@@ -131,15 +131,15 @@ sub setup_dir_diff
 
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
-my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $no_prompt, $prompt, $tool_help);
+my ($difftool_cmd, $dirdiff, $extcmd, $gui, $help, $prompt, $tool_help);
 GetOptions('g|gui' => \$gui,
 	'd|dir-diff' => \$dirdiff,
 	'h' => \$help,
-	'prompt' => \$prompt,
+	'prompt!' => \$prompt,
+	'y' => sub { $prompt = 0; },
 	't|tool:s' => \$difftool_cmd,
 	'tool-help' => \$tool_help,
-	'x|extcmd:s' => \$extcmd,
-	'y|no-prompt' => \$no_prompt);
+	'x|extcmd:s' => \$extcmd);
 
 if (defined($help)) {
 	usage(0);
@@ -203,10 +203,11 @@ if (defined($dirdiff)) {
 	}
 } else {
 	if (defined($prompt)) {
-		$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
-	}
-	elsif (defined($no_prompt)) {
-		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		if ($prompt) {
+			$ENV{GIT_DIFFTOOL_PROMPT} = 'true';
+		} else {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		}
 	}
 
 	$ENV{GIT_PAGER} = '';
-- 
1.7.10.rc1.40.g756bbcd
