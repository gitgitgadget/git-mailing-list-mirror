From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: support user-supplied completion scripts for user's
	git commands
Date: Fri, 29 Jan 2010 20:06:42 +0100
Message-ID: <20100129190642.GA31303@neumann>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	<20100129151127.GA21821@spearce.org>
	<7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	<20100129175950.GE21821@spearce.org>
	<7vockciyb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 20:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NawBB-00020X-Ra
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 20:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0A2TGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 14:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807Ab0A2TGr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 14:06:47 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:61731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0A2TGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 14:06:46 -0500
Received: from [127.0.1.1] (p5B130E12.dip0.t-ipconnect.de [91.19.14.18])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M8JwA-1NwZnd1xvW-00vLJU; Fri, 29 Jan 2010 20:06:44 +0100
Content-Disposition: inline
In-Reply-To: <7vockciyb8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1+M7cB+e7VRxV/SyQONqw+tIOt8lXKAdGJ/+JV
 +GQMuCO7ZxG28X4mjt1qelGPnK+lAps79wxXJf8WHyPstXP9VW
 LegF1M1nWU0b/bKjvHh8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138339>

The bash completion script already provides support to complete
aliases, options and refs for aliases (if the alias can be traced back
to a supported git command by __git_aliased_command()), and the user's
custom git commands, but it does not support the options of the user's
custom git commands (of course; how could it know about the options of
a custom git command?).  Users of such custom git commands could
extend git's bash completion script by writing functions to support
their commands, but they might have issues with it: they might not
have the rights to modify a system-wide git completion script, and
they will need to track and merge upstream changes in the future.

This patch addresses this by providing means for users to supply
custom completion scriplets for their custom git commands without
modifying the main git bash completion script.

Instead of having a huge hard-coded list of command-completion
function pairs (in _git()), the completion script will figure out
which completion function to call based on the command's name.  That
is, when completing the options of 'git foo', the main completion
script will check whether the function '_git_foo' is declared, and if
declared, it will invoke that function to perform the completion.  If
such a function is not declared, it will fall back to complete file
names.  So, users will only need to provide this '_git_foo' completion
function in a separate file, source that file, and it will be used the
next time they press TAB after 'git foo '.

There are two git commands (stage and whatchanged), for which the
completion functions of other commands were used, therefore they
got their own completion function.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

How about something like this for subcommands (not aliases)?  It's a
good code size reduction anyway.

 contrib/completion/git-completion.bash |   67 ++++++------------------=
--------
 1 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index da46bf8..2cecf4f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1433,6 +1433,11 @@ _git_send_email ()
 	COMPREPLY=3D()
 }
=20
+_git_stage ()
+{
+	_git_add
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file=3D c=3D$COMP_CWORD
@@ -2164,6 +2169,11 @@ _git_tag ()
 	esac
 }
=20
+_git_whatchanged ()
+{
+	_git_log
+}
+
 _git ()
 {
 	local i c=3D1 command __git_dir
@@ -2203,61 +2213,8 @@ _git ()
 	local expansion=3D$(__git_aliased_command "$command")
 	[ "$expansion" ] && command=3D"$expansion"
=20
-	case "$command" in
-	am)          _git_am ;;
-	add)         _git_add ;;
-	apply)       _git_apply ;;
-	archive)     _git_archive ;;
-	bisect)      _git_bisect ;;
-	bundle)      _git_bundle ;;
-	branch)      _git_branch ;;
-	checkout)    _git_checkout ;;
-	cherry)      _git_cherry ;;
-	cherry-pick) _git_cherry_pick ;;
-	clean)       _git_clean ;;
-	clone)       _git_clone ;;
-	commit)      _git_commit ;;
-	config)      _git_config ;;
-	describe)    _git_describe ;;
-	diff)        _git_diff ;;
-	difftool)    _git_difftool ;;
-	fetch)       _git_fetch ;;
-	format-patch) _git_format_patch ;;
-	fsck)        _git_fsck ;;
-	gc)          _git_gc ;;
-	grep)        _git_grep ;;
-	help)        _git_help ;;
-	init)        _git_init ;;
-	log)         _git_log ;;
-	ls-files)    _git_ls_files ;;
-	ls-remote)   _git_ls_remote ;;
-	ls-tree)     _git_ls_tree ;;
-	merge)       _git_merge;;
-	mergetool)   _git_mergetool;;
-	merge-base)  _git_merge_base ;;
-	mv)          _git_mv ;;
-	name-rev)    _git_name_rev ;;
-	notes)       _git_notes ;;
-	pull)        _git_pull ;;
-	push)        _git_push ;;
-	rebase)      _git_rebase ;;
-	remote)      _git_remote ;;
-	replace)     _git_replace ;;
-	reset)       _git_reset ;;
-	revert)      _git_revert ;;
-	rm)          _git_rm ;;
-	send-email)  _git_send_email ;;
-	shortlog)    _git_shortlog ;;
-	show)        _git_show ;;
-	show-branch) _git_show_branch ;;
-	stash)       _git_stash ;;
-	stage)       _git_add ;;
-	submodule)   _git_submodule ;;
-	svn)         _git_svn ;;
-	tag)         _git_tag ;;
-	whatchanged) _git_log ;;
-	*)           COMPREPLY=3D() ;;
-	esac
+	local completion_func=3D"_git_${command//-/_}"
+	declare -F $completion_func >/dev/null && $completion_func
 }
=20
 _gitk ()
--=20
1.7.0.rc0.78.g2070a
