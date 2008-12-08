From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v3] git-svn: Make following parents atomic
Date: Mon, 8 Dec 2008 08:31:31 -0500
Message-ID: <20081208133131.GA9190@euler>
References: <20081207222444.GA10881@euler> <1228717252-1016-1-git-send-email-deskinm@umich.edu> <7v1vwj83sd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9gEb-0007XR-Ie
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 14:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYLHNbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 08:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYLHNbl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 08:31:41 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:38718 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYLHNbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 08:31:40 -0500
Received: by yx-out-2324.google.com with SMTP id 8so438058yxm.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=neWkzxoyI3SxbViy9Rg5nAZocOClSkRRiUMxYq1JvJM=;
        b=P6emtApkZl0cGANbCYjQ8fLQwjD4kJDvTX0yBCZJqkdrYP8QKE/OLE+n9iwpQVOKsf
         6BwqrEwrXQhz3tlbdffvVifKADNHWefaSmUwU2tfLzC7QgdPDCYhIyk8fgzkjzX9GUT3
         ZTFZIXCeF/GxBRHxqaD36Bpg0CPw0XqpoJy6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=C4i0aMz9O5bsCXuyS+S+EGXb5s/dlE0BOAqxV5bJwEbaiT0TJtC3oYMICn2WRLoD9s
         WnFx97Qh57b0Ao3VkkM2fMMxOdOFy6MnEkMqKMiL6nWQhHniuO8u1+pSbd+TMohex8ig
         z0CGE8+NBgxtSfbF1f/BOSvxhZyCeMGbxazVk=
Received: by 10.64.210.3 with SMTP id i3mr2795877qbg.30.1228743098724;
        Mon, 08 Dec 2008 05:31:38 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id k30sm10448268qba.8.2008.12.08.05.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Dec 2008 05:31:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1vwj83sd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102544>

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
Re-roll based on Junio's comments on the testcase, plus fix some minor
whitespace lunacy I left in the testcase.

On Mon, Dec 08, 2008 at 12:33:22AM -0800, Junio C Hamano wrote:
> Deskin Miller <deskinm@umich.edu> writes:
> 
> > +test_expect_success "follow-parent is atomic" '
> > +	cd wc &&
> > +	[...]
> > +	cd .. &&
> 
> If you need to chdir around inside a test, please do that in a subshell,
> so that after failing any command in between, the next test will not start
> in an unexpected directory.

Good point; this even bit me once while I worked on this testcase, and I
still didn't take the hint (yikes!)
 
> > +	(svn cp -m "early stunk flunked too" \
> > +		"$svnrepo"/stunk@17 "$svnrepo"/flunked ||
> > +	svn cp -m "early stunk flunked too" \
> > +		-r17 "$svnrepo"/stunk "$svnrepo"/flunked) &&
> 
> On the other hand, I do not see a need for this portion to be in a
> subshell.  Wouldn't a normal statement grouping with {} work just as well?

It does work as well; I just didn't know about the { cmd-list; }
construction.

Thanks for the comments,

Deskin Miller

 git-svn.perl                     |   16 ++++++++++---
 t/t9104-git-svn-follow-parent.sh |   42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

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
index 4d964e2..d80ea64 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -149,6 +149,48 @@ test_expect_success "track initial change if it was only made to parent" '
 	     "`git rev-parse r9270-d~1`"
 	'
 
+test_expect_success "follow-parent is atomic" '
+	(
+		cd wc &&
+		svn up &&
+		svn mkdir stunk &&
+		echo "trunk stunk" > stunk/readme &&
+		svn add stunk/readme &&
+		svn ci -m "trunk stunk" &&
+		echo "stunk like junk" >> stunk/readme &&
+		svn ci -m "really stunk" &&
+		echo "stink stank stunk" >> stunk/readme &&
+		svn ci -m "even the grinch agrees"
+	) &&
+	svn copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&
+	{ svn cp -m "early stunk flunked too" \
+		"$svnrepo"/stunk@17 "$svnrepo"/flunked ||
+	svn cp -m "early stunk flunked too" \
+		-r17 "$svnrepo"/stunk "$svnrepo"/flunked; } &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	git update-ref refs/remotes/flunk@18 refs/remotes/stunk~2 &&
+	git update-ref -d refs/remotes/stunk &&
+	git config --unset svn-remote.svn.fetch stunk &&
+	mkdir -p "$GIT_DIR"/svn/flunk@18 &&
+	rev_map=$(cd "$GIT_DIR"/svn/stunk && ls .rev_map*) &&
+	dd if="$GIT_DIR"/svn/stunk/$rev_map \
+	   of="$GIT_DIR"/svn/flunk@18/$rev_map bs=24 count=1 &&
+	rm -rf "$GIT_DIR"/svn/stunk &&
+	git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
+	git svn fetch -i flunk &&
+	git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
+	git svn fetch -i stunk &&
+	git svn init --minimize-url -i flunked "$svnrepo"/flunked &&
+	git svn fetch -i flunked
+	test "`git rev-parse --verify refs/remotes/flunk@18`" \
+	   = "`git rev-parse --verify refs/remotes/stunk`" &&
+	test "`git rev-parse --verify refs/remotes/flunk~1`" \
+	   = "`git rev-parse --verify refs/remotes/stunk`" &&
+	test "`git rev-parse --verify refs/remotes/flunked~1`" \
+	   = "`git rev-parse --verify refs/remotes/stunk~1`"
+	'
+
 test_expect_success "track multi-parent paths" '
 	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git-svn multi-fetch &&
-- 
1.6.1.rc2
