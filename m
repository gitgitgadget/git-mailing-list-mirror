From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 1/2] filter-branch: stop special-casing $filter_subdir argument
Date: Tue, 10 Nov 2009 22:04:50 +0100
Message-ID: <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch>
References: <4AE945D0.5030403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7xuf-0008LQ-GY
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 22:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbZKJVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 16:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbZKJVFx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 16:05:53 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:38572 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758081AbZKJVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 16:05:53 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 10 Nov
 2009 22:05:56 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 10 Nov
 2009 22:05:36 +0100
X-Mailer: git-send-email 1.6.5.2.365.ge9237
In-Reply-To: <4AE945D0.5030403@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132597>

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

Thanks once again for your reviews.  It's been a while since I last
looked into this, but after some staring, I think you're right on all
counts.

Johannes Sixt wrote:
> # we need "--" only if there are no path arguments in $@
> nonrevs=$(git rev-parse --no-revs "$@") || exit
> dashdash=${nonrevs+"--"}
> 
> (including the comment; you can drop the dquotes in the dashdash
> assignment if you think the result is still readable.)

Ok.  I was briefly scared that this was bash-specific syntax, but dash
seems happy so I'll trust your advice.

> This is not correct: $filter_subdir undergoes an extra level of
> evaluation. You must write it like this:
> 
> 	eval set -- "$(git rev-parse --sq --no-revs "$@" \
> 		$dashdash "$filter_subdir")"

Hopefully I finally understand what's going on here.  The quoting
rules make my head spin.

> > -		ancestor=$(git rev-list --simplify-merges -1 \
> > -				$ref -- "$filter_subdir")
> > +		ancestor=$(git rev-list --simplify-merges -1 "$ref" "$@")
> 
> You added dquotes around $ref: while not absolutely necessary, I agree
> with this change.

It's kind of a sneak fix, but I broke this back in the ancestor
rewriting patch...  Luckily the refname sanity rules are designed to
prevent this from causing any harm.


 git-filter-branch.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a480d6f..96b2182 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -257,15 +257,24 @@ git read-tree || die "Could not seed the index"
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+# we need "--" only if there are no path arguments in $@
+nonrevs=$(git rev-parse --no-revs "$@") || exit
+dashdash=${nonrevs+"--"}
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
1.6.5.2.365.ge9237
