From: Pierre Habouzit <madcoder@debian.org>
Subject: [Proof of concept PATCH] implement --prune-empty switch for filter-branch
Date: Thu, 30 Oct 2008 17:18:58 +0100
Message-ID: <1225383538-23666-3-git-send-email-madcoder@debian.org>
References: <20081030132623.GC24098@artemis.corp>
 <1225383538-23666-1-git-send-email-madcoder@debian.org>
 <1225383538-23666-2-git-send-email-madcoder@debian.org>
Cc: pasky@suse.cz, srabbelier@gmail.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 17:20:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaG7-0005xS-Nv
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbYJ3QTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbYJ3QTG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:19:06 -0400
Received: from pan.madism.org ([88.191.52.104]:39191 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756821AbYJ3QTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:19:02 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 07B0D3B415;
	Thu, 30 Oct 2008 17:18:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 789E85EE240; Thu, 30 Oct 2008 17:18:58 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.758.gc29b0
In-Reply-To: <1225383538-23666-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99494>

This is not a real patch (lacks a test at least) and is absolutely not
tested, though should basically work as expected.

This is only meant as a basis for discussion.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-filter-branch.txt |   14 ++++++++++++++
 git-filter-branch.sh                |   26 +++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletions(-)

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
index 8af3126..9c83402 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -49,6 +49,15 @@ die()
 	echo "$*" >&2
 	exit 1
 }
+
+git_commit_non_empty_tree()
+{
+	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
+		map "$3"
+	else
+		git commit-tree "$@"
+	fi
+}
 EOF
 )
 
@@ -95,6 +104,7 @@ d=                      temporary path to use for rewriting
 f,force                 force filter-branch to run
 subdirectory-filter=    only look at the history touching that specific subdirectory
 original=               namespace where the original commits will be stored (default: refs/original)
+prune-empty             use this if you want to automatically prune empty commits
 
  Filters that you can run:
 
@@ -121,11 +131,12 @@ filter_tree=
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
@@ -138,6 +149,8 @@ do
 	--original)
 		orig_namespace=$(expr "$2/" : '\(.*[^/]\)/*$')/
 		shift;;
+	--prune-empty)
+		prune_empty=t;;
 
 	--env-filter)
 		filter_env="$2"; shift;;
@@ -161,6 +174,17 @@ do
 	shift
 done
 
+case "$prune_empty,$filter_commit" in
+',')
+	filter_commit='git commit-tree "$@"';;
+'t,')
+	filter_commit='git_commit_non_empty_tree "$@"';;
+','*)
+	;;
+*)
+	die "Cannot set --prune-empty and --filter-commit at the same time"
+esac
+
 case "$force" in
 t)
 	rm -rf "$tempdir"
-- 
1.6.0.3.758.gc29b0
