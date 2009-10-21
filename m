From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] filter-branch: stop special-casing $filter_subdir argument
Date: Wed, 21 Oct 2009 20:16:21 +0200
Message-ID: <95535b01e2181d321190c6d93b2834188612a389.1256148512.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0fkB-0002X4-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 20:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbZJUSQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZJUSQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 14:16:57 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30590 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbZJUSQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 14:16:56 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 20:16:59 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 20:16:55 +0200
X-Mailer: git-send-email 1.6.5.1.142.g4bac9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130949>

Handling $filter_subdir in the usual way requires a separate case at
every use, because the variable is empty when unused.  Furthermore,
the case for --subdirectory-filter supplies its own --, so the user
cannot provide one himself (though there is also very little point in
doing so).

Instead, tack the $filter_subdir onto $@ in the right place
automatically, and only use a -- if it was not already provided by the
user.

We set non_ref_args again after changing "$@"; the next patch wants to
use it again afterwards, so we better not leave a stale value in
there.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is preparatory for the next patch; introducing another 'case'
along the lines of the existing one annoyed me, so I went for this
instead.  I would greatly appreciate extra eyes on my use of 'eval'.
I originally expected this to work without eval, but apparently this
is how one does it.  Quoting rules in the shell are annoying.

Incidentally, the last hunk sneak fixes a previously unquoted use of
$ref that is my fault from back in a0e4639 (filter-branch: fix ref
rewriting with --subdirectory-filter, 2008-08-12).


 git-filter-branch.sh |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a480d6f..3890c22 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -257,15 +257,29 @@ git read-tree || die "Could not seed the index"
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+non_ref_args=$(git rev-parse --no-revs --sq "$@")
+dashdash=--
+for arg in "$non_ref_args"; do
+	if test arg = --; then
+		dashdash=
+		break
+	fi
+done
+
 case "$filter_subdir" in
 "")
-	git rev-list --reverse --topo-order --default HEAD \
-		--parents --simplify-merges "$@"
+	filter_subdir_sq=
 	;;
 *)
-	git rev-list --reverse --topo-order --default HEAD \
-		--parents --simplify-merges "$@" -- "$filter_subdir"
-esac > ../revs || die "Could not get the commits"
+	filter_subdir_sq=$(git rev-parse --sq-quote "$filter_subdir")
+esac
+
+eval "set -- \"\$@\" $dashdash $filter_subdir_sq"
+non_ref_args=$(git rev-parse --no-revs --sq "$@")
+
+git rev-list --reverse --topo-order --default HEAD \
+	--parents --simplify-merges "$@" \
+	> ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
@@ -356,8 +370,8 @@ then
 	do
 		sha1=$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
-		ancestor=$(git rev-list --simplify-merges -1 \
-				$ref -- "$filter_subdir")
+		ancestor=$(eval "git rev-list --simplify-merges " \
+				"-1 \"$ref\" $non_ref_args")
 		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
-- 
1.6.5.1.139.g12527
