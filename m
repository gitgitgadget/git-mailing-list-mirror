From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Thu, 15 Jan 2015 17:46:05 -0500
Message-ID: <20150115224605.GD19021@peff.net>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBtB7-0001yR-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbbAOWqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:46:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:35213 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753902AbbAOWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:46:08 -0500
Received: (qmail 6271 invoked by uid 102); 15 Jan 2015 22:46:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 16:46:07 -0600
Received: (qmail 17324 invoked by uid 107); 15 Jan 2015 22:46:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:46:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 17:46:05 -0500
Content-Disposition: inline
In-Reply-To: <1421361371-30221-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262518>

On Thu, Jan 15, 2015 at 02:36:11PM -0800, Stefan Beller wrote:

> So for here is my proposal for small transactions:
> (just one ref [and/or reflog] touched):

The implication being that a "large" transaction is any with more than
one update.

I think performance may suffer if you do not also take into account the
size of the packed-refs file. If you are updating 5 refs and there are
10 in the packed-refs file, rewriting the extra 5 is probably not a big
deal. If there are 400,000 in the packed-refs file, it probably is. I'm
not sure where the cutoff is (certainly the per-ref cost is less for
packed-refs once you have started writing the file, so there is probably
some crossover percentage that you could measure).

> 	* detect if we transition to a large transaction
> 	  (by having more than one entry in transaction->updates)
> 	  if so:
> 		* Pack all currently existing refs into the packed
> 		  refs file, commit the packed refs file and delete
> 		  all loose refs. This will avoid (d/f) conflicts.
> 
> 		* Keep the packed-refs file locked and move the first
> 		  transaction update into the packed-refs.lock file

This increases lock contention, as now independent ref updates all need
to take the same packed-refs.lock. This can be a problem on a busy
repository, especially because we never retry the packed-refs lock.
We already see this problem somewhat on GitHub. Ref deletions need the
packed-refs.lock file, which can conflict with another deletion, or with
running `git pack-refs`.

-Peff
