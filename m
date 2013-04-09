From: Jeff King <peff@peff.net>
Subject: Re: commit-message attack for extracting sensitive data from
 rewritten Git history
Date: Tue, 9 Apr 2013 13:01:59 -0400
Message-ID: <20130409170159.GC21972@sigill.intra.peff.net>
References: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com>
 <7vehelyqrv.fsf@alter.siamese.dyndns.org>
 <20130408215457.GB11227@sigill.intra.peff.net>
 <5163AF2C.2020107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbvv-0001DQ-63
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763192Ab3DIRCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:02:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36416 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760264Ab3DIRCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:02:05 -0400
Received: (qmail 23836 invoked by uid 107); 9 Apr 2013 17:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 13:03:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 13:01:59 -0400
Content-Disposition: inline
In-Reply-To: <5163AF2C.2020107@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220586>

On Tue, Apr 09, 2013 at 08:03:24AM +0200, Johannes Sixt wrote:

> Am 4/8/2013 23:54, schrieb Jeff King:
> > Yeah, it would make sense for filter-branch to have a "--map-commit-ids"
> > option or similar that does the update. At first I thought it might take
> > two passes, but I don't think it is necessary, as long as we traverse
> > the commits topologically (i.e., you cannot have mentioned X in a commit
> > that is an ancestor of X, so you do not have to worry about mapping it
> > until after it has been processed).
> 
> Topological traversal is not sufficient. Consider this history:
> 
>      o--A--o--
>     /     /
>  --o--B--o
> 
> If A mentions B (think of cherry-pick -x), then you must ensure that the
> branch containing B was traversed first.

Yeah, you're right. Multiple passes are necessary to get it
completely right. And because each pass may change more commit id's, you
have to recurse to pick up those changes, and keep going until you have
a pass with no changes.

But I haven't thought that hard about it. There might be a clever
optimization where you can prune out parts of the history (e.g., if you
know that all changes to consider are in descendants of a commit, you do
not have to care about rewriting the commit or its ancestors).

-Peff
