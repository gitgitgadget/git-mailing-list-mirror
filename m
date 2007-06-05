From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] filter-branch: use sh -c instead of eval
Date: Tue, 5 Jun 2007 18:57:34 +0200
Message-ID: <20070605165734.GA21708@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 18:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcLz-00075X-8S
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616AbXFEQ5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbXFEQ5h
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:57:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:56146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758616AbXFEQ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 12:57:36 -0400
Received: (qmail invoked by alias); 05 Jun 2007 16:57:34 -0000
Received: from pD9EBB5EC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp053) with SMTP; 05 Jun 2007 18:57:34 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18D9IlWdbwDREZKi4/NiRgAdSEEQRBqWwbc0q4RPD
	si4TztjwWKeT8o
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49206>

If filters use variables with the same name as variables
used in the script the script breaks.  Executing the filters
in a separate process prevents accidential modification of
the variables in the main process.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This one goes on top of the last patch, adding the < /dev/null.

Example:
% git filter-branch --tree-filter 'commit=foo' bar 
94ddd5151901a2b62820facc1bcf578abf842c8a (1/2) fatal: ambiguous argument 'foo': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: ambiguous argument 'foo': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
94ddd5151901a2b62820facc1bcf578abf842c8a
[..]
head: cannot open `../map/81208e18e22e0f1c7c73a4ea5bbd5150c0ee65c2'
for reading: No such file or directory
usage: git-update-ref [-m <reason>] (-d <refname> <value> | [--no-deref] <refname> <value> [<oldval>])
---
 git-filter-branch.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 73e7c01..b446011 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -54,9 +54,9 @@
 # Filters
 # ~~~~~~~
 # The filters are applied in the order as listed below. The COMMAND
-# argument is always evaluated in shell using the 'eval' command.
-# The $GIT_COMMIT environment variable is permanently set to contain
-# the id of the commit being rewritten. The author/committer environment
+# argument is always evaluated in shell using sh -c "$filter".  The
+# $GIT_COMMIT environment variable is permanently set to contain the id
+# of the commit being rewritten. The author/committer environment
 # variables are set before the first filter is run.
 #
 # A 'map' function is available that takes an "original sha1 id" argument
@@ -349,21 +349,21 @@ while read commit; do
 
 	eval "$(set_ident AUTHOR <../commit)"
 	eval "$(set_ident COMMITTER <../commit)"
-	eval "$filter_env" < /dev/null
+	sh -c "$filter_env" < /dev/null
 
 	if [ "$filter_tree" ]; then
 		git-checkout-index -f -u -a
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
 		git-ls-files -z --others | xargs -0 rm -f
-		eval "$filter_tree" < /dev/null
+		sh -c "$filter_tree" < /dev/null
 		git-diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
 			xargs -0 git-update-index --add --replace --remove
 		git-ls-files -z --others | \
 			xargs -0 git-update-index --add --replace --remove
 	fi
 
-	eval "$filter_index" < /dev/null
+	sh -c "$filter_index" < /dev/null
 
 	parentstr=
 	for parent in $(get_parents $commit); do
@@ -376,11 +376,11 @@ while read commit; do
 		fi
 	done
 	if [ "$filter_parent" ]; then
-		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
+		parentstr="$(echo "$parentstr" | sh -c "$filter_parent")"
 	fi
 
 	sed -e '1,/^$/d' <../commit | \
-		eval "$filter_msg" | \
+		sh -c "$filter_msg" | \
 		sh -c "$filter_commit" git-commit-tree $(git-write-tree) $parentstr | \
 		tee ../map/$commit
 done <../revs
@@ -410,7 +410,7 @@ if [ "$filter_tag_name" ]; then
 		[ -f "../map/$sha1" ] || continue
 		new_sha1="$(cat "../map/$sha1")"
 		export GIT_COMMIT="$sha1"
-		new_ref="$(echo "$ref" | eval "$filter_tag_name")"
+		new_ref="$(echo "$ref" | sh -c "$filter_tag_name")"
 
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
-- 
1.5.2.1.860.g78ab5-dirty
