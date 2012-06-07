From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4] completion: add new zsh completion
Date: Thu,  7 Jun 2012 03:29:44 +0200
Message-ID: <1339032584-2877-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 01:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScPgv-0003Cw-26
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 01:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab2FFXbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 19:31:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36717 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab2FFXa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 19:30:59 -0400
Received: by wibhj8 with SMTP id hj8so5518365wib.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8mtHF0MWz+02DjEWJpXkroQfVxcdUUcR5qcJX1zOutM=;
        b=MUzkb+NMSswqMKCyMuGIvDVmFngBmgevoR1JQd/pdzrqHVlWTz3IcmjuDovZc71Opu
         St/qhTaD8hwzz8jiyUFvoud8+if2QtXB7a7cCeOrq+fifxFWagEMCl5wU3Mp/glFaWa0
         SRSPIHLZ8uusdl4uISHBO3yxp9LwoNH1cihrKHEwrzAqm7raRFh9sDe/mp4LNYp1ZHgq
         S+FyOXT8iTbMnnb8lIvGng64uKUZYlw9jc7clWssxT4I64lekeZx6ra+1CsVtZ0XyBk1
         29WG0nKS6gyeFfERE9npEoo0WEPhYzhfUIxi9LbDvE3VzX2TbEj5Kn0+ZMn/r0EYuYsC
         4Swg==
Received: by 10.216.211.209 with SMTP id w59mr17777052weo.160.1339025458018;
        Wed, 06 Jun 2012 16:30:58 -0700 (PDT)
Received: from localhost (ip-109-43-0-125.web.vodafone.de. [109.43.0.125])
        by mx.google.com with ESMTPS id hv7sm4348262wib.0.2012.06.06.16.30.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 16:30:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199361>

It seems there's always issues with zsh's bash completion emulation.
I've tried to fix as many as I could and most of the fixes are already
in the latest version of zsh, but still, there are issues.

There is no point going through all that pain; the emulation is easy to
achieve, and this patch works better than zsh's emulation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
v4:

 * Simplification updates for the latest bash completion

v3:

 * Simplification
 * Avoid COMPREPLY; call compadd directly
 * Fix _get_comp_words_by_ref

 contrib/completion/git-completion.zsh |   68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..07fa5a4
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,68 @@
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
+	compadd -Q -S "$3" -P "$2" -p "${(M)cur#*[=:]}" -- ${=1} && _ret=0
+}
+
+__gitcomp ()
+{
+	local cur_="${3-$cur}"
+
+	case "$cur_" in
+	--*=)
+		;;
+	*)
+		local IFS=$'\n'
+		__gitcompadd "$(__gitcomp_1 "${1-}")" "${2-}" ""
+		;;
+	esac
+}
+
+__gitcomp_nl ()
+{
+	local IFS=$'\n'
+	__gitcompadd "$1" "${2-}" "${4- }"
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
+		_main_${service}
+	}
+	let _ret && _default -S '' && _ret=0
+	return _ret
+}
+
+_git
-- 
1.7.10.3
