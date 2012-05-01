From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] completion: add new zsh completion
Date: Tue,  1 May 2012 20:09:54 +0200
Message-ID: <1335895794-3306-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 20:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHX5-0005Er-81
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733Ab2EASKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:10:34 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59050 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab2EASKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:10:33 -0400
Received: by were53 with SMTP id e53so313037wer.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KciYVbuUJ1mT/HPbzwE1YwU3qClnQIhDTeWLt8dJHcg=;
        b=WTrgk9p7Kq3kq9kw/xA2dUBkf8QOw2+Rb62klv0Dqr7uXXy+vz7cxqW7yDp/qjkIg2
         JeDPGPzihPL/1q7TANQUdI+8Gqs5LMkBkGab+e8ht/CdwkhFSYzaXlSK6xZVBDjn/zDu
         bxZz7ph6soAel8MQLJRTWFiEN6mqhu1hEFehNrDtRj9b9iZrmbZgbiZ0Xvns3cAUx5Zr
         Zi3cMjk2f448tIhy5bzEnp0714qSKBHowVFPGVaOON71OjdQG2fuihC9ERc1+h1SuZN7
         wDiRIfnZ0rXzfHFr2QMyLGDKNfXoU150efqySvQrthA+Z55a/JoiEMj5/sEqmmDubepo
         5r+g==
Received: by 10.180.101.136 with SMTP id fg8mr7057927wib.4.1335895832234;
        Tue, 01 May 2012 11:10:32 -0700 (PDT)
Received: from localhost (gateway02.m3-connect.de. [88.79.237.12])
        by mx.google.com with ESMTPS id ea6sm38141229wib.5.2012.05.01.11.10.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 11:10:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196720>

It seems there's always issues with zsh's bash completion emulation.
I've tried to fix as many as I could and most of the fixes are already
in the latest version of zsh, but still, there are issues.

There is no point going through all that pain; the emulation is easy to
achieve, and this patch works better than zsh's emulation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

v3:

 * Simplification
 * Avoid COMPREPLY; call compadd directly
 * Fix _get_comp_words_by_ref

 contrib/completion/git-completion.zsh |   97 +++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..2f069cc
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,97 @@
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
+_get_comp_words_by_ref ()
+{
+	emulate -L zsh
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=${_words[CURRENT]}
+			;;
+		prev)
+			prev=${_words[CURRENT-1]}
+			;;
+		words)
+			words=("${_words[@]}")
+			;;
+		cword)
+			((cword = CURRENT - 1))
+			;;
+		esac
+		shift
+	done
+}
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
+do_wrap ()
+{
+	typeset -f $1 | sed "s/${1} ()/${1}_wrap ()/"
+}
+
+eval "$(do_wrap _git)"
+eval "$(do_wrap _gitk)"
+
+_git ()
+{
+	local _ret=1
+	local -a _words
+	_words=( $words )
+	() {
+		emulate -L ksh
+		typeset -h words
+		_${service}_wrap
+	}
+	let _ret && _default -S '' && _ret=0
+	return _ret
+}
+
+_git
-- 
1.7.10
