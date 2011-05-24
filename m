From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Support multiple virtual repositories with a single
 object store and refs
Date: Tue, 24 May 2011 15:47:11 -0700
Message-ID: <20110524224711.GA2527@leaf>
References: <20110524010252.GA5368@leaf>
 <20110524195937.GE584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jamey Sharp <jamey@minilop.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 00:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0Nr-0003CI-OX
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab1EXWrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:47:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59374 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141Ab1EXWrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:47:21 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id E6677A8068;
	Wed, 25 May 2011 00:47:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 1iY27c1XYIrq; Wed, 25 May 2011 00:47:18 +0200 (CEST)
X-Originating-IP: 131.252.247.248
Received: from leaf (host-247-248.pubnet.pdx.edu [131.252.247.248])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BAB63A8070;
	Wed, 25 May 2011 00:47:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110524195937.GE584@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174353>

Thanks for your feedback!  We just sent v2 of the patch (with a new patch
to http-backend) before seeing your mail, so we'll send out a v3
incorporating your feedback.

On Tue, May 24, 2011 at 03:59:37PM -0400, Jeff King wrote:
> On Mon, May 23, 2011 at 06:02:52PM -0700, Josh Triplett wrote:
> > Given many repositories with copies of the same objects (such as
> > branches of the same source), sharing a common object store will avoid
> > duplication.  Alternates provide a single baseline, but don't handle
> > ongoing activity in the various repositories.  Git safely handles
> > concurrent accesses to the same object store across repositories, but
> > operations such as gc need to know about all of the refs.
> > 
> > This change adds support in upload-pack and receive-pack to simulate
> > multiple virtual repositories within the object store and references of
> > a single underlying repository.
> 
> Neat idea. It is important to note, though, that it is possible to leak
> information between virtual repos that share the same object store. You
> can't directly say "give me object ABCD" if you don't have a ref to it,
> but you can do some other sneaky things like:
> 
>   1. Claiming to push ABCD, at which point the server will optimize out
>      the need for you to actually send it. Now you have a ref to ABCD
>      and can fetch it (claiming not to have it, of course).
> 
>   2. Requesting other refs, claiming that you have ABCD, at which point
>      the server may generates deltas against ABCD.
> 
> Both are problems with alternates, too, of course. But in the case of
> alternates, you can share only a subset of the objects. So every day or
> so, you could pack all of the objects that _all_ repos can see into one
> big alternates repo, and then each "leaf" repo contains any objects
> private to itself.
> 
> Of course none of this is a concern if you are just hosting public
> repositories, or everyone who gets to see one virtual repo can see
> what's in other ones (e.g., everybody is sharing objects within one
> organization).

We hadn't thought of those ways to access objects from another virtual
repository.  We had already planned to use separate storage repositories
for separate security domains for exactly such reasons, though.  Fixing
those issues seems possible if someone cares about security models other
than the everyone-can-read model you mentioned, but given that our use
case fits in that model we'd like to leave that as Someone Else's
Problem(tm). :)

> But it may make sense to touch on these issues in the documentation
> (which also needs to be written at all :) ).

v2 of the patch includes some documentation in the http-backend manpage,
though we probably should have a separate manpage documenting the whole
concept and reference that from any backends which implement it.  How
does gitvirtual(1) sound?

We didn't document the new upload-pack and receive-pack options, but
those programs already seem to have a pile of undocumented options. :)

v3 will include additional documentation, and we'll make sure to mention
the security implications.

> > The refs and heads of the virtual repositories get stored in the
> > underlying repository using prefixed names specified by the
> > --ref-prefix and --head options; for instance, --ref-prefix=repo1/
> > will use refs/repo1/heads/* and refs/repo1/tags/*.  upload-pack and
> > receive-pack will not expose any references that do not match the
> > specified prefix.
> 
> You have a namespace clash if a repo is named "heads" or "tags" or
> "remotes". Should we give it its own namespace, like:
> 
>   refs/virtual/repo1/heads/*
> 
> ?
> 
> Also, it seems conceptually simpler to me if it's a straight prefix.
> IOW, "refs/heads/foo" in repo1 becomes:
> 
>   refs/virtual/repo1/refs/heads/foo
>
> Then if we are operating in the virtual repo1 space, then:
> 
>   1. It is an easy test to know whether we are allowed to see a ref:
>      "does it start with refs/virtual/$repo/ ?"
>
>   2. Converting back and forth is simple. You just prepend or strip the
>      refs/virtual/$repo prefix.

Both of the namespaces you suggested work with our current patch:
--ref-prefix=virtual/repo1/, or --ref-prefix=virtual/repo1/refs/.  We'd
like to leave the exact choice of paths up to the policies of the host,
but your suggestion does seem like a good general namespacing policy.

- Josh Triplett and Jamey Sharp
