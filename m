From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 19:27:45 -0400
Message-ID: <20160324232745.GA18499@sigill.intra.peff.net>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
 <20160324215104.GC8830@LykOS>
 <20160324221457.GB17805@sigill.intra.peff.net>
 <20160324223257.GE8830@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:27:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEfS-0001Xs-CK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbcCXX1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:27:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:37872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750797AbcCXX1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:27:48 -0400
Received: (qmail 959 invoked by uid 102); 24 Mar 2016 23:27:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 19:27:47 -0400
Received: (qmail 18729 invoked by uid 107); 24 Mar 2016 23:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 19:28:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 19:27:45 -0400
Content-Disposition: inline
In-Reply-To: <20160324223257.GE8830@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289821>

On Thu, Mar 24, 2016 at 06:32:58PM -0400, Santiago Torres wrote:

> > But I notice that we already handle SIGPIPE explicitly in sign_buffer()
> > for similar reasons.  What I was wondering earlier was whether we should
> > teach other functions that call gpg (like verify_signed_buffer()) to
> > ignore SIGPIPE, too, so that we can return a reasonable error value
> > rather than just killing the whole program.
> 
> Now I get it  I think this should be easy to achieve by moving
> verify_tag() to tag.c, along with the static run_gpg_verify functions.

Exactly.

> I could move the SIGPIPE call inside the verify-tag command and patch up
> everything accordingly. Does this sound ok?

I think that works, but take note of two things:

  - convert it to sigchain_push(), and make sure you sigchain_pop() it
    when you are done, so that the caller retains their original SIGPIPE
    behavior after the function returns. See the example in
    sign_buffer().

  - you should probably do it as close to the gpg call as possible, so
    as to affect as little code as possible. So probably in
    verify_signed_buffer(), not in verify_tag().

-Peff
