From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] attr.c::path_matches(): special case paths that end
 with a slash
Date: Tue, 26 Mar 2013 15:05:58 -0400
Message-ID: <20130326190558.GC26462@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZCd-0005Ni-0c
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759957Ab3CZTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:06:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40540 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab3CZTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:06:03 -0400
Received: (qmail 6366 invoked by uid 107); 26 Mar 2013 19:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 15:07:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 15:05:58 -0400
Content-Disposition: inline
In-Reply-To: <1364323171-20299-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219184>

On Tue, Mar 26, 2013 at 11:39:30AM -0700, Junio C Hamano wrote:

> A similar adjustment for match_pathname() might be needed, but I
> didn't look into it.

I notice that match_pathname takes _two_ lengths for the pattern: the
nowildcardlen (called "prefix", and the full patternlen). But the first
thing it does is:

  if (*pattern == '/') {
          pattern++;
          prefix--;
  }

which seems obviously wrong, as patternlen should be dropped, too. But
we do not seem to look at patternlen at all! I think we can drop the
parameter totally.

We do seem to use strncmp_icase through the rest of the function,
though, which should be OK. The one exception is that we call fnmatch at
the end. Should the allocation hack from the previous patch make its way
into an "fnmatch_icase_bytes()" function, so we can use it here, too?
And then when we have a more efficient solution, we can just plug it in
there.

-Peff
