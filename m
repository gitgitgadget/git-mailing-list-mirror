From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 06:33:21 -0400
Message-ID: <20150622103321.GB12584@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6z2s-0000iu-EA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbFVKd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:33:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:49748 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752191AbbFVKdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:33:24 -0400
Received: (qmail 16839 invoked by uid 102); 22 Jun 2015 10:33:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:33:24 -0500
Received: (qmail 7243 invoked by uid 107); 22 Jun 2015 10:33:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:33:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20150622083822.GB12259@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272323>

On Mon, Jun 22, 2015 at 04:38:22AM -0400, Jeff King wrote:

> > +	prepare_packed_git();
> > +	for (p = packed_git; p; p = p->next) {
> > +		open_pack_index(p);
> > +	}
> 
> Yikes. The fact that you need to do this means that
> for_each_packed_object is buggy, IMHO. I'll send a patch.

Here's that patch. And since I did not want to pile work on Charles, I
went ahead and just implemented the patches I suggested in the other
email.

We may want to take patch 1 separately for the maint-track, as it is
really a bug-fix (albeit one that I do not think actually affects anyone
in practice right now).

Patches 2-5 are useful even if we go with Charles' command, as they make
cat-file better (cleanups and he new buffer option).

Patches 6-7 implement the cat-file option that would be redundant with
list-all-objects.

By the way, in addition to not showing objects in order,
list-all-objects (and my cat-file option) may show duplicates. Do we
want to "sort -u" for the user? It might be nice for them to always get
a de-duped and sorted list. Aside from the CPU cost of sorting, it does
mean we'll allocate ~80MB for the kernel to store the sha1s. I guess
that's not too much when you are talking about the kernel repo. I took
the coward's way out and just mentioned the limitation in the
documentation, but I'm happy to be persuaded.

  [1/7]: for_each_packed_object: automatically open pack index
  [2/7]: cat-file: minor style fix in options list
  [3/7]: cat-file: move batch_options definition to top of file
  [4/7]: cat-file: add --buffer option
  [5/7]: cat-file: stop returning value from batch_one_object
  [6/7]: cat-file: split batch_one_object into two stages
  [7/7]: cat-file: add --batch-all-objects option

-Peff
