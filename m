From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git-svn: Make following parents atomic
Date: Sun,  7 Dec 2008 11:06:10 -0500
Message-ID: <1228665970-21204-1-git-send-email-deskinm@umich.edu>
Cc: normalperson@yhbt.net, gitster@pobox.com,
	Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 17:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9MAV-0003JU-Nz
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 17:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbYLGQGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 11:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbYLGQGV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 11:06:21 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:41729 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbYLGQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 11:06:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so322765yxm.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=A3IAEB92jAtCGl5nqthhZFKJqFcxTHuZTZmnYnshUF0=;
        b=PapwxrI6Nm2PVgSqjh50cmhCtTkf0aNmTvhrQ3kZXEiQohEhWCwWPQ9mEC0ncAyPKS
         B+l6Yc2rXmlqoSZQp93C0RLHY6VBDuYea/KSmTJutIh1QuctKP+VeRi0PyfLbXuSwAxQ
         pWsgqPXTqTZKGR5DmgdP5S/u/BB5H3j3Oq4iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=x58565ss0eO7ATfbM8rtVeraPoP2l7zo8RKT+hN0PvhDqHVXku5Xx3sdBvYRAhjz9O
         WW+pW8mOLGgKvUKZbyEHhPju//bqWDcyeMVbRDNbcenwXc2JFgv/KdvK+Dz+k9FSwzHh
         UUmkI/cpHQuh9bBWMQIUmWf6CGietOy8A5Ogc=
Received: by 10.65.59.11 with SMTP id m11mr1943705qbk.90.1228665979004;
        Sun, 07 Dec 2008 08:06:19 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id k7sm6416438qba.6.2008.12.07.08.06.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 08:06:18 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc1.45.g123ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102499>

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
Patch is based on maint.

This was a nasty bug that took some work to figure out; I knew two
git-svn copies had diverged, but though I could look at the commits
where they diverged there was no good way to figure out what git-svn had
been doing at that point.  I ended up writing a script to automate the
process and save information for me to analyse later; I'll be posting an
announcement with further explanation, but the repository is available
at

git://git.deskinm.fdns.net/git-svn-bugfix.git

Deskin Miller

 git-svn.perl                     |   14 +++++++++++---
 t/t9104-git-svn-follow-parent.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 56238da..c53d864 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2318,9 +2318,17 @@ sub find_parent_branch {
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
 		($r0, $parent) = $gs->last_rev_commit;
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 4d964e2..8e7b95b 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -149,6 +149,39 @@ test_expect_success "track initial change if it was only made to parent" '
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
+	cd .. &&
+	svn copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	git update-ref refs/remotes/flunk@17 refs/remotes/stunk~1 &&
+	git update-ref -d refs/remotes/stunk &&
+	git config --unset svn-remote.svn.fetch stunk &&
+	mkdir -p "$GIT_DIR"/svn/flunk@17 &&
+	rev_map=$(cd "$GIT_DIR"/svn/stunk && ls .rev_map*) &&
+	dd if="$GIT_DIR"/svn/stunk/$rev_map \
+           of="$GIT_DIR"/svn/flunk@17/$rev_map bs=24 count=1 &&
+	rm -rf "$GIT_DIR"/svn/stunk &&
+	git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
+	git svn fetch -i flunk &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	test "`git rev-parse --verify refs/remotes/flunk@17`" \
+           = "`git rev-parse --verify refs/remotes/stunk`" &&
+	test "`git rev-parse --verify refs/remotes/flunk~1`" \
+           = "`git rev-parse --verify refs/remotes/stunk`"
+	'
+
 test_expect_success "track multi-parent paths" '
 	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git-svn multi-fetch &&
-- 
1.6.1.rc1.45.g123ed
