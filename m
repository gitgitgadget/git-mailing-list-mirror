From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter
 instead of mmap
Date: Tue, 26 Aug 2014 13:54:28 -0400
Message-ID: <20140826175428.GA17546@peff.net>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
 <1408896466-23149-5-git-send-email-prohaska@zib.de>
 <20140825124323.GB17288@peff.net>
 <E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:54:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKx1-0008QY-5T
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbaHZRyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:54:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59412 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752540AbaHZRya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:54:30 -0400
Received: (qmail 3515 invoked by uid 102); 26 Aug 2014 17:54:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 12:54:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 13:54:28 -0400
Content-Disposition: inline
In-Reply-To: <E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255930>

On Mon, Aug 25, 2014 at 06:55:51PM +0200, Steffen Prohaska wrote:

> It could be handled that way, but we would be back to the original problem
> that 32-bit git fails for large files.  The convert code path currently
> assumes that all data is available in a single buffer at some point to apply
> crlf and ident filters.
> 
> If the initial filter, which is assumed to reduce the file size, fails, we
> could seek to 0 and read the entire file.  But git would then fail for large
> files with out-of-memory.  We would not gain anything for the use case that
> I describe in the commit message's first paragraph.

Ah. So the real problem is that we cannot handle _other_ conversions for
large files, and we must try to intercept the data before it gets to
them. So this is really just helping "reduction" filters. Even if our
streaming filter succeeds, it does not help the situation if it did not
reduce the large file to a smaller one.

It would be nice in the long run to let the other filters stream, too,
but that is not a problem we need to solve immediately. Your patch is a
strict improvement.

Thanks for the explanation; your approach makes a lot more sense to me
now.

-Peff
