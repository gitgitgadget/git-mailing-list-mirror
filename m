From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 17:34:51 -0500
Message-ID: <20110216223450.GA5617@sigill.intra.peff.net>
References: <20110216032047.GA2858@elie>
 <7v1v37kb3p.fsf@alter.siamese.dyndns.org>
 <20110216195931.GA22884@sigill.intra.peff.net>
 <201102162203.40480.jnareb@gmail.com>
 <7v39nnirfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:35:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pppxu-0004t8-7s
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab1BPWe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 17:34:57 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33164 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab1BPWey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 17:34:54 -0500
Received: (qmail 15659 invoked by uid 111); 16 Feb 2011 22:34:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 22:34:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 17:34:51 -0500
Content-Disposition: inline
In-Reply-To: <7v39nnirfq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167014>

On Wed, Feb 16, 2011 at 01:46:01PM -0800, Junio C Hamano wrote:

> > Also it would be not as easy as reflogs - you would have either to save
> > copy of index, or create a tree out of it and save reference in reflog.
> 
> Also note that "Create a tree out of it" is not always a useful way to
> save the state of the index.  The "stash" shares the same issue, but you
> would need an equivalent of a tarball that consists of the index file
> (with conflicted state) and the files in the working tree that corresponds
> to index entries with conflicted states if you want to be useful for
> storing a state away in case you botch the conflict resolution you are
> attempting.

I had assumed it would be a reflog of trees (or more likely parentless
commits), just keeping track of useful states. But the usage there isn't
very intuitive. You can do "git show index@{5.minutes.ago}:foo.c >bar.c"
to recover the state of a file, or even "git read-tree index@{1}" to
get a whole state. And those would be enough for the basic "oops, I just
want to go back to where I was".

But probably you should be able to do a three-way merge with where you
are now, with the HEAD at the time of save as a pseudo-parent. IOW,
treat the index state as if you had committed it and put it on a reflog.
And in the case that you are at the same HEAD, then a merge collapses
into a "fast-forward" to the index state you were at (I put
"fast-forward" in quotes because we are obviously not interested in
moving HEAD to the pseudo-commit at all, but just what ends up in the
index).

I dunno. I haven't thought all that hard about it, so maybe there is a
more clever way of doing it. Certainly the porcelain support for "reset
to this index, but don't move my HEAD" is not good, nor for "merge this
index, but nevermind about recording anything about the commit".  They
are both conceptually easy to implement in terms of plumbing, but the
commands to run them are a little unintuitive.

-Peff
