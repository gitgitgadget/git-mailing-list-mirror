From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Thu, 4 Jun 2015 09:09:02 -0400
Message-ID: <20150604130902.GA12404@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <20150527061818.GA885@peff.net>
 <20150527070838.GA6873@peff.net>
 <CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 15:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0UuQ-0000Bf-MU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 15:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbbFDNKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 09:10:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:41075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753338AbbFDNJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 09:09:05 -0400
Received: (qmail 29622 invoked by uid 102); 4 Jun 2015 13:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 08:09:04 -0500
Received: (qmail 31844 invoked by uid 107); 4 Jun 2015 13:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 09:09:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 09:09:02 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZxFnkneixquUijd2yfKBh6+XnYiYzCh8L9Mkourh64Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270772>

On Mon, Jun 01, 2015 at 10:49:45AM -0700, Stefan Beller wrote:

> However the client side with builtin/fetch, builtin/fetch-pack, fetch-pack
> is a bit of a mystery to me, as I cannot fully grasp the difference between
>  * connect.{h,c}
>  * remote.{h.c}
>  * transport.{h.c}
> there. All of it seems to be doing network related stuff, but I have trouble
> getting the big picture. I am assuming all of these 3 are rather a low level,
> used like a library, though there must be even more hierarchy in there,
> connect is most low level judging from the header file and used by
> the other two.
> transport.h seems to provide the most toplevel library stuff as it includes
> remote.h in its header?

connect.c was originally "the git protocol", and was used by send-pack
and fetch-pack. Other individual programs implemented other transports.
Later, as the interface moved towards everybody running "fetch" and
"push", and those delegating work to the individual transports, we got
transport.c, which is an abstract interface for all transports. It
delegates actual git-protocol work to the functions in connect.c (or
bundle work elsewhere, or handles remote-helpers itself).

And then remote.c contains routines for dealing with the remotes at a
logical level. E.g., which refs to fetch or push, etc.

So in theory, the flow is something like:

  - fetch.c knows "the user wants to fetch from 'foo'"

  - fetch asks remote.c: "who is remote 'foo'"; we get back a URL

  - fetch asks transport.c: "what are the refs for $URL"

  - it turns out to be a git URL. transport.c calls into connect.c to
    implement get_refs_via_connect.

  - after fetch gets back the list of refs, it uses routines in remote.c
    to figure out which refs we are interested in, handle refspecs, etc

  - now fetch asks transport.c: "OK, fetch just these refs"

  - transport.c again calls into connect.c to handle the actual fetch

Of course over the years a lot of cruft has grown around all of them. I
wouldn't be surprised if there are functions which cross these
abstractions, or other random functions inside each file that do not
belong.

> and the issue I am concerned about is the select_capabilities as well as
> the request_capabilities function here. The select_capabilities functionality
> is currently residing in the high level parts of the code as it both depends on
> the advertised server capabilities and on the user input (--use-frotz or config
> options), so the capability selection is done in fetchpack.c
> 
> So there are 2 routes to go: Either we leave the select_capabilities in the
> upper layers (near the actual high level command, fetch, fetchpack) or we put
> it into the transport layer and just passing in a struct what the user desires.
> And when the users desire doesn't meet the server capabilities we die deep down
> in the transport layer.

I think you have to leave it in the fetch-pack code. As you note, it's
the place where we know about what the user is asking for and can
manipulate the list. And not all transports even support capabilities
like this.

-Peff
