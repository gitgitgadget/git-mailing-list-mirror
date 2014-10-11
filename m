From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 3/3] difftool: don't assume that default sh is sane
Date: Sat, 11 Oct 2014 01:39:38 -0700
Message-ID: <1413016778-94829-3-git-send-email-davvid@gmail.com>
References: <1413016778-94829-1-git-send-email-davvid@gmail.com>
 <1413016778-94829-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 10:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcsDN-0008CH-VP
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 10:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaJKIjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 04:39:45 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43148 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaJKIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 04:39:42 -0400
Received: by mail-pd0-f170.google.com with SMTP id p10so2987240pdj.29
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuYtMGfdqCzRPDGETCCgS5Jc9ujffVxZtGpFTRbbeXg=;
        b=CCHLQQVT2WgcstsTSCdsYn0C9EFexxw2/YkISHgkAyQdKbfXZZJDm2vbyzLcXpU5M+
         rTHw6aPxDx1zINfTAeLaYzGCCaGunsdVJ3ibuuIOPQI9zDaMUIFcWKox40n0J1Df8c5O
         GCIpc5ixqeTn98ZX9Zasw/Q0VWVaPi96uJw6vmCJF9KHviAcfxDLYCZM0RY+MzAFoU5d
         9BS00peebhSnboIvjyoc4kx9LuR3A2KUH7ezspHQGnxgnls5IbMvJadoDTLsoXFfJn9y
         tHSIeUUi+Oc991kWs24mMSLQV81uyhh1UH1cUoub9h7sGXbugimKhYtQfTypNWymogZb
         dQxQ==
X-Received: by 10.66.153.16 with SMTP id vc16mr10880253pab.48.1413016781845;
        Sat, 11 Oct 2014 01:39:41 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id gz1sm5558417pbb.8.2014.10.11.01.39.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 Oct 2014 01:39:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.378.g89c0b73
In-Reply-To: <1413016778-94829-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

git-difftool used to create a command list script containing $( ... )
and explicitly calls "sh -c" with this list.

Instead, allow mergetool --tool-help to take a mode parameter and call
mergetool directly to invoke the show_tool_help function. This mode
parameter is intented for use solely by difftool.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
Helped-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
No changes since v2.

 git-difftool.perl | 6 +-----
 git-mergetool.sh  | 4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 18ca61e..598fcc2 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -47,13 +47,9 @@ sub find_worktree
 
 sub print_tool_help
 {
-	my $cmd = 'TOOL_MODE=diff';
-	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
-	$cmd .= ' && show_tool_help';
-
 	# See the comment at the bottom of file_diff() for the reason behind
 	# using system() followed by exit() instead of exec().
-	my $rc = system('sh', '-c', $cmd);
+	my $rc = system(qw(git mergetool --tool-help=diff));
 	exit($rc | ($rc >> 8));
 }
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cddb533..10782b8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -327,6 +327,10 @@ guessed_merge_tool=false
 while test $# != 0
 do
 	case "$1" in
+	--tool-help=*)
+		TOOL_MODE=${1#--tool-help=}
+		show_tool_help
+		;;
 	--tool-help)
 		show_tool_help
 		;;
-- 
2.1.2.378.g89c0b73
