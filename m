From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2] git-svn: Make following parents atomic
Date: Mon,  8 Dec 2008 01:20:52 -0500
Message-ID: <1228717252-1016-1-git-send-email-deskinm@umich.edu>
References: <20081207222444.GA10881@euler>
Cc: normalperson@yhbt.net, gitster@pobox.com,
	Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 07:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ZVz-0003ZC-Dj
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 07:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbYLHGVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 01:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYLHGVE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 01:21:04 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:6597 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYLHGVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 01:21:01 -0500
Received: by yx-out-2324.google.com with SMTP id 8so396203yxm.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=w9iLVJxVW4LhTHBxF6LMSdHUf+U8XKtARacwVegER6Q=;
        b=lU+w2Kc1rc6qCZ0ua1k20anCLn1ZNy7ahP4GcVzJ+Supeka3LNhnNqpkjkAVdd6l+6
         DVwfJKsAkLgMsMqmVZFSQtWq+orvi3XPB0ZX/F7zTmchM3CUh3L3OT9u4s25WWxUusjm
         6EUOv7PL3V9woL2Q1i37rzwuJWm3xQBjfmhhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=e0DvYgqB3ZRp/64b4n9+O5KVftQ+Hmx5scamsm1PXvb1L/6HKPwjmSEAn713KhQicU
         Tfi3yO4Vd7oV+sATx480zTGoroYDl8Pc+phhjXVNmvNPyb6azkcgCppm7XYGpf/01h9K
         LecL18JREYiy0sq8zly1328wLQwMAvWpE1xOM=
Received: by 10.65.242.7 with SMTP id u7mr2526915qbr.23.1228717260117;
        Sun, 07 Dec 2008 22:21:00 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id s12sm7478691qbs.10.2008.12.07.22.20.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 22:20:58 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc1.45.g123ed
In-Reply-To: <20081207222444.GA10881@euler>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102529>

find_parent_branch generates branch@rev type branches when one has to
look back through SVN history to properly get the history for a branch
copied from somewhere not already being tracked by git-svn.  If in the
process of fetching this history, git-svn is interrupted, then when one
fetches again, it will use whatever was last fetched as the parent
commit and fail to fetch any more history which it didn't get to before
being terminated.  This is especially troubling in that different
git-svn copies of the same SVN repository can end up with different
commit sha1s, incorrectly showing the history as divergent and
precluding easy collaboration using git push and fetch.

To fix this, when we initialise the Git::SVN object $gs to search for
and perhaps fetch history, we check if there are any commits in SVN in
the range between the current revision $gs is at, and the top revision
for which we were asked to fill history.  If there are commits we're
missing in that range, we continue the fetch from the current revision
to the top, properly getting all history before using it as the parent
for the branch we're trying to create.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
Fixes the bug I found after sending v1.  I squashed in a check for it
into the testcase; if it's preferable I can split it into its own
testcase (this one runs quite long as-is).

Deskin Miller

 git-svn.perl                     |   16 ++++++++++---
 t/t9104-git-svn-follow-parent.sh |   43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 56238da..25ed2f4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2318,12 +2318,20 @@ sub find_parent_branch {
 		$gs = Git::SVN->init($u, $p, $repo_id, $ref_id, 1);
 	}
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
-	if (!defined $r0 || !defined $parent) {
-		my ($base, $head) = parse_revision_argument(0, $r);
-		if ($base <= $r) {
+	{
+		my ($base, $head);
+		if (!defined $r0 || !defined $parent) {
+			($base, $head) = parse_revision_argument(0, $r);
+		} else {
+			if ($r0 < $r) {
+				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+					0, 1, sub { $base = $_[1] - 1 });
+			}
+		}
+		if (defined $base && $base <= $r) {
 			$gs->fetch($base, $r);
 		}
-		($r0, $parent) = $gs->last_rev_commit;
+		($r0, $parent) = $gs->find_rev_before($r, 1);
 	}
 	if (defined $r0 && defined $parent) {
 		print STDERR "Found branch parent: ($self->{ref_id}) $parent\n";
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 4d964e2..45138a2 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -149,6 +149,49 @@ test_expect_success "track initial change if it was only made to parent" '
 	     "`git rev-parse r9270-d~1`"
 	'
 
+test_expect_success "follow-parent is atomic" '
+	cd wc &&
+	svn up &&
+	svn mkdir stunk &&
+	cd stunk &&
+	echo "trunk stunk" > readme &&
+	svn add readme &&
+	cd .. &&
+	svn ci -m "trunk stunk" &&
+	echo "stunk like junk" >> stunk/readme &&
+	svn ci -m "really stunk" &&
+	echo "stink stank stunk" >> stunk/readme &&
+	svn ci -m "even the grinch agrees" &&
+	cd .. &&
+	svn copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&
+	(svn cp -m "early stunk flunked too" \
+		"$svnrepo"/stunk@17 "$svnrepo"/flunked ||
+	svn cp -m "early stunk flunked too" \
+		-r17 "$svnrepo"/stunk "$svnrepo"/flunked) &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	git update-ref refs/remotes/flunk@18 refs/remotes/stunk~2 &&
+	git update-ref -d refs/remotes/stunk &&
+	git config --unset svn-remote.svn.fetch stunk &&
+	mkdir -p "$GIT_DIR"/svn/flunk@18 &&
+	rev_map=$(cd "$GIT_DIR"/svn/stunk && ls .rev_map*) &&
+	dd if="$GIT_DIR"/svn/stunk/$rev_map \
+           of="$GIT_DIR"/svn/flunk@18/$rev_map bs=24 count=1 &&
+	rm -rf "$GIT_DIR"/svn/stunk &&
+	git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
+	git svn fetch -i flunk &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	git svn init --minimize-url -i flunked "$svnrepo"/flunked &&
+	git svn fetch -i flunked
+	test "`git rev-parse --verify refs/remotes/flunk@18`" \
+           = "`git rev-parse --verify refs/remotes/stunk`" &&
+	test "`git rev-parse --verify refs/remotes/flunk~1`" \
+           = "`git rev-parse --verify refs/remotes/stunk`" &&
+	test "`git rev-parse --verify refs/remotes/flunked~1`" \
+           = "`git rev-parse --verify refs/remotes/stunk~1`"
+	'
+
 test_expect_success "track multi-parent paths" '
 	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git-svn multi-fetch &&
-- 
1.6.1.rc1.45.g123ed
