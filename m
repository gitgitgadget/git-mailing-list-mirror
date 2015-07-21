From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Mon, 20 Jul 2015 18:19:31 -0700
Message-ID: <20150721011931.GB28255@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630132653.GA25742@peff.net>
 <CAPig+cT_3pFH6XKBO1F2rbNyiGz5NgLMMiA_T+NWBroW5Sj7cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 03:19:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHMDc-0000il-EX
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 03:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424AbbGUBTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 21:19:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757218AbbGUBTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 21:19:36 -0400
Received: (qmail 9996 invoked by uid 102); 21 Jul 2015 01:19:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jul 2015 20:19:35 -0500
Received: (qmail 22990 invoked by uid 107); 21 Jul 2015 01:19:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jul 2015 21:19:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2015 18:19:32 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cT_3pFH6XKBO1F2rbNyiGz5NgLMMiA_T+NWBroW5Sj7cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274366>

On Mon, Jul 20, 2015 at 08:41:08PM -0400, Eric Sunshine wrote:

> > Here's a patch, on top of jk/date-mode-format (I think it would also be
> > fine to just squash into the tip commit; the explanation in the commit
> > message is sufficiently mirrored in the code comment).
> 
> While cleaning up old local branches, I noticed that, although the
> jk/date-mode-format topic[1] made it into 'next' (and will be merged
> to 'master' according to "What's cooking"[2]), the below follow-on
> patch[3] which improves strbuf_addftime() never got picked up. Was
> this omission intentional? Based upon the discussion[4], I was under
> the impression that the patch was considered reasonably acceptable
> (and did not worsen problems with bogus format strings -- which are
> bogus anyway).

Thanks for noticing. I do think the patch you quoted (to loop and grow
the strbuf) is a good change. The original code would easily bite
somebody with a really large date format, whereas this should work
sanely everywhere, short of malformed inputs. And even then, I'd expect
reasonable behavior on most systems. The obvious thing to worry about is
a system where feeding a malformed "% " causes strftime to return 0, no
matter what, and we reallocated and loop forever. But:

  1. I don't even know if such a system exists.

  2. We probably would blow up on malloc() eventually, so it wouldn't
     even be a "real" infinite loop.

So I think the worst case is probably that we get a report later on from
somebody on an arcane system that says "I fed crap to --date=format, and
my git died with an out-of-memory error", and then we figure out exactly
_how_ their system is weird and deal with it then.

-Peff
