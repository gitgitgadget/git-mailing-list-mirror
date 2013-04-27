From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 9/9] completion: remove __git_index_file_list_filter()
Date: Sat, 27 Apr 2013 15:10:07 -0500
Message-ID: <1367093407-8898-10-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTT-0000Wy-VQ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab3D0ULx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:53 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49898 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262Ab3D0ULw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id k3so4978731oag.19
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2J/jiaHMaQl3GBimEr+U2yct6cjcD7Vgv5inY4I9aRk=;
        b=Uz+zpMe+FyUzW+ocW26iRwiPz9mNBFY2gVBL81ouSNIz2bp3ld8wz4oFiEJ0oRNcJO
         c93YFPHj22AZaRAljNU58yie+rzSsr5SR5hK+qM/etyvl7hhV69gP3ydws/f4QXUmPHF
         /J0Y+8sOiKfZOC8gDnwIkDhjlGBsBXPFaayZThE+TXbHsddRUF8/4kxO9fL8+4hRhv5t
         Og9uN5q7LRNBLJbJcSRcp+HIh+iJOqRCdOyALm3GG7XxqPbepAu8bkDlrXj5fmJyuZBW
         rECj2NXSYn3OQ7irgv7vmB0Q2l70rO+1GsKSP70uM8b5NPv4Tk7IWkl7vTRAQv6wGVoI
         dk2Q==
X-Received: by 10.60.79.161 with SMTP id k1mr6496992oex.106.1367093512112;
        Sat, 27 Apr 2013 13:11:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm13346612obc.1.2013.04.27.13.11.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222690>

Refactor the code into the only caller; __git_index_files().

Also, Somehow messing up with the 'path' variable messes up the 'PATH'
variable. So let's not do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 20c9718..edb7428 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -259,23 +259,6 @@ __gitcomp_file ()
 	compgen -f /non-existing-dir/ > /dev/null
 }
 
-# Process path list returned by "ls-files" and "diff-index --name-only"
-# commands, in order to list only file names relative to a specified
-# directory, and append a slash to directory names.
-__git_index_file_list_filter ()
-{
-	local path
-
-	while read -r path; do
-		case "$path" in
-		?*/*)
-			echo "${path%%/*}" ;;
-		*)
-			echo "$path" ;;
-		esac
-	done
-}
-
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
@@ -303,11 +286,16 @@ __git_ls_files_helper ()
 #    slash.
 __git_index_files ()
 {
-	local dir="$(__gitdir)" root="${2-.}"
+	local dir="$(__gitdir)" root="${2-.}" file
 
 	if [ -d "$dir" ]; then
-		__git_ls_files_helper "$root" "$1" | __git_index_file_list_filter |
-			sort | uniq
+		__git_ls_files_helper "$root" "$1" |
+		while read -r file; do
+			case "$file" in
+			?*/*) echo "${file%%/*}" ;;
+			*) echo "$file" ;;
+			esac
+		done | sort | uniq
 	fi
 }
 
-- 
1.8.2.1.1031.g2ee5873
