From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 17:00:27 -0400
Message-ID: <20160428210026.GA12268@sigill.intra.peff.net>
References: <20160428112912.GB11522@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281405540.2896@virtualbox>
 <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
 <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
 <20160428165031.GA31421@sigill.intra.peff.net>
 <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
 <20160428191038.GA10574@sigill.intra.peff.net>
 <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avt35-0005NV-KR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbcD1VAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:00:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:58756 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753265AbcD1VAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:00:30 -0400
Received: (qmail 15473 invoked by uid 102); 28 Apr 2016 21:00:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:00:29 -0400
Received: (qmail 14553 invoked by uid 107); 28 Apr 2016 21:00:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:00:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 17:00:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292951>

On Thu, Apr 28, 2016 at 12:28:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's definitely sufficient, it's just annoying if a user shows up every
> > week and says "I want X.Y", and then somebody else shows up a week later
> > and says "I want X.Z".
> >
> > Are we serving any purpose in vetting each one (and if so, what)?
> 
> Personally I do not think we would need to filter _anything_ if we
> can tell that the user directly said
> 
> 	git -c var1=val1 -c var2=val2 $cmd ...
> 
> and "git $cmd" ended up needing to spawn another "git" subcommand,
> possibly in some other repository (i.e. "$cmd" in this case is
> likely to be "submodule", but in principle it does not have to be).
> If the user somehow gives variables like core.worktree that are
> inappropriate to be applied across repositories, that's user's
> problem, i.e. "don't do it then if it hurts".

Right, we are talking about that direct case here. And any time our
filter heuristic lets something through, it is probably "if it hurts
don't do it" as the worst case.

So I think the only two cases worth filtering are:

  1. Ones where we _know_ that the config is nonsense to pass along,
     _and_ where a user might conceivably make use of the
     just-the-top-level version of it (core.worktree
     comes to mind, though of course they are probably better served by
     "--work-tree" in such a case).

  2. An option where we think there may be some security implication.
     Setting "http.sslverify" to false does have some security
     implications ("oops, I only meant to turn off verification for the
     root repo, and I got MiTM-attacked for the submodules!"). But it's
     so obscure and unlikely that I think the benefit outweighs it.

     And I can't think of any other cases whose security implications
     aren't similarly unlikely. But I haven't carefully gone down the
     list (and as I said, I'd be hesitant to support a blacklist until
     _somebody_ takes the time to do so).

> If we are doing any filtering, however, it is always hard, if not
> impossible, to take away what we originally granted, even by
> mistake, for any reason, even for correctness or for security, in a
> later release.

Yep, agreed.

I am OK staying with a whitelist. But I think we should be fairly
lenient in whitelisting hierarchies that people have a use for, and
which do not violate (1) or (2) above.

> We probably could sidestep it by introducing an end-user
> configurable "whitelist" somewhere.

Ugh. Please no. I do not want to have to think about explaining to
somebody that they can accomplish what they want with submodules, but
only by pre-configuring their ~/.gitconfig to allow certain keys so that
they can pass the appropriate config on the command line.

-Peff
