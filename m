From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/11] completion: refactor diff_index wrappers
Date: Sat, 27 Apr 2013 05:19:48 -0500
Message-ID: <1367057994-19887-6-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GV-0003W0-8k
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab3D0KVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:49 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:36864 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab3D0KVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:25 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so4807520oag.32
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xA2XhJjsiHLNn4l9RYS0jnwJAprEo6tG98kMVINYUx0=;
        b=xGfTr+aYCIWA72WYd+SmGYhg63vz1lWXYHDBRxy1xZnLDSr1qkVeXCPiHHGsw0GF53
         INJVRSsuVIZ+mnkBgR3JZva7PJ+dHiBAUAQSop+zeDbGGdXUpIZUSQWmPea5a3ujfFiQ
         59yRflNt1qPgxC1vNLj/ksyjxP/kVpzbsAFDA0JtMMaUDVeA0mcPUG7JYLHd894e15xk
         NwNMVTyvdGXhXcbuEMqHOLE2vCSiebnVWFXKErirJ9iozHa8SDZYr/7N4Sy8pBCpJKOW
         AcTWPW+fdWF7swCfCtOzJhlarq9ZmHFHs7d/LOxp/cqbIZvKn1KVWBJJKGYSOu1XBbxh
         eRnQ==
X-Received: by 10.60.124.3 with SMTP id me3mr18750081oeb.89.1367058084985;
        Sat, 27 Apr 2013 03:21:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id xz9sm12077586oeb.5.2013.04.27.03.21.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222634>

At the end of the day what we really need is to find out the files that
have been staged, or modified, because those files are the ones that
make sense to pass as arguments to 'git commit'.

We need diff-index to find those out, since 'git ls-files' doesn't do
that.

But we don't need wrappers and wrappers basically identical to the ones
used for 'git ls-files', when we can pretend it receives a --committable
option that would return what we need.

That way, we can remove a bunch of code without any functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 71 ++++++++--------------------------
 1 file changed, 16 insertions(+), 55 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7f1ebe4..2561265 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -297,30 +297,25 @@ __git_index_file_list_filter ()
 	__git_index_file_list_filter_bash
 }
 
-# Execute git ls-files, returning paths relative to the directory
-# specified in the first argument, and using the options specified in
-# the second argument.
+# Execute 'git ls-files', unless the --committable option is specified, in
+# which case it runs 'git diff-index' to find out the files that can be
+# committed.  It return paths relative to the directory specified in the first
+# argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
 	(
 		test -n "${CDPATH+set}" && unset CDPATH
-		# NOTE: $2 is not quoted in order to support multiple options
-		cd "$1" && git ls-files --exclude-standard $2
+		cd "$1"
+		if [ "$2" == "--committable" ]; then
+			git diff-index --name-only --relative HEAD
+		else
+			# NOTE: $2 is not quoted in order to support multiple options
+			git ls-files --exclude-standard $2
+		fi
 	) 2>/dev/null
 }
 
 
-# Execute git diff-index, returning paths relative to the directory
-# specified in the first argument, and using the tree object id
-# specified in the second argument.
-__git_diff_index_helper ()
-{
-	(
-		test -n "${CDPATH+set}" && unset CDPATH
-		cd "$1" && git diff-index --name-only --relative "$2"
-	) 2>/dev/null
-}
-
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
 # 2: A directory path (optional).
@@ -337,22 +332,6 @@ __git_index_files ()
 	fi
 }
 
-# __git_diff_index_files accepts 1 or 2 arguments:
-# 1) The id of a tree object.
-# 2) A directory path (optional).
-#    If provided, only files within the specified directory are listed.
-#    Sub directories are never recursed.  Path must have a trailing
-#    slash.
-__git_diff_index_files ()
-{
-	local dir="$(__gitdir)" root="${2-.}"
-
-	if [ -d "$dir" ]; then
-		__git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
-			sort | uniq
-	fi
-}
-
 __git_heads ()
 {
 	local dir="$(__gitdir)"
@@ -550,8 +529,10 @@ __git_complete_revlist_file ()
 }
 
 
-# __git_complete_index_file requires 1 argument: the options to pass to
-# ls-file
+# __git_complete_index_file requires 1 argument:
+# 1: the options to pass to ls-file
+#
+# The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
 	local pfx cur_="$cur"
@@ -570,26 +551,6 @@ __git_complete_index_file ()
 	esac
 }
 
-# __git_complete_diff_index_file requires 1 argument: the id of a tree
-# object
-__git_complete_diff_index_file ()
-{
-	local pfx cur_="$cur"
-
-	case "$cur_" in
-	?*/*)
-		pfx="${cur_%/*}"
-		cur_="${cur_##*/}"
-		pfx="${pfx}/"
-
-		__gitcomp_file "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_"
-		;;
-	*)
-		__gitcomp_file "$(__git_diff_index_files "$1")" "" "$cur_"
-		;;
-	esac
-}
-
 __git_complete_file ()
 {
 	__git_complete_revlist_file
@@ -1211,7 +1172,7 @@ _git_commit ()
 	esac
 
 	if git rev-parse --verify --quiet HEAD >/dev/null; then
-		__git_complete_diff_index_file "HEAD"
+		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
 		__git_complete_index_file "--cached"
-- 
1.8.2.1.1031.g2ee5873
