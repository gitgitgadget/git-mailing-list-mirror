From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [TopGit PATCH] tg redepend: New command.
Date: Fri, 15 Aug 2008 15:53:47 +0200
Organization: lilypond-design.org
Message-ID: <1218808427.25300.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 15:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTzlX-0001eC-H1
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 15:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYHONxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 09:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYHONxv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 09:53:51 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:38808 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYHONxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 09:53:50 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 91A7C11E6E5;
	Fri, 15 Aug 2008 15:53:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id C5062DC070;
	Fri, 15 Aug 2008 15:53:47 +0200 (CEST)
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92471>

As discussed previously

    http://kerneltrap.org/mailarchive/git/2008/8/13/2925144

Change a topgit branch's dependencies by doing a rebase-by-merge.


Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile       |    2 +-
 README         |    5 ++
 tg-redepend.sh |  154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletions(-)
 create mode 100644 tg-redepend.sh

diff --git a/Makefile b/Makefile
index ea6489e..3988251 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,7 @@ sharedir = $(prefix)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-redepend.sh tg-summary.sh tg-update.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/README b/README
index b58a1b4..3528602 100644
--- a/README
+++ b/README
@@ -330,6 +330,11 @@ tg export
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
 
+tg redepend
+~~~~~~~~~~~
+	Change the current topic branch's list of dependencies
+	by doing a rebase-by-merge onto the new dependencies.
+
 tg update
 ~~~~~~~~~
 	Update the current topic branch wrt. changes in the branches
