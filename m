From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] prompt: fix missing file errors in zsh
Date: Fri, 11 Apr 2014 18:32:25 -0500
Message-ID: <1397259145-18514-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 01:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYl5a-0004UL-Jg
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 01:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbaDKXm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 19:42:26 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:59560 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaDKXmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 19:42:25 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so6883469oag.23
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dFVYmsRDHlTmfVLgMktmsxXzfB6hu91zZ3UUDJlrXXw=;
        b=veCU80Snjzfz0rY7ACgd3AmoKfrG7dBHi4yvpIC/Dz1GoZOJ8ZfiuVGLZQgE6XgXUI
         B4083K2ZaQf6EQtbgOXuouQa4rKQK/e7SShhJHv80RRSTSaUbi7e9clWbKdNqDTjNixx
         ko9SvfH3rj0vWohzOQOl8IHtL/zOMd8C2uWQtEZwwh4/3mcYTMt73QHyKhxSNJu9bvPi
         ztF+UudLLknuoMl3wH/dDMQhAd7vIQCkNAYd//2zj0dibe0o6zIa2yDhDCiyfzMwjrJy
         8PBGLG8+rIKq2Ms8VK2mtS/3rDiEBOzgHCZiZNS/J7ZXgGx+zTpFJlmtKuqk2Y/7w6TP
         gfRw==
X-Received: by 10.182.118.169 with SMTP id kn9mr22008065obb.46.1397259745349;
        Fri, 11 Apr 2014 16:42:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dg2sm14819295obb.17.2014.04.11.16.42.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 16:42:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246159>

zsh seems to have a bug while redirecting the stderr of the 'read'
command:

 % read foo 2> /dev/null < foo
 zsh: no such file or directory: foo

Which causes errors to be displayed when certain files are missing.
Let's add a convenience function to manually check if the file is
readable before calling "read".

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 7b732d2..1526086 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -259,6 +259,13 @@ __git_ps1_colorize_gitstring ()
 	r="$c_clear$r"
 }
 
+eread ()
+{
+	f="$1"
+	shift
+	test -r "$f" && read "$@" < "$f"
+}
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
 # in this mode it prints text to add to bash PS1 prompt (includes branch name)
@@ -321,9 +328,9 @@ __git_ps1 ()
 	local step=""
 	local total=""
 	if [ -d "$g/rebase-merge" ]; then
-		read b 2>/dev/null <"$g/rebase-merge/head-name"
-		read step 2>/dev/null <"$g/rebase-merge/msgnum"
-		read total 2>/dev/null <"$g/rebase-merge/end"
+		eread "$g/rebase-merge/head-name" b
+		eread "$g/rebase-merge/msgnum" step
+		eread "$g/rebase-merge/end" total
 		if [ -f "$g/rebase-merge/interactive" ]; then
 			r="|REBASE-i"
 		else
@@ -331,10 +338,10 @@ __git_ps1 ()
 		fi
 	else
 		if [ -d "$g/rebase-apply" ]; then
-			read step 2>/dev/null <"$g/rebase-apply/next"
-			read total 2>/dev/null <"$g/rebase-apply/last"
+			eread "$g/rebase-apply/next" step
+			eread "$g/rebase-apply/last" total
 			if [ -f "$g/rebase-apply/rebasing" ]; then
-				read b 2>/dev/null <"$g/rebase-apply/head-name"
+				eread "$g/rebase-apply/head-name" b
 				r="|REBASE"
 			elif [ -f "$g/rebase-apply/applying" ]; then
 				r="|AM"
@@ -358,7 +365,7 @@ __git_ps1 ()
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
 			local head=""
-			if ! read head 2>/dev/null <"$g/HEAD"; then
+			if ! eread "$g/HEAD" head; then
 				if [ $pcmode = yes ]; then
 					PS1="$ps1pc_start$ps1pc_end"
 				fi
-- 
1.9.1+fc3.9.gc73078e
