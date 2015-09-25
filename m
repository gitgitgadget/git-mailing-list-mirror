From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] gc: remove broken refs
Date: Thu, 24 Sep 2015 21:35:37 -0400
Message-ID: <20150925013537.GA7522@sigill.intra.peff.net>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
 <8855bae256311446dffd221ab33c1163eb104c4a.1443085919.git.johannes.schindelin@gmx.de>
 <20150924175758.GB15117@sigill.intra.peff.net>
 <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 03:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfHvZ-0002LV-0W
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 03:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbIYBfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 21:35:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:36253 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752954AbbIYBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 21:35:40 -0400
Received: (qmail 28542 invoked by uid 102); 25 Sep 2015 01:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 20:35:40 -0500
Received: (qmail 417 invoked by uid 107); 25 Sep 2015 01:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 21:35:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 21:35:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278645>

On Thu, Sep 24, 2015 at 05:08:41PM -0700, Junio C Hamano wrote:

> One thing I wondered was if we can reliably tell between a ref that
> wanted to be a real ref that records a broken object name and a ref
> that wanted to be a symbolic ref that points a bogus thing, and if
> we can't, should we worry about it too much.  The former is more
> serious, as the history behind the commit it wanted to but failed to
> record is at risk of being pruned.
> 
> One case that is clearly safe is "ref: refs/heads/gone"; it is not
> likely to be the result of attempting to write a real object name
> gone bad by whatever filesystem corruption.  On the other hand, an
> obviously problematic case is an empty file.  We cannot tell if the
> "broken" ref used to anchor the tip of a real history (which is
> about to be lost with Dscho's patch 1/4) or was merely pointing at
> another ref (which will not harm the object database if ignored).
> 
> So the rule should be
> 
>     If resolve_ref_unsafe_1() says it is a symbolic ref, if
>     check_ref_format() is OK with the ref it points at, and if that
>     pointee is missing, then it is safe to skip.
> 
> All other funnies should trigger the safety.

Right, I agree with that rule. If we don't know what it is, we should
err on the conservative side (and that _shouldn't_ happen, because does
not generate files in .git/refs that it cannot itself understand). But
"ref: " is clearly something we understand.

-Peff
