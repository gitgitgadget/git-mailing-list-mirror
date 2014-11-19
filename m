From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Tue, 18 Nov 2014 21:04:52 -0500
Message-ID: <20141119020451.GA2734@peff.net>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
 <20141119020009.GR6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:05:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqude-0000zX-Vs
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaKSCEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:04:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:42111 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753801AbaKSCEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:04:54 -0500
Received: (qmail 11240 invoked by uid 102); 19 Nov 2014 02:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:04:54 -0600
Received: (qmail 26028 invoked by uid 107); 19 Nov 2014 02:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 21:05:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 21:04:52 -0500
Content-Disposition: inline
In-Reply-To: <20141119020009.GR6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 06:00:09PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > For most errors, we jump to a goto label that unlocks the
> > ref and returns NULL. However, in none of these error paths
> > would we ever have actually locked the ref. By the time we
> > actually take the lock, we follow a different path that does
> > not ever hit this goto (we rely on verify_lock to unlock if
> > it finds an error).
> [...]
> >  refs.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> Wouldn't this leak lock (in all cases) and lock->ref_name and
> lock->orig_ref_name (on safe_create_leading_directories failure)?

Ah, you're right. I totally missed that unlock_ref is not just about
unlocking, but about free()ing. We do need to keep the goto/unlock.

Hmph. Should we just abandon my series in favor of taking Ronnie's
original patch, then? We can apply the "save/restore errno in error()"
patch independently if we like.

-Peff
