From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test: accept death by SIGPIPE as a valid failure mode
Date: Thu, 5 Nov 2015 02:47:31 -0500
Message-ID: <20151105074730.GA6819@sigill.intra.peff.net>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
 <CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
 <CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
 <xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com>
 <xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com>
 <xmqqr3kcjbll.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>,
	Fredrik Medley <fredrik.medley@gmail.com>,
	patrick.reynolds@github.com,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuFGk-00057f-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032709AbbKEHre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:47:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:53221 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1032699AbbKEHrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 02:47:33 -0500
Received: (qmail 22307 invoked by uid 102); 5 Nov 2015 07:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 01:47:34 -0600
Received: (qmail 11141 invoked by uid 107); 5 Nov 2015 07:48:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 02:48:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 02:47:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3kcjbll.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280915>

On Fri, Oct 30, 2015 at 02:22:14PM -0700, Junio C Hamano wrote:

> On a local host, the object/history transport code often talks over
> pipe with the other side.  The other side may notice some (expected)
> failure, send the error message either to our process or to the
> standard error and hung up.  In such codepaths, if timing were not
> unfortunate, our side would receive the report of (expected) failure
> from the other side over the pipe and die().  Otherwise, our side
> may still be trying to talk to it and would die with a SIGPIPE.
> 
> This was observed as an intermittent breakage in t5516 by a few
> people.
> 
> In the real-life scenario, either mode of death exits with a
> non-zero status, and the user would learn that the command failed.
> The test_must_fail helper should also know that dying with SIGPIPE
> is one of the valid failure modes when we are expecting the tested
> operation to notice problem and fail.

Sorry for the slow review; before commenting I wanted to dig into
whether this SIGPIPE ambiguity was avoidable in the first place.

I think the answer is "probably not". We do call write_or_die() pretty
consistently in the network-aware programs. So we could ignore SIGPIPE,
and then we would catch EPIPE (of course, we convert that into SIGPIPE
in many places, but we do not have to do so). But since the SIGPIPE
behavior is global, that carries the risk of us failing to check a write
against some other descriptor. It's probably not worth it.

Teaching the tests to handle both cases seems like a reasonable
workaround. Changing test_must_fail covers a lot of cases; I wondered if
there are other tests that would not want to silently cover up a SIGPIPE
death. But I could not really think of a plausible reason.

So I think your patch is the best thing to do.

-Peff
