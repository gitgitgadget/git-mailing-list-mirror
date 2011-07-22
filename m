From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Fri, 22 Jul 2011 16:13:38 -0600
Message-ID: <20110722221337.GA15753@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
 <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
 <20110722204749.GC11922@sigill.intra.peff.net>
 <7vbowmx9da.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNyf-0007kz-5d
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab1GVWNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:13:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36833
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab1GVWNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:13:44 -0400
Received: (qmail 23866 invoked by uid 107); 22 Jul 2011 22:14:12 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:14:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:13:38 -0600
Content-Disposition: inline
In-Reply-To: <7vbowmx9da.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177675>

On Fri, Jul 22, 2011 at 03:01:53PM -0700, Junio C Hamano wrote:

> Yes, both "just prompt you once" and "would have to be configured only
> once" cut both ways, and that is mildly disturbing to my taste.
> 
> If we annotate the remote in .git/config perhaps like this:
> 
> 	[remote "foo"]
>         	url = https://github.com/peff/foo.git
>                 auth_context = "foo project at github"
> 		...
> 	[remote "bar"]
>         	url = https://github.com/peff/bar.git
>                 auth_context = "bar project at github"
> 
> and have "git push foo" pass the auth_context to the credential backend,
> which can notice the two projects are in different context and cache two
> identities under different contexts, would it be a good workaround for the
> issue?  Then, a remote that does not have auth_context configured would
> use "https:github.com" that is machine-generated (in http.c in your code),
> but that can easily be overridden if/as necessary.

That has the minor downside of not handling one-off URLs.

Actually, though, I think even with the current code, you can do better
than that. The "username" is an implicit part of the context, as well. A
poorly-written helper might ignore it, of course, but you can already
say:

  [remote "foo"]
    url = https://peff@github.com/peff/foo.git
    ...
  [remote "bar"]
    url = https://otheruser@github.com/otheruser/foo.git"
    ...

The "cache" helper will match the username when looking up only a
password. The "store" helper is less exacting, and uses only the
opaque context. Mostly because it uses the config format as a backing
store, which makes pairing usernames and passwords more difficult (but
not impossible; it can be worked around by saving some context between
invocations of the config callback). So that's a good reason to improve
"store".

As a bonus, this technique actually works to access the exact same repo
as two different identities (whereas just including the path in the
context does not). E.g.:

  [remote "repo-as-me"]
    url = https://me@example.com/repo.git
    ...
  [remote "repo-as-other-role"]
    url = https://role@example.com/repo.git
    ...

I expect those cases to be even less common, of course, but it's nice
that it's straightforward to support them.

> > I tried to optimize for the common case (many repos under one identity)
> > than the uncommon (many identities under one host).
> 
> As I am not convinced if this statement is true.

I admit I don't have any data beyond my own experiences. GitHub tends
towards the concept of a single identity, and it has some group
management. I don't know about other sites, though. Do you have any
specific examples in mind?

-Peff
