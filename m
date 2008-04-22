From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 17:52:39 -0400
Message-ID: <20080422215239.GB30770@sigill.intra.peff.net>
References: <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:53:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoQQc-0002PQ-Md
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbYDVVwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 17:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYDVVwo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 17:52:44 -0400
Received: from peff.net ([208.65.91.99]:3923 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528AbYDVVwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 17:52:43 -0400
Received: (qmail 22470 invoked by uid 111); 22 Apr 2008 21:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 17:52:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 17:52:39 -0400
Content-Disposition: inline
In-Reply-To: <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80168>

On Tue, Apr 22, 2008 at 01:45:05PM -0700, Junio C Hamano wrote:

> >         "git push $there $commit:$name", when $name does not begin with
> >         refs/, is interpreted as "git push $there
> >         $commit:$prefix/$name", where $prefix is determined by resolving
> >         $commit and pulling off its first two directories.
> >
> > (or maybe this should just be picky and DWIM only for refs/heads and
> > refs/tags). So "git push v1.0" is the same as "git push v1.0:v1.0",
> > which is the same as "git push refs/tags/v1.0:refs/tags/v1.0".
> 
> Where is $there in your example?

Heh, sorry. s/git push/& $there/g.

> Funny but I recall recently running "git push ko v1.5.5.1" and it all
> worked as expected...

I'm not sure what you mean here. Yes, we already special case "git push
$there $ref" into "git push $there $ref:$ref", except we use the
fully-qualified ref name for the right-hand side. I mention it because I
think of this as simply extending that dwimmery to $commit:branch2. That
is, there is a complete and unambiguous refspec like
"refs/heads/branch1:refs/heads/branch2", and the others are logical DWIM
shorthands that expand into such a refspec.

> I thought the original poster's example was
> 
> 	git push $there $commit:branch2
> 
> where $commit happened to be "branch1".  Would we dwim
> 
> 	git push $there branch1~4:this_is_known_ok
> 
> to refs/heads/?

I'm not sure what you mean by "this_is_known_ok". Do you mean the remote
already has such a ref? I think the dwim is:

  1. if the destination ref is fully qualified, use that
  2. if the destination ref is not fully qualified, but resolves
     unambiguously to a ref on the remote, use that
  3. otherwise, do the dwim we are talking about, which is to qualify it
     using the same type as the source ref

So if you meant "the remote has such a ref", then no, I think we stick
with the current behavior (2).

But I think what you were getting at is: "what is the source type of
branch~4"? I am inclined to say "the same as the source type of branch",
but I can see how one might think that is getting a little crazy.
Related is the question of "what is the source type of <sha1>". In that
case, we should almost certainly give an error as we do now. Putting
"branch~4" into that category (or HEAD if it is detached) makes some
sense to me.

-Peff
