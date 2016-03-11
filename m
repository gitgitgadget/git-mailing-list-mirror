From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Fri, 11 Mar 2016 13:16:35 -0500
Message-ID: <20160311181635.GA31299@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net>
 <20160310122020.GA24007@lanh>
 <20160310211052.GC30595@sigill.intra.peff.net>
 <xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
 <20160310214042.GB32608@sigill.intra.peff.net>
 <CACsJy8BRhuSOs96fonjBJ0ok6JZJ3CwLkDPCP_9QQdROZUVh8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:24:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRg9-0000BC-FU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcCKSQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:16:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:58494 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750819AbcCKSQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:16:38 -0500
Received: (qmail 9485 invoked by uid 102); 11 Mar 2016 18:16:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 13:16:37 -0500
Received: (qmail 5378 invoked by uid 107); 11 Mar 2016 18:16:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 13:16:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 13:16:35 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BRhuSOs96fonjBJ0ok6JZJ3CwLkDPCP_9QQdROZUVh8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288694>

On Fri, Mar 11, 2016 at 07:47:34AM +0700, Duy Nguyen wrote:

> Well, assume again that F and G are ref heads, and their respective
> distance to C and D are the same (like the below graph), then "fetch
> --deptch=<distance>" can mark C and D as shallow cut points because
> --depth traverses from refs until the distance is met, it does not do
> total exclusion ^C like rev-list.
> 
>        --- B ---- C ---- H ---- F
>           /      /
>      --- D ---- E ---- G

Right, so I think we would only apply the "use existing cutoffs as
bounds" thing when we were not otherwise given a --depth. Because it can
definitely cause us to override the depth (and there's no need to; the
point is to avoid linking in all of history, and --depth already solves
that). So we probably do want the client to ask "I'm not giving you a
depth, but please use my existing shallows as cutoffs".

I think a more interesting case here is when we have C as a cutoff, and
somebody fetches "E" directly. They are part of the truncated history.
So we should exclude them from a fetch of "G", but if the user asked for
them directly, that probably needs to override the existing shallow
cutoff.

We probably want to compute the --boundary of "E ^C", but then omit from
that any items that are directly in want_obj. IOW, it is OK to truncate
at depth=1 due to an existing cutoff, but not at depth=0. :)

That does mean we would then fetch all of the history leading up to E,
but I think that's OK. If the user didn't specify --depth and they are
fetching from behind the shallow-cutoff point, we don't have any real
way of knowing how much they wanted (though I guess it would also be
sensible to just apply depth=1 in such a case).

-Peff
