From: Jeff King <peff@peff.net>
Subject: [PATCH v4 0/3] fix corner cases with lock_ref_sha1_basic
Date: Tue, 12 Jan 2016 16:43:18 -0500
Message-ID: <20160112214318.GA2527@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
 <20160112095804.GB16501@sigill.intra.peff.net>
 <20160112132628.GA31854@sigill.intra.peff.net>
 <20160112135522.GA23255@sigill.intra.peff.net>
 <xmqqlh7utwki.fsf@gitster.mtv.corp.google.com>
 <20160112202251.GA10843@sigill.intra.peff.net>
 <20160112204229.GA13706@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:44:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ6j5-0004qo-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 22:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbcALVnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 16:43:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:52559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753764AbcALVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 16:43:20 -0500
Received: (qmail 19546 invoked by uid 102); 12 Jan 2016 21:43:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:43:20 -0500
Received: (qmail 18777 invoked by uid 107); 12 Jan 2016 21:43:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:43:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 16:43:18 -0500
Content-Disposition: inline
In-Reply-To: <20160112204229.GA13706@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283845>

On Tue, Jan 12, 2016 at 03:42:29PM -0500, Jeff King wrote:

> Ah, I see. When calling git-symbolic-ref, we don't provide an old_sha1,
> and therefore never call verify_lock(). And we get whatever value in
> lock->old_oid we happened to read earlier in resolve_ref_unsafe(). Which
> happened outside of a lock. Yikes. It seems like we could racily write
> the wrong reflog entry in such a case.
>
> [...]
> The patch above is not quite right; I'll work up a series that takes
> this approach.

OK, here it is. This replaces the top two patches of jk/symbolic-ref
(i.e., everything in this thread I've sent in the last day or two).

Besides fixing the race (which is detailed in patch 2/3), I think the
resulting 3/3 is much cleaner. Sorry for all the false starts. The more
I looked at this, the more complex it seemed to get. But I _think_ this
is the right solution. :)

  [1/3]: checkout,clone: check return value of create_symref
  [2/3]: lock_ref_sha1_basic: always fill old_oid while holding lock
  [3/3]: lock_ref_sha1_basic: handle REF_NODEREF with invalid refs

-Peff
