From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Fri, 31 Oct 2008 10:26:44 +0100
Message-ID: <1225445204-28000-1-git-send-email-madcoder@debian.org>
References: <20081030132623.GC24098@artemis.corp>
Cc: pasky@suse.cz, srabbelier@gmail.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 10:28:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvqIU-0006Vi-9R
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 10:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbYJaJ0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 05:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbYJaJ0s
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 05:26:48 -0400
Received: from pan.madism.org ([88.191.52.104]:60175 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbYJaJ0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 05:26:47 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BB30C3B51C;
	Fri, 31 Oct 2008 10:26:45 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 216A95EE236; Fri, 31 Oct 2008 10:26:44 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.757.gf86e6.dirty
In-Reply-To: <20081030132623.GC24098@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99568>

git_commit_non_empty_tree is added to the functions that can be run from
commit filters. Its effect is to commit only commits actually touching the
tree and that are not merge points either.

The option --prune-empty is added. It defaults the commit-filter to
'git_commit_non_empty_tree "$@"', and can be used with any other
combination of filters, except --commit-hook that must used
'git_commit_non_empty_tree "$@"' where one puts 'git commit-tree "$@"'
usually to achieve the same result.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  Okay, this one is meant for inclusion, and has a test case.

  Note that this prune-empty option is not 100% perfect, for example, it won't
  prune an empty base (an empty commit whose parent is 0000000) since it has
  no parent, or won't reduce histories this way:

     t0---t1---t1            t0---t1
              /     ---->        /
             t2                t2

  But I don't think it's especially bad since such trees happen when one does
  'git merge -s ours' all the time, and I don't think git-filter-branch should
  erase those (I mean some people may want to, but then they can figure out
  how to do that by themselves, I don't think it's a common wish).

  The goal of --prune-empty is rather meant to be used e.g. when you remove a
  file from your history, and want to get rid of commits that only touched it,
  or that you want to extract the history of a given subdirectory only and
  remove commits that didn't touch that directory.

 Documentation/git-filter-branch.txt |   14 ++++++++++++++
 git-filter-branch.sh                |   29 ++++++++++++++++++++++++++++-
 t/t7003-filter-branch.sh            |    8 ++++++++
 3 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index fed6de6..451950b 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -122,6 +122,10 @@ You can use the 'map' convenience function in this filter, and other
 convenience functions, too.  For example, calling 'skip_commit "$@"'
 will leave out the current commit (but not its changes! If you want
 that, use 'git-rebase' instead).
++
+You can also use the 'git_commit_non_empty_tree "$@"' instead of
+'git commit-tree "$@"' if you don't wish to keep commits with a single parent
+and that makes no change to the tree.
 
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
@@ -151,6 +155,16 @@ to other tags will be rewritten to point to the underlying commit.
 	The result will contain that directory (and only that) as its
 	project root.
 
+--prune-empty::
+	Some kind of filters will generate empty commits, that left the tree
+	untouched.  This switch allow git-filter-branch to ignore such
+	commits.  Though, this switch only applies for commits that have one
+	and only one parent, it will hence keep merges points. Also, this
+	option is not compatible with the use of '--commit-filter'. Though you
+	just need to use the function 'git_commit_non_empty_tree "$@"' instead
+	of the 'git commit-tree "$@"' idiom in your commit filter to make that
+	happen.
+
 --original <namespace>::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is 'refs/original'.
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 81392ad..4827934 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -40,6 +40,16 @@ skip_commit()
 	done;
 }
 
+# if you run 'git_commit_non_empty_tree "$@"' in a commit filter,
+# it will skip commits that leave the tree untouched, commit the other.
+git_commit_non_empty_tree()
+{
+	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
+		map "$3"
+	else
+		git commit-tree "$@"
+	fi
+}
 # override die(): this version puts in an extra line break, so that
 # the progress is still visible
 
@@ -109,11 +119,12 @@ filter_tree=
 filter_index=
 filter_parent=
 filter_msg=cat
-filter_commit='git commit-tree "$@"'
+filter_commit=
 filter_tag_name=
 filter_subdir=
 orig_namespace=refs/original/
 force=
+prune_empty=
 while :
 do
 	case "$1" in
@@ -126,6 +137,11 @@ do
 		force=t
 		continue
 		;;
+	--prune-empty)
+		shift
+		prune_empty=t
+		continue
+		;;
 	-*)
 		;;
 	*)
@@ -176,6 +192,17 @@ do
 	esac
 done
 
+case "$prune_empty,$filter_commit" in
+',')
+	filter_commit='git commit-tree "$@"';;
+'t,')
+	filter_commit="$functions;"' git_commit_non_empty_tree "$@"';;
+','*)
+	;;
+*)
+	die "Cannot set --prune-empty and --filter-commit at the same time"
+esac
+
 case "$force" in
 t)
 	rm -rf "$tempdir"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index b0a9d7d..352b56b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -262,4 +262,12 @@ test_expect_success 'Tag name filtering allows slashes in tag names' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Prune empty commits' '
+	make_commit to_remove &&
+	(git rev-list HEAD | grep -v $(git rev-parse HEAD)) > expect &&
+	git filter-branch -f --index-filter "git update-index --remove to_remove" --prune-empty HEAD &&
+	git rev-list HEAD > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.0.3.757.gf86e6.dirty
