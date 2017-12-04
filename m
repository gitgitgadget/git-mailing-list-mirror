Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D099520954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbdLDWCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:02:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752441AbdLDWCa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:02:30 -0500
Received: (qmail 10881 invoked by uid 109); 4 Dec 2017 22:02:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 22:02:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27444 invoked by uid 111); 4 Dec 2017 22:02:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 17:02:50 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 17:02:28 -0500
Date:   Mon, 4 Dec 2017 17:02:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 0/2] fix v2.15 progress regression
Message-ID: <20171204220228.GA29422@sigill.intra.peff.net>
References: <20171204203647.30546-1-lars.schneider@autodesk.com>
 <20171204213350.GA21552@sigill.intra.peff.net>
 <xmqqvahmkwbi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvahmkwbi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 01:38:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So the minimal fix is actually:
> >
> > diff --git a/progress.c b/progress.c
> > index 289678d43d..b774cb1cd1 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -229,7 +229,7 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
> >  
> >  struct progress *start_delayed_progress(const char *title, unsigned total)
> >  {
> > -	return start_progress_delay(title, total, 0, 2);
> > +	return start_progress_delay(title, total, 100, 2);
> >  }
> 
> That makes a lot more sense to me (at least from a cursory
> comparison between the two approaches).

Here's what I think we should do: fix the bug in the minimal way, and
then drop the useless code. It's worth doing in two steps, because we
may decide to resurrect the feature later, and it would then just be a
straight revert of the second commit.

  [1/2]: progress: set default delay threshold to 100%, not 0%
  [2/2]: progress: drop delay-threshold code

 progress.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

This regression is in v2.15, so this probably ought to go to maint (at
least the first part, though I think the second should have no
user-visible effects).

-Peff
