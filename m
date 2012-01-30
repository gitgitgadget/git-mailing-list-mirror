From: Felipe Contreras <felipec@infradead.org>
Subject: [PATCH v2] completion: add new zsh completion
Date: Mon, 30 Jan 2012 19:40:45 +0200
Message-ID: <1327945245-7083-1-git-send-email-felipec@infradead.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 18:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvDt-0005By-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab2A3Rkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:40:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38088 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2A3Rkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:40:51 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RrvDl-0000Vh-SB; Mon, 30 Jan 2012 17:40:50 +0000
Received: from bombadil.infradead.org ([2001:4830:2446:ff00:4687:fcff:fea6:5117] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1RrvDl-00052p-70; Mon, 30 Jan 2012 17:40:49 +0000
X-Mailer: git-send-email 1.7.8
X-SRS-Rewrite: SMTP reverse-path rewritten from <felipec@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189381>

From: Felipe Contreras <felipe.contreras@gmail.com>

It seems there's always issues with zsh's bash completion emulation,
after I took a deep look at the code, I found many issues[1].

So, here is a kind of wrapper that does the same, but properly :)

This would also allow us to make fixes if necessary, since the code is
simple enough, and extend functionality.

[1] http://article.gmane.org/gmane.comp.shells.zsh.devel/24290

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

v2:

 * Fix completion of aliased commands
 * Add check for wrong commands
 * Properly set return codes
 * Add default actiooon; for 'git foo -- <tab>'

 contrib/completion/git-completion.zsh |  181 +++++++++++++++++++++++++++++++++
 1 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..bca08f2
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,181 @@
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
+zstyle -s ":completion:$curcontext:" script script
+test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+ZSH_VERSION='' . "$script"
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
+		setopt KSH_TYPESET
+		setopt kshglob noshglob braceexpand nokshautoload
+		typeset -h words
+		local cur words cword prev
+		_get_comp_words_by_ref -n =: cur words cword prev
+		$1
+	} $1
+	results=( "${^COMPREPLY[@]}" )
+	if [[ -n $results ]]; then
+		local COMP_WORDBREAKS="\"'@><=;|&(:"
+		local i start
+		local cur="${words[CURRENT]}"
+		i=$(expr index "$cur" "$COMP_WORDBREAKS")
+		start="${cur:0:$i}"
+		compadd -Q -S '' -p "$start" -a results && ret=0
+	fi
+	if (( ret )); then
+		_default -S '' && ret=0
+	fi
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
+_get_completion_func ()
+{
+	emulate -L sh
+	setopt KSH_TYPESET
+	local command="$1"
+
+	completion_func="_git_${command//-/_}"
+	declare -f $completion_func >/dev/null && return
+
+	local expansion=$(__git_aliased_command "$command")
+	if [ -n "$expansion" ]; then
+		completion_func="_git_${expansion//-/_}"
+		declare -f $completion_func >/dev/null && return
+	fi
+
+	completion_func=
+}
+
+_git ()
+{
+	local ret=1
+
+	if [[ $service != git ]]
+	then
+		_bash_wrap _$service
+		return ret
+	fi
+
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
+		local completion_func
+		_get_completion_func "${words[1]}"
+		test "$completion_func" && _bash_wrap $completion_func
+		;;
+	esac
+
+	return ret
+}
+
+_git
-- 
1.7.8
