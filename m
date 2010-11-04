From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Thu, 4 Nov 2010 10:58:17 -0400
Message-ID: <20101104145817.GA27580@sigill.intra.peff.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <7vsjzixty5.fsf@alter.siamese.dyndns.org>
 <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com>
 <201011040149.47968.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 15:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE1G2-0008EP-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 15:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab0KDO5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 10:57:38 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab0KDO5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 10:57:36 -0400
Received: (qmail 31790 invoked by uid 111); 4 Nov 2010 14:57:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 14:57:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 10:58:17 -0400
Content-Disposition: inline
In-Reply-To: <201011040149.47968.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160726>

On Thu, Nov 04, 2010 at 01:49:47AM +0100, Johan Herland wrote:

> I'd probably suggest a more straightforward (and hopefully less confusing) 
> setup like this:
> 
>   Remote repo    ->   Local repo
>   ------------------------------------------------
>   refs/heads/*        refs/remotes/$remote/heads/*
>   refs/tags/*         refs/remotes/$remote/tags/*
>   refs/notes/*        refs/remotes/$remote/notes/*
> 
> ...and these would all be set in the config, i.e. no implicit/magic 
> refspecs.

I have often considered that something like that would be simpler, too.
But just specifying

  fetch = refs/tags/*:refs/remotes/$remote/tags/*

would pull down _all_ tags from the remote. Right now we only pull down
tags for things that we are actually fetching (i.e., auto-follow).

Now you could argue that auto-follow is not worth the effort. It is
somewhat confusing, and I can't think of a time when it ever actually
reduced the set of objects I was fetching (as opposed to just fetching
all tags). But maybe others have use cases where it matters.

> We would, for example, extend the ref disambiguation of <name> (as 
> documented in the "SPECIFYING REVISIONS" section of git-rev-parse(1)), so 
> that in the cases where <name> is of the form "<foo>/<bar>" AND <foo> is an 
> existing remote, we also check for the following refs (after none of the 
> existing checks have returned a match):
> 
>   7. refs/remotes/<foo>/tags/<bar>
>   8. refs/remotes/<foo>/heads/<bar>

This codifies that refs for remote $foo are in refs/remotes/$foo, which
is something we have avoided so far. For example, when finding the
"upstream" branch, we have the name of the remote and the merge branch,
look up the fetch refspecs in the config, and then figure out where that
branch would be fetched to. Which of course turns out as you say (as
remotes/$remote_name/$branch) in the default config, but we don't
restrict people to that.

-Peff
