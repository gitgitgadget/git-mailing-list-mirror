From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 02:01:39 +0200
Message-ID: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 01:02:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrehU-00069p-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 01:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2A3ACT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 19:02:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55208 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab2A3ACS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 19:02:18 -0500
Received: by mail-ww0-f44.google.com with SMTP id ed3so3946527wgb.1
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 16:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VhDKlQOWDuEe//R37BI4LwGezEzbmb4Ba8QFQqmmFNs=;
        b=QnG/jdHqzzTkJpryL8Z+dP7nGM5qBRqsgYTaFZh6WPFhQ8sidjg23JForRpkwLIbq6
         TZ9VoKVPyyIND9JoAzU9EQm2UAmLKAr1xfFeNerjCQhpeoHgNSM+gRfSuzBLeBw4QBpX
         QVsO9Qsrbl/l7Ta3LkQbDhboELTCq6l7qNOBk=
Received: by 10.180.103.97 with SMTP id fv1mr24136443wib.17.1327881738169;
        Sun, 29 Jan 2012 16:02:18 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id t15sm26629406wiv.6.2012.01.29.16.02.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 16:02:16 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189310>

It seems there's always issues with zsh's bash completion emulation,
after I took a deep look at the code, I found many issues[1].

So, here is a kind of wrapper that does the same, but properly :)

This would also allow us to make fixes if necessary, since the code is
simple enough, and extend functionality.

[1] http://article.gmane.org/gmane.comp.shells.zsh.devel/24290

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh |  146 +++++++++++++++++++++++++++++++++
 1 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..15961df
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,146 @@
+#compdef git gitk
+
+compgen () {
+	local prefix suffix
+	local -a results
+	while getopts "W:P:S:" opt
+	do
+		case $opt in
+		W)
+			results=( ${(Q)~=OPTARG} )
+			;;
+		P)
+			prefix="$OPTARG"
+			;;
+		S)
+			suffix="$OPTARG"
+			;;
+		esac
+	done
+	print -l -r -- "$prefix${^results[@]}$suffix"
+}
+
+complete () {
+	# do nothing
+	return 0
+}
+
+ZSH_VERSION='' . /usr/share/git/completion/git-completion.bash
+
+_get_comp_words_by_ref ()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=${_words[CURRENT]}
+			;;
+		prev)
+			cur=${_words[CURRENT-1]}
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
+_bash_wrap ()
+{
+	local -a COMPREPLY results _words
+	_words=( $words )
+	() {
+		emulate -L sh
+		setopt kshglob noshglob braceexpand nokshautoload
+		typeset -h words
+		local cur words cword prev
+		_get_comp_words_by_ref -n =: cur words cword prev
+		$1
+	} $1
+	results=( "${^COMPREPLY[@]}" )
+	local COMP_WORDBREAKS="\"'@><=;|&(:"
+	local i start
+	local cur="${words[CURRENT]}"
+	i=$(expr index "$cur" "$COMP_WORDBREAKS")
+	start="${cur:0:$i}"
+	compadd -Q -S '' -p "$start" -a results && return 0
+}
+
+_gitk ()
+{
+	__git_has_doubledash && return
+
+	local g="$(__gitdir)"
+	local merge=""
+	if [ -f "$g/MERGE_HEAD" ]; then
+		merge="--merge"
+	fi
+	case "$cur" in
+	--*)
+		__gitcomp "
+		$__git_log_common_options
+		$__git_log_gitk_options
+		$merge
+		"
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
+_git ()
+{
+	if [[ $service != git ]]
+	then
+		_bash_wrap _$service
+		return ret
+	fi
+
+	local ret=1
+	local curcontext="$curcontext" state state_descr line
+	typeset -A opt_args
+
+	_arguments -C \
+		'(-p --paginate --no-pager)'{-p,--paginate}'[Pipe all output into ''less'']' \
+		'(-p --paginate)--no-pager[Do not pipe git output into a pager]' \
+		'--git-dir=-[Set the path to the repository]: :_directories' \
+		'--bare[Treat the repository as a bare repository]' \
+		'(- :)--version[Prints the git suite version]' \
+		'--exec-path=-[Path to where your core git programs are installed]:: :_directories' \
+		'--html-path[Print the path where git''s HTML documentation is installed]' \
+		'--work-tree=-[Set the path to the working tree]: :_directories' \
+		'--namespace=-[Set the git namespace]: :_directories' \
+		'(- :)--help[Prints the synopsis and a list of the most commonly used commands]' \
+		'(-): :->command' \
+		'(-)*:: :->option-or-argument' && return 0
+
+	case $state in
+	(command)
+		emulate sh -c __git_compute_porcelain_commands
+		local -a porcelain aliases
+		porcelain=( ${=__git_porcelain_commands} )
+		aliases=( $(__git_aliases) )
+		_describe -t porcelain-commands 'porcelain commands' porcelain && ret=0
+		_describe -t aliases 'aliases' aliases && ret=0
+		;;
+	(option-or-argument)
+		local command="${words[1]}"
+
+		completion_func="_git_${command//-/_}"
+		declare -f $completion_func >/dev/null && _bash_wrap $completion_func && return 0
+
+		local expansion=$(__git_aliased_command "$command")
+		if [ -n "$expansion" ]; then
+			completion_func="_git_${expansion//-/_}"
+			declare -f $completion_func >/dev/null && _bash_wrap $completion_func && return 0
+		fi
+		;;
+	esac
+
+	return ret
+}
+
+_git
-- 
1.7.8.3
