From: Jeff King <peff@peff.net>
Subject: Re: Tabs in commit messages - de-tabify option in
 strbuf_stripspace()?
Date: Wed, 16 Mar 2016 01:17:49 -0400
Message-ID: <20160316051748.GA3524@sigill.intra.peff.net>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
 <xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
 <CA+55aFw8roOTTuFknzh3zRkCbgaMGmtxMRk-ctBdJ8Wsu041bA@mail.gmail.com>
 <xmqqzitz58si.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyFHmmoHMgRkuBqNUho=tiJ=VwxHWzcGw3pRjr+aGS7ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 06:18:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag3qU-00059T-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 06:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbcCPFR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 01:17:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:60354 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755478AbcCPFRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 01:17:52 -0400
Received: (qmail 7764 invoked by uid 102); 16 Mar 2016 05:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 01:17:51 -0400
Received: (qmail 10936 invoked by uid 107); 16 Mar 2016 05:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 01:18:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 01:17:49 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyFHmmoHMgRkuBqNUho=tiJ=VwxHWzcGw3pRjr+aGS7ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288948>

On Tue, Mar 15, 2016 at 09:57:16PM -0700, Linus Torvalds wrote:

> On Tue, Mar 15, 2016 at 9:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > It also ignores that byte counts of non-HT bytes may not necessarily
> > match display columns.  There is utf8_width() function exported from
> > utf8.c for that purpose.
> 
> Hmm. I did that to now make it horribly slower. Doing the
> per-character widths really does horrible things for performance.
> 
> That said, I think I can make it do the fast thing for lines that have
> no tabs at all, which is the big bulk of it. So it would do the width
> calculations only in the rare "yes, I found a tab" case.
> 
> I already wrote it in a way that non-tab lines end up just looping
> over the line looking for a tab and then fall back to the old code.
> 
> I might just have to make that behavior a bit more explicit. Let me
> stare at it a bit, but it won't happen until tomorrow, I think.

I wondered about performance when reading yours, and measured a straight
"git log >/dev/null" on the kernel at about 3% slower (best-of-five and
average). We can get most of that back by sticking a

    memchr(line, '\t', linelen);

in front and skipping the loop if it returns NULL. You can also
implement your loop in terms of memchr() calls to skip to the next tab,
but I don't know if it's worth it. It's really only worth spending time
optimizing the non-tab case (and even then, only worth it for trivial
things like "use the already optimized-as-hell memchr").

-Peff
