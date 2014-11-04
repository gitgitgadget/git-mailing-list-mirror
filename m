From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Tue, 4 Nov 2014 18:32:15 -0500
Message-ID: <20141104233215.GA16091@peff.net>
References: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <20141030213523.GA21017@peff.net>
 <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
 <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
 <20141101033327.GA8307@peff.net>
 <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
 <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
 <20141103220408.GA12462@peff.net>
 <xmqq389zrguw.fsf@gitster.dls.corp.google.com>
 <xmqq4muepr40.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlnaH-0002oU-6O
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 00:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbaKDXcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 18:32:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:36820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751324AbaKDXcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 18:32:16 -0500
Received: (qmail 19665 invoked by uid 102); 4 Nov 2014 23:32:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 17:32:16 -0600
Received: (qmail 10456 invoked by uid 107); 4 Nov 2014 23:32:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 18:32:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2014 18:32:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4muepr40.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 04, 2014 at 01:56:15PM -0800, Junio C Hamano wrote:

> >>   2. Including two lines, like:
> >>
> >>         $sha1 HEAD\0symref=refs/heads/master
> >>         $sha1 HEAD
> >>
> >>      which JGit does the right thing with (and git.git seems to, as
> >>      well).
> >
> > Sounds sensible, even though it looks ugly X-<.
> 
> I have a mild preference for a syntax that is more similar to the
> on-wire protocol, so that connect.c::parse_feature_value() can be
> reused to parse it and possibly annotate_refs_with_symref_info() can
> also be reused by calling it from transport.c::get_refs_from_bundle().

Yeah, what I wrote above was the simplest thing that could work, and
does not need to be the final form.  I know that you already know what
I'm about to describe below, Junio, but I want to expand on the
situation for the benefit of onlookers (and potential implementers like
Philip).

The online protocol is hampered by the "if you see something after a
NUL, it is a capabilities string, and you must throw out the previous
capabilities string and replace it with this one" historical rule. And
that's why we cannot do:

  $sha1 refs/heads/master\0thin-pack side-band etc
  $sha1 HEAD\0symref=refs/heads/master

as it would throw out "thin-pack", "side-band", etc. Instead we do it
more like:

  $sha1 refs/heads/master\0thin-pack side-band etc symref=HEAD:refs/heads/master
  $sha1 HEAD

to shove _all_ of the symref mappings into the capability string, rather
than letting them ride along with their respective refs. The downside is
that we are bounded in the number of symref mappings we can send (by the
maximum length for a single pkt-line), and therefore send only the value
of HEAD.

The bundle code is not bound by this historical legacy, and could do it
in a different (and more efficient and flexible) way. But it is probably
saner to just keep them identical. It makes the code simpler, and having
bundle as the only transport which has the extra flexibility does not
really buy us much (and probably just invites confusion).

-Peff
