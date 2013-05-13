From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] prompt: factor out gitstring coloring logic
Date: Mon, 13 May 2013 19:19:17 +0530
Message-ID: <1368452958-31090-3-git-send-email-artagnon@gmail.com>
References: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 15:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubt6Z-0000G7-P4
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab3EMNrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:47:47 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36020 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3EMNrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:47:46 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so4421912pdj.38
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hqHFbiqvUSErA3Vnp0vYnntxQoJ/1oi3AasGGL8noEk=;
        b=kgUC4/BMttFJOK+AEU9OvwsudzU859FCueyHO5yhJB3RqCWCSMGiHGFrWkp7MGzpdo
         0Pi7ljd47MWsMmjJ2rtDSErWnXj1BYnzkvf7VxF1p0fsPyYnmDpfYG1qiOTTzbvEfcMH
         ZCZxWNJpBnow7VjI0go54ngvcWA3/U7DPOJxTRfcQjeN1f1mRCLj0bn3BaLxU808t8O0
         XEhv53i9BIC6UIpWUUrXnuqX6NH5cwXKDPJw9DePN5MJ8dwpazaUdu5V4sLhE6uL24aw
         bM6rB4/P+qZq+I1jf/gdPB4CLedTdTlWhsD1WOKhKggTeer6xzwiNIbDx//4buI8Vw3m
         g5Yw==
X-Received: by 10.68.194.135 with SMTP id hw7mr29143071pbc.192.1368452865772;
        Mon, 13 May 2013 06:47:45 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id sq9sm15114287pab.5.2013.05.13.06.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 06:47:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224138>

So that we can extend it with ZSH-colors in a later patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 79 ++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5d8b745..6943f86 100644
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
@@ -368,42 +410,7 @@ __git_ps1 ()
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
1.8.3.rc1.57.g4ac1522
