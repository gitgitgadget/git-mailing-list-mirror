From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] cmd_push: pass "flags" pointer to config callback
Date: Mon, 16 Feb 2015 02:16:39 -0500
Message-ID: <20150216071638.GA818@peff.net>
References: <20150216061051.GA29895@peff.net>
 <20150216061325.GB32381@peff.net>
 <xmqqr3tq72ui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:16:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNFvC-0005OS-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 08:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbbBPHQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 02:16:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:49442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbbBPHQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 02:16:41 -0500
Received: (qmail 11929 invoked by uid 102); 16 Feb 2015 07:16:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:16:41 -0600
Received: (qmail 12901 invoked by uid 107); 16 Feb 2015 07:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 02:16:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 02:16:39 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3tq72ui.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263886>

On Sun, Feb 15, 2015 at 11:05:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This will let us manipulate any transport flags which have matching
> > config options (there are none yet, but we will add one in
> > the next patch).
> 
> Nice---this will later lets us do push.atomic if we really wanted
> to, right?

Yes, exactly. Or push.signed, or whatever.

> > To be honest, the whole do_push is confusing to me. It seems like that
> > should just be part of cmd_push.
> 
> Yeah, that part of the push callchain always confuses me every time
> I look at it.  I think it was a consequence of how transport layer
> was wedged into the existing codepath that only handled push that
> called send-pack to unify the codepaths that push calls into
> different transport backends, and we may have done it differently
> and more cleanly if we were designing the push to transport to
> backends from scratch.

I took a very cursory look at folding do_push into cmd_push. It's not
_too_ bad. You wouldn't want to fold push_with_options in, as that gets
called from a loop (you could make it the loop body, but I think it is
more clear as-is).

However, it is really do_push which continues to manipulate the flags
and set up the push, so that is the bit that should be folded in. And
then it would be fine to make transport_flags a global, and
push_with_options could just use it directly, I think.

-Peff
