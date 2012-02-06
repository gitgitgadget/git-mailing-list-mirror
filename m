From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 00:06:37 -0500
Message-ID: <20120206050637.GA4263@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGmq-0006iS-NS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785Ab2BFFGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:06:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58558
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab2BFFGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:06:39 -0500
Received: (qmail 22963 invoked by uid 107); 6 Feb 2012 05:13:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 00:13:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 00:06:37 -0500
Content-Disposition: inline
In-Reply-To: <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190011>

On Mon, Feb 06, 2012 at 03:42:24PM +1100, Andrew Ardill wrote:

> On 6 February 2012 15:30, Jeff King <peff@peff.net> wrote:
> 
> > And perhaps in that case we should be discouraging them from calling it
> > something besides master (because while master is mostly convention,
> > there are a few magic spots in the code where it is treated specially,
> > and departing from the convention for no good reason should be
> > discouraged).
> 
> What exactly are the areas where 'master' is treated specially? I
> agree that people should be discouraged from needlessly abandoning
> convention, however I think users should have the ability to name
> their branches as they see fit.

Fairly minor stuff. Between the top of my head and a quick grep:

  1. Some transports (like git://) are incapable of communicating the
     destination of a remote's symbolic ref (they see only that HEAD
     points to some specific sha1). But things like "clone" want to know
     where the HEAD is pointing to set up the remotes/$origin/HEAD
     link. We can guess that if HEAD and some branch have the same sha1,
     that HEAD is pointing to that branch. But you might have two or
     more such branches pointing to the same spot. In this case, we
     prefer "master" over other branches.

     This code is in guess_remote_head.

  2. When merging, if the current branch is named "master", the default
     merge message says "Merge branch foo". Otherwise, it says "Merge
     branch foo into bar".

  3. It looks like the antique "branches" file format defaults to
     fetching "master" when no branch specifier is given. I doubt anyone
     is still using this file format these days.

I was actually surprised how infrequently the term "master" comes up in
a grep of the code. So while I wouldn't call my search exhaustive, I did
inspect every match in the C code.

> If I am forced to abandon code targeted at the 'master' naming
> convention in order to use my desired naming convention, we should fix
> that. Additionally, if I have to either manually set a branch name
> with plumbing commands, or delete existing branches that are generated
> automatically with no option not to generate them, we should improve
> the porcelain to cover these cracks.
> 
> In general, I think it plausible that in some use cases the term
> 'master' might be misleading or inappropriate and users should not be
> punished for that.

I kind of agree that we shouldn't be unnecessarily restrictive. On the
other hand, I am stretching to find the plausible reason that one would
want to throw away the normal convention. Code aside, it simply
introduces a slight communication barrier when talking with other git
users, and for that reason should be something you don't do lightly. I
don't recall seeing anybody complain seriously about it in the past six
years of git's existence.

-Peff
