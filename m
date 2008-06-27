From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH/RFC] stash: introduce 'stash save --keep-index' option
Date: Fri, 27 Jun 2008 16:37:15 +0200
Message-ID: <20080627143715.GD6747@neumann>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	<20080627071014.GA12344@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 16:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCF5e-0008IM-O5
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 16:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbYF0OhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 10:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbYF0OhT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 10:37:19 -0400
Received: from francis.fzi.de ([141.21.7.5]:25502 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755678AbYF0OhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 10:37:17 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Jun 2008 16:37:14 +0200
Content-Disposition: inline
In-Reply-To: <20080627071014.GA12344@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 27 Jun 2008 14:37:14.0950 (UTC) FILETIME=[4ADE3E60:01C8D863]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86566>

'git stash save' saves local modifications to a new stash, and runs 'gi=
t
reset --hard' to revert them to a clean index and work tree.  When the
'--keep-index' option is specified, after that 'git reset --hard' the
previous contents of the index is restored and the work tree is updated
to match the index.  This option is useful if the user wants to commit
only parts of his local modifications, but wants to test those parts
before committing.

Also add support for the completion of the new option, and add an
example use case to the documentation.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Fri, Jun 27, 2008 at 09:10:14AM +0200, Bj=F6rn Steinbrink wrote:
> Hm, I use "stash" for that purpose, which leads to kind of the revers=
e
> of your approach. So I do sth. like this:
>=20
>  - hack hack hack
>  - Notice that I want to make two commits out of what I have in my
>    working tree
>  - git add -p -- stage what I want in the first commit
>  - git commit -m tmp -- temporary commit
>  - git stash -- stash away what doesn't belong in the first commit
>  - git reset HEAD^ -- drop the temporary commit, with the changes kep=
t
>    in the working tree
>  - test, fix bugs, read the diff, whatever
>  - git commit -- this time for good
>  - git stash apply -- get back the changes for the second commit
I used to do the same, so I have added a '--keep-index' option to 'git
stash save' to simplify this workflow.  Have a look at the use case
added to the documentation to see, how you could spare the temporary
commit and the 'reset HEAD^'.

RFC, because I'm not quite confident with using plumbing like 'git
read-tree'...  and there are no tests.


 Documentation/git-stash.txt            |   22 +++++++++++++++++++++-
 contrib/completion/git-completion.bash |   13 ++++++++++++-
 git-stash.sh                           |   22 ++++++++++++++++++----
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index baa4f55..936864f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -36,12 +36,15 @@ is also possible).
 OPTIONS
 -------
=20
-save [<message>]::
+save [--keep-index] [<message>]::
=20
 	Save your local modifications to a new 'stash', and run `git-reset
 	--hard` to revert them.  This is the default action when no
 	subcommand is given. The <message> part is optional and gives
 	the description along with the stashed state.
++
+If the `--keep-index` option is used, all changes already added to the
+index are left intact.
=20
 list [<options>]::
=20
@@ -169,6 +172,23 @@ $ git stash apply
 ... continue hacking ...
 ----------------------------------------------------------------
=20
+Testing partial commits::
+
+You can use `git stash save --keep-index` when you want to make two or
+more commits out of the changes in the work tree, and you want to test
+each change before committing:
++
+----------------------------------------------------------------
+... hack hack hack ...
+$ git add --patch foo
+$ git stash save --keep-index
+$ build && run tests
+$ git commit -m 'First part'
+$ git stash apply
+$ build && run tests
+$ git commit -a -m 'Second part'
+----------------------------------------------------------------
+
 SEE ALSO
 --------
 linkgit:git-checkout[1],
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ebf7cde..9a15500 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1139,8 +1139,19 @@ _git_show ()
 _git_stash ()
 {
 	local subcommands=3D'save list show apply clear drop pop create'
-	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
+	else
+		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		case "$subcommand,$cur" in
+		save,--*)
+			__gitcomp "--keep-index"
+			;;
+		*)
+			COMPREPLY=3D()
+			;;
+		esac
 	fi
 }
=20
diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..92531a2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -86,6 +86,13 @@ create_stash () {
 }
=20
 save_stash () {
+	keep_index=3D
+	case "$1" in
+	--keep-index)
+		keep_index=3Dt
+		shift
+	esac
+
 	stash_msg=3D"$1"
=20
 	if no_changes
@@ -104,6 +111,13 @@ save_stash () {
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
 	printf 'Saved working directory and index state "%s"\n' "$stash_msg"
+
+	git reset --hard
+
+	if test -n "$keep_index" && test -n $i_tree
+	then
+		git read-tree --reset -u $i_tree
+	fi
 }
=20
 have_stash () {
@@ -153,7 +167,8 @@ apply_stash () {
 		die "$*: no valid stashed state found"
=20
 	unstashed_index_tree=3D
-	if test -n "$unstash_index" && test "$b_tree" !=3D "$i_tree"
+	if test -n "$unstash_index" && test "$b_tree" !=3D "$i_tree" &&
+			test "$c_tree" !=3D "$i_tree"
 	then
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
@@ -235,7 +250,7 @@ show)
 	;;
 save)
 	shift
-	save_stash "$*" && git-reset --hard
+	save_stash "$*"
 	;;
 apply)
 	shift
@@ -268,8 +283,7 @@ pop)
 	if test $# -eq 0
 	then
 		save_stash &&
-		echo '(To restore them type "git stash apply")' &&
-		git-reset --hard
+		echo '(To restore them type "git stash apply")'
 	else
 		usage
 	fi
--=20
1.5.6.1.95.ge713
