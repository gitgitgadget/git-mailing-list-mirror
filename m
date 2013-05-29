From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: improve bash script loading
Date: Tue, 28 May 2013 22:24:00 -0500
Message-ID: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhX1G-0001mL-4n
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759381Ab3E2DZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:25:42 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64100 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759346Ab3E2DZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:25:41 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so10982601oag.16
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jtu8tks08CbHYL+Dx6MIm8pwAvzOfT5GbdULIKv5JiU=;
        b=Ux+8cwerjmIZqbI+eLtVnjSYYE6SLUbmWsDn6WhtgYJ2X157BR7ct8ZLHMSgeMd+s7
         yrROjMlP4ms416uHa8PK4GmkMMCeOxoWL0j1QcvOFBwHcNwnBnpPz/Ym/26TLyojZ1Cs
         6bgCR4dL1U4up8mpwS05ED5vTRUVmx1dhkt7fRJcRCAQsxZ2GOZjK/AVLaFbKl3tsFhM
         +6L39Bq6O1EWm09LYDfjSIELKDpYXtWuGhImIhv0U86TDT6O2Y/EhK+C/Boq2r4/1VCI
         1B0WPmEYeifpAw5dJa1LVNDvsi77N7rMb0JBvZvbEXuIC1SGJ6I7RL7i00PQsf/ruL7D
         KypA==
X-Received: by 10.60.103.76 with SMTP id fu12mr461380oeb.71.1369797940886;
        Tue, 28 May 2013 20:25:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id hv3sm38186173obb.7.2013.05.28.20.25.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:25:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225712>

It's better to check in multiple locations, so the user doesn't have to.

And update the documentation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2565d2e..9555cf8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -4,18 +4,17 @@
 #
 # Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
 #
-# You need git's bash completion script installed somewhere, by default on the
-# same directory as this script.
+# You need git's bash completion script installed somewhere, by default it
+# would be the location bash-completion uses.
 #
-# If your script is on ~/.git-completion.sh instead, you can configure it on
-# your ~/.zshrc:
+# If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
 #
-# The recommended way to install this script is to copy to
-# '~/.zsh/completion/_git', and then add the following to your ~/.zshrc file:
+# The recommended way to install this script is to copy to '~/.zsh/_git', and
+# then add the following to your ~/.zshrc file:
 #
-#  fpath=(~/.zsh/completion $fpath)
+#  fpath=(~/.zsh $fpath)
 
 complete ()
 {
@@ -27,7 +26,18 @@ zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
 zstyle -s ":completion:*:*:git:*" script script
-test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+if [ -z "$script" ]; then
+	local -a locations
+	locations=(
+		'/etc/bash_completion.d/git' # fedora, old debian
+		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
+		'/usr/share/bash-completion/git' # gentoo
+		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
+		)
+	for e in $locations; do
+		test -f $e && script="$e" && break
+	done
+fi
 ZSH_VERSION='' . "$script"
 
 __gitcomp ()
-- 
1.8.3.rc3.312.g47657de
