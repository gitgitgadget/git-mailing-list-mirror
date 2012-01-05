From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: try internal cache before reading object db
Date: Thu, 5 Jan 2012 16:49:41 -0500
Message-ID: <20120105214941.GA31836@sigill.intra.peff.net>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 22:49:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RivC1-0002fc-Ki
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab2AEVtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 16:49:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58447
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab2AEVto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 16:49:44 -0500
Received: (qmail 30730 invoked by uid 107); 5 Jan 2012 21:56:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jan 2012 16:56:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2012 16:49:41 -0500
Content-Disposition: inline
In-Reply-To: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187997>

On Thu, Jan 05, 2012 at 01:35:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This might seem circular, since step 2a uses the type
> > information determined in step 1 to call the appropriate
> > lookup function. However, we can notice that all of the
> > lookup_* functions are backed by lookup_object. In other
> > words, all of the objects are kept in a master hash table,
> > and we don't actually need the type to do the "do we have
> > it" part of the lookup,...
> 
> The only case that might matter is where you read one object, you have
> written another object of a different type but that happens to hash to the
> same SHA-1 value. The other existing optimizations do not take that into
> account, so I do not think there is any new issue here.

Yeah, I tried to think of issues like that. Even if you protected
against that, you'd still have the issue of reading one object, then
writing another of the _same_ type but with different content. We
wouldn't notice with the current code path (we'd just recreationally
read the data from disk and then throw it away).

The worst potential problem I could come up with is if you somehow had
an object whose "parsed" flag was set, but somehow didn't have its other
fields set (like type). But I think you'd have to be abusing the lookup
functions pretty hard to get into such a state (how would you be parsing
if you didn't know the type?). The parsed flag only gets set by the
type-specific lookup functions.

So I think it is safe short of somebody doing some horrible manual
munging of a "struct object".

> > For example, GitHub's alternates repository for git.git has
> > ~120,000 refs, of which only ~3200 are unique. The time for
> > upload-pack to print its list of advertised refs dropped
> > from 3.4s to 0.76s.
> 
> Nice. I am more impressed by 120k/3.4 than 3.2k/0.76, though ;-)

You can thank optimized zlib for that. We spent 60% of our time there.
:)

-Peff
