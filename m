From: Greg Price <price@MIT.EDU>
Subject: [PATCH 4/6] rebase: --rewrite-{refs,heads,tags} to pull refs along
 with branch
Date: Wed, 18 Nov 2009 18:51:11 -0500
Message-ID: <c2d11ffe876a540b6fad46e2ecc57a24018cfb73.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuO-0006H7-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab1F0Afr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:35:47 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:44627 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab1F0Aev (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:34:51 -0400
X-AuditID: 12074423-b7ce8ae000000a29-0a-4e07d0249522
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.69.02601.420D70E4; Sun, 26 Jun 2011 20:34:44 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YoAB003492;
	Sun, 26 Jun 2011 20:34:50 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0YnLP019035;
	Sun, 26 Jun 2011 20:34:50 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixCmqrKtygd3P4N86SYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugStjxu5r7AUNmhUbPr9ga2DsUOhiZOeQEDCR2BnX
	xcgJZIlJXLi3nq2LkYtDSGAfo8TER6/YIZwNjBKfpnWzQDhfGCXaD/xlAmkRElCXuNl2iBHC
	1pG4evgXlG0lsev4AjYI21DiydE77CA2r0CIxIPNs1m7GDk4OAWMJF42KsCU3L/QBFbOJqAg
	8WP+OmYQW0RATWJi2yEWEJtZQFxi3dzz7CCtLAKqEj/3BYOEhQUiJdbeusg4gVFwASPDKkbZ
	lNwq3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjKBwY3dR3sH456DSIUYBDkYlHt7OOHY/
	IdbEsuLK3EOMkhxMSqK8oueBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR434UB5XhTEiurUovy
	YVLSHCxK4ry53v99hQTSE0tSs1NTC1KLYLIyHBxKErxBIEMFi1LTUyvSMnNKENJMHJwgw3mA
	hoeC1PAWFyTmFmemQ+RPMSpKifOuBkkIgCQySvPgemHp4BWjONArwrxtIFU8wFQC1/0KaDAT
	0OC+y2wgg0sSEVJSDYwlp7v76jx/u5q9tmM5pmMT9jZKnOnkZ53It4/XrFB8uTFGenXP4euC
	NY8X+m1xOZ/asqnj3MF0GQb5vkYhN87pF8Vb2fzq1eeIGB0p/rujZX7CLOEaW7WJvK4HVz39
	tNp+whm97z28e2uauPYrbLb1bUl+1zT/D2PUA3U+bs11LH4y29uK3yixFGckGmox 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176343>

The new option --rewrite-refs causes the TODO file to contain a "ref"
command for each appropriate ref pointing to a selected commit, other
than the one we are already rebasing.  The argument to --rewrite-refs
is a ref pattern of the same type accepted by for-each-ref: a pattern
matches a ref name if it matches exactly, matches exactly up to a
slash, or matches according to fnmatch(3).  The options
--rewrite-heads and --rewrite-tags are supplied as shortcuts.

The effect of this is that when a branch contains intermediate
branches, like so:

      part1 part2 topic
        |     |     |
        v     v     v
  A--*--*--*--*--*--*
   \
    B <--master

a single command like "git rebase --rewrite-heads master topic"
suffices to rewrite all the heads that are part of the topic, like so:

        part1 part2 topic
  A       |     |     |
   \      v     v     v
    B--*--*--*--*--*--*
    ^
    |
    master

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/git-rebase.txt |   13 ++++++++++++-
 git-rebase--interactive.sh   |   25 ++++++++++++++++++++++++-
 git-rebase.sh                |   17 +++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 74fda58..e4f32fc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -347,6 +347,15 @@ idea unless you know what you are doing (see BUGS below).
 	root commits will be rewritten to have <newbase> as parent
 	instead.
 
+--rewrite-refs=<pattern>::
+--rewrite-heads::
+--rewrite-tags::
+	Rewrite refs matching <pattern> which point to the rebased
+	commits.  The options --rewrite-heads and --rewrite-tags are
+	shortcuts for --rewrite-refs=refs/heads and
+	--rewrite-refs=refs/tags respectively.  Ref patterns are
+	interpreted as in linkgit:git-for-each-ref[1].
+
 --autosquash::
 --no-autosquash::
 	When the commit log message begins with "squash! ..." (or
@@ -457,7 +466,9 @@ but omits the commit messages of commits with the "fixup" command.
 
 If you want to update a ref to point to a rewritten commit, add a
 command "ref <refname>" after the "pick", "edit", or other command
-that produces the commit.
+that produces the commit.  You can use the --rewrite-refs option to
+have the file start out with these commands for refs inside the branch
+you are rebasing.
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cec9cab..42ea3e7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -741,12 +741,23 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
+if test -z "rewrite_refs"
+then
+	pretty=oneline
+else
+	pretty=format:"%m%h %s%n%m%D"
+fi
+git rev-list $merges_option --pretty="$pretty" --abbrev-commit \
 	--abbrev=7 --reverse --left-right --topo-order \
 	$revisions | \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
+	if test -n "$rewrite_refs"
+	then
+		read refs
+	fi
+
 	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
@@ -771,6 +782,18 @@ do
 			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 		fi
 	fi
+
+	if test -n "$rewrite_refs"
+	then
+		for ref in $refs; do echo "$ref"; done | \
+		git for-each-ref --stdin $rewrite_refs \
+			--format '%(refname)' | \
+		while read ref
+		do
+			test "$ref" != "$head_name" &&
+			echo "ref $ref" >> "$todo"
+		done
+	fi
 done
 
 # Watch for commits that been dropped by --cherry-pick
diff --git a/git-rebase.sh b/git-rebase.sh
index 1bfe6a8..7c365ab 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -38,6 +38,9 @@ git-rebase [-i] --continue | --abort | --skip
 v,verbose!         display a diffstat of what changed upstream
 q,quiet!           be quiet. implies --no-stat
 onto=!             rebase onto given branch instead of upstream
+rewrite-heads!     rewrite intermediate heads on branch
+rewrite-tags!      rewrite intermediate tags on branch
+rewrite-refs=!     rewrite intermediate refs matching pattern
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -96,6 +99,7 @@ state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
 preserve_merges=
+rebase_refs=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 
@@ -246,6 +250,19 @@ do
 		strategy="$1"
 		do_merge=t
 		;;
+	--rewrite-refs)
+		shift
+		rewrite_refs="$rewrite_refs $1"
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
+	--rewrite-heads)
+		rewrite_refs="$rewrite_refs refs/heads"
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
+	--rewrite-tags)
+		rewrite_refs="$rewrite_refs refs/tags"
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	-n)
 		diffstat=
 		;;
-- 
1.7.5.4
