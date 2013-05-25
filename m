From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: improve bash script loading
Date: Fri, 24 May 2013 22:31:44 -0500
Message-ID: <1369452704-5974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 05:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug5EV-0008FX-35
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 05:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab3EYDdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 23:33:23 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:43391 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3EYDdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 23:33:22 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6842919oag.25
        for <git@vger.kernel.org>; Fri, 24 May 2013 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jtu8tks08CbHYL+Dx6MIm8pwAvzOfT5GbdULIKv5JiU=;
        b=QtoxLmmNOsrXtSeJa47DlLO1esgnzdX2bPQkze15Y8KERdtgYWuhuTyBTGcFAzUjur
         k6MfMrIZq3Hs0uJDEAru5z4wk7ypqxs1tBmVe0QAAtOFEQnxF1DI0KT7MxgOJfV5frRt
         Ns094Lze1R8MWFY/a25Pb2DgsGKIcKnJpPRKLjhtEurIL1CgFpj1IAvHkNEXc1/GZQid
         JjSuEtQNagBuZZufEk9y3EjN2OGpvvf2aNiPn9cLPR85t98vtGMyl/yBp/K1Spb9EHge
         lFInAxTwTkj3a1Z0fgeTATL83RCiXrQVHZoaIOk+arUNCjhuzMcKJC4pDE7QNKPvlU3L
         CKFA==
X-Received: by 10.60.125.101 with SMTP id mp5mr6621453oeb.18.1369452801805;
        Fri, 24 May 2013 20:33:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20768124oes.6.2013.05.24.20.33.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 20:33:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225485>

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
