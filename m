From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 17:56:27 -0500
Message-ID: <20130121225626.GA17156@sigill.intra.peff.net>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <CACsJy8C4qx0P621imj5B+HdoJkow0_jaGLVDRvdCDw3YRnK98g@mail.gmail.com>
 <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQIO-0005Ro-3u
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3AUW4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 17:56:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41767 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3AUW4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 17:56:30 -0500
Received: (qmail 20349 invoked by uid 107); 21 Jan 2013 22:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 17:57:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 17:56:27 -0500
Content-Disposition: inline
In-Reply-To: <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214168>

On Sat, Jan 19, 2013 at 11:16:00AM -0800, Junio C Hamano wrote:

> For example, if you mirror-clone from either of my repositories from
> GitHub:
> 
>     git clone --mirror git://github.com/git/git/
>     git clone --mirror git://github.com/gitster/git/
> 
> you will see stuff that does not belong to the project; objects that
> are only reachable from refs/pull/* are not something I approved to
> be placed in my repository; I as the project owner do not want to
> give these objects to a cloner as if they are part of my project.
> 
> The server side can hide refs/pull/ and refs/pull-request-tags/ so
> that clones (and ls-remote) will not see clutter, and nobody gets
> hurt.

I think it is unfortunately not so simple as that. You do not want them
to be part of your "clone --mirror", but some people do (because they
will inspect them when evaluating the pull request). And that decision
is, I think, in the eye of the cloner, not the eye of the repo owner. I
think in your case it is a little harder to see, in that you do not care
about the PR mechanism for git.git at all, but let us think for a minute
about a project that actually uses PRs.

For an ordinary developer, they would be content to fetch the branch
tips and tags (and that is what we do by default with "git clone). They
do not need to fetch all of refs/pull. If they learn out-of-band that PR
123 exists, they can in theory ask for refs/pull/123/head. That works
even with your proposal, because it is just about dropping the
advertisement, not the availability of refs.

But what about entities which really do want all of refs/pull?  I can
think of two good reasons to want them:

  1. You really do want a mirror, because you are creating a backup or
     alternate distribution channel. IOW, you are using "git clone
     --mirror", but it is missing those refs.

  2. You are a developer who is sometimes disconnected. You want to
     fetch all of the PRs, and then examine them at your leisure.

Without advertising, how do they ask for the wildcard of `refs/pull/*`?
They're stuck massaging some out-of-band data into a set of distinct
fetch refspecs.

I don't know much about what's in Gerrit's refs/changes, but I imagine
one could make a similar argument that their value is in the eye of the
client. And later you give this example:

> Another example.  If you run ls-remote against the above two
> repositories, you will notice that the latter has tons more
> branches.  The former are to publish only the primary integration
> branches, while the latter are to show individual topics.
> 
> I wish I didn't have to do this if I could.
> 
> We have periodical "What's cooking" postings that let interested
> parties learn topics out-of-band.  If I can hide refs/heads/??/*
> from normal users' clones while actually keeping individual topics
> there at the same place, I do not have to push into two places.

Most people do not want to see those heads. But some people (like me)
do, and it is a great convenience to be able to fetch them all with a
wildcard refspec, which cannot work if they are not advertised. I would
have to parse what's cooking and fetch them each individually. That's
not a technologically insurmountable problem, but it means git is being
a lot less helpful than it could be.


So I think in these cases of "extra refs", some clients would want them,
and some would not. And only they can know which camp they are in, not
the server side. Which is why the current system works pretty well: we
advertise everything and let the client decide what it wants. Clone very
sanely fetches only refs/heads/* (and associated tags), and you can put
whatever extra junk you want elsewhere in the hierarchy. A mirrored
clone will fetch it, but to me that is the point of --mirror. And if you
want some arbitrary subset, then you can implement that, too, by the
use of fetch refspecs[1].

The downside, of course, is that the ref advertisement is bigger than
many clients will want. But dealing with that is a separate issue from
"these refs should never be shown", as solutions for one may not work
from the other (e.g., if we delayed ref advertisement until the client
had spoken, the client could tell us what refspecs they are interested
in).

For your topic branch example, why don't you push to refs/topics of the
main git repository? Then normal cloners wouldn't see it, but anybody
interested could add the appropriate fetch refspec.

-Peff

[1] It may be that refspecs are not as expressive as we would like,
    but that is a client side problem we can deal with. For instance,
    you cannot currently say "give me everything except refs/foo/*".
