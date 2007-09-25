From: Jeff King <peff@peff.net>
Subject: Re: diffcore-rename performance mode
Date: Tue, 25 Sep 2007 15:06:40 -0400
Message-ID: <20070925190640.GA4613@coredump.intra.peff.net>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net> <20070925163843.GA22987@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFkB-00036Q-62
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbXIYTGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXIYTGo
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:06:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2396 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbXIYTGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:06:43 -0400
Received: (qmail 19084 invoked by uid 111); 25 Sep 2007 19:06:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Sep 2007 15:06:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2007 15:06:40 -0400
Content-Disposition: inline
In-Reply-To: <20070925163843.GA22987@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59151>

On Tue, Sep 25, 2007 at 12:38:43PM -0400, Jeff King wrote:

>[...]
>
> What is most confusing is why the 'somefree' case performs so badly,
> since we should just be using the cnt_data. I'll see if gprof can shed

OK, I found the problem. estimate_similarity calls
diff_populate_filespec each time, even if we already have the cnt_data,
which leads to recomputing the blob contents from deltas. Oops.

Fixing this, the correct numbers are:

                 | stock | nofree | old somefree | fixed somefree
-----------------|-----------------------------------------------
user time (s)    | 76.78 | 16.96  | 46.26        | 16.99
peak memory (Kb) | 52300 | 66796  | 59156        | 57328

So now we're at a 4.5x speedup for about 10% extra memory usage. Patch
will follow.

-Peff
