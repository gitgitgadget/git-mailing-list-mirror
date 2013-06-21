From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH 2/4] git-prompt.sh: refactor colored prompt code
Date: Thu, 20 Jun 2013 23:25:27 -0300
Message-ID: <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, artagnon@gmail.com,
	s.oosthoek@xs4all.nl, gitster@pobox.com, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 04:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upr3o-0006lF-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 04:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110Ab3FUC0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 22:26:40 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:65534 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3FUC0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 22:26:39 -0400
Received: by mail-yh0-f50.google.com with SMTP id i72so2909522yha.9
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=280ysu2YGBANKHkN0/EqsjuY6cTvD4W8Qvus0JybS7E=;
        b=vq+QHoe1lvHAhQBo3getHovttv+aX5UIM0U4SO+7Dsr3ZGojhkrysrceZ/m74wkWu1
         ucsjwG/X8qQhdmxrEeLEAeqs+BPzBL0U50wqcPqisCy04PyH1ITptptkBZyNQqqZgU1K
         TbZXHPYs8kDYKolDQ55y9dVJweHJTqmuoifelV8ZgEb8yi288iB+ocyxNRRvur70mqxb
         oynj1w4Yr38rTCL1Hva22V+qHxFJ3DonGs6PuxL1Vfn36BcxjFrZxV3PMDtdxyCU7kEg
         6ws8OVrgkBIk+prr5P5QDQPkHVl9YnmI7s41gmfaSvJYhjBxhH2ItplEZVkoH6GcoLNL
         AN0g==
X-Received: by 10.236.63.73 with SMTP id z49mr6368613yhc.161.1371781598350;
        Thu, 20 Jun 2013 19:26:38 -0700 (PDT)
Received: from localhost.localdomain (201.86.243.62.dynamic.adsl.gvt.net.br. [201.86.243.62])
        by mx.google.com with ESMTPSA id s65sm4968400yhs.14.2013.06.20.19.26.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 19:26:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g28387b2
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228564>

__git_ps1_colorize_gitstring() sets color codes and
builds the prompt gitstring. It has duplicated code
to handle color codes for bash and zsh shells.
__git_ps1() also has duplicated logic to build the
prompt gitstring.

Remove duplication of logic to build gitstring in
__git_ps1_colorize_gitstring() and __git_ps1().

Leave in __git_ps1_colorize_gitstring() only logic
to set color codes.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
26	59	contrib/completion/git-prompt.sh
 contrib/completion/git-prompt.sh | 85 ++++++++++++----------------------------
 1 file changed, 26 insertions(+), 59 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..b02b7b2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -225,8 +225,8 @@ __git_ps1_show_upstream ()
 }
 
 # Helper function that is meant to be called from __git_ps1.  It
-# builds up a gitstring injecting color codes into the appropriate
-# places.
+# injects color codes into the appropriate gitstring variables used
+# to build a gitstring.
 __git_ps1_colorize_gitstring ()
 {
 	if [[ -n ${ZSH_VERSION-} ]]; then
@@ -234,74 +234,40 @@ __git_ps1_colorize_gitstring ()
 		local c_green='%F{green}'
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
-		local bad_color=$c_red
-		local ok_color=$c_green
-		local branch_color="$c_clear"
-		local flags_color="$c_lblue"
-		local branchstring="$c${b##refs/heads/}"
-
-		if [ $detached = no ]; then
-			branch_color="$ok_color"
-		else
-			branch_color="$bad_color"
-		fi
-
-		gitstring="$branch_color$branchstring$c_clear"
-
-		if [ -n "$w$i$s$u$r$p" ]; then
-			gitstring="$gitstring$z"
-		fi
-		if [ "$w" = "*" ]; then
-			gitstring="$gitstring$bad_color$w"
-		fi
-		if [ -n "$i" ]; then
-			gitstring="$gitstring$ok_color$i"
-		fi
-		if [ -n "$s" ]; then
-			gitstring="$gitstring$flags_color$s"
-		fi
-		if [ -n "$u" ]; then
-			gitstring="$gitstring$bad_color$u"
-		fi
-		gitstring="$gitstring$c_clear$r$p"
-		return
+	else
+		# Using \[ and \] around colors
+		# is necessary to prevent wrapping issues!
+		local c_red='\[\e[31m\]'
+		local c_green='\[\e[32m\]'
+		local c_lblue='\[\e[1;34m\]'
+		local c_clear='\[\e[0m\]'
 	fi
-	local c_red='\e[31m'
-	local c_green='\e[32m'
-	local c_lblue='\e[1;34m'
-	local c_clear='\e[0m'
 	local bad_color=$c_red
 	local ok_color=$c_green
-	local branch_color="$c_clear"
 	local flags_color="$c_lblue"
-	local branchstring="$c${b##refs/heads/}"
 
+	local branch_color=""
 	if [ $detached = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
 	fi
+	c="$branch_color$c"
+	b="$b$c_clear"
 
-	# Setting gitstring directly with \[ and \] around colors
-	# is necessary to prevent wrapping issues!
-	gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
-
-	if [ -n "$w$i$s$u$r$p" ]; then
-		gitstring="$gitstring$z"
-	fi
 	if [ "$w" = "*" ]; then
-		gitstring="$gitstring\[$bad_color\]$w"
+		w="$bad_color$w"
 	fi
 	if [ -n "$i" ]; then
-		gitstring="$gitstring\[$ok_color\]$i"
+		i="$ok_color$i"
 	fi
 	if [ -n "$s" ]; then
-		gitstring="$gitstring\[$flags_color\]$s"
+		s="$flags_color$s"
 	fi
 	if [ -n "$u" ]; then
-		gitstring="$gitstring\[$bad_color\]$u"
+		u="$bad_color$u"
 	fi
-	gitstring="$gitstring\[$c_clear\]$r$p"
+	r="$c_clear$r"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
@@ -443,19 +409,20 @@ __git_ps1 ()
 		fi
 
 		local z="${GIT_PS1_STATESEPARATOR-" "}"
+
+		# NO color option unless in PROMPT_COMMAND mode
+		if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
+
 		local f="$w$i$s$u"
+		local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
+
 		if [ $pcmode = yes ]; then
-			local gitstring=
-			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-				__git_ps1_colorize_gitstring
-			else
-				gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
-			fi
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
-			# NO color option unless in PROMPT_COMMAND mode
-			printf -- "$printf_format" "$c${b##refs/heads/}${f:+$z$f}$r$p"
+			printf -- "$printf_format" "$gitstring"
 		fi
 	fi
 }
-- 
1.8.3.1.487.g28387b2
