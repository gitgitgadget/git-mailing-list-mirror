From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin
Date: Mon, 26 Mar 2012 13:24:32 -0400
Message-ID: <20120326172432.GD7942@sigill.intra.peff.net>
References: <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3478.3090505@gmx.net>
 <20120325012432.GD27651@sigill.intra.peff.net>
 <4F6EEAE3.60204@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDer-0006tq-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089Ab2CZRYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:24:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60000
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932742Ab2CZRYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:24:34 -0400
Received: (qmail 14198 invoked by uid 107); 26 Mar 2012 17:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 13:24:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 13:24:32 -0400
Content-Disposition: inline
In-Reply-To: <4F6EEAE3.60204@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193935>

On Sun, Mar 25, 2012 at 11:52:35AM +0200, Ivan Todoroski wrote:

> >>-static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
> >>+static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
> >>+		int nr_fetch, struct ref **to_fetch)
> [...]
> Yeah, I realized this was ugly after I sent it.... not only are new
> arguments added to rpc_service(), but they seem completely arbitrary
> and specific to fetch-pack. There is no reason other callers of
> rpc_service() would want args in the exact same format.

Yeah, I think that is what was bugging me about it.

> On the other hand I can't reuse rpc_state.argv because that is
> already passed to client.argv for start_command().

Right. You'd need a new member.

> Would it be OK if I add a new memeber in rpc_state, e.g. "struct
> strbuf *stdin_preamble"? If non-NULL, it would contain any data the
> caller of rpc_service() wants shoved into the stdin of the
> sub-command before anything else. That way the caller is free to
> format this data in whatever format they need, not only in the
> pkt-line format needed by fetch-pack.

I think that is the cleanest solution. It's a little less efficient, in
that we build the whole buffer in memory instead of sending each packet
as we form it. But I think we are talking about a few kilobytes at most.

-Peff
