From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 01:41:17 +0200
Message-ID: <1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreNs-00089H-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab2A2Xl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:41:57 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56395 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2A2Xl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:41:56 -0500
Received: by wics10 with SMTP id s10so2968108wic.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 15:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K1V0uoo1yc48Mltipu63xLD5XlAnDwtIlNSNrDVqwjU=;
        b=LcJSsf+PaVnDF7t5HreVkjqp2o0afujN3eSfrTIuf8ZEoHyICkqOkKDXGIlR4fCx27
         lo+FxhtJfNkj9gbwJ5VvUEpKm9YX4XxGdcSjkXztyBaiG+NgQVa3Nizr8ls122yCMskO
         6jqTw0c9IjJhvsfLTGvDVnhCvc/DlYbgelg00=
Received: by 10.180.95.131 with SMTP id dk3mr24498785wib.6.1327880515536;
        Sun, 29 Jan 2012 15:41:55 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id n3sm46605380wiz.9.2012.01.29.15.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 15:41:54 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189304>

And yet another bug in zsh[1] causes a mismatch; zsh seems to have
problem emulating wordspliting, but only when the ':' command is
involved.

Let's avoid it. This has the advantage that the code is now actually
understandable (at least to me), while before it looked like voodoo.

I found this issue because __git_compute_porcelain_commands listed all
commands (not only porcelain).

[1] http://article.gmane.org/gmane.comp.shells.zsh.devel/24296

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..7051c7a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -676,7 +676,8 @@ __git_merge_strategies=
 # is needed.
 __git_compute_merge_strategies ()
 {
-	: ${__git_merge_strategies:=$(__git_list_merge_strategies)}
+	test "$__git_merge_strategies" && return
+	__git_merge_strategies=$(__git_list_merge_strategies 2> /dev/null)
 }
 
 __git_complete_revlist_file ()
@@ -854,7 +855,8 @@ __git_list_all_commands ()
 __git_all_commands=
 __git_compute_all_commands ()
 {
-	: ${__git_all_commands:=$(__git_list_all_commands)}
+	test "$__git_all_commands" && return
+	__git_all_commands=$(__git_list_all_commands 2> /dev/null)
 }
 
 __git_list_porcelain_commands ()
@@ -947,7 +949,8 @@ __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	__git_compute_all_commands
-	: ${__git_porcelain_commands:=$(__git_list_porcelain_commands)}
+	test "$__git_porcelain_commands" && return
+	__git_porcelain_commands=$(__git_list_porcelain_commands 2> /dev/null)
 }
 
 __git_pretty_aliases ()
-- 
1.7.8.3
