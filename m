From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [TopGit PATCH] tg-undepend.sh: new command to remove a dependency.
Date: Wed, 13 Aug 2008 16:20:52 +0200
Organization: lilypond-design.org
Message-ID: <1218637253.7561.25.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:23:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHFN-00063j-HP
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYHMOU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbYHMOU4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:20:56 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:42631 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbYHMOUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:20:55 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 609AB11E6D7;
	Wed, 13 Aug 2008 16:20:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 90BDFDC07F;
	Wed, 13 Aug 2008 16:20:53 +0200 (CEST)
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92217>

Here's a stab at removing a dependency from a topgit branch.

This is something we think we need for ooo-build to switch to git.

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile       |    2 +-
 README         |    5 ++++
 tg-undepend.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletions(-)
 create mode 100755 tg-undepend.sh

diff --git a/Makefile b/Makefile
index af46399..d40e509 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,7 @@ sharedir = $(prefix)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-undepend.sh tg-update.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/README b/README
index b58a1b4..096b9ec 100644
--- a/README
+++ b/README
@@ -330,6 +330,11 @@ tg export
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
 
+tg undepend
+~~~~~~~~~~~
+	Update the current topic branch by removing the given
+	branch (required argument) from the list of dependencies.
+
 tg update
 ~~~~~~~~~
 	Update the current topic branch wrt. changes in the branches
diff --git a/tg-undepend.sh b/tg-undepend.sh
new file mode 100755
index 0000000..d4c0143
--- /dev/null
+++ b/tg-undepend.sh
@@ -0,0 +1,57 @@
+#! /bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) 2008  Jan Nieuwenhuizen <janneke@gnu.org>
+# GNU GPL version 2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg undepend [NAME]" >&2
+		exit 2;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" \
+	|| die "not a TopGit-controlled branch"
+	
+this_branch=$(git symbolic-ref HEAD | cut -b 12-)
+
+# Use a detached head so that this operation can be aborted
+git checkout -q $(git rev-parse HEAD)
+
+unmerge=$(git log --pretty=oneline "$base_rev".."$name" | cut -b -40 | tr '\n' ' ')
+while [ -n "$unmerge" ]; do
+	commit="${unmerge%% *}"
+	unmerge="${unmerge#* }"
+	[ -n "$unmerge" ] || break # skip initial .top* commit
+	if ! git revert --no-edit $commit; then
+		info "Please commit merge resolution and call: tg undepend $name"
+		info "It is also safe to abort this operation using:"
+		info "git reset --hard some_branch"
+		info "(You are on a detached HEAD now.)"
+		exit 1
+	fi
+done
+
+git branch -m $this_branch work/$this_branch.save-undepend
+git checkout -q -b work/$this_branch.undepend
+git branch -m work/$this_branch.undepend $this_branch
+git branch -D work/$this_branch.save-undepend
+
+mv .topdeps .topdeps~ && grep -v "^$name\$" .topdeps~ > .topdeps && rm .topdeps~
+git commit -am "Remove dependency on $name."
+
+# Local Variables:
+# sh-basic-offset:8
+# End:
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
