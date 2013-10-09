From: Jeff King <peff@peff.net>
Subject: Re: Bisect needing to be at repo top-level?
Date: Wed, 9 Oct 2013 14:55:00 -0400
Message-ID: <20131009185459.GA2823@sigill.intra.peff.net>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
 <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
 <20130917175813.GA14173@blizzard>
 <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
 <5255A02E.3050405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <git@cryptocrack.de>,
	"Burton, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 20:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTyuf-0006C4-BN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab3JISzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 14:55:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46430 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755109Ab3JISzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 14:55:05 -0400
Received: (qmail 3347 invoked by uid 102); 9 Oct 2013 18:55:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 13:55:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 14:55:00 -0400
Content-Disposition: inline
In-Reply-To: <5255A02E.3050405@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235833>

On Wed, Oct 09, 2013 at 08:27:58PM +0200, Stefan Beller wrote:

> > At least on Linux, if you checkout a revision with "foo/" directory,
> > chdir to it and then checkout a revision with "foo" file to nuke
> > your current place, I know "git checkout" will happily do so and you
> > will still be in a directory that is connected nowhere.  Your ".."
> > is probably pointing at the top-level, but there is no reverse, so
> > "cd ../foo" may or may not work from that state, and it would lead
> > to an interesting confusion.
> > 
> > We may want to check the condition and forbid such a checkout.
> 
> I think forbidding such a checkout is a bit hard:
> 	$ git checkout <branch>
> 	fatal: checkout not possible, because of said reason (dangling pwd)
> 	$ cd ../.. # go to top level or somewhere else unaffected
> 	$ git checkout <branch> # this will work
> 
> Wouldn't it be better to navigate to the 'nearest' possible working dir on checkout?
> Such a workflow would emerge:
> 	$ git checkout <branch> # this includes the "cd .." of the previous step, it just went the dir structure up, until a valid dir was found.
> 	warning: the current working directory is not part of the tree, navigating to $(PWD)

The problem is that the program calling "git checkout" (e.g., the shell)
is in the directory that is going away, and git cannot impact the
working directory of its parent. So there is no way to "fix" it here.
Our only options are to proceed and hope the user can figure it out, or
to warn/forbid.

-Peff
