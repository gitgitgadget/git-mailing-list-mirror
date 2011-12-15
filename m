From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --ignore-stale option
Date: Thu, 15 Dec 2011 02:38:16 -0500
Message-ID: <20111215073816.GD1327@sigill.intra.peff.net>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 08:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb5tX-0001vE-Li
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 08:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1LOHiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 02:38:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50366
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab1LOHiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 02:38:18 -0500
Received: (qmail 6319 invoked by uid 107); 15 Dec 2011 07:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 02:45:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 02:38:16 -0500
Content-Disposition: inline
In-Reply-To: <7vobvct58u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187195>

On Tue, Dec 13, 2011 at 03:35:13PM -0800, Junio C Hamano wrote:

> Teach a new "--ignore-stale" option to "git push" which tells it not to
> push stale refs (i.e. the commit that would have been pushed without the
> option is an ancestor of the commit that is at the destination). With this,
> a lazy workflow could be like this:
> 
>     $ git clone <<origin>>
>     $ git checkout -b topic1 origin/topic1
>     $ work work work
>     $ git push origin :
>     $ git checkout -b topic2 origin/topic2
>     $ work work work
>     $ git push --ignore-stale origin :
> 
> and the second push does not have to worry about other people working on
> topic1 and updating it in the central repository while you haven't touched
> the corresponding local branch at all.

Unless the action of the people in the central repo was to rewind
history, in which case you are overwriting their work. Probably
unlikely, though.

But I still see this as solving the wrong problem, and encouraging a
dangerous workflow. Why are you using ":" to push matching branches if
you don't want to push topic1? I think a much more likely scenario is:

  $ git clone <<origin>>
  $ git checkout -b topic1 origin/topic1
  $ work work work
  $ : hmm, it's not ready yet
  $ git checkout -b topic2 origin/topic2
  $ work work work
  $ : looking good, let's ship it!
  $ git push  ;# we default to matching!

I.e., the user is not actually intending to push all matching branches,
but does so accidentally because "matching" is the default. And they
have accidentally just pushed non-ready work to topic1, which would
happen even with --ignore-stale.

IOW, I am not convinced that people are actually consciously choosing
the workflow you outlined above, and are instead interested in
--ignore-stale as a convenient way of guessing which branches should be
pushed during a matching push. But it's only a guess, and as I showed
above, it can still cause problems. I think the right solution is to
switch the default away from matching, which is the root cause of the
confusion.

-Peff
