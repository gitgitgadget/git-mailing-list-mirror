From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Fri, 22 Jul 2011 14:47:50 -0600
Message-ID: <20110722204749.GC11922@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
 <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMdh-0006wr-G1
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab1GVUr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:47:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44641
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab1GVUr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:47:59 -0400
Received: (qmail 23186 invoked by uid 107); 22 Jul 2011 20:48:27 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 16:48:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 14:47:50 -0600
Content-Disposition: inline
In-Reply-To: <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177668>

On Wed, Jul 20, 2011 at 03:17:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -342,11 +341,11 @@ static void http_auth_init(const char *url)
> >  		host = at + 1;
> >  	}
> >  
> > +	http_auth.description = url_decode_mem(host, slash - host);
> 
> Could a hosting site like github host multiple repositories, each of which
> the user may interact with under different identity?  Just wondering if it
> is sufficient to say "http://example.com/" or it needs to be more
> specific, e.g. "http://example.com/p/project.git/".

Yes, it's entirely possible. This is a policy decision I had to make
(which I really tried to avoid in this series, but at some point, you
have to make some if you don't want a million config options).

It means that you can get convenient credential handling (whether it's
because you've configured a username, or you're getting it from a
wallet, or caching, or whatever) with:

  git push https://github.com/peff/git.git &&
  git push https://github.com/peff/foo.git

which should hopefully just prompt you once (and a configured username
would have to be configured only once for the host).

And it comes at the cost that there's not a good way to use two
different identities for the same host.

I tried to optimize for the common case (many repos under one identity)
than the uncommon (many identities under one host). But I do wish there
were a better way to say "No, I want to be more specific". In the
current code, it would probably mean adding a config option to put the
repo path into the unique token.

If we go in the direction of dumping a list of key/value attributes to
the credential helper, then it becomes up to the helper to make that
policy decision. Which is extremely flexible (e.g., you could use the
same identity for all repos on host1, but per-repo identities on host2).
But configuring it becomes a matter of actually writing your own helper,
which is not something most people would (or should have to) do.

-Peff
