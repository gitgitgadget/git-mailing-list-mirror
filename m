From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] prompt: factor out gitstring coloring logic
Date: Fri, 17 May 2013 14:25:47 +0530
Message-ID: <1368780948-28917-3-git-send-email-artagnon@gmail.com>
References: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 10:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGQi-0000XC-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab3EQIyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 04:54:16 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:61423 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3EQIyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 04:54:14 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3129880pdj.38
        for <git@vger.kernel.org>; Fri, 17 May 2013 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DJkfiW0/veoDxY9zMqPg1naCyyjokGm7j0Z6VuqsN9w=;
        b=mDAXldHBIKPEWPJuDF3pOae/I/VFXERmDDFP/wn1EPCu9Hh004ZyAJMMSQ5JQFFlon
         MFywOO6aGwnI4GHbLnVDaRCWsX/7UGCaML/OWklhaqQaqQGhkaw5+3k0WCWqM2egpt0d
         lMCu364fNknFuwSdbns8TkS7aUvH9VGOFQqMAkPVFD9Y8ckxf4B+UbaT6reTiLSv3btX
         c53dN1Lpo3+MvvkUDTi8IuC+ZTPjDt9YOZ638YKdYK8s5ZmgThRrDOkYYZaN8srtMr3x
         uldrIiZITPRkkYu5m9+iMLHBytxqQSapxwmCFiIujaWBF/mZYEsRv8JLkBOkvOmWyhuE
         My3w==
X-Received: by 10.66.2.199 with SMTP id 7mr21171813paw.176.1368780854062;
        Fri, 17 May 2013 01:54:14 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id do4sm10438933pbc.8.2013.05.17.01.54.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 01:54:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
In-Reply-To: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224661>

So that we can extend it with ZSH-colors in a later patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 79 ++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index fb9296b..263d2d7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -222,6 +222,48 @@ __git_ps1_show_upstream ()
 
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
+	if [ -n "$w$i$s$u$r$p" ]; then
+		gitstring="$gitstring$z"
+	fi
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
@@ -364,42 +406,7 @@ __git_ps1 ()
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
-				if [ -n "$w$i$s$u$r$p" ]; then
-					gitstring="$gitstring$z"
-				fi
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
 				gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
 			fi
-- 
1.8.1.2.432.g070c57d
