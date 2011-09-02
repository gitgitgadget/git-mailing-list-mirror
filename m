From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 1 Sep 2011 20:00:39 -0400
Message-ID: <20110902000039.GB9339@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 02:00:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzHBg-0008W5-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 02:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab1IBAAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 20:00:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38736
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab1IBAAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 20:00:43 -0400
Received: (qmail 25606 invoked by uid 107); 2 Sep 2011 00:01:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 20:01:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 20:00:39 -0400
Content-Disposition: inline
In-Reply-To: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180585>

On Thu, Sep 01, 2011 at 11:25:31AM -0700, Junio C Hamano wrote:

> Suggested reading:
> 
>   http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-commit-to-git.html
> 
> I am wondering if we are better off applying something along the lines of
> this patch, so that with the default configuration, users can notice if
> their upstream unexpectedly rewound their branches.

Hmm. This feels like it's subtly changing the meaning of
refs/remotes/$remote/*.

Right now, I think of it as a local cache for whatever the remote side
has. In other words, a way of separating the network-fetching parts of
the workflow from the local parts. And in that sense, it is perfectly
reasonable to overwrite with what the other side has, whether they
rewind or not, because we are just representing what they have. And
since we keep a reflog, it's not as if the previous state is lost to us
locally.

But with this change, we are making a policy judgement about what to
fetch. And as you noticed, it means that users need to start telling git
about their policy (e.g., mentioning in the refspecs that pu can rewind)
in order to keep fetch working.

So I consider that a downside, because it's extra work for the user[1].
What are the upsides?

Is this about preventing workflow-related mistakes where people
accidentally merge in rebased commits, creating annoying shadow
histories?

Is it about preventing malicious rewinds from infecting downstream
repositories?

If the former, then I suspect we need to give more guidance to the user
than saying "reject, non-fast-forward". What then? Should they "fetch
-f"?  Or "pull --rebase" (actually, how do they even fetch the branch
now for such a pull --rebase)? Or talk out-of-band to the repo owner?

If the latter, then I think we should be specific about the attack
scenarios, and what happens with and without this config. And if it's a
security precaution, what cases doesn't it cover (e.g., initial clone is
still vulnerable, as is a one-off pull. As are are malicious insertion
attacks that don't involve rewinding).

And then we can weigh the upsides and the downsides.

-Peff

[1] What I really don't like is that cloning git.git is no longer:

      git clone git://git.kernel.org/pub/scm/git/git.git

    which is a minimal as it can be, but becomes:

      git clone git://git.kernel.org/pub/scm/git/git.git
      cd git
      git config --add remote.origin.fetch +refs/heads/pu:refs/remotes/origin/pu

    It's not that my fingers are too tired to do all that typing, but
    rather that the first set of instructions is very easy to explain,
    and the second one is full of magic and head-scratching about why
    git isn't handling this magic itself.

    It would be considerably nicer if the server had some way of saying
    "I expect this branch to be rewound". Which has been discussed off
    and on over the years, as I recall.
