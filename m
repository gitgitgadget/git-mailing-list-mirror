From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 15:50:18 -0400
Message-ID: <20150501195017.GA3493@peff.net>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 21:50:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGxD-0000Bz-7H
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 21:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbEATuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 15:50:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:52980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752118AbbEATuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 15:50:21 -0400
Received: (qmail 7351 invoked by uid 102); 1 May 2015 19:50:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 14:50:20 -0500
Received: (qmail 19209 invoked by uid 107); 1 May 2015 19:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 15:50:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 15:50:18 -0400
Content-Disposition: inline
In-Reply-To: <1430508507-14016-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268178>

On Fri, May 01, 2015 at 12:28:27PM -0700, Stefan Beller wrote:

> It's safe to free the char pointer `p` unconditionally.
> 
> The pointer is assigned just 2 lines earlier as a return from
> prefix_path, which allocates new memory for its return value.
> 
> Then it is used in checkout_file, which passes the pointer on to
> cache_name_pos and write_tempfile_record, both of which do not store
> the pointer in any permanent record.
> 
> So the condition on when to free the pointer is just "always".

That of course makes me wonder why somebody would write this in the
first place. :)

It looks like it comes from be65e7d (Fix users of prefix_path() to
free() only when necessary, 2006-05-07), which claims that prefix_path
sometimes does not allocate. When did that change? Looks like maybe
d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
2008-01-28), but it certainly is the case now.

Probably all of the other sites touched by be65e7d could use the same
treatment.

-Peff
