From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Mon, 20 Jun 2011 09:09:45 -0400
Message-ID: <20110620130945.GA19011@sigill.intra.peff.net>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org>
 <4DFEEB60.5000005@viscovery.net>
 <20110620070316.GA15246@sigill.intra.peff.net>
 <4DFF2A1D.3060206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 15:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYeEk-0007wu-7T
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 15:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1FTNJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 09:09:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab1FTNJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 09:09:48 -0400
Received: (qmail 20976 invoked by uid 107); 20 Jun 2011 13:10:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 09:10:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 09:09:45 -0400
Content-Disposition: inline
In-Reply-To: <4DFF2A1D.3060206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176066>

On Mon, Jun 20, 2011 at 01:08:13PM +0200, Michael J Gruber wrote:

> > For that matter, --match should be spelled "--glob", as we already have:
> > 
> >   $ git log --glob='jk/*'
> > 
> > I think having the ref-selection for "git branch" match that of the
> > revision walker makes sense.
> 
> Well, "branch" is about refs, and "log" about revs.

Sure, and I wouldn't expect "git branch --list 1234abcd" to do anything
useful. But naming refs is a subset of naming revs. Certainly it seems
worth it to make the shorthands like "--remotes" behave the same way
where applicable.

I do agree that "git branch -l 'jk/*'" is less typing than "--glob"; it
may be worth supporting both forms to provide the least surprise to the
user (i.e., even though it may not be the shortest, users may expect the
same syntax to work in both places, and it costs us very little to
accept either).

> I'd rather have
> "branch" similar to "tag" in that respect (i.e. '-l'). I'm still meaning
> to revive that series:
> 
> http://permalink.gmane.org/gmane.comp.version-control.git/172228

Modulo Junio's comments on the "-l" transition, I like the idea. One
thing jumped out at me:

> -       else if (argc == 0)
> -               return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
> +       else if (argc == 0 || (verbose && argc == 1))
> +               return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ?  argv[0] : NULL);

Is there any reason not to accept:

  git branch --list jk/* mg/*

? For "tag -l", we seem to silently ignore any arguments past the first:

  $ git tag -l 'v1.7.4.*' 'v1.7.5.*'
  v1.7.4.1
  v1.7.4.2
  v1.7.4.3
  v1.7.4.4
  v1.7.4.5

We should at least warn and say "your second argument is being ignored"
or show the usage message.  But perhaps it is even friendlier to accept
a list of patterns.

-Peff
