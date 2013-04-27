From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/11] completion: remove __git_index_file_list_filter()
Date: Sat, 27 Apr 2013 05:19:53 -0500
Message-ID: <1367057994-19887-11-git-send-email-felipe.contreras@gmail.com>
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
	id 1UW2GU-0003W0-Ay
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab3D0KVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:39 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:62459 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab3D0KVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:38 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so4802854oag.36
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vR+LhT2qr3OTcNEDV7oMhId5U7NwPv73p13t8NXhjy4=;
        b=ZthuebFI4VyWOVUkGVCfT11R7+pYYV2kKvSJRBHeDzFY18k0jsYr1bxicdQZk0d6hx
         JtW1O8FkyK8DmPK1s49cC9piiipMeBn1KEA0U80NOPGpwXQotINa9VDGBdBv8AoD88yW
         xsaFLbJwU9KhuIsrOtXrN/iR6SpnoJSi/D6BD8zzsEbeAKA26bL8ZmgiZIbLvyBg9tSQ
         ShDnqGU4V1AB3GbpZDnd7nLjggkGUjBHX2hJjQyq+E95MBe5E6RjVWyzMU71X3tOZ1U0
         o6YbYxWb6D22YUZhIqPBYaEShSN4w8uJQLtjSeIfIxAaAvdtRxwkkkgbj8i6PJ6PDd6r
         llcA==
X-Received: by 10.60.65.68 with SMTP id v4mr20458511oes.13.1367058098070;
        Sat, 27 Apr 2013 03:21:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm11675128obc.1.2013.04.27.03.21.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222635>

Refactor the code into the only caller; __git_index_files().

Also, Somehow messing up with the 'path' variable messes up the 'PATH'
variable. So let's not do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60a6a0b..8100085 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -237,21 +237,6 @@ __gitcomp_nl ()
 	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
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
-		?*/*) echo "${path%%/*}/" ;;
-		*) echo "$path " ;;
-		esac
-	done
-}
-
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
@@ -279,11 +264,16 @@ __git_ls_files_helper ()
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
+			?*/*) echo "${file%%/*}/" ;;
+			*) echo "$file " ;;
+			esac
+		done | sort | uniq
 	fi
 }
 
-- 
1.8.2.1.1031.g2ee5873
