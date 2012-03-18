From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 6/9 v2] difftool: replace system call with Git::command_noisy
Date: Sat, 17 Mar 2012 21:55:31 -0400
Message-ID: <1332035734-5443-7-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MY-0004Hw-9R
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab2CRB4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab2CRB4X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:23 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PMZni4Yo40Dy7qZJSKrDrXhgL2kRxW4RCAWZn1ee38s=;
        b=Qhvpxijo2cVKj9LHM+HyTTJ9dw2rZ8MtE1Og9+p2wx7I6/eeni/+WGDNkuXOOSB65u
         kym0R2XqlzwiFwgsggHIWYYqcV/5/uQYvKMaaUQj9bQ9pc1o7rwTPmiM6nVigb2/37K8
         k0ShaxET9JrHWyJq6jFpa1eIhynBUUw4D4fm3wHLDB0d6Q4ps4ho8l84QHp2opcOW2gG
         j1DsClEOkShaqafLvty/K66jSXOsu36L0hXDLwWG9td61orItx5OY+Qc2uBz8P4Fxdkw
         p2z3bJ4sD4A/RrwlqOx/4hlz6ihxk1cLzNbBPFHiVV8XoF+j5I7HBBrt89SczDLE0H/A
         X7YA==
Received: by 10.50.189.135 with SMTP id gi7mr1076357igc.37.1332035782682;
        Sat, 17 Mar 2012 18:56:22 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id gw10sm2974121igb.5.2012.03.17.18.56.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193362>

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
