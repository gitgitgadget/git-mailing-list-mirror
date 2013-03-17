From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sun, 17 Mar 2013 04:47:51 -0400
Message-ID: <20130317084750.GA934@sigill.intra.peff.net>
References: <20130316102428.GA29358@sigill.intra.peff.net>
 <7v7gl6txl3.fsf@alter.siamese.dyndns.org>
 <20130317054039.GA16070@sigill.intra.peff.net>
 <7vk3p6sg7l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 09:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9GT-0005nu-FR
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab3CQIr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:47:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756099Ab3CQIr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:47:57 -0400
Received: (qmail 7994 invoked by uid 107); 17 Mar 2013 08:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:49:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:47:51 -0400
Content-Disposition: inline
In-Reply-To: <7vk3p6sg7l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218353>

On Sat, Mar 16, 2013 at 11:17:18PM -0700, Junio C Hamano wrote:

> > I almost wonder if we should cut it out entirely. It is definitely a
> > possible race condition, but I wonder if anybody actually hits it in
> > practice (and if they do, the consequence is that the fetch fails and
> > needs to be retried). As far as I can tell, the code path has never
> > actually been followed, and I do not recall ever seeing a bug report or
> > complaint about it (though perhaps it happened once, which spurred the
> > initial development?).
> 
> If you run multiple servers serving the same repository at the same
> URL with a small mirroring lag, one may observe a set of refs from
> one server, that are a tad older than the other server you actually
> fetch from.  k.org may have such an arrangement, but does GitHub
> serve the same repository on multiple machines without tying the
> same client to the same backend?

Each repository is a on a single backend host. They're redundant
internally (each host is actually multiple hosts), but pure-git requests
go to a single master for each host (though for some read-only
operations I think we spread the load across the redundant spares). You
might get a separate machine during a failover event, but they share
block devices via DRBD, so in theory an fsync() should hit both
machines, and there is no lag (and you are likely to get an intermittent
failure in such a case, anyway, since the machine serving your git
request probably died mid-packet).

I thought this change was to prevent against the common race:

  1. Client request stateless ref advertisement.

  2. Somebody updates ref.

  3. Client requests "want" objects based on old advertisement.

and I think it does solve that (assuming step 2 is not a rewind). The
important thing is that time always moves forward.

But if you are talking about mirror lag, time can move in either
direction. Imagine you have two machines, A and B, and A is missing an
update to B. If you hit A first, then B, it is the same as the update
sequence above. The patch helps. But if you hit B first, then A, you
will ask it for objects it has not yet received, and we must fail.

So I think any such mirroring setup would want to try very hard to make
sure you hit the same machine both times anyway, regardless of this
patch.

I'm fine to leave it. I was just questioning its utility since AFAICT,
it has never worked and nobody has cared. It's not too much code,
though, and it is only run when we hit the race, so I don't think it is
hurting anything.

-Peff
