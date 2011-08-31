From: Jeff King <peff@peff.net>
Subject: git credential helper design [was: What's cooking in git.git (Aug
 2011, #07; Wed, 24)]
Date: Tue, 30 Aug 2011 22:38:01 -0400
Message-ID: <20110831023801.GB3340@sigill.intra.peff.net>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
 <20110825202057.GB6165@sigill.intra.peff.net>
 <7vhb55i11i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 04:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyah1-0003Ef-1s
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 04:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab1HaCiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 22:38:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52061
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853Ab1HaCiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 22:38:04 -0400
Received: (qmail 32331 invoked by uid 107); 31 Aug 2011 02:38:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 22:38:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 22:38:01 -0400
Content-Disposition: inline
In-Reply-To: <7vhb55i11i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180455>

On Thu, Aug 25, 2011 at 03:22:49PM -0700, Junio C Hamano wrote:

> > I'm OK with holding this off for another round. I'd really like to get
> > more feedback from third-party helper writers. ...
> 
> I actually do not think the lack of finer-than-host level granularity a
> problem we need to solve before moving forward. IIRC, when accessing
> "http://github.com/frotz" and "http://github.com/nitfol", you would key
> the authentication material with something like "http://github.com" (or
> was it "http:github.com"? the details do not matter for the purpose of
> this discussion).

It's "http:github.com", which has always looked a bit ugly to me. I had
hoped they would just be opaque blobs and nobody would need to look at
them. But when you get into things like setting the username via the
config, then users see them, and they need to look sane. Making them
look more like a canonicalized URL is probably a good thing.

After seeing the helper that Lukas posted recently on the list, I am
wondering if they should include the username, too. I had left it
separate, because I wanted helpers to be able to index "foo@example.com"
and "example.com" in the same slot. I.e., to realize that the latter
could use the same credentials cached for the former. But it also
complicates the helpers; instead of doing:

  credential = secure_storage_lookup(unique_token);
  return credential /* could be NULL */

they have to do:

  for credential in secure_storage_lookup(unique_token) {
    if (!username)
      return credential; /* take first one arbitrarily */
    else if (username == credential.username)
      return credential; /* ok, matched preferred username */
  }
  return NULL;

which implies that the secure storage can even store a list indexed
under the token.

So perhaps a better model is to give the helper some canonicalized URL,
like:

  https://foo@example.com

(where the canonicalization is important, because we want the helper to
be able to just treat it like a string of bytes if it wants).  And then
we can naturally extend that to:

  https://foo@example.com/specific-repo.git

if the user wants a repo-specific authentication context.

> We can consider what you already have as the default case for a more
> general "we cut off at the hostname and take that as the auth-domain
> boundary unless told otherwise". We may not have the way to "tell
> otherwise" yet, but as long as we are reasonably confident that we know
> how to extend the system in a backward compatible way, it is not a
> show-stopper.

I think in either case it gets tacked onto the auth token. But it
probably makes sense now to choose a nice syntax for the token that will
look good when we extend it later.

Ted wrote:

> How about a config variable with regular expressions like
>
> auth-domain.xyz.url = https://(.*@)?github.com/.*

I like this. In fact, perhaps it makes sense for git to generate the
maximal token, like:

  https://user@host.example.com/path/to/repo.git

and then provide the user with configuration like this to narrow it down
as they see fit. Perhaps even do a substitution regexp to let them
rewrite it arbitrarily. And then if we want to be more permissive by
default, provide some backup regexps to be used when they don't provide
their own, like cutting out the pathname portion.

-Peff
