From: Jeff King <peff@peff.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Tue, 15 Sep 2015 06:05:39 -0400
Message-ID: <20150915100538.GA21831@sigill.intra.peff.net>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net>
 <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
 <20150912033054.GA30431@sigill.intra.peff.net>
 <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
 <20150913100728.GA26562@sigill.intra.peff.net>
 <CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbn7T-0006Jw-LE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 12:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbbIOKFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 06:05:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:59178 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750698AbbIOKFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 06:05:42 -0400
Received: (qmail 23984 invoked by uid 102); 15 Sep 2015 10:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 05:05:42 -0500
Received: (qmail 4731 invoked by uid 107); 15 Sep 2015 10:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 06:05:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 06:05:39 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277899>

On Sun, Sep 13, 2015 at 10:19:33PM -0700, Junio C Hamano wrote:

> For that matter, I am not sure how "blame A..B" with first-parent &
> reverse should behave when A is not an ancestor on the first-parent
> chain. Wouldn't we try to find a cut-point on the first-parent chain by
> traversing first-parent chain from B and painting them as positive,
> while traversing _all_ parents from B and painting them as negative,
> until the traversal intersect? And wouldn't we discover at least two
> children (one positive and one negative) for the cut point we discover
> by that traversal? That cut point would be the (fake) latest state the
> blame traversal starts at, and then we try to use the first (fake) parent
> that in real life is the first child (which we do not have a good definition
> for). And at that point a simple panda brain explodes ;-)
> 
> We might end up doing the right thing even in that case, but I haven't
> convinced myself about that (yet).  If the change were limited to "blame",
> the change may be much less problematic.

Good point.

It seems like nobody is actually that interested in what "blame
--first-parent --reverse" does in the first place, though, and there's
no reason for its complexity to hold up vanilla --first-parent. So what
do you think of:

-- >8 --
Subject: [PATCH] blame: handle --first-parent

The revision.c options-parser will parse "--first-parent"
for us, but the blame code does not actually respect it, as
we simply iterate over the whole list returned by
first_scapegoat(). We can fix this by returning a
truncated parent list.

Note that we could technically also do so by limiting the
return value of num_scapegoats(), but that is less robust.
We would rely on nobody ever looking at the "next" pointer
from the returned list.

Combining "--reverse" with "--first-parent" is more
complicated, and will probably involve cooperation from
revision.c. Since the desired semantics are not even clear,
let's punt on this for now, but explicitly disallow it to
avoid confusing users (this is not really a regression,
since it did something nonsensical before).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c     | 11 ++++++++++-
 t/annotate-tests.sh |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..ae4301c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1366,8 +1366,15 @@ static void pass_whole_blame(struct scoreboard *sb,
  */
 static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
 {
-	if (!reverse)
+	if (!reverse) {
+		if (revs->first_parent_only &&
+		    commit->parents &&
+		    commit->parents->next) {
+			free_commit_list(commit->parents->next);
+			commit->parents->next = NULL;
+		}
 		return commit->parents;
+	}
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
@@ -2680,6 +2687,8 @@ parse_done:
 	}
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
+	else if (revs.first_parent_only)
+		die("combining --first-parent and --reverse is not supported");
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index f5c0175..b1673b3 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -111,6 +111,10 @@ test_expect_success 'blame 2 authors + 2 merged-in authors' '
 	check_count A 2 B 1 B1 2 B2 1
 '
 
+test_expect_success 'blame --first-parent blames merge for branch1' '
+	check_count --first-parent A 2 B 1 "A U Thor" 2 B2 1
+'
+
 test_expect_success 'blame ancestor' '
 	check_count -h master A 2 B 2
 '
-- 
2.6.0.rc2.408.ga2926b9
