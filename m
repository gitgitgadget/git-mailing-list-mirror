From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/3] completion: add new zsh completion
Date: Sun, 14 Oct 2012 17:52:51 +0200
Message-ID: <1350229971-9343-4-git-send-email-felipe.contreras@gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 17:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQVH-0003nq-9G
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 17:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab2JNPxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 11:53:09 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60930 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2JNPxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 11:53:08 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so93674wib.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GRokxDdGbUf6z14rZKej+7QE8hgVitJQjtKtp8kB8ws=;
        b=oFXpaVNGVfYStn+g59vXm7ev6el5scyxg/01OudxhcmV8uSlEZRw1rbrAqEBMaHaiS
         urFqNpBrkTmjPxI+6U2dtPSzXNebeQn7vcdZCgTSz6YiN67m64sQee8BetrlaU/9gb1F
         S92zIaBh39ici9a02AkRXkULq8KCCbtBUESpXQtEc8f2EpFhiLFXYkimeQTj3hEGelLZ
         O2uiinDrkhPS3zyjt/PTHqN6VO+L6ZonX1nVGXfnp8o5oBoPW4ojWelFn2+4ructvqvu
         oNHI6wUeE6RPF8IWU34/griBbmnrL7MrXi5sRSe4plcnuInBnJSTo2/4csQQcLwWFD4k
         4oxQ==
Received: by 10.216.209.40 with SMTP id r40mr5895183weo.144.1350229986985;
        Sun, 14 Oct 2012 08:53:06 -0700 (PDT)
Received: from localhost (ip-109-43-0-56.web.vodafone.de. [109.43.0.56])
        by mx.google.com with ESMTPS id cn6sm10496278wib.9.2012.10.14.08.53.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 08:53:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
In-Reply-To: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207669>

It seems there's always issues with zsh's bash completion emulation.
I've tried to fix as many as I could and most of the fixes are already
in the latest version of zsh, but still, there are issues.

There is no point in going through all that pain; the emulation is easy
to achieve, and this patch works better than zsh's emulation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

v5:

 * Even more simplification by using __gitcompadd

v4:

 * Simplification updates for the latest bash completion

v3:

 * Simplification
 * Avoid COMPREPLY; call compadd directly
 * Fix _get_comp_words_by_ref

 contrib/completion/git-completion.zsh | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..dbb5261
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,48 @@
+#compdef git gitk
+
+# zsh completion wrapper for git
+#
+# You need git's bash completion script installed somewhere, by default on the
+# same directory as this script.
+#
+# If your script is on ~/.git-completion.sh instead, you can configure it on
+# your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
+#
+# The recommended way to install this script is to copy to
+# '~/.zsh/completion/_git', and then add the following to your ~/.zshrc file:
+#
+#  fpath=(~/.zsh/completion $fpath)
+
+complete ()
+{
+	# do nothing
+	return 0
+}
+
+zstyle -s ":completion:*:*:git:*" script script
+test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+ZSH_VERSION='' . "$script"
+
+__gitcompadd ()
+{
+	compadd -Q -S "$4" -P "$2" -p "${(M)cur#*[=:]}" -- ${=1} && _ret=0
+}
+
+_git ()
+{
+	local _ret=1
+	() {
+		emulate -L ksh
+		local cur cword prev
+		cur=${words[CURRENT-1]}
+		prev=${words[CURRENT-2]}
+		let cword=CURRENT-1
+		__${service}_main
+	}
+	let _ret && _default -S '' && _ret=0
+	return _ret
+}
+
+_git
-- 
1.7.12.1
