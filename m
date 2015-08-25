From: Jeff King <peff@peff.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 13:12:39 -0400
Message-ID: <20150825171238.GB9674@sigill.intra.peff.net>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUHmF-0001LZ-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbbHYRMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:12:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:49858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755246AbbHYRMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:12:41 -0400
Received: (qmail 9422 invoked by uid 102); 25 Aug 2015 17:12:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 12:12:41 -0500
Received: (qmail 5393 invoked by uid 107); 25 Aug 2015 17:12:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 13:12:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 13:12:39 -0400
Content-Disposition: inline
In-Reply-To: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276539>

On Tue, Aug 25, 2015 at 05:01:01PM +0200, Gabor Bernat wrote:

> So it would be great if the filter-branch beside the Rewrite
> f8f0b351ae35ff7ac4bd58078cbba1aa34243779 (523/22625), would also
> append a basic ETA signaling the end of the operation.
> 
> It could be as simple as the the average number of milliseconds per
> step up to this point multiplied with the remaining number of steps,
> then convert this into a day:hour:minutes:seconds format. It sound
> simple enough, but really handy for long running filter branch
> operations. I could also contribute if one could direct me towards the
> appropriate files this should go to.

Yeah, I agree the current filter-branch progress reporting is pretty
simplistic. The line you want to tweak is in git-filter-branch.sh:

  printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"

But the real trick is getting accurate timing in a shell script. You can
probably do the math within a "$(())" arithmetic block if you're OK with
integers. But you'd have to run `date` on each loop iteration to get the
current time, which may have a noticeable speed impact.

Of course, filter-branch is so slow in the first place, maybe it would
not matter. :)

Something like this seems to work:

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..04e45bc 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -276,10 +276,21 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 # Rewrite the commits
 
+start=$(date +%s)
 git_filter_branch__commit_count=0
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
-	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"
+	now=$(date +%s)
+	elapsed=$(($now - $start))
+	# work in integer percentages as a sort of fixed-point
+	pct=$(($git_filter_branch__commit_count * 100 / $commits))
+	if test $pct -eq 0; then
+		remain=
+	else
+		eta=$(($elapsed * 100 / $pct))
+		remain="($(($eta - $elapsed)) seconds remaining)   "
+	fi
+	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits) $remain"
 
 	case "$filter_subdir" in
 	"")

but the time jumps around early on because of the lack of precision. And
of course there's no smoothing, and no emphasis on recent history versus
the whole operation. I'll leave those as an exercise to the reader. :)

-Peff
