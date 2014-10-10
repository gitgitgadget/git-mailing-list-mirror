From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] difftool: don't assume that default sh is sane
Date: Fri, 10 Oct 2014 01:51:44 -0700
Message-ID: <1412931104-74648-2-git-send-email-davvid@gmail.com>
References: <1412931104-74648-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:51:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcVvX-0006zr-TV
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 10:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbaJJIvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 04:51:51 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39285 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaJJIvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 04:51:49 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so1274760pdj.23
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8aw/lO2Kb39Ggqq4X9L5HNgZ7fw68rB+fiiG3yeTJ8=;
        b=L/t+tjnf+CCY6ITKLyqYTWkmK8+tfs/YiRlqgBfpg3qTNkyaKesUV5z0ZQu9VIJKJK
         KoOPkb01KOExi38uY2fBdW3CjK3QtNpYgp9k/vlix3kTXxw6IG1qOnwByMDHeIZtVQ0c
         NfTcwjsneXvOIU6H7Z6FG2sLl1T/ASuDHjAK+lUKmGH13ivPkpsLddI8RY3K8710W9I7
         YwMOYA/XIc9S3zrGi/AHbDT4kao9/TwkNm6ncGdWXWai2L9gcg+ltj7a+RTGYQ+9itoe
         4IaRGTjMpqJogiyC5/gsSVzuQs+6xLZHh7r7J+5JVg6YaMutcR7YXY8l618f9rHHq/sp
         QDSQ==
X-Received: by 10.68.197.170 with SMTP id iv10mr3545710pbc.129.1412931105616;
        Fri, 10 Oct 2014 01:51:45 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id l6sm2754550pdr.39.2014.10.10.01.51.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 01:51:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.377.g0e18f12
In-Reply-To: <1412931104-74648-1-git-send-email-davvid@gmail.com>
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
Changes since v1:

The case statement for --tool-help=* was made simpler
thanks to John.

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
index a502430..ea8fe37 100755
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
2.1.2.377.g0e18f12
