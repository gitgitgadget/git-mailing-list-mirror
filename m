From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 17:35:08 -0400
Message-ID: <20120810213508.GC888@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
 <20120810180836.GA29597@sigill.intra.peff.net>
 <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
 <20120810182555.GA29707@sigill.intra.peff.net>
 <7vr4reigm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzwsA-0007Vs-Bd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630Ab2HJVfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:35:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34062 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab2HJVfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:35:16 -0400
Received: (qmail 2530 invoked by uid 107); 10 Aug 2012 21:35:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 17:35:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 17:35:08 -0400
Content-Disposition: inline
In-Reply-To: <7vr4reigm8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203266>

On Fri, Aug 10, 2012 at 02:25:51PM -0700, Junio C Hamano wrote:

> > I don't think there's any bug here. They are all of a class of features
> > where the client can handle the case where the server simply ignores the
> > request. However it is certainly food for thought if we are considering
> > tightening git's server side (even if we fix these, we have to support
> > the innocuous capabilities list forever for older clients).
> 
> I doubt the "innocuous" approach is really viable, unless we have an
> autoritative documentation that tells which ones are and which ones
> are not innocuous, and everybody follows it, so that everybody's
> server and client understands the same set of capabilities as such.

I think the point is that the ordering is something like:

  1. New client features get implemented wrongly. Nobody notices because
     the server side is lax.

  2. Somebody writes a new server (dulwich), or tightens the existing
     code (what we are thinking of). They create the innocuous list
     because they must deal with older clients from (1).

  3. Somebody tries to implement a new client feature wrongly. They
     notice because strict servers actually exist, and are told their
     client is buggy and wrong. The innocuous list never grows.

So we are at step (2), and are just realizing the client problem. Even
if we fix it, we still need the current innocuous list to handle
existing clients.

Although I would think you do not have to worry about the innocuous list
if you always advertise those features. Which I'm surprised dulwich does
not do (IOW, why do they even need the innocuous list?).

> Which is not likely to happen.  So in that sense, the above have
> three bugs.  A new person that starts writing his server without
> knowing the workaround Dulwich used that has been hidden from the
> Git community until today will have to rediscover the "innocuous"
> workaround on his server, unless such buggy clients die out.
> 
> I'd rather make sure that 10 years on, the maintainer does not have
> to worry about interoperating with a new server written by some
> third-party.

Oh, definitely. I wasn't arguing that we shouldn't fix the clients. Just
that we need to make sure that the current list continues working if we
decide to tighten the server side.

> Something like this, perhaps.
> 
>  builtin/fetch-pack.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index bc7a0f9..fdec7f6 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -818,6 +818,12 @@ static struct ref *do_fetch_pack(int fd[2],
>  			fprintf(stderr, "Server supports side-band\n");
>  		use_sideband = 1;
>  	}
> +	if (!server_supports("thin-pack"))
> +		args.use_thin_pack = 0;
> +	if (!server_supports("no-progress"))
> +		args.no_progress = 0;
> +	if (!server_supports("include-tag"))
> +		args.include_tag = 0;
>  	if (server_supports("ofs-delta")) {
>  		if (args.verbose)
>  			fprintf(stderr, "Server supports ofs-delta\n");

Yes, I think that is all that is necessary to fix the immediate issue.
The protocol-capabilities document talks about what to do when
include-tag is not available ("SHOULD issue a subsequent fetch to
acquire the tags that include-tag would have otherwise given the
client"), but I am not sure how well we handle that (in theory we should
be handling it already, but I didn't look).

-Peff
