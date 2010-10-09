From: Olaf Dabrunz <odabrunz@gmx.net>
Subject: [TopGit PATCH] t/depend-add-using-export
Date: Sat,  9 Oct 2010 03:43:18 +0200
Message-ID: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olaf Dabrunz <odabrunz@gmx.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pasky@suse.cz>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4OeE-0000NS-VV
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760080Ab0JIByt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:54:49 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mailout-de.gmx.net ([213.165.64.23]:56924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1760009Ab0JIBys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:54:48 -0400
Received: (qmail invoked by alias); 09 Oct 2010 01:54:42 -0000
Received: from unknown (EHLO santana.dyndns.org) [109.250.241.189]
  by mail.gmx.net (mp065) with SMTP; 09 Oct 2010 03:54:42 +0200
X-Authenticated: #20497841
X-Provags-ID: V01U2FsdGVkX1+ET9FpKeyERyNUVqyD4bgdcMD/E2zB4qWbvXtk+V
	h8FceUgAL6rDOq
Received: by santana.dyndns.org (Postfix, from userid 1000)
	id 98BC392A5; Sat,  9 Oct 2010 03:54:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158572>

When dependencies can be removed as well as added, tg depend add
needs to make sure that the new dependency can bring in changes
from a branch that has previously been removed as a dependency
from the current TopGit branch.

This implementation uses an exported branch set up by tg export,
and merges the new dependency into the commit that corresponds to
the current base. Using the exported branch in the merge has the
advantage that removed dependencies do not appear as parents, and
the merge base selected by git merge does not include changes from
a removed dependency. As a result, these changes can be merged in
again if the new dependency brings in these changes.

The tree of the merge commit is then used to create the next
commit on the TopGit base branch.

Uwe Kleine-K=C3=B6nig had the idea to use tg export here.

Signed-off-by: Olaf Dabrunz <odabrunz@gmx.net>

---

This is an experimental implementation. It did not get much testing, ma=
inly
because testing ran into a fatal "tg export" bug with my test repositor=
y. "tg
export" could be convinced to continue past the error with "bash -x", a=
nd that
is how this patch was tested.

This is also my first feature patch for TopGit, so I expect people to h=
ave
comments.

Known issues:
    - .top* files in the base should probably be excluded with pretty_t=
ree
    - handle tg export producing zero commits for a dependency


 tg-depend.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/tg-depend.sh b/tg-depend.sh
index 474ccda..4d1572d 100644
--- a/tg-depend.sh
+++ b/tg-depend.sh
@@ -60,6 +60,86 @@ depend_add()
 	grep -F -x -e "$name" "$root_dir/.topdeps" >/dev/null &&
 		die "tg: $current_name already depends on $name"
=20
+	tmp_export=3D"_tg_tmp/tg_depend"
+	trap 'git branch -D "$tmp_export" 2>/dev/null || true' EXIT
+
+	# Create a separate history that does not contain parent pointers to
+	# removed dependencies. This makes sure that these dependencies can
+	# come in again if any of them were merged into the new dependency.
+	# (I.e., not having any parents leading to removed deps makes sure th=
at
+	# "git merge new_dep" selects a merge base that does not already
+	# include the removed dependencies.)
+
+	# tg export sets up a branch with the following properties:
+	#   - For each of the exported TopGit branch and it's recursive TopGi=
t
+	#     dependencies, zero, one or two commits are created. If there is
+	#     more than one dependency, one commit is created that contains t=
he
+	#     tree from the tip of the base branch (i.e., the merge of all
+	#     current dependencies). If the TopGit patch branch is non-empty,
+	#     another commit contains the collapsed patch.
+	#   - Only current dependencies from .topdeps are considered; removed
+	#     dependencies are not part of the history of the branch.
+	#   - The .top* files are removed.
+	#
+	# tg export bails if the TopGit branch is not up-to-date.
+	$tg export "$tmp_export" || exit
+
+	# Now checkout the commit representing the base of the current branch
+	# in the export, and use that to merge in the new dep, resulting in t=
he
+	# new base tree.
+	# FIXME: also handle the zero commits case -- does TopGit actually ma=
ke
+	#        that case possible?
+	if branch_empty "$current_name"; then
+		# There is no patch commit. Use tmp_export directly.
+		git checkout -q "$tmp_export"
+	else
+		# Set $tmp_export to it's parent commit, which has the merged
+		# deps without the current patch on top, and check that out.
+		# FIXME: keep the tree of the HEAD commit with the collapsed
+		# patch / new dep merge resolution and use it in the commit on
+		# the patch branch, instead of running tg update? -- this would
+		# re-use conflict resolutions (and other changes) -- but would
+		# git rerere not kick in anyway?
+		git update-ref "refs/heads/$tmp_export" "$tmp_export^"
+		git checkout -q "$tmp_export"
+	fi
+
+	# merge the new dependency into the temp export
+	if ! git merge "$name"; then
+		# open up a shell to work on the conflict
+		info "You are in a subshell. If you abort the merge,"
+		info "use \`exit 1\` to abort adding the dependency."
+		if ! sh -i </dev/tty; then
+			info "Ok, you aborted the merge. Now, you just need to"
+			info "switch back to some sane branch using \`git checkout\`."
+			exit 3
+		fi
+	fi
+
+	# commit the tree of the complete dependency merge on top of the base=
 branch
+	# git-commit-tree $tree -p $topgitbasebranch -p $newdep
+	new_commit=3D"$(
+		echo "Merge branch '$name' into refs/top-bases/$current_name" |
+		git commit-tree "$tmp_export^{tree}" -p "refs/top-bases/$current_nam=
e" -p "$name")"
+
+	git update-ref "refs/top-bases/$current_name" "$new_commit"
+
+	# now update the patch branch
+	git checkout -q "$current_name"
+
+	# TODO: improve .topfiles handling by merging them specially
+	# (not always with topgit's "ours" strategy):
+	#   - when merging deps, which may include topgit branches,
+	#	- .topmsg must not be changed: use "ours", or drop the file in
+	#	                               the base branch altogether
+	#	- .topdeps information from deps is irrelevant to the current
+	#	  branch: use "ours", or drop the file in the base branch
+	#   - when merging the base branch into the patch branch, "ours" is o=
k,
+	#     for the same reasons as above
+	#   - when merging from collaborator's branches (git pull or push
+	#     from/to a remote), do a real merge ("recursive"): the
+	#     collaborator's changes matter on this branch level (TODO)
+
 	echo "$name" >>"$root_dir/.topdeps"
 	git add -f "$root_dir/.topdeps"
 	git commit -m"New TopGit dependency: $name"
--=20
tg: (9404aa1..) t/depend-add-using-export (depends on: master)
