From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 07/14] remote.c: introduce branch_get_upstream helper
Date: Thu, 21 May 2015 14:14:30 -0400
Message-ID: <20150521181429.GA6684@peff.net>
References: <20150521044429.GA5857@peff.net>
 <20150521044528.GG23409@peff.net>
 <xmqqbnhdkdne.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUzO-00059C-9I
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbbEUSOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:14:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:34150 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753867AbbEUSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:14:33 -0400
Received: (qmail 11044 invoked by uid 102); 21 May 2015 18:14:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 13:14:33 -0500
Received: (qmail 6017 invoked by uid 107); 21 May 2015 18:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 14:14:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 14:14:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnhdkdne.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269636>

On Thu, May 21, 2015 at 11:07:33AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > All of the information needed to find the @{upstream} of a
> > branch is included in the branch struct, but callers have to
> > navigate a series of possible-NULL values to get there.
> > Let's wrap that logic up in an easy-to-read helper.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> This step in the whole series is a gem.  I cannot believe that we
> were content having to repeat that "branch->merge[0]->dst if we can
> dereference down to that level" this many times.  Nice clean-up.

There is a related cleanup I resisted, which is that several call-sites
will call stat_tracking_info, then later look directly at
branch->merge[0]->dst without a check for NULL (fill_tracking_info is
such a site).

This works because stat_tracking_info's return value tells us that we
did indeed find an upstream to compare with. But it feels a little leaky
to me. One solution is for stat_tracking_info to pass out the name of
thte upstream, making the caller side something like:

diff --git a/builtin/branch.c b/builtin/branch.c
index cc55ff2..edc4deb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -425,11 +425,12 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
+	const char *upstream;
 	struct strbuf fancy = STRBUF_INIT;
 	int upstream_is_gone = 0;
 	int added_decoration = 1;
 
-	switch (stat_tracking_info(branch, &ours, &theirs)) {
+	switch (stat_tracking_info(branch, &ours, &theirs, &upstream)) {
 	case 0:
 		/* no base */
 		return;
@@ -443,7 +444,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	}
 
 	if (show_upstream_ref) {
-		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		ref = shorten_unambiguous_ref(upstream, 0);
 		if (want_color(branch_use_color))
 			strbuf_addf(&fancy, "%s%s%s",
 					branch_get_color(BRANCH_COLOR_UPSTREAM),


This is still a little error-prone, though. We assume "upstream" was
filled in depending on the return value of stat_tracking_info. I wonder
if we could get rid of the weird tri-state return value from
stat_tracking_info, and just have callers detect the "there is no base"
case by checking "upstream != NULL".

I dunno. It is not buggy in any of the current callers, so it might not
be worth spending too much time on.

-Peff
