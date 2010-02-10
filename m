From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Wed, 10 Feb 2010 00:49:57 -0500
Message-ID: <20100210054957.GG28526@coredump.intra.peff.net>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7vmxzj8hca.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:51:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf5Tf-000436-7s
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab0BJFt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:49:56 -0500
Received: from peff.net ([208.65.91.99]:44147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab0BJFt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:49:56 -0500
Received: (qmail 31347 invoked by uid 107); 10 Feb 2010 05:50:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:50:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:49:57 -0500
Content-Disposition: inline
In-Reply-To: <7vmxzj8hca.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139491>

On Mon, Feb 08, 2010 at 02:59:01PM -0800, Junio C Hamano wrote:

> >> +	if (flags & TRANSPORT_PUSH_PORCELAIN) {
> >> +		/* Do not give advice messages to Porcelain scripts */
> >> +		advice_push_nonfastforward = 0;
> >> +	}
> >
> > I think this is sane.
> 
> I am tempted to suggest adding "clear_advice(void)" in advice.[ch], so
> that people adding new advices do not have to hunt for even the above
> hunk.  It would be a good direction to go in general _if_ we will have
> more like this --porcelain thing in other parts of the system.
> 
> I didn't do so because that "_if_" is still iffy.

Would it make sense to clear _all_ advice if we are just in porcelain
mode for git-push? That is, let's say I am in "push --porcelain" and I
try to write a reflog entry for a local tracking ref, but my identity is
implicitly picked up from the hostname[1]. Should it trigger
advice_implicit_identity and say "by the way, your identity is implicit"
on stderr or not?

I would say yes. The advice output should all be on stderr, and the
porcelain output should all be on stdout. So there is no parsing
conflict. And stderr either goes to /dev/null (because the porcelain is
not terminal-based, or doesn't want the terminal screwed up), in which
case the advice does nothing, or stderr goes to the terminal (because
the porcelain is some simple script), in which case the message is
probably something the user would want to see.

-Peff

[1] I am actually not sure if you can trigger the implicit identity
advice in this way. But I am arguing from the perspective of "assume you
have triggered some random advice through some sub-action", which may
include advice to be added in the future.
