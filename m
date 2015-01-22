From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 08:10:18 -0500
Message-ID: <20150122131018.GE19681@peff.net>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
 <1421893929-7447-6-git-send-email-sbeller@google.com>
 <54C0DDE7.8030708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 22 14:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHWi-0000IH-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 14:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbAVNKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 08:10:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:37296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752309AbbAVNKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 08:10:19 -0500
Received: (qmail 17811 invoked by uid 102); 22 Jan 2015 13:10:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 07:10:19 -0600
Received: (qmail 9076 invoked by uid 107); 22 Jan 2015 13:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 08:10:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 08:10:18 -0500
Content-Disposition: inline
In-Reply-To: <54C0DDE7.8030708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262831>

On Thu, Jan 22, 2015 at 12:24:23PM +0100, Michael Haggerty wrote:

> I can't figure out where to apply this series or where to fetch it from,
> so I can't see these changes in context, so maybe I'm misunderstanding
> something. It looks like this code is doing
> 
>     open(), close(), open(), fdopen(), write(), fclose(), rename()
> 
> on each lockfile. But don't we have enough information to write the
> SHA-1 into the lockfile the first time we touch it? I.e., couldn't we
> reduce this to
> 
>     open(), fdopen(), write(), fclose(), rename()
> 
> , where the first four calls all happen in the initial loop? If a
> problem is discovered when writing a later reference, we would roll back
> the transaction anyway.
> 
> I understand that this would require a bigger rewrite, so maybe it is
> not worth it.

I had a nagging feeling on the multiple-open thing, too, and would much
prefer to just write out the contents early (since we know what they
are). It looks like we would just need to split write_ref_sha1() into
its two halves:

  1. Write out the lockfile

  2. Commit the change

And then call them at the appropriate spots from ref_transaction_commit().

I guess that is maybe a step backwards for abstracted ref backends,
though.

-Peff
