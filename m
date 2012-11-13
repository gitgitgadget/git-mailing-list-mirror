From: Jeff King <peff@peff.net>
Subject: Re: [msysGit] Re: [PATCH] git tag --contains : avoid stack overflow
Date: Mon, 12 Nov 2012 22:46:05 -0500
Message-ID: <20121113034605.GB8387@sigill.intra.peff.net>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
 <20121112231453.GA21679@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211130114180.13573@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 04:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7SD-0003St-6d
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 04:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab2KMDqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 22:46:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab2KMDqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 22:46:10 -0500
Received: (qmail 18406 invoked by uid 107); 13 Nov 2012 03:46:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 22:46:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 22:46:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1211130114180.13573@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209565>

On Tue, Nov 13, 2012 at 01:16:01AM +0000, Johannes Schindelin wrote:

> > We can do much better than O(number of commits), though, if we stop
> > traversing down a path when its timestamp shows that it is too old to
> > contain the commits we are searching for. The problem is that the
> > timestamps cannot always be trusted, because they are generated on
> > machines with wrong clocks, or by buggy software. This could be solved
> > by calculating and caching a "generation" number, but last time it was
> > discussed there was a lot of arguing and nothing got done.
> 
> Sadly, not only machines with skewed clocks, but in particular buggy
> 3rd-party SCMs make this more than just problematic. In a git-svn clone
> that was used as base for heavy Git development, I encountered quite a lot
> of Jan 1, 1970 commits.

Yeah. We tolerate a certain amount of skew (24 hours for --name-rev, and
5 broken commits in a row for --since). But the big ones are usually
software bugs (the big kernel ones were from broken "guilt", I think) or
broken imports (when I published a bunch of skew statistics last year,
the interesting ones were all imports; I don't know if they were
software bugs, or just garbage in, garbage out).

> It just cannot be helped, we must distrust timestamps completely.

Note that name-rev will produce wrong answers in the face of clock skew.
And I think that you even wrote that code. :)

-Peff
