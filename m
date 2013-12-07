From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: fix completion of certain aliases
Date: Sat,  7 Dec 2013 07:11:13 -0600
Message-ID: <1386421873-27863-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:18:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHmR-0003mj-BW
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab3LGNSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:18:43 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57561 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab3LGNSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:18:43 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2043817oag.35
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ytKQaFkSkg38scRRhDzsV+Fu9nTYKi5xDnFUPQoWMaA=;
        b=eDBydNJSyVnD0Od6/wFTlEZ9p08/TZe2Dp0d9+CXpi4ewNbyZyH1eqKm+dW/mvDgm3
         CAxoOyN+bQm+N7z2K+InhB+fFFQIZlUGmeHwDx4bxZWTc1byN1guex+Qa0+ey/LptcEh
         SBj8OoeSRLea3I8zcdj5Xj+eHVadDg+1HaFBoVjRQok0c+YBJkQ+vx0/p2t3t0BzDz+S
         B18tiWQONm8RBRNYguSQ+gyAs/usr/obW5VWp9kpTIbjb3bZMHkwbB5PxhAGZaWEsc7g
         esSuQPcb8f26JNvrVV+fkRm6t/FJYlwGOGZj4gGLRnyW6cafXY3dRLOXzW3qMe6spgSh
         zHiA==
X-Received: by 10.182.158.71 with SMTP id ws7mr6544544obb.6.1386422322675;
        Sat, 07 Dec 2013 05:18:42 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm5262709oep.2.2013.12.07.05.18.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:18:41 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238984>

Some commands need the first word to determine the actual action that is
being executed, however, the command is wrong when we use an alias, for
example 'alias.p=push', if we try to complete 'git p origin ', the
result would be wrong because __git_complete_remote_or_refspec() doesn't
know where it come from.

So let's override words[1], so the alias 'p' is override by the actual
command, 'push'.

Reported-by: Aymeric Beaumet <aymeric.beaumet@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dba3c15..c14bac4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2530,6 +2530,7 @@ __git_main ()
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
+		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fac5e71..3eeb7f8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -96,6 +96,7 @@ __git_zsh_bash_func ()
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
+		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
-- 
1.8.4.2+fc1
