From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 2/5] git-prompt.sh: refactor colored prompt code
Date: Wed, 26 Jun 2013 00:05:14 -0300
Message-ID: <7ecb9a0f24499fd6dd8ddf51514cadfb9f559bf6.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, "Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 05:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urg5A-0005F6-BK
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 05:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab3FZDHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 23:07:40 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:40625 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3FZDHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 23:07:40 -0400
Received: by mail-gh0-f174.google.com with SMTP id r17so4310856ghr.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=BQBKBD1Tw6jHp7ZEwDtUdky4mGWMb6ifLMf40m1Q2kU=;
        b=XCrsC4totYIDp+xFl8kSHiXY9f9QJsHOVo3lifUspRayO3hQwYzO4z9MAMne2Tp2Y7
         eFj5cQ7jEIsewmTJFf+Zpvra7DkU5AJdn6RlprN7BNjFXz9LKFD9JPkYrbU+/RWanTHP
         aJcCBxM/rgA//z+kOinaJwJk5/VQ7nDGY6OHvMtYMPchEAqt6GWAdvnnMUxtZkJpijb5
         Jue81cJpXcopmXkLz6mZb3qSTVOnlxTD2lby7rz/BkM7AWbRQd4l8GXPy5xWOimARy1i
         htBIwJgIXBTFpSFL8aHRvc3QREwTRpsOepyJ7hcPSrzPltK/1oaPatM6in5bOux9a44Z
         iNtA==
X-Received: by 10.236.155.105 with SMTP id i69mr998379yhk.159.1372216059425;
        Tue, 25 Jun 2013 20:07:39 -0700 (PDT)
Received: from localhost.localdomain (200.175.80.235.dynamic.adsl.gvt.net.br. [200.175.80.235])
        by mx.google.com with ESMTPSA id y70sm42415518yhe.15.2013.06.25.20.07.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 20:07:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.590.g42a98dd
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229023>

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
index 07a6218..fdedb45 100644
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
+		# Using \[ and \] around colors is necessary to prevent
+		# issues with command line editing/browsing/completion!
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
1.8.3.1.590.g42a98dd
