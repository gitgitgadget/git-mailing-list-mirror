From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Tue, 3 Apr 2012 05:19:37 -0400
Message-ID: <20120403091937.GB14483@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780F5.3060306@lsrfire.ath.cx>
 <20120402201432.GA26503@sigill.intra.peff.net>
 <4F7A2E0D.9030402@lsrfire.ath.cx>
 <20120403084035.GA14483@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 03 11:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEzua-0001p7-2f
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 11:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab2DCJTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 05:19:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44107
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2DCJTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 05:19:44 -0400
Received: (qmail 27550 invoked by uid 107); 3 Apr 2012 09:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 05:19:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 05:19:37 -0400
Content-Disposition: inline
In-Reply-To: <20120403084035.GA14483@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194608>

On Tue, Apr 03, 2012 at 04:40:36AM -0400, Jeff King wrote:

> > It looks nice and to the point, but breaks several tests for me
> > (t3508, t4013, t4041, t4202, t6003, t6009, t6016, t6018 and t7401).
> > Not sure why.
> 
> I probably screwed up the reversal or something. My patch was a quick "I
> was thinking of this direction" and I didn't actually test it well.

Ugh. Not that it matters now, but the patch below fixes my version.

Not only did I manage to screw up the reversal, but I also messed up the
calling convention for qsort. So the moral is that we should take 100
lines of your tested code over 5 lines of my junk. ;)

As a fun fact, I tried fixing the reversal by sorting low to high, and
then just doing the commit_list_insert calls in that order (since it
prepends). However, that loses the stability of the sort. It turns out
that t4207 fails in this case (though not reliably, since your commits
might or might not be made in the same second).

I had already checked your mergesort() implementation to be sure that it
is stable (and it is). But it's nice to know that t4207 also backs up
the analysis. :)

-Peff

---
diff --git a/revision.c b/revision.c
index 22c26d0..15bf30a 100644
--- a/revision.c
+++ b/revision.c
@@ -2064,11 +2064,11 @@ static void set_children(struct rev_info *revs)
 
 static int commit_compare_by_date(const void *va, const void *vb)
 {
-	const struct commit *a = va;
-	const struct commit *b = vb;
-	if (a->date < b->date)
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+	if (a->date > b->date)
 		return -1;
-	if (b->date < a->date)
+	if (b->date > a->date)
 		return 1;
 	return 0;
 }
