From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH (3rd try)] Add git-stash script
Date: Sat, 30 Jun 2007 14:37:09 +0900
Message-ID: <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 07:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Vg9-0007kD-Ox
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 07:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbXF3FjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 01:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbXF3FjT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 01:39:19 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:47129 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXF3FjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 01:39:18 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5U5dHLh003989
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 22:39:18 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=X76WKhTjIW6/JgmPexxNgm47ZFioOmg2WjcMXaQQKj+zzQFZHshHzSEHSXFo3KlR/
	C4X0U+thA3SKSFCtoU06nU8NrcGDgDc6HG2dkfT98wZrw1WmSKTPdk/1dnnwPHq
Received: from nanako3.mail.bluebottle.com ([222.221.254.163])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5U5cpC5025676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2007 22:39:10 -0700
In-Reply-To: <Pine.LNX.4.64.0706300304480.4438@racer.site>
X-Trusted-Delivery: <085d7ad065263ec33f6f0fbe2966968d>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51192>

When my boss has something to show me and I have to update, for some
reason I am always in the middle of doing something else, and git pull
command refuses to work in such a case.

I wrote this little script to save the changes I made, perform the
update, and then come back to where I was, but on top of the updated
commit.

This is how you would use the script:

  $ git stash
  $ git pull
  $ git stash apply

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---

Thank you for the hint for labeling the conflict blocks.
I also added an entry to gitignore and Makefile as requested.

 .gitignore   |    1 +
 Makefile     |    3 +-
 git-stash.sh |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 1 deletions(-)
 create mode 100755 git-stash.sh

diff --git a/.gitignore b/.gitignore
index e8b060c..02d9b04 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@ git-ssh-fetch
 git-ssh-pull
 git-ssh-push
 git-ssh-upload
+git-stash
 git-status
 git-stripspace
 git-submodule
diff --git a/Makefile b/Makefile
index a98e27a..05b1fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -212,7 +212,8 @@ SCRIPT_SH = \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
-	git-filter-branch.sh
+	git-filter-branch.sh \
+	git-stash.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-stash.sh b/git-stash.sh
new file mode 100755
index 0000000..05ca3a6
--- /dev/null
+++ b/git-stash.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+# Copyright (c) 2007, Nanako Shiraishi
+
+USAGE='[ | list | show | apply | clear]'
+
+. git-sh-setup
+require_work_tree
+
+TMP="$GIT_DIR/.git-stash.$$"
+trap 'rm -f "$TMP-*"' 0
+
+ref_stash=refs/stash
+
+no_changes () {
+	git-diff-index --quiet --cached HEAD &&
+	git-diff-files --quiet
+}
+
+clear_stash () {
+	logfile="$GIT_DIR/logs/$ref_stash" &&
+	mkdir -p "$(dirname "$logfile")" &&
+	: >"$logfile"
+}
+
+save_stash () {
+	if no_changes
+	then
+		echo >&2 'No local changes to save'
+		exit 0
+	fi
+	test -f "$GIT_DIR/logs/refs/stash" ||
+		clear_stash || die "Cannot initialize stash"
+
+	# state of the base commit
+	if b_commit=$(git-rev-parse --verify HEAD)
+	then
+		head=$(git-log --abbrev-commit --pretty=oneline -n 1 HEAD)
+	else
+		die "You do not have the initial commit yet"
+	fi
+
+	if branch=$(git-symbolic-ref -q HEAD)
+	then
+		branch=${branch#refs/heads/}
+	else
+		branch='(no branch)'
+	fi
+	msg=$(printf '%s: %s' "$branch" "$head")
+
+	# state of the index
+	i_tree=$(git-write-tree) &&
+	i_commit=$(printf 'index on %s' "$msg" |
+		git-commit-tree $i_tree -p $b_commit) ||
+		die "Cannot save the current index state"
+
+	# state of the working tree
+	w_tree=$( (
+		GIT_INDEX_FILE="$TMP-index" &&
+		export GIT_INDEX_FILE &&
+
+		rm -f "$TMP-index" &&
+		git-read-tree $i_tree &&
+		git-add -u &&
+		git-write-tree &&
+		rm -f "$TMP-index"
+	) ) ||
+		die "Cannot save the current worktree state"
+
+	# create the stash
+	w_commit=$(printf 'WIP on %s' "$msg" |
+		git-commit-tree $w_tree -p $b_commit -p $i_commit) ||
+		die "Cannot record working tree state"
+
+	git-update-ref -m "$msg" $ref_stash $w_commit ||
+		die "Cannot save the current status"
+	printf >&2 'Saved WIP on %s\n' "$msg"
+}
+
+list_stash () {
+	git-log --pretty=oneline -g "$@" $ref_stash |
+	sed -n -e 's/^[.0-9a-f]* refs\///p'
+}
+
+show_stash () {
+	flags=$(git-rev-parse --no-revs --flags "$@")
+	if test -z "$flags"
+	then
+		flags=--stat
+	fi
+	s=$(git-rev-parse --revs-only --no-flags --default $ref_stash "$@")
+
+	w_commit=$(git-rev-parse --verify "$s") &&
+	b_commit=$(git-rev-parse --verify "$s^") &&
+	git-diff $flags $b_commit $w_commit
+}
+
+apply_stash () {
+	git-diff-files --quiet ||
+		die 'Cannot restore on top of a dirty state'
+
+	# current index state
+	c_tree=$(git-write-tree) ||
+		die 'Cannot apply a stash in the middle of a merge'
+
+	s=$(git-rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
+	w_tree=$(git-rev-parse --verify "$s:") &&
+	b_tree=$(git-rev-parse --verify "$s^:") ||
+		die "$*: no valid stashed state found"
+
+	eval "
+		GITHEAD_$w_tree='Stashed changes' &&
+		GITHEAD_$c_tree='Updated upstream' &&
+		GITHEAD_$b_tree='Version stash was based on' &&
+		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
+	"
+
+	if git-merge-recursive $b_tree -- $c_tree $w_tree
+	then
+		# No conflict
+		a="$TMP-added" &&
+		git-diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
+		git-read-tree --reset $c_tree &&
+		git-update-index --add --stdin <"$a" ||
+			die "Cannot unstage modified files"
+		git-status
+		rm -f "$a"
+	else
+		# Merge conflict
+		exit 1
+	fi
+}
+
+# Main command set
+case "$1" in
+list)
+	shift
+	if test $# = 0
+	then
+		set x -n 10
+		shift
+	fi
+	list_stash "$@"
+	;;
+show)
+	shift
+	show_stash "$@"
+	;;
+apply)
+	shift
+	apply_stash "$@"
+	;;
+clear)
+	clear_stash
+	;;
+'')
+	save_stash && git-reset --hard
+	;;
+*)
+	usage
+esac
-- 
1.5.2

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com
