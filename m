From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter
 instead of mmap
Date: Tue, 26 Aug 2014 14:00:18 -0400
Message-ID: <20140826180018.GB17546@peff.net>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
 <1408896466-23149-5-git-send-email-prohaska@zib.de>
 <20140825124323.GB17288@peff.net>
 <E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
 <xmqq4mx0mn7i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:00:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XML2p-0002is-0X
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 20:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbaHZSAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 14:00:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59420 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753252AbaHZSAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 14:00:20 -0400
Received: (qmail 3797 invoked by uid 102); 26 Aug 2014 18:00:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 13:00:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 14:00:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mx0mn7i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255931>

On Mon, Aug 25, 2014 at 11:35:45AM -0700, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> >> Couldn't we do that with an lseek (or even an mmap with offset 0)? That
> >> obviously would not work for non-file inputs, but I think we address
> >> that already in index_fd: we push non-seekable things off to index_pipe,
> >> where we spool them to memory.
> >
> > It could be handled that way, but we would be back to the original problem
> > that 32-bit git fails for large files.
> 
> Correct, and you are making an incremental improvement so that such
> a large blob can be handled _when_ the filters can successfully
> munge it back and forth.  If we fail due to out of memory when the
> filters cannot, that would be the same as without your improvement,
> so you are still making progress.

I do not think my proposal makes anything worse than Steffen's patch.
_If_ you have a non-required filter, and _if_ we can run it, then we
stream the filter and hopefully end up with a small enough result to fit
into memory. If we cannot run the filter, we are screwed anyway (we
follow the regular code path and dump the whole thing into memory; i.e.,
the same as without this patch series).

I think the main argument against going further is just that it is not
worth the complexity. Tell people doing reduction filters they need to
use "required", and that accomplishes the same thing.

> >> So it seems like the ideal strategy would be:
> >> 
> >>  1. If it's seekable, try streaming. If not, fall back to lseek/mmap.
> >> 
> >>  2. If it's not seekable and the filter is required, try streaming. We
> >>     die anyway if we fail.
> 
> Puzzled...  Is it assumed that any content the filters tell us to
> use the contents from the db as-is by exiting with non-zero status
> will always be large not to fit in-core?  For small contents, isn't
> this "ideal" strategy a regression?

I am not sure what you mean by regression here. We will try to stream
more often, but I do not see that as a bad thing.

-Peff
