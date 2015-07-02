From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: Re: [PATCH] filter-branch: handle deletion of annotated tags
Date: Thu, 2 Jul 2015 14:55:02 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150702125502.GA20534@musxeris015.imu.intel.com>
References: <20150702125048.GA15759@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jorge Nunes <jorge.nunes@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 14:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAe1K-0000GT-Tn
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 14:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbbGBMzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 08:55:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:18858 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419AbbGBMzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 08:55:08 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 02 Jul 2015 05:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,392,1432623600"; 
   d="scan'208";a="739236267"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2015 05:55:03 -0700
Content-Disposition: inline
In-Reply-To: <20150702125048.GA15759@musxeris015.imu.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273228>

If filter-branch removes a commit which an annotated tag points to,
and that tag is in the list of refs to be rewritten, we die with an
error like this:

    error: Ref refs/tags/a1t is at 699cce2774f79a0830d8c5f631deca12d4b1ee8c but expected ba247450492030b03e3d2a9d5fef7ef67519483e
    Could not delete refs/tags/a1t

In order to update refs, we first peel the ref until we find a
commit sha1. We then pass the commit sha1 to update-ref as the
<oldvalue> parameter. Please consider the following scenarios:

 a) The ref points to a commit object directly. In this case,
    update-ref will find that the current value of the ref still
    matches oldvalue, and succeeds. This check is redundant, since
    we only just queried the current value.

 b) The ref points to a tag object. In this case, update-ref will
    error out, since the commit sha1 cannot match the current value
    of the ref. If the commit has been removed, or rewritten into
    multiple commits, we simply die. If the commit has been
    rewritten, we output a warning message saying that to rewrite
    tags one should use --tag-name-filter, and then we continue. If
    --tag-name-filter is active, the tag will later be rewritten.

There seems to be no added value in passing the <oldvalue>
parameter. So remove it.

This fixes deletion of tag objects. We also do not die any more if
a tag object points to a commit which has been rewritten into
multiple commits. However, we probably will die later in the
--tag-name-filter code, because it does not seem to handle this
case.

This is a minimalist fix which leaves the following issues open:

 o In the absence of --tag-name-filter, we rewrite lightweight tags, but
   not annotated tags, which is not intuitive. We do output a warning,
   though:

   $ git filter-branch --msg-filter "cat && echo hi" -- --all
   [...]
   WARNING: You said to rewrite tagged commits, but not the corresponding tag.
   WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag.

 o Annotated tags are backed up as lightweight tags.

 o Annotated tags are backed up even in the absence of
   --tag-name-filter. But in this case backup is not needed because
   they are not rewritten.

These issues could be solved by moving the tag rewriting logic from
tag-name-filter to the regular ref updating code, and
tag-name-filter should deal only with renaming tags. However, this
would change behavior. Currently, the following command would
rewrite tags:

    git filter-branch --msg-filter "cat && echo hi" \
        --tag-name-filter cat -- --branches

With the suggested behavior, tags would be rewritten only if we
include them in the rev-list options:

    git filter-branch --msg-filter="cat && echo hi" -- --all

I am not sure if we can afford to change behavior like that.

Cc: Thomas Rast <tr@thomasrast.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
---

Re-send with Thomas' email address fixed.

 git-filter-branch.sh     | 20 +++++++++-----------
 t/t7003-filter-branch.sh | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..7ca1d99 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -399,21 +399,19 @@ do
 	case "$rewritten" in
 	'')
 		echo "Ref '$ref' was deleted"
-		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
+		git update-ref -m "filter-branch: delete" -d "$ref" ||
 			die "Could not delete $ref"
 	;;
 	$_x40)
 		echo "Ref '$ref' was rewritten"
-		if ! git update-ref -m "filter-branch: rewrite" \
-					"$ref" $rewritten $sha1 2>/dev/null; then
-			if test $(git cat-file -t "$ref") = tag; then
-				if test -z "$filter_tag_name"; then
-					warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
-					warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
-				fi
-			else
-				die "Could not rewrite $ref"
+		if test $(git cat-file -t "$ref") = tag; then
+			if test -z "$filter_tag_name"; then
+				warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
+				warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
 			fi
+		else
+			git update-ref -m "filter-branch: rewrite" "$ref" $rewritten ||
+				die "Could not rewrite $ref"
 		fi
 	;;
 	*)
@@ -423,7 +421,7 @@ do
 		warn "WARNING: Ref '$ref' points to the first one now."
 		rewritten=$(echo "$rewritten" | head -n 1)
 		git update-ref -m "filter-branch: rewrite to first" \
-				"$ref" $rewritten $sha1 ||
+				"$ref" $rewritten ||
 			die "Could not rewrite $ref"
 	;;
 	esac
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 855afda..6a34527 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -261,6 +261,7 @@ test_expect_success 'Subdirectory filter with disappearing trees' '
 '
 
 test_expect_success 'Tag name filtering retains tag message' '
+	git update-ref -d refs/tags/T &&
 	git tag -m atag T &&
 	git cat-file tag T > expect &&
 	git filter-branch -f --tag-name-filter cat &&
@@ -268,6 +269,26 @@ test_expect_success 'Tag name filtering retains tag message' '
 	test_cmp expect actual
 '
 
+test_expect_success "Rewrite commit referenced by annotated tag" '
+	git update-ref -d refs/tags/T &&
+	git tag -a -m atag T &&
+	git rev-parse refs/tags/T^0 >old_commit &&
+	git filter-branch -f --msg-filter "cat && echo foo" --tag-name-filter cat refs/tags/T &&
+	echo tag >type.expect &&
+	git cat-file -t refs/tags/T >type.actual &&
+	test_cmp type.expect type.actual &&
+	git rev-parse refs/tags/T^0 >new_commit &&
+	test_must_fail test_cmp old_commit new_commit
+'
+
+test_expect_success "Remove all commits" '
+	git branch removed-branch &&
+	git tag -a -m atag removed-tag &&
+	git filter-branch -f --commit-filter "skip_commit \"\$@\"" removed-branch removed-tag &&
+	test_must_fail git rev-parse refs/heads/removed-branch &&
+	test_must_fail git rev-parse refs/tags/removed-tag
+'
+
 faux_gpg_tag='object XXXXXX
 type commit
 tag S
-- 
1.9.4