diff --git a/tg-redepend.sh b/tg-redepend.sh
new file mode 100644
index 0000000..e1612ea
--- /dev/null
+++ b/tg-redepend.sh
@@ -0,0 +1,154 @@
+#! /bin/sh
+# TopGit - A different patch queue manager
+# (c) 2008  Jan Nieuwenhuizen <janneke@gnu.org>
+# GNU GPL version 2
+
+add=
+remove=
+redeps=
+restarted=
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+		--add)
+			[ -z "$redeps" ] || die "already specified new list of dependencies ($redeps)"
+			[ -z "$remove" ] || die "already specified dependencies to remove ($remove)"
+			add="$add "
+			;;
+		-h|--help)
+			echo "Usage: tg [--add|--remove] DEPENDENCY..." >&2
+			;;
+		--remove)
+			[ -z "$redeps" ] || die "already specified new list of dependencies ($redeps)"
+			[ -z "$add" ] || die "already specified dependencies to add ($add)"
+			remove="$remove "
+			;;
+		*)
+			[ -z "$add" ] || add="$add$arg "
+			[ -z "$remove" ] || remove="$remove$arg "
+			[ ! -z "$add$remove" ] || redeps="$redeps$arg "
+	esac
+done
+
+if [ -n "$add" ]; then
+	add="${add/# }"
+	add="${add//  / }"
+	dupes=$(grep -E "^${add// /|}/\$" "$root_dir/.topdeps" | tr '\n' ' ')
+	[ -z "$dupes" ] || die "already depend on: $dupes"
+	redeps=$(echo "$add" | cat "$root_dir/.topdeps" - | tr '\n' ' ' | sed -e 's/ \+$//')
+elif [ -n "$remove" ]; then
+	remove="${remove//  / }"
+	remove="${remove/# }"
+	avail=$(grep -E "^${remove// /|}/\$" "$root_dir/.topdeps" | sort | tr '\n' ' ')
+	remove_sorted=$(echo "$remove" | tr ' ' '\n' | grep -v '^$' | sort | tr '\n' ' ')
+	[ "$avail" = "$remove_sorted" ] || die "not depending on some of: $remove"
+	redeps=$(grep -vE "^${remove// /|}/\$" "$root_dir/.topdeps" | tr '\n' ' ')
+fi
+
+redeps="${redeps/# }"
+redeps="${redeps/# }"
+
+if [ -z "$redeps" ]; then
+	if [ -s "$git_dir/top-name" -a -s "$git_dir/top-redeps" -a -f "$git_dir/top-rebase" ]; then
+		restarted=rebase
+	elif [ -s "$git_dir/top-name" -a -s "$git_dir/top-redeps" -a -f "$git_dir/top-merge" ]; then
+		restarted=merge
+	else
+		echo "Usage: tg [--add|--remove] DEPENDENCY..." >&2
+		exit 2
+	fi
+fi
+
+function fail () {
+	info "Please resolve conflicts and call: tg redepend"
+	info "It is also safe to abort this operation using:"
+	info "tg delete $b_; git reset --hard some_branch"
+	echo "$p" > "$git_dir/top-name"
+	echo "$redeps" > "$git_dir/top-redeps"
+	touch "$git_dir/top-$1"
+	exit 1
+}
+
+# See http://kerneltrap.org/mailarchive/git/2008/8/13/2925144
+#
+# B -- (some mess) -- P
+#
+# Do "git rebase --onto B' B P" while preserving history to get
+#
+# B -- (some mess) -- old P -- P
+#                             /
+#                           B'
+
+if [ -z "$restarted" ]; then
+	info "New list of dependencies: $redeps."
+	p=$(git symbolic-ref HEAD | cut -b 12-)
+else
+	p="$(cat "$git_dir/top-name")"
+	redeps="$(cat "$git_dir/top-redeps")"
+fi
+
+# Clean up any restart stuff
+rm -f "$git_dir/top-name" "$git_dir/top-redeps" "$git_dir/top-rebase" "$git_dir/top-merge"
+
+b="$(git rev-parse --short --verify "refs/top-bases/$p" 2>/dev/null)" \
+	|| die "not a TopGit-controlled branch"
+p_=tg-redepend/tmp/${p}_
+b_=tg-redepend/tmp/$p.base_
+
+# Create new base B' -- does not have to be a topgit branch, but that's easiest
+if [ -z "$restarted" ]; then
+	git branch -D $p_  > /dev/null 2>&1 || :
+
+	tg create $b_ $redeps
+	git commit -m 'tg redepend: add TopGit .top* info.'
+
+# Do "git rebase --onto B' B P" while preserving history
+	git checkout -b $p_ $p
+
+	if ! git rebase --onto $b_ $b; then
+		fail rebase
+	fi
+elif [ "$restarted" = "rebase" ]; then
+	[ ! -d "$git_dir/rebase-apply" ] || git add "$root_dir"
+	[ ! -d "$git_dir/rebase-apply" ] || git add -u "$root_dir"
+	[ ! -d "$git_dir/rebase-apply" ] || if ! git rebase --continue; then
+		fail rebase
+	fi
+	rm -f "$git_dir/top-name" "$git_dir/top-redeps"
+	restarted=
+fi
+
+if [ "$restarted" != "merge" ]; then
+	git checkout $(git rev-parse $p)
+	if ! git merge --no-ff --no-commit $b_; then
+		touch "$git_dir/top-merge"
+		fail merge
+	fi
+elif ! git status | grep 'nothing to commit' > /dev/null; then
+	git add "$root_dir"
+	git add -u "$root_dir"
+	git commit -m 'tg redepend: resolve merge.' > /dev/null 2>&1
+fi
+git read-tree -m -u $(git rev-parse $p_)
+
+echo "$redeps" | tr ' ' '\n' > "$root_dir/.topdeps"
+
+git add "$root_dir"
+git add -u "$root_dir"
+
+git commit -m "Rebased-using-merge onto new dependencies: $redeps."  > /dev/null 2>&1
+
+git branch -f $p
+git checkout $p
+
+tg delete $b_  > /dev/null 2>&1
+git branch -D $p_
+
+info "Rebased-using-merge onto new dependencies: $redeps."
+
+# Local Variables:
+# sh-basic-offset:8
+# End:
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
