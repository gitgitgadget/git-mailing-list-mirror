From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 09:26:18 -0400
Message-ID: <20160429132617.GB30931@sigill.intra.peff.net>
References: <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
 <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
 <20160428165031.GA31421@sigill.intra.peff.net>
 <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
 <20160428191038.GA10574@sigill.intra.peff.net>
 <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
 <20160428210026.GA12268@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604291417580.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw8R7-0007Nq-MD
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 15:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbcD2N0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 09:26:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59068 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752759AbcD2N0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 09:26:21 -0400
Received: (qmail 5852 invoked by uid 102); 29 Apr 2016 13:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:26:20 -0400
Received: (qmail 21731 invoked by uid 107); 29 Apr 2016 13:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:26:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 09:26:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604291417580.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292996>

On Fri, Apr 29, 2016 at 02:29:25PM +0200, Johannes Schindelin wrote:

> The more I think about it, I actually think that we do the user a *really*
> great disservice by filtering the CONFIG_DATA_ENVIRONMENT. If I call
> 
> 	git -c ... $cmd
> 
> and that configuration is *not* picked up, it is much worse than letting
> users shoot themselves in their own feet by specifying config settings
> that are *prone* to wreak havoc.

That's a good point. For every "whoops, I didn't mean for this to kick
in for the submodule!" there is an equal and opposite "whoops, this
needed to kick in for the submodule!" case (e.g., instead of
over-reaching turning http.sslverify off, you might be trying to turn it
_on_ and fail to apply it in all cases).

And making the rule "-c applies to all sub-processes, period" is much
simpler to explain.

(Though of course it is still not entirely true. We clear the config
 when accessing another repository as a remote for fetching or pushing.
 But a good chunk of that is simply for consistency of all remotes, as
 we do not pass the environment across TCP sessions).

> > So I think the only two cases worth filtering are:
> > 
> >   1. Ones where we _know_ that the config is nonsense to pass along,
> >      _and_ where a user might conceivably make use of the
> >      just-the-top-level version of it (core.worktree
> >      comes to mind, though of course they are probably better served by
> >      "--work-tree" in such a case).
> >   2. An option where we think there may be some security implication.
> >      Setting "http.sslverify" to false does have some security
> >      implications ("oops, I only meant to turn off verification for the
> >      root repo, and I got MiTM-attacked for the submodules!"). But it's
> >      so obscure and unlikely that I think the benefit outweighs it.
> 
> I can see that happening when somebody calls an alias with `git -c ...`
> and that alias performs actions in the top-level project as well as all
> submodules.
> 
> But. Do we really have to be "Big Daddy" for users who do that?

I have more sympathy for cases that full under (1) above, just because
they currently work _now_. So it's possible somebody is currently doing
a thing that makes sense under the current rules, but will involve
foot-shooting under the new version.

> > I am OK staying with a whitelist.
> 
> Me, too. But I am even more in favor of abandoning this "we know what is
> good for you" approach, i.e. that whitelist that filters
> CONFIG_DATA_ENVIRONMENT.

I could live with that, too. I've added Jens to the cc; his preference
for not blindly sharing config to submodules is part of what influenced
me in the original discussion.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/264840

    I think that's the right link, which I dug out of my
    <20160219043019.GA14764@sigill.intra.peff.net> from a few months
    ago. Gmane seems to be down.
