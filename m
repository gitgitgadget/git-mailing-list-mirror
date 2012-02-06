From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 5 Feb 2012 23:30:12 -0500
Message-ID: <20120206043012.GD29365@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGDc-0002W5-VW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab2BFEaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:30:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58548
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab2BFEaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 23:30:14 -0500
Received: (qmail 22726 invoked by uid 107); 6 Feb 2012 04:37:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 23:37:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 23:30:12 -0500
Content-Disposition: inline
In-Reply-To: <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190009>

On Sun, Feb 05, 2012 at 06:06:53PM -0800, Junio C Hamano wrote:

> Subject: [PATCH] git checkout -b: allow switching out of an unborn branch
> 
> Running "git checkout -b another" immediately after "git init" when you do
> not even have a commit on 'master' is forbidden, with a readable message:
> 
>     $ git checkout -b another
>     fatal: You are on a branch yet to be born
> 
> It is readable but not easily understandable unless the user knows what
> "yet to be born" really means.
> 
> So let's try allowing it and see what happens. I strongly suspect that
> this may just shift the confusion one step further without adding much
> value to the resulting system, because the next question that would come
> to somebody who does not understand what "yet to be born" is is "why don't
> I see 'master' in the output from 'git branch' command?", and the new
> warning may not be descriptive enough to explain what the user is doing.

I thought the concern wasn't confusion at the error message, but rather
"how do I start a new repository with a branch named something besides
'master'?"

You would expect:

  git init
  git checkout -b foo

to work, but it doesn't. And there's no easy way to do what you want
(you have to resort to plumbing to put the value in HEAD). So the issue
is not a bad error message or a confusing situation, but that the user
wants to accomplish X, and we don't provide a reasonable way to do it.

I suspect it hasn't come up so far because the "X" in this case is not
something people generally want to do. I.e., they are almost always
cloning and making a new branch from old history. If they have a
brand-new repo, they almost certainly don't actually care what the
branch is called.

And perhaps in that case we should be discouraging them from calling it
something besides master (because while master is mostly convention,
there are a few magic spots in the code where it is treated specially,
and departing from the convention for no good reason should be
discouraged).

So I don't see "this is just shifting confusion" as a real argument. But
you could argue that it is enabling the user to do something stupid and
pointless, and for that reason it should be disallowed (and in that
case, it might be better for the error to say "what you are doing is
stupid and pointless").

-Peff
