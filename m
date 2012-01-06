From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: try internal cache before reading object db
Date: Fri, 6 Jan 2012 14:16:54 -0500
Message-ID: <20120106191654.GA11022@sigill.intra.peff.net>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 20:17:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFHi-00005C-7j
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883Ab2AFTQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:16:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59560
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265Ab2AFTQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:16:56 -0500
Received: (qmail 8312 invoked by uid 107); 6 Jan 2012 19:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 14:23:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 14:16:54 -0500
Content-Disposition: inline
In-Reply-To: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188040>

On Thu, Jan 05, 2012 at 01:35:50PM -0800, Junio C Hamano wrote:

> > For example, GitHub's alternates repository for git.git has
> > ~120,000 refs, of which only ~3200 are unique. The time for
> > upload-pack to print its list of advertised refs dropped
> > from 3.4s to 0.76s.
> 
> Nice. I am more impressed by 120k/3.4 than 3.2k/0.76, though ;-)

Actually, we can do much better than that. Here are a few patches that
avoid parsing objects when possible. They drop the 3.4s to 2.0s. If you
combine them with the parse_object optimization, my 120K case drops to
around 0.68s.

I don't know if it is really that worth it on top of the parse_object
optimization. It's almost negligible for the normal case (though I get a
tiny speedup on my ~900-ref git.git repo), and a minor speedup on the
crazy alternates case. OTOH, if you had some totally insane ref
structure, like 120K _unique_ refs (which would probably imply that
you're making one ref per commit or something silly like that. But hey,
people have suggested it in the past), then it could be a big
improvement.

  [1/2]: upload-pack: avoid parsing objects during ref advertisement
  [2/2]: upload-pack: avoid parsing tag destinations

-Peff
