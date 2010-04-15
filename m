From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 12:36:07 -0400
Message-ID: <20100415163607.GA4279@coredump.intra.peff.net>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org>
 <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org>
 <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org>
 <4BC70D75.70801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 18:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2S3Z-0006RQ-7K
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 18:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0DOQgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 12:36:38 -0400
Received: from peff.net ([208.65.91.99]:42113 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801Ab0DOQgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 12:36:37 -0400
Received: (qmail 20589 invoked by uid 107); 15 Apr 2010 16:36:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Apr 2010 12:36:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Apr 2010 12:36:07 -0400
Content-Disposition: inline
In-Reply-To: <4BC70D75.70801@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144998>

On Thu, Apr 15, 2010 at 02:58:29PM +0200, Johannes Sixt wrote:

> Am 4/15/2010 14:30, schrieb Junio C Hamano:
> > A reflog consists of entries, each of which records how you got to the
> > current history by pointing to different commit objects.  Some entries
> > matter more than others do.  Dead-end experiments stop mattering faster
> > than others.  It is these _entries_ that we expire, because keeping them
> > indefinitely is a wasteful clutter.
> 
> I have no problem with this point of view, i.e., that expiration is merely
> about the entries, and that garbage-collecting objects is just a
> side-effect of removed entries.
> 
> But I don't see yet, why an entry pointing to a dead-end experiment is
> less important when it is an entry in a branch reflog than when it is an
> entry in the HEAD reflog. Care to explain?

I think it is because the reachability test is defined as "from the
current ref". So if I am doing a reachability test on next@{20}, I will
check whether it is in the current version of next. Unreachable things
are therefore dead-end experiments. But on HEAD, if I do:

  $ git checkout topic1
  $ git checkout topic2

Then the entry for HEAD@{1} will be unreachable from the current HEAD,
even though it is _not_ a failed experiment. It is just that we are no
longer pointing to that branch.

I think another way of addressing the same problem would be to redefine
"reachable" in this context as "reachable from any current ref".

-Peff
