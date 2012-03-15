From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Thu, 15 Mar 2012 18:25:11 -0400
Message-ID: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 15 23:25:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8J6h-0002Cy-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760820Ab2COWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:25:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54098 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759898Ab2COWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:25:08 -0400
Received: by iagz16 with SMTP id z16so4475697iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+pdlp62zIlU6KrorfIB13rAUlgQGJIGzAkFzAWFSTYA=;
        b=ELdFHDTRMVbWbT32wWOQpMso7kOD6jPhNhY9mbTn4cw0Bqlo9cJ+/00aQQHPzHsDL+
         xC5bqQe1jw/fWkOCNSPFHg6L0WQPH2D54wbKQR0tcvMDsotyY8ZEJNPqT2jfv0Nw0e/K
         qoDCyYkgSUKwPj29c67m+2atFWrT48hJgRYnNxfypDKx0I6Uc+5sR7FYVC0M8SutgPDS
         2vP6m+Sjka0m68tqMmzv+VenWhs8xvqgP5oSKXhkutX8GUIJSF204ArASFeloWw91L9Q
         jbf8Vdu+RpaTH1UImG53wVih4tQ0gybmYeN0KrdvWUjyJZK485uvIduZLJPMynuqdZhN
         DWSA==
Received: by 10.50.196.165 with SMTP id in5mr20167674igc.8.1331850308089;
        Thu, 15 Mar 2012 15:25:08 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id cv10sm3082408igc.13.2012.03.15.15.25.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 15:25:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193233>

Since bc7a96a, it is possible to add new diff tools by creating a
simple script file in the '$(git --exec-path)/mergetools' directory.
However, updating the difftool help text is still a manual process.

This commit reads the list of valid diff tools from the 'mergetools'
directory and prints them for the user when the '--tool-help' option
is given.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 Documentation/git-difftool.txt |    7 ++++---
 git-difftool.perl              |   14 ++++++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 19d473c..2b4b6ee 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,9 +31,10 @@ OPTIONS
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
-	Valid diff tools are:
-	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
-	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
+	See `--tool-help` for the list of valid <tool> settings.
+
+--tool-help::
+	Print a list of diff tools that may be used with `--tool`.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/git-difftool.perl b/git-difftool.perl
index 09b65f1..4cfb1ae 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -14,7 +14,7 @@ use 5.008;
 use strict;
 use warnings;
 use Cwd qw(abs_path);
-use File::Basename qw(dirname);
+use File::Basename qw(dirname basename);
 
 require Git;
 
@@ -24,7 +24,8 @@ my $DIR = abs_path(dirname($0));
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
+usage: git difftool [-t|--tool=<tool>]   [--tool-help]
+                    [-x|--extcmd=<cmd>]
                     [-y|--no-prompt]   [-g|--gui]
                     ['git diff' options]
 USAGE
@@ -100,6 +101,15 @@ sub generate_command
 		if ($arg eq '-h') {
 			usage();
 		}
+		if ($arg eq '--tool-help') {
+			my $gitpath = Git::exec_path();
+			print "'git difftool --tool=<tool>' may be set to one of the following:\n";
+			for (glob "$gitpath/mergetools/*") {
+				next if /defaults$/;
+				print "\t" . basename($_) . "\n";
+			}
+			exit(1);
+		}
 		push @command, $arg;
 	}
 	if ($prompt eq 'yes') {
-- 
1.7.9.GIT
