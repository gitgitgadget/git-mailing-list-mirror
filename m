From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v5 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Wed, 11 Nov 2009 09:53:46 +0100
Message-ID: <4AFA7B9A.4090005@viscovery.net>
References: <4AE945D0.5030403@viscovery.net> <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch> <4AFA7624.5040400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:54:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88xn-0003ha-N8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbZKKIxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZKKIxw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:53:52 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62487 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZKKIxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:53:51 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N88xW-0000wh-MK; Wed, 11 Nov 2009 09:53:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 786846D9; Wed, 11 Nov 2009 09:53:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AFA7624.5040400@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132624>

From: Thomas Rast <trast@student.ethz.ch>

Handling $filter_subdir in the usual way requires a separate case at
every use, because the variable is empty when unused.

Furthermore, --subdirectory-filter supplies its own '--', and if the user
provided one himself, such as in

  git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

	an extra '--' was used as path filter in the call to git-rev-list that
determines the commits that shall be rewritten.

To keep the argument handling sane, we filter $@ to contain only the
non-revision arguments, and store all revisions in $ref_args.  The
$ref_args are easy to handle since only the SHA1s are needed; the
actual branch names have already been stored in $tempdir/heads at this
point.

An extra separating -- is only required if the user did not provide
any non-revision arguments, as the latter disambiguate the
$filter_subdir following after them (or fail earlier because they are
ambiguous themselves).

Thanks to Johannes Sixt for suggesting this solution.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Johannes Sixt schrieb:
> I'll submit a replacement patch.

Here it is. The interdiff to your version is merely

--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -266,7 +266,7 @@

 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
-dashdash=${nonrevs+"--"}
+test -z "$nonrevs" && dashdash=-- || dashdash=
 rev_args=$(git rev-parse --revs-only "$@")

 case "$filter_subdir" in

and I changed the commit message in the way I announced it.

-- Hannes

 git-filter-branch.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a480d6f..ed3db7d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -257,15 +257,24 @@ git read-tree || die "Could not seed the index"
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"

+# we need "--" only if there are no path arguments in $@
+nonrevs=$(git rev-parse --no-revs "$@") || exit
+test -z "$nonrevs" && dashdash=-- || dashdash=
+rev_args=$(git rev-parse --revs-only "$@")
+
 case "$filter_subdir" in
 "")
-	git rev-list --reverse --topo-order --default HEAD \
-		--parents --simplify-merges "$@"
+	eval set -- "$(git rev-parse --sq --no-revs "$@")"
 	;;
 *)
-	git rev-list --reverse --topo-order --default HEAD \
-		--parents --simplify-merges "$@" -- "$filter_subdir"
-esac > ../revs || die "Could not get the commits"
+	eval set -- "$(git rev-parse --sq --no-revs "$@" $dashdash \
+		"$filter_subdir")"
+	;;
+esac
+
+git rev-list --reverse --topo-order --default HEAD \
+	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")

 test $commits -eq 0 && die "Found nothing to rewrite"
@@ -356,8 +365,7 @@ then
 	do
 		sha1=$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
-		ancestor=$(git rev-list --simplify-merges -1 \
-				$ref -- "$filter_subdir")
+		ancestor=$(git rev-list --simplify-merges -1 "$ref" "$@")
 		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
-- 
1.6.5.rc2.47.g49402
