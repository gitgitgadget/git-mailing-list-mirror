From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Fri, 16 Mar 2012 21:59:17 -0400
Message-ID: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:59:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ivY-0006Zu-6v
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946022Ab2CQB7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:59:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61404 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945895Ab2CQB7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:59:22 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6234576iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PMZni4Yo40Dy7qZJSKrDrXhgL2kRxW4RCAWZn1ee38s=;
        b=YnoUP0P/xwXcS38q8ycPwhnQipezapADT1vKLAupxE6PkWrTy/vsnCOTO5A1IInr/l
         Q+GqQvHdMXRup0p5ryFDsZcUSoDCHlHwOqI24cCxhHEWvBtKqSVKxwEs5RQMnhcMcnAI
         itHnsvMTEwMwVD8IZDKra8jD+MCTmCp21UTHzOS/uCIQI5ZL0peRFrfI1cUe+FnKMTpo
         Qn5KGxOakYj3QGbfnhh6Selim4Q7f3NXZc88Xi6rnfcBHrIFJrmdgEef+UaWAnyYFZ/d
         ZTrX8Wv4fHB6P3l4Jxb/DM+X36K/8QGOLsHnKD6/Wm1fexdfPu+KHFQEwbDdZjYUdSvw
         jYug==
Received: by 10.50.194.232 with SMTP id hz8mr952207igc.38.1331949562133;
        Fri, 16 Mar 2012 18:59:22 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id uz5sm917965igc.10.2012.03.16.18.59.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:59:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193295>

The Git.pm module includes functions intended to standardize working
with Git repositories in Perl scripts. This commit teaches difftool
to use Git::command_noisy rather than a system call to run the diff
command.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 9495f14..8498089 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -72,12 +72,4 @@ elsif (defined($no_prompt)) {
 
 $ENV{GIT_PAGER} = '';
 $ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-my @command = ('git', 'diff', @ARGV);
-
-# ActiveState Perl for Win32 does not implement POSIX semantics of
-# exec* system call. It just spawns the given executable and finishes
-# the starting program, exiting with code 0.
-# system will at least catch the errors returned by git diff,
-# allowing the caller of git difftool better handling of failures.
-my $rc = system(@command);
-exit($rc | ($rc >> 8));
+git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
-- 
1.7.9.1.290.gbd444
