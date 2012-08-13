From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 16:54:24 -0400
Message-ID: <20120813205423.GA31630@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 22:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11em-0004XG-KP
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab2HMUyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:54:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36517 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab2HMUyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:54:31 -0400
Received: (qmail 30106 invoked by uid 107); 13 Aug 2012 20:54:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Aug 2012 16:54:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2012 16:54:24 -0400
Content-Disposition: inline
In-Reply-To: <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203363>

On Mon, Aug 13, 2012 at 12:07:35PM -0700, Junio C Hamano wrote:

>  * And this is your 4 adjusted for the previous one, releaving the
>    caller from having to figure out where the capability string
>    ends.
> [...]
> @@ -829,8 +831,15 @@ static struct ref *do_fetch_pack(int fd[2],
>  			fprintf(stderr, "Server supports ofs-delta\n");
>  	} else
>  		prefer_ofs_delta = 0;
> -	if (server_supports("agent"))
> +
> +	if ((agent_feature = server_feature("agent", &agent_len)) != NULL &&
> +	    5 < agent_len && agent_feature[5] == '=') {
>  		agent_supported = 1;
> +		if (args.verbose) {
> +			fprintf(stderr, "Server version is %.*s\n",
> +				agent_len - 6, agent_feature + 6);
> +		}
> +	}

Yeah, this is exactly the kind of ugliness I was trying to avoid with my
allocating wrapper. Still, there is only one call site, so I do not care
overly much (and I as I've already said, I'm lukewarm on the final two
patches, anyway).

There is one difference in your code and mine. With mine, the server can
say simply "agent" to tell the client that it understands the extension
but does not wish to disclose its version. That might be considered
unfriendly (why would the client show theirs if the server is not
willing to do the same?), but it may be a practical decision (e.g.,
security policies may say that servers are higher-risk targets[1]).
Of course, a server can also say "agent=git/none-of-your-business"; this
is just a syntactic question.

-Peff

[1] I think you and I both agreed earlier that the "sharing versions is
    a security risk" line of argument is not that compelling, but that
    does not mean it is not made all the time.

-Peff
