From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 03:52:53 -0400
Message-ID: <20160614075252.GA12563@sigill.intra.peff.net>
References: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
 <xmqqbn34buak.fsf@gitster.mtv.corp.google.com>
 <CALnYDJO=_hfcQf+=+XuHQwmH4XewqHo4qggzB0rM79WVt+e6nQ@mail.gmail.com>
 <CALnYDJNS9QAtu37a76Q6N3C=GRbfgU8Xq3g7F1q7vX+b=rwOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith McGuigan <kmcguigan@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 09:53:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCj9j-0003Zu-01
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 09:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbcFNHw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 03:52:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751703AbcFNHwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 03:52:55 -0400
Received: (qmail 12140 invoked by uid 102); 14 Jun 2016 07:52:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 03:52:55 -0400
Received: (qmail 25875 invoked by uid 107); 14 Jun 2016 07:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 03:53:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 03:52:53 -0400
Content-Disposition: inline
In-Reply-To: <CALnYDJNS9QAtu37a76Q6N3C=GRbfgU8Xq3g7F1q7vX+b=rwOOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297270>

On Mon, Jun 13, 2016 at 08:14:43PM -0400, Keith McGuigan wrote:

> Right.  The string_list ends up getting (potentially) populated with a
> mix of dup'd and borrowed values.  I figured it was safer to leak here
> (especially as we're on the way out anyway), than free memory that
> shouldn't be freed.
> 
> Actually, what motivates this (and I apologize that I didn't say this
> earlier) is that we added (in our repo) a bit of stats collection code
> that executes after the string_list_clear(), and calls remote_get()
> which goes all sideways when some of its memory has been freed.

Yeah, I think nobody noticed because we don't have any actual code that
runs after this string_list_clear(), but that doesn't make it not-buggy.

> As an alternative, I could xstrdup each instance where remote->name is
> appended, which would make the string_list a homogenous dup'd list,
> which we could then free.  If you prefer that I'll do a re-roll in
> that style (it just seemed to me at the time like it would be doing
> some useless allocations).  I don't much mind either way.

That sounds much better. Fixing any case like this is really a two-part
thing:

  1. Making the memory ownership policy of the string_list consistent
     (either all allocated, or all not). And if you have _some_ items
     which must be newly allocated (i.e., there is no other place to own
     them), then the only consistent solution is to allocate all of
     them.

  2. Matching the strdup_strings field to that policy.

     The main() function should not have to play tricks with setting
     list->strdup_strings after the fact. It should set it up front,
     and the functions it calls should use string_list_append as
     appropriate.

-Peff
