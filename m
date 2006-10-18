From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 07:52:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 16:53:45 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaCnK-0001Qh-Le
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 16:53:23 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaCmy-0002aF-NR; Wed, 18 Oct 2006 15:53:00 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GaCmX-0002Vo-9e
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 15:52:33 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IEqQaX025174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 07:52:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IEqPhB005132;
	Wed, 18 Oct 2006 07:52:25 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20061018053647.GA3507@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29236>



On Wed, 18 Oct 2006, Jeff King wrote:
> 
> I never used BK, but my understanding is that it was based on
> changesets, so a bundle was a group of changesets.

Yes.

> Because a git commit represents the entire tree state, how can we avoid 
> sending the entire tree in each bundle?

That's not the problem. That's easy to handle - and we already do. That's 
the whole point of the wire-transfer protocol (ie sending deltas, and only 
sending enough to actually matter).

> The interactive protocols can ask "what do you have?" but an email 
> bundle is presumably meant to work without a round trip.

Right, but they can do exactly what bk did: you have to have a reference 
to what the other side has. In git, that's usually even simpler: you'd do

	git send origin..

and that "origin" is what the other end is expected to already have.

Of course, if you send an unconnected bundle (ie you give an origin that 
the other end _doesn't_ have), you're screwed.

In other words, to get such a pack, we'd _literally_ just do something 
like

	git-rev-list --objects-edge origin.. |
		git-pack-objects --stdout |
		uuencode

and that would be it. You'd still need to add a "diffstat" to the thing, 
and tell the other end what the current HEAD is (so that it knows what 
it's supposed to fast-forward to), but it _literally_ is that simple.

"plug-in architecture" my ass. "I recognize this - it's UNIX!".

		Linus
