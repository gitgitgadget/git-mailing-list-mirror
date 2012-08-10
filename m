From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 14:25:55 -0400
Message-ID: <20120810182555.GA29707@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
 <20120810180836.GA29597@sigill.intra.peff.net>
 <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SztuV-0004hp-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759857Ab2HJS0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:26:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33877 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759815Ab2HJS0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:26:04 -0400
Received: (qmail 744 invoked by uid 107); 10 Aug 2012 18:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 14:26:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 14:25:55 -0400
Content-Disposition: inline
In-Reply-To: <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203245>

On Fri, Aug 10, 2012 at 11:13:30AM -0700, Dave Borowitz wrote:

> > Thanks for the data point. I knew you guys ran some custom code, so I
> > wasn't sure how widespread this is. The fact that other dulwich-based
> > servers would see the same issue makes me doubly sure that my fix is the
> > right direction.
> 
> You may also notice in that code a set of innocuous_capabilities,
> which IIRC is the complete set of capabilities, at the time of
> writing, that the C git client may send without the server advertising
> them. Such a set (painstakingly assembled, I assure you :) may be
> useful as we move further in this direction.

Oh, hmm. When initially writing my message I thought that might be the
case, but I checked to see that the features were sent only when the
server had first advertised them. However, I didn't notice that is true
only in _some_ of these lines from fetch-pack.c:

    if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
    if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
    if (no_done)            strbuf_addstr(&c, " no-done");
    if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
    if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
    if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
    if (args.no_progress)   strbuf_addstr(&c, " no-progress");
    if (args.include_tag)   strbuf_addstr(&c, " include-tag");

The early ones are checking that the server claimed support, but all of
the args.* ones are influenced directly by the arguments, whether the
server supports it or not.

I don't think there's any bug here. They are all of a class of features
where the client can handle the case where the server simply ignores the
request. However it is certainly food for thought if we are considering
tightening git's server side (even if we fix these, we have to support
the innocuous capabilities list forever for older clients).

-Peff
