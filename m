From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] git-prompt.zsh: introduce thin ZSH wrapper
Date: Sat, 11 May 2013 21:55:13 +0530
Message-ID: <1368289513-8700-3-git-send-email-artagnon@gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 18:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCbN-0001SU-UR
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab3EKQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:24:48 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:61626 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3EKQYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:24:46 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so3460307pbc.11
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BTpUB7x8zGCBDblNCRS0CfMattI434YlukrffwNk5nE=;
        b=VSMmlr7+dnik4sBjkks17GA9eY4ASQv3L86L1IlWD8hg+HQEfvKTgeQRNwGkqiwj1U
         fkiA2r5r8HjPCC1quxiqGq8ET/dp/PkKUbdg9DJZOshJfowFixcVgVaVfD7NjPTwrao2
         au9iHzK+Y3hCG7TANY6gFrk3tP8PQmfwOvS9rVPHo4U70Cw8ke0F6xHTvKy8aLydEoEa
         8uYKbKDXXwX6MpUGcGscwG7Sbu1EAY1sPw6TWoyBKbWRh58zo3ALc4Kq9Up7sH2g/h8r
         NrC4fdL+WzaNJB1mJz1Nv4K6vZArbGtFCE7R/UMEb6LO+U+bTpQrXzBvLKOxcdcI49PW
         08qA==
X-Received: by 10.66.216.136 with SMTP id oq8mr22379511pac.161.1368289485842;
        Sat, 11 May 2013 09:24:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.109.165])
        by mx.google.com with ESMTPSA id fn2sm7096965pbc.15.2013.05.11.09.24.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:24:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.g4537cf1
In-Reply-To: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223994>

To facilitate a colored prompt in ZSH, write a thin wrapper around
git-prompt.sh, factoring out and overriding the coloring logic.  Since
ZSH lacks a PROMPT_COMMAND, instruct the user to execute __git_ps1
inside precmd().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh  | 73 +++++++++++++++++++++------------------
 contrib/completion/git-prompt.zsh | 59 +++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 33 deletions(-)
 create mode 100644 contrib/completion/git-prompt.zsh

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 08c9b22..0bc51ad 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -222,6 +222,45 @@ __git_ps1_show_upstream ()
 
 }
 
+# Helper function that is meant to be called from __git_ps1.  It
+# builds up a gitstring injecting color codes into the appropriate
+# places.
+__git_ps1_colorize_gitstring ()
+{
+	local c_red='\e[31m'
+	local c_green='\e[32m'
+	local c_lblue='\e[1;34m'
+	local c_clear='\e[0m'
+	local bad_color=$c_red
+	local ok_color=$c_green
+	local branch_color="$c_clear"
+	local flags_color="$c_lblue"
+	local branchstring="$c${b##refs/heads/}"
+
+	if [ $detached = no ]; then
+		branch_color="$ok_color"
+	else
+		branch_color="$bad_color"
+	fi
+
+	# Setting gitstring directly with \[ and \] around colors
+	# is necessary to prevent wrapping issues!
+	gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
+
+	if [ "$w" = "*" ]; then
+		gitstring="$gitstring\[$bad_color\]$w"
+	fi
+	if [ -n "$i" ]; then
+		gitstring="$gitstring\[$ok_color\]$i"
+	fi
+	if [ -n "$s" ]; then
+		gitstring="$gitstring\[$flags_color\]$s"
+	fi
+	if [ -n "$u" ]; then
+		gitstring="$gitstring\[$bad_color\]$u"
+	fi
+	gitstring="$gitstring\[$c_clear\]$r$p"
+}
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
@@ -363,39 +402,7 @@ __git_ps1 ()
 		if [ $pcmode = yes ]; then
 			local gitstring=
 			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-				local c_red='\e[31m'
-				local c_green='\e[32m'
-				local c_lblue='\e[1;34m'
-				local c_clear='\e[0m'
-				local bad_color=$c_red
-				local ok_color=$c_green
-				local branch_color="$c_clear"
-				local flags_color="$c_lblue"
-				local branchstring="$c${b##refs/heads/}"
-
-				if [ $detached = no ]; then
-					branch_color="$ok_color"
-				else
-					branch_color="$bad_color"
-				fi
-
-				# Setting gitstring directly with \[ and \] around colors
-				# is necessary to prevent wrapping issues!
-				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
-
-				if [ "$w" = "*" ]; then
-					gitstring="$gitstring\[$bad_color\]$w"
-				fi
-				if [ -n "$i" ]; then
-					gitstring="$gitstring\[$ok_color\]$i"
-				fi
-				if [ -n "$s" ]; then
-					gitstring="$gitstring\[$flags_color\]$s"
-				fi
-				if [ -n "$u" ]; then
-					gitstring="$gitstring\[$bad_color\]$u"
-				fi
-				gitstring="$gitstring\[$c_clear\]$r$p"
+				__git_ps1_colorize_gitstring
 			else
 				gitstring="$c${b##refs/heads/}${f:+$f}$r$p"
 			fi
diff --git a/contrib/completion/git-prompt.zsh b/contrib/completion/git-prompt.zsh
new file mode 100644
index 0000000..dc164dd
--- /dev/null
+++ b/contrib/completion/git-prompt.zsh
@@ -0,0 +1,59 @@
+# git prompt support for zsh: wrapper around git-prompt.sh
+#
+# To enable:
+#
+#    1) Copy this file and git-prompt.sh to ~/.zsh/prompt
+#    2) Add the following lines to your .zshrc:
+#
+#          source ~/.zsh/prompt/git-prompt.zsh
+#          GIT_PS1_SHOWCOLORHINTS=true
+#          precmd () { __git_ps1 "%n|" ":%~$ " "%s" }
+#
+#    3) You can now add the following to ~/.zshrc and expect the
+#       characters to be displayed in color:
+#
+#          GIT_PS1_DESCRIBE_STYLE=branch
+#          GIT_PS1_SHOWUPSTREAM=auto
+#          GIT_PS1_SHOWDIRTYSTATE=true
+#          GIT_PS1_SHOWUNTRACKEDFILES=true
+
+test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-prompt.sh
+ZSH_VERSION='' . "$script"
+
+autoload colors
+colors
+
+__git_ps1_colorize_gitstring ()
+{
+	local c_red='%F{red}'
+	local c_green='%F{green}'
+	local c_lblue='%F{blue}'
+	local c_clear='%f'
+	local bad_color=$c_red
+	local ok_color=$c_green
+	local branch_color="$c_clear"
+	local flags_color="$c_lblue"
+	local branchstring="$c${b##refs/heads/}"
+
+	if [ $detached = no ]; then
+		branch_color="$ok_color"
+	else
+		branch_color="$bad_color"
+	fi
+
+	gitstring="$branch_color$branchstring$c_clear"
+
+	if [ "$w" = "*" ]; then
+		gitstring="$gitstring$bad_color$w"
+	fi
+	if [ -n "$i" ]; then
+		gitstring="$gitstring$ok_color$i"
+	fi
+	if [ -n "$s" ]; then
+		gitstring="$gitstring$flags_color$s"
+	fi
+	if [ -n "$u" ]; then
+		gitstring="$gitstring$bad_color$u"
+	fi
+	gitstring="$gitstring$c_clear$r$p"
+}
-- 
1.8.3.rc1.52.g4537cf1
