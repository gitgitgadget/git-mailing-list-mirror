From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] fix repo name when cloning a server's root
Date: Wed, 5 Aug 2015 17:19:47 -0400
Message-ID: <20150805211947.GC21134@sigill.intra.peff.net>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
 <xmqq4mkd4p1x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:20:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN66W-0006Ck-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbHEVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:19:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:41295 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750968AbbHEVTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:19:52 -0400
Received: (qmail 19267 invoked by uid 102); 5 Aug 2015 21:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 16:19:51 -0500
Received: (qmail 32229 invoked by uid 107); 5 Aug 2015 21:20:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 17:20:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 17:19:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mkd4p1x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275399>

On Wed, Aug 05, 2015 at 10:34:34AM -0700, Junio C Hamano wrote:

> > As you can see, there is a lot of complexity in there and I'm not
> > convinced this is better than just exposing
> > 'parse_connect_url()', which already handles everything for us.
> 
> If the function "handles everything for us", that's fine, but the
> primary reason I am hesitant is because parse_connect_url() was
> designed specifically not to have to worry about some protocols
> (e.g. I think feeding it a "http://" would fail, and more
> importantly, its current callers want such a call to fail).  Also it
> is meant to handle some non-protocols (e.g. scp style host:path that
> does not follow <scheme>://...).

True, but the transport code _is_ handling that at some point. It makes
me wonder if it would be possible to push the call to transport_get
further up inside cmd_clone(), and then provide some way to query the
remote path and hostname from the transport code. Then guess_dir_name
could just go away entirely, in favor of something like:

  dir_name = transport_get_path(transport);
  if (!*dir_name)
	dir_name = transport_get_host(transport);

That may be overly simplistic or unworkable, though. I haven't dug into
the code.

> Also does it handle the "2222" case above?  I do not think
> parse_connect_url() even calls get_host_and_port() to be able to
> tell what "2222" means in these examples.

Speaking of which, has anyone tested whether the old or new code handles
external remote helpers? Certainly:

  foo::https://host/repo.git

should still use repo.git. But technically the string handed to
git-remote-foo does not have to look anything like a URL. In those cases
neither guess_dir_name nor the transport code have any idea what anything
to the right of the "::" means; we probably have to resort to blind
guessing based on characters like colon and slash.

-Peff
