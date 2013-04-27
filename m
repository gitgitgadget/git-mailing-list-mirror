From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/11] completion: avoid compopt -o filenames
Date: Sat, 27 Apr 2013 05:19:50 -0500
Message-ID: <1367057994-19887-8-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GE-0003IE-3V
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab3D0KVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:32 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34060 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3D0KVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:30 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so4187446obc.20
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=J05bHURtp3CXpTSMaMU0AxXm2a89WI+wkDwfj30O+cw=;
        b=DOLeM4LkuAmWM9OupXRjT0qk+HAxXn6PulDNACevppzVoIutE5TFNFy9RNUC8XoiU7
         CHZUWk8GG/LL6gZHl6XmFE33OoyFo9dy56b0EiQ2i3RuV1Q+D9J+CvzCsHLipn3JcW80
         BTMBONVW4N4Psa2OGH8g1zJzT9zK7GuIish/fyj7NbQWknzQD+2RN5llOuyvY0eAbOkF
         IyLSmBE6Krdtp6g32kyaOy6Xxi4iGYzeSUaJVLDrKTNkDKZz2RreCQP/eCOfB7UP2vve
         MO6uCammewiEApMc8PHg66IIxObmcoRHaAa90mnUd41pV7xlheH7mAvNpJ8kUpnwfcmN
         5F3g==
X-Received: by 10.182.171.99 with SMTP id at3mr19625644obc.25.1367058090063;
        Sat, 27 Apr 2013 03:21:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm11676365obb.0.2013.04.27.03.21.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222627>

If this option causes so much trouble, lets just not use it.

The supposed advantages of specifying the 'filenames' is that 1) a slash
is added at the end, 2) trailing spaces are removed (which doesn't seem
to be true), and 3) special characters are quoted. We can do all those
things by ourselves.

Also, this will allow us to add a space after the completion, just like
it happened before fea16b4 (git-completion.bash: add support for path
completion), and just like the rest of the script does.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 43 ++++------------------------------
 t/t9902-completion.sh                  |  6 ++---
 2 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9cea170..5dd6646 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -253,12 +253,12 @@ __gitcomp_file ()
 	# This means that COMPREPLY will be empty and Bash default
 	# completion will be used.
 	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
-
-	# Tell Bash that compspec generates filenames.
-	compopt -o filenames 2>/dev/null
 }
 
-__git_index_file_list_filter_compat ()
+# Process path list returned by "ls-files" and "diff-index --name-only"
+# commands, in order to list only file names relative to a specified
+# directory, and append a slash to directory names.
+__git_index_file_list_filter ()
 {
 	local path
 
@@ -270,33 +270,6 @@ __git_index_file_list_filter_compat ()
 	done
 }
 
-__git_index_file_list_filter_bash ()
-{
-	local path
-
-	while read -r path; do
-		case "$path" in
-		?*/*)
-			# XXX if we append a slash to directory names when using
-			# `compopt -o filenames`, Bash will append another slash.
-			# This is pretty stupid, and this the reason why we have to
-			# define a compatible version for this function.
-			echo "${path%%/*}" ;;
-		*)
-			echo "$path" ;;
-		esac
-	done
-}
-
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
@@ -2651,14 +2624,6 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 
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
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 81a1657..e6cdb05 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -396,10 +396,10 @@ test_expect_success 'complete files' '
 	: TODO .gitignore should not be here &&
 	test_completion "git mv modified " <<-\EOF &&
 	.gitignore
-	dir
+	dir/
 	modified
 	untracked
-	untracked-dir
+	untracked-dir/
 	EOF
 
 	test_completion "git commit " "modified" &&
@@ -407,7 +407,7 @@ test_expect_success 'complete files' '
 	: TODO .gitignore should not be here &&
 	test_completion "git ls-files " <<-\EOF
 	.gitignore
-	dir
+	dir/
 	modified
 	EOF
 
-- 
1.8.2.1.1031.g2ee5873
