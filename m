From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sun, 18 Nov 2007 00:00:34 -0500
Message-ID: <20071118050033.GA13097@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125602.GC23186@sigill.intra.peff.net> <7vir40z7nm.fsf@gitster.siamese.dyndns.org> <20071118023942.GA4560@sigill.intra.peff.net> <7vwssgxir4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 06:01:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItcHD-0006id-2n
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 06:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbXKRFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 00:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbXKRFAl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 00:00:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3968 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXKRFAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 00:00:40 -0500
Received: (qmail 7964 invoked by uid 111); 18 Nov 2007 05:00:37 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 00:00:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 00:00:34 -0500
Content-Disposition: inline
In-Reply-To: <7vwssgxir4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65339>

On Sat, Nov 17, 2007 at 08:47:11PM -0800, Junio C Hamano wrote:

>>> +     for (ref = refs; ref; ref = ref->next) {
>>> +             const char *msg;
>>> +             if (prefixcmp(line, ref->name))
>>> +                     continue;
>>> +             msg = line + strlen(ref->name);
>>> +             if (*msg++ != ' ')
>>> +                     continue;
>>> +             ref->status = REF_STATUS_REMOTE_REJECT;
>>> +             ref->error = xstrdup(msg);
>>> +             ref->error[strlen(ref->error)-1] = '\0';
>>> +             return ref;
>>> +     }
>>> +     return NULL;
>>> +}
> > It is actually _just_ prefixcmp. Or do you mean the strlen we call in
> > prefixcmp? If so, I think the right solution is to make prefixcmp
> > faster.  :)
> I was referring to strlen(ref->name) taken for all refs during
> the loop.  Micro-optimized one finds the end of refname on the
> "ng" line once before entering the loop.

I don't see such a strlen, except in the implementation of prefixcmp,
because we continue most of the time based on its result. If you have a
false match on the prefixcmp (i.e., a prefix of another ref), you do an
extra strlen.

But I don't think this is worth micro-optimizing.

-Peff
