From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 7/9 v6] difftool: replace system call with Git::command_noisy
Date: Thu, 22 Mar 2012 15:52:22 -0400
Message-ID: <1332445944-10944-8-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:54:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo59-0005lx-By
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322Ab2CVTxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50888 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab2CVTxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:53 -0400
Received: by qcqw6 with SMTP id w6so1554843qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wAgnV6ZO0LF1JaTkRoGcYtM87xo89E577YHZLhY1PrE=;
        b=FhaFN2iBlezyh+a6hCtInelkKT3XnO/ijFWSpAGMYOJI78PFWQRYIk9oS5a645ybtQ
         m8B/NFZ47qA6SmeWvaQ4c70fe8ukbp1jeldYcUx0WP0vxu2C3jae9Vtld47W1Zm7gIJV
         8fI2Mh0aiIXrmjSg7HN1v2ALKIqnE7Kxf7V9EAj/JEubbvEc2d1y7nz68y9H2fLyHcAW
         ejy6ct7rxqk1snujT9zlpuyj0fAIQgNS6QkkBZw1NMuXkPL1mJbaY/5ePScZIHycu6um
         YuIHUJEYIcm5hfqvopN4uxqAyKDLPKmawyvCPwXMTgHU2+TtlI973Cqy1E2E0z5rtiGL
         q93A==
Received: by 10.224.95.210 with SMTP id e18mr12688182qan.81.1332446033283;
        Thu, 22 Mar 2012 12:53:53 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id hb3sm10014475qab.6.2012.03.22.12.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193706>

The Git.pm module includes functions intended to standardize working
with Git repositories in Perl scripts. This commit teaches difftool
to use Git::command_noisy rather than a system call to run the diff
command.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index d4fe998..7366bf5 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -75,12 +75,4 @@ if (defined($prompt)) {
 
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
1.7.10.rc1.36.g15e879
