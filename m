From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 17:25:26 -0400
Message-ID: <20150612212526.GA25447@peff.net>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
 <1434049168-10613-1-git-send-email-augie@google.com>
 <557A7ABA.2000404@kdbg.org>
 <xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
 <20150612180005.GA9242@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Augie Fackler <augie@google.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WSF-0004Kt-Hl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbbFLVZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:25:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:45424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754723AbbFLVZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:25:29 -0400
Received: (qmail 10413 invoked by uid 102); 12 Jun 2015 21:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 16:25:29 -0500
Received: (qmail 17627 invoked by uid 107); 12 Jun 2015 21:25:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 17:25:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 17:25:26 -0400
Content-Disposition: inline
In-Reply-To: <20150612180005.GA9242@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271525>

On Fri, Jun 12, 2015 at 02:00:05PM -0400, Jeff King wrote:

> When I added GIT_TRACE_PACKET long ago, I had always intended to
> follow-up with a GIT_TRACE_PACKFILE. The former stops tracing when we
> get to the binary data, but I had intended the latter to store the pure
> on-the-wire packfile transmission for later debugging to. I never got
> around to it, but I think it is something like the patch below.

Here it is, a bit more cleaned up. I think this is a nice improvement,
and it does fix some minor issues in the existing GIT_TRACE_PACKET code.
But I don't think it will ever work for receive-pack, because we hand
off the socket directly to index-pack.

I can live with that. But another approach would be to make it easier to
capture the stdin of programs with GIT_TRACE, rather than just their
arguments. That makes it more generically usable (e.g., I have hacky
patches on our servers for capturing "pack-objects" input so I can
replay expensive fetch requests). As Augie noted, that's not a full
pack-file due to the --pack-header stuff. But given a full trace (which
has both the arguments and stdin), you could reconstruct the packfile,
which we could do as a post-processing step.

I dunno. I prefer introducing a nicely generic mechanism, but it would
probably be a little more irritating to use in practice.

I guess yet another way to do it would be to put the GIT_TRACE_PACK
intelligence into index-pack and unpack-objects (rather than
fetch-pack). Then it at least applies to both the pushing and fetching
sides.

Anyway, here are the patches I came up with:

  [1/3]: pkt-line: simplify starts_with checks in packet tracing
  [2/3]: pkt-line: tighten sideband PACK check when tracing
  [3/3]: pkt-line: support tracing verbatim pack contents

-Peff
