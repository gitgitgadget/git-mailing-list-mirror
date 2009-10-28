From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/2] filter-branch: stop special-casing $filter_subdir argument
Date: Wed, 28 Oct 2009 23:59:16 +0100
Message-ID: <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch>
References: <4AE0187C.4040608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3HVI-00050L-1d
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 00:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZJ1XAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 19:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZJ1XAR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 19:00:17 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40134 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbZJ1XAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 19:00:16 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 00:00:22 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 23:59:58 +0100
X-Mailer: git-send-email 1.6.5.1.161.g3b9c0
In-Reply-To: <4AE0187C.4040608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131507>

Handling $filter_subdir in the usual way requires a separate case at
every use, because the variable is empty when unused.

Furthermore, the case for --subdirectory-filter supplies its own --,
so the user cannot provide one himself, so the following was
impossible:

  git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

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
---

Johannes Sixt wrote:
> When the shell expands $variable (outside quotes), it does not apply
> quotes anymore, but only word-splits using $IFS. In your code, the words
> would contain literal single-quotes, and paths with spaces would still be
> split into words.

If there's a good reason for these weird rules, I'm still missing
it...

But your suggestion works very nicely.

 git-filter-branch.sh |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a480d6f..da23b99 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -257,15 +257,23 @@ git read-tree || die "Could not seed the index"
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+dashdash=
+test -z "$(git rev-parse --no-revs "$@")" && dashdash=--
+ref_args=$(git rev-parse --revs-only "$@")
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
+	eval set -- "$(git rev-parse --sq --no-revs "$@")" \
+	    $dashdash "$filter_subdir"
+	;;
+esac
+
+git rev-list --reverse --topo-order --default HEAD \
+	--parents --simplify-merges $ref_args "$@" \
+	> ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
@@ -356,8 +364,7 @@ then
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
1.6.5.1.161.g3b9c0
