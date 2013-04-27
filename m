From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/9] completion: add hack to enable file mode in bash < 4
Date: Sat, 27 Apr 2013 15:10:05 -0500
Message-ID: <1367093407-8898-8-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTJ-0000Il-4k
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab3D0ULr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:47 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57947 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348Ab3D0ULq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:46 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so4393670obc.23
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Bo7BDmNcoPQiAootfIOoGye2wTZJCQNdiemd1tuzhRM=;
        b=iSMJehPfflsnWaIlVvBlJmiCTD0N2Ba4h4qXiCSBHTuDhZKkWo435T8qar6rB7dD92
         mjWDy/y2gP6WrP66PjtM5POPEFziblPR0eZEMfZVUCBAnMxodYu7Vt/z8IZ7bn2Vo8wL
         heiOrD9nE0hMYaXsRDPUafcaLOXlbgWBAiXhez3KZAEn4EX23O3II1SNCl/wSjXMm61n
         /uOTltG9xG/LazmqyVvRwQMWRM5oDtYJ6/BGq3C2bv/yvnZWWg0Lyd4vmZzfQklyZFu3
         ObO/xJA6hQYMqUd89XMFGpH2MDz/9VePspIknsRIs3NJcRoyuvSKUAlT+0qE4tzc6bIM
         jxaw==
X-Received: by 10.60.60.227 with SMTP id k3mr25657502oer.97.1367093506102;
        Sat, 27 Apr 2013 13:11:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm13341268oby.5.2013.04.27.13.11.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222686>

This way we don't need all the compat stuff, different filters, and so
on. Also, now we complete exactly the same in bash 3 and bash 4.

This is the way bash-completion did it for quite some time, when bash 3
was supported. For more information about the hack:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=272660#64

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 43 ++++++----------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9cea170..f9e8e7d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -254,33 +254,21 @@ __gitcomp_file ()
 	# completion will be used.
 	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
 
-	# Tell Bash that compspec generates filenames.
-	compopt -o filenames 2>/dev/null
+	# use a hack to enable file mode in bash < 4
+	compopt -o filenames 2>/dev/null ||
+	compgen -f /non-existing-dir/ > /dev/null
 }
 
-__git_index_file_list_filter_compat ()
-{
-	local path
-
-	while read -r path; do
-		case "$path" in
-		?*/*) echo "${path%%/*}/" ;;
-		*) echo "$path" ;;
-		esac
-	done
-}
-
-__git_index_file_list_filter_bash ()
+# Process path list returned by "ls-files" and "diff-index --name-only"
+# commands, in order to list only file names relative to a specified
+# directory, and append a slash to directory names.
+__git_index_file_list_filter ()
 {
 	local path
 
 	while read -r path; do
 		case "$path" in
 		?*/*)
-			# XXX if we append a slash to directory names when using
-			# `compopt -o filenames`, Bash will append another slash.
-			# This is pretty stupid, and this the reason why we have to
-			# define a compatible version for this function.
 			echo "${path%%/*}" ;;
 		*)
 			echo "$path" ;;
@@ -288,15 +276,6 @@ __git_index_file_list_filter_bash ()
 	done
 }
 
-# Process path list returned by "ls-files" and "diff-index --name-only"
-# commands, in order to list only file names relative to a specified
-# directory, and append a slash to directory names.
-__git_index_file_list_filter ()
-{
-	# Default to Bash >= 4.x
-	__git_index_file_list_filter_bash
-}
-
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
@@ -2651,14 +2630,6 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 
 	compdef _git git gitk
 	return
-elif [[ -n ${BASH_VERSION-} ]]; then
-	if ((${BASH_VERSINFO[0]} < 4)); then
-		# compopt is not supported
-		__git_index_file_list_filter ()
-		{
-			__git_index_file_list_filter_compat
-		}
-	fi
 fi
 
 __git_func_wrap ()
-- 
1.8.2.1.1031.g2ee5873
