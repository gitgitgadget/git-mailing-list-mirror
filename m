From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/18] hardening allocations against integer overflow
Date: Mon, 15 Feb 2016 17:02:13 -0500
Message-ID: <20160215220212.GA10461@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 23:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRDn-0000q2-9e
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcBOWCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:02:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:42531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOWCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:02:15 -0500
Received: (qmail 3006 invoked by uid 102); 15 Feb 2016 22:02:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 17:02:15 -0500
Received: (qmail 12752 invoked by uid 107); 15 Feb 2016 22:02:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 17:02:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 17:02:13 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286276>

On Mon, Feb 15, 2016 at 04:45:16PM -0500, Jeff King wrote:

> The only bug I have actually confirmed in practice here is fixed by
> patch 2 (which is why it's at the front). There's another one in
> path_name(), but that function is already dropped by the nearby
> jk/lose-name-path topic.
> 
> The rest are cleanups of spots which _might_ be buggy, but I didn't dig
> too far to find out. As with the earlier audit, I tried to refactor
> using helpers that make the code clearer and less error-prone. So maybe
> they're fixing bugs or not, but they certainly make it easier to audit
> the result for problems.

After this, looking for /[cm]alloc.*\+/ is pretty clean. I _didn't_ fix
any sites in xdiff, but those are already protected by dcd1742 (xdiff:
reject files larger than ~1GB, 2015-09-24).

That's not necessarily complete coverage, though, as you can always
screw up the computation outside of the xmalloc call, and pass in the
truncated version. E.g.:

  int alloc = a + b;
  char *foo = xmalloc(alloc);

However, this is only a big problem if you then copy "a" and "b"
separately. If you use "alloc" later as the limit, like:

  xsnprintf(foo, alloc, "%s%s", a, b);

that's only a minor bug (we notice the overflow and complain, rather
than smashing the heap).

-Peff
