From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Sat, 27 Feb 2016 13:31:33 -0500
Message-ID: <20160227183133.GB12822@sigill.intra.peff.net>
References: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
 <20160227043625.GC11604@sigill.intra.peff.net>
 <20160227174523.GB11593@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:31:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjeW-0003fA-Rb
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbcB0Sbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:31:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:50781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756657AbcB0Sbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:31:36 -0500
Received: (qmail 31847 invoked by uid 102); 27 Feb 2016 18:31:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 13:31:35 -0500
Received: (qmail 14548 invoked by uid 107); 27 Feb 2016 18:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 13:31:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:31:33 -0500
Content-Disposition: inline
In-Reply-To: <20160227174523.GB11593@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287718>

On Sat, Feb 27, 2016 at 12:45:24PM -0500, Santiago Torres wrote:

> > A much more interesting change in this area, I think, would be to skip
> > verify-tag entirely. Once upon a time it had a lot of logic itself, but
> > these days it is a thin wrapper over run_gpg_verify(), and we could
> > improve the efficiency quite a bit by eliminates the sub-process
> > entirely.
> 
> I agree here too. while going through gdb to follow the logic on this I saw that
> this code forks three times (git, tag-verify and gpg). I'm sure that
> removing one layer should be good efficiencly-wise.
> 
> Is it ok if I give this a shot?

Sure.

I suspect the extra process is there for historical reasons; git-tag was
originally a shell script that called out to git-verify-tag, and the
conversion to C retained the separate call.

I cannot think of a reason that it would be a bad thing to do it all in
a single process. Do note the trickery with SIGPIPE in verify-tag,
though. We probably need to do the same here (in fact, I wonder if that
should be pushed down into the code that calls gpg).

-Peff
