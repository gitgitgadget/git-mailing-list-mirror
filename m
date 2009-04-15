From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Wed, 15 Apr 2009 04:03:02 -0400
Message-ID: <20090415080301.GD23332@coredump.intra.peff.net>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net> <20090410171458.GA26478@sigill.intra.peff.net> <49E487B2.5030606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 10:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu073-0000Rn-9m
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 10:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbZDOIDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 04:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbZDOIDK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 04:03:10 -0400
Received: from peff.net ([208.65.91.99]:48947 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbZDOIDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 04:03:07 -0400
Received: (qmail 14737 invoked by uid 107); 15 Apr 2009 08:03:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 04:03:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 04:03:02 -0400
Content-Disposition: inline
In-Reply-To: <49E487B2.5030606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116596>

On Tue, Apr 14, 2009 at 02:55:14PM +0200, Michael J Gruber wrote:

> >   const char *shorten_ref(const char *);
> >   const char *shorten_ref_unambiguous(const char *);
> > 
> > ? The implementations are quite different, with prettify_ref not really
> > respecting the ref lookup rules, but rather just considering a few
> > pre-determined bits of the hierarchy as uninteresting. It shouldn't be
> > that hard to have them both use the same implementation, like:
> > 
> >   const char *shorten_ref(const char *, int unambiguous);
> 
> Should I rebase this on top of Bert's newer patch (which has the
> signature you suggest)? Currently I don't see any of them in.

It has the same signature, but the meanings are different. My flag meant
"should we bother looking at ambiguity at all?" whereas Bert's flag is
about "how strictly should we be counting ambiguity?".

So really there are three levels, which implies an enum (with none,
loose, and strict). However, calling it with a tri-state flag would be
less convenient, since your logic for the flag is:

  if (we are shortening something non-local)
    flag = none;
  else if (core.warn_ambiguous_refs is not set)
    flag = loose;
  else
    flag = strict;

So you really want to pass the two bits of information separately.

-Peff
