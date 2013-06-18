From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 3/3] git-prompt.sh: enable color prompt in non-pcmode
Date: Mon, 17 Jun 2013 23:19:46 -0300
Message-ID: <1371521986-10179-1-git-send-email-erdavila@gmail.com>
References: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolWk-0002T9-2s
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab3FRCUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 22:20:03 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:35926 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3FRCUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:20:02 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so2115301qeb.8
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5Be0GyB1y5x8zOuZgloTqmC9+5Gtq6+hTB8H/XiyH8w=;
        b=r1oYeLQLGAPg/YAqF0Lb3RbQuLIRqdxdqtL/WahKALv2ciYOWsNRWg+Ye/UAWX03Md
         nuduqxEZe+cH7ps25h2qB9tXxJMqZNftDSqUZzSUoD3/rAk+CXsMUJH54R8UqrvDgpRK
         HZo/sMx6YsVoHqAIGmeVSGBxcmIxaUhI00ZuVzjIFKbzgcSdsHaJdZNTwQBSO9fdIT/Q
         IDPXJeP1H+aVFakbvHegYxWVMVK9m42D/LhPIGdujQncCB+HaSPgTI+it4shGUG0SNBI
         lItNHg34lw6+kQN6JeuAaowKi+SLFxF0AhU/yJqrcnpnyrOvPalo0AWF4Rb3OOQxa0pf
         GelQ==
X-Received: by 10.229.73.72 with SMTP id p8mr6571522qcj.53.1371522001822;
        Mon, 17 Jun 2013 19:20:01 -0700 (PDT)
Received: from localhost.localdomain ([177.97.121.196])
        by mx.google.com with ESMTPSA id 15sm25244058qaa.9.2013.06.17.19.19.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 19:20:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228147>

The use of colors in a prompt is only possible in
pcmode (using the variable PROMPT_COMMAND).

Enable color prompt in non-pcmode (using the variable
PS1) for both Bash and ZSH.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
15	9	contrib/completion/git-prompt.sh
19	0	t/t9903-bash-prompt.sh
 contrib/completion/git-prompt.sh | 24 +++++++++++++++---------
 t/t9903-bash-prompt.sh           | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 70515cc..c5c75e7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -13,7 +13,7 @@
 #    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
-#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
 #        the optional argument will be used as format string.
 #    3b) Alternatively, if you are using bash, __git_ps1 can be
 #        used for PROMPT_COMMAND with two parameters, <pre> and
@@ -235,12 +235,18 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \[ and \] around colors
-		# is necessary to prevent wrapping issues!
-		local c_red='\[\e[31m\]'
-		local c_green='\[\e[32m\]'
-		local c_lblue='\[\e[1;34m\]'
-		local c_clear='\[\e[0m\]'
+		local c_red='\e[31m'
+		local c_green='\e[32m'
+		local c_lblue='\e[1;34m'
+		local c_clear='\e[0m'
+		if [ $pcmode = yes ]; then
+			# Using \[ and \] around colors
+			# is necessary to prevent wrapping issues!
+			c_red="\[$c_red\]"
+			c_green="\[$c_green\]"
+			c_lblue="\[$c_lblue\]"
+			c_clear="\[$c_clear\]"
+		fi
 	fi
 	local bad_color=$c_red
 	local ok_color=$c_green
@@ -411,7 +417,7 @@ __git_ps1 ()
 		local z="${GIT_PS1_STATESEPARATOR-" "}"
 
 		# NO color option unless in PROMPT_COMMAND mode
-		if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 			__git_ps1_colorize_gitstring
 		fi
 
@@ -422,7 +428,7 @@ __git_ps1 ()
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
-			printf -- "$printf_format" "$gitstring"
+			printf -- "${printf_format//%s/%b}" "$gitstring"
 		fi
 	fi
 }
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 1101adf..7dccc1c 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -789,4 +789,23 @@ test_expect_success 'prompt - zsh color pc mode - untracked files status indicat
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - bash color ps1 mode - untracked files status indicator' '
+	printf " (\e[32mmaster\e[0m)" >expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color ps1 mode - untracked files status indicator' '
+	printf " (%%F{green}master%%f)" >expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		ZSH_VERSION=5.0.0 &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done
-- 
1.8.3.1.440.g82707f8
