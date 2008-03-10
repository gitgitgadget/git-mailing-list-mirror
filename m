From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add 'git svn' subcommands and options
Date: Mon, 10 Mar 2008 16:02:25 +0100
Message-ID: <1205161345-21120-4-git-send-email-szeder@ira.uka.de>
References: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
 <1205161345-21120-2-git-send-email-szeder@ira.uka.de>
 <1205161345-21120-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjXE-0003YV-DE
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYCJPCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 11:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCJPCd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:02:33 -0400
Received: from francis.fzi.de ([141.21.7.5]:44346 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751427AbYCJPCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:02:31 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 16:02:24 +0100
X-Mailer: git-send-email 1.5.4.4.481.g5075
In-Reply-To: <1205161345-21120-3-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 10 Mar 2008 15:02:24.0861 (UTC) FILETIME=[BFD1A0D0:01C882BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76734>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   81 ++++++++++++++++++++++++=
+++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c194972..5a844f5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -392,7 +392,6 @@ __git_commands ()
 		show-index)       : plumbing;;
 		ssh-*)            : transport;;
 		stripspace)       : plumbing;;
-		svn)              : import export;;
 		symbolic-ref)     : plumbing;;
 		tar-tree)         : deprecated;;
 		unpack-file)      : plumbing;;
@@ -1150,6 +1149,84 @@ _git_submodule ()
 	fi
 }
=20
+_git_svn ()
+{
+	local subcommands=3D"
+		init fetch clone rebase dcommit log find-rev
+		set-tree commit-diff info create-ignore propget
+		proplist show-ignore show-externals
+		"
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		local remote_opts=3D"--username=3D --config-dir=3D --no-auth-cache"
+		local fc_opts=3D"
+			--follow-parent --authors-file=3D --repack=3D
+			--no-metadata --use-svm-props --use-svnsync-props
+			--log-window-size=3D --no-checkout --quiet
+			--repack-flags --user-log-author $remote_opts
+			"
+		local init_opts=3D"
+			--template=3D --shared=3D --trunk=3D --tags=3D
+			--branches=3D --stdlayout --minimize-url
+			--no-metadata --use-svm-props --use-svnsync-props
+			--rewrite-root=3D $remote_opts
+			"
+		local cmt_opts=3D"
+			--edit --rmdir --find-copies-harder --copy-similarity=3D
+			"
+
+		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		case "$subcommand,$cur" in
+		fetch,--*)
+			__gitcomp "--revision=3D --fetch-all $fc_opts"
+			;;
+		clone,--*)
+			__gitcomp "--revision=3D $fc_opts $init_opts"
+			;;
+		init,--*)
+			__gitcomp "$init_opts"
+			;;
+		dcommit,--*)
+			__gitcomp "
+				--merge --strategy=3D --verbose --dry-run
+				--fetch-all --no-rebase $cmt_opts $fc_opts
+				"
+			;;
+		set-tree,--*)
+			__gitcomp "--stdin $cmt_opts $fc_opts"
+			;;
+		create-ignore,--*|propget,--*|proplist,--*|show-ignore,--*|\
+		show-externals,--*)
+			__gitcomp "--revision=3D"
+			;;
+		log,--*)
+			__gitcomp "
+				--limit=3D --revision=3D --verbose --incremental
+				--oneline --show-commit --non-recursive
+				--authors-file=3D
+				"
+			;;
+		rebase,--*)
+			__gitcomp "
+				--merge --verbose --strategy=3D --local
+				--fetch-all $fc_opts
+				"
+			;;
+		commit-diff,--*)
+			__gitcomp "--message=3D --file=3D --revision=3D $cmt_opts"
+			;;
+		info,--*)
+			__gitcomp "--url"
+			;;
+		*)
+			COMPREPLY=3D()
+			;;
+		esac
+	fi
+}
+
 _git_tag ()
 {
 	local i c=3D1 f=3D0
@@ -1251,6 +1328,7 @@ _git ()
 	show-branch) _git_log ;;
 	stash)       _git_stash ;;
 	submodule)   _git_submodule ;;
+	svn)         _git_svn ;;
 	tag)         _git_tag ;;
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=3D() ;;
@@ -1301,6 +1379,7 @@ complete -o default -o nospace -F _git_shortlog g=
it-shortlog
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
 complete -o default -o nospace -F _git_submodule git-submodule
+complete -o default -o nospace -F _git_svn git-svn
 complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_tag git-tag
 complete -o default -o nospace -F _git_log git-whatchanged
--=20
1.5.4.4.481.g5075
