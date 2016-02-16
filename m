From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 23:22:22 -0500
Message-ID: <20160216042222.GA27060@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215244.GG10287@sigill.intra.peff.net>
 <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
 <20160216031554.GB13606@sigill.intra.peff.net>
 <20160216032626.GA19954@sigill.intra.peff.net>
 <20160216033620.GA26430@sigill.intra.peff.net>
 <CAPig+cQOF7CsJNoiu8FAMk+csrOWG2dbEyxqfpWNwvGdUsjxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVX9h-0000hi-0X
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbcBPEWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:22:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:42769 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752002AbcBPEWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:22:24 -0500
Received: (qmail 21279 invoked by uid 102); 16 Feb 2016 04:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 23:22:25 -0500
Received: (qmail 16307 invoked by uid 107); 16 Feb 2016 04:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 23:22:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 23:22:22 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQOF7CsJNoiu8FAMk+csrOWG2dbEyxqfpWNwvGdUsjxcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286317>

On Mon, Feb 15, 2016 at 11:18:56PM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/reflog.c b/builtin/reflog.c
> > @@ -408,13 +407,12 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
> >                 reflog_expire_cfg_tail = &reflog_expire_cfg;
> >
> >         for (ent = reflog_expire_cfg; ent; ent = ent->next)
> > -               if (ent->len == len &&
> > -                   !memcmp(ent->pattern, pattern, len))
> > +               if (!strncmp(ent->pattern, pattern, len) &&
> > +                   ent->pattern[len] == '\0')
> 
> If 'ent->pattern' is shorter than 'pattern' then the strncmp() will
> fail, thus it will short-circuit before ent->pattern[len] has a chance
> to access beyond the end of memory allocated for 'ent->pattern'. Okay,
> makes sense.

Yeah. It took me a minute to convince myself that this was correct. If
you have a shorter or more clear way of writing it, I'm open to it. The
best I could come up with is running an extra "strlen" and otherwise
keeping the loop as it is; the performance on that is not as good, but
if performance is a concern, maybe something besides a linear search
would be in order. :)

-Peff
