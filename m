From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] perl
Date: Mon, 28 Oct 2013 21:18:59 -0400
Message-ID: <20131029011859.GA22140@sigill.intra.peff.net>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
 <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
 <526EA7C8.2020607@kdbg.org>
 <20131028182718.GA4242@google.com>
 <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
 <20131028192216.GB4242@google.com>
 <20131028195429.GA8299@sigill.intra.peff.net>
 <20131028210420.GC4242@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaxxc-0004hu-BV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab3J2BTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:19:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:57371 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751825Ab3J2BTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:19:03 -0400
Received: (qmail 28718 invoked by uid 102); 29 Oct 2013 01:19:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:19:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:18:59 -0400
Content-Disposition: inline
In-Reply-To: <20131028210420.GC4242@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236879>

On Mon, Oct 28, 2013 at 02:04:20PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Speaking of which, is there any reason to use the ugly "$PERL_PATH"
> > everywhere, and not simply do:
> >
> >   perl () {
> >     "$PERL_PATH" "$@"
> >   }
> >
> > in test-lib.sh?
> 
> Sounds like a nice potential improvement to me. :)

One answer to "is there any reason..." is "it will loop infinitely if
you set PERL_PATH=perl". :) However, we can work around that with
"command".

It also may cause problems due to the way one-shot variables are treated
when calling a function versus a command, but we do not seem to set any
variables for invocations perl (and I do not envision it happening
often).

And finally, the other reason I can think of is that we can't apply it
consistently. It only helps where a shell function would activate, which
makes the end result potentially more confusing (especially to somebody
who does not really grok shells and subprocesses). Still, it does not
introduce any _new_ cases that need it, but only helps with a subset of
the cases. So in that sense it is a strict improvement, as we can let
most uses go, but catch only the trickier cases in review.

So I'm on the fence on whether it is a good idea or not, but I wrote up
the patches to play with it. I also noticed that we do not consistently
use $PERL_PATH in some of the built scripts, so I included that fix,
too.

Note that I do not have a system with a broken perl. I simulated a very
broken perl, which is how I found all of the spots to fix. But whether
they are actual bugs that would trigger due to a Windows perl that
handles CRLF differently, I have no clue.

  [1/3]: use @@PERL@@ in built scripts
  [2/3]: t: provide a perl() function which uses $PERL_PATH
  [3/3]: t: use perl instead of "$PERL_PATH" where applicable

-Peff
