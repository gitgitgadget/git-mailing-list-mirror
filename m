From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] usage: try harder to format very long error messages
Date: Tue, 11 Aug 2015 12:33:55 -0400
Message-ID: <20150811163355.GA15521@sigill.intra.peff.net>
References: <20150811161752.GA14829@sigill.intra.peff.net>
 <CAGZ79kbL6DuXoQi72z_5=PZy2+HPh_L4+FJ_diokJi6s3uP57g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 18:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPCVA-000414-03
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 18:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbbHKQeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 12:34:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:43695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755378AbbHKQeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 12:34:00 -0400
Received: (qmail 17010 invoked by uid 102); 11 Aug 2015 16:33:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 11:33:59 -0500
Received: (qmail 16908 invoked by uid 107); 11 Aug 2015 16:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 12:34:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 12:33:55 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbL6DuXoQi72z_5=PZy2+HPh_L4+FJ_diokJi6s3uP57g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275697>

On Tue, Aug 11, 2015 at 09:28:34AM -0700, Stefan Beller wrote:

> On Tue, Aug 11, 2015 at 9:17 AM, Jeff King <peff@peff.net> wrote:
> > We use a fixed-size buffer of 4096 bytes to format die() and
> > error() messages. We explicitly avoided using a strbuf or
> > other fanciness here, because we want to make sure that we
> > report the message even in the face of malloc() failure
> > (after all, we might even be dying due to a malloc call).
> 
> Would it make sense to allocate memory in the early startup phase
> for a possible error message?
> So instead of putting 4kb on the stack we'd just have an unused 16kb
> on the heap.

Isn't that just punting on the problem? Now your 16kb filename will get
truncated messages (in general we cannot even work with such files, but
it is nice if the error message telling us so is readable).

If stack space is the problem, we can just put 16kb in BSS. But I think
we really do want something that grows to the appropriate size. Or we
need to start being more clever about our truncation. E.g., printing:

  error: unable to stat 'aaaaaaaaa[...]aaaaaa/foo': File too long

where the "[...]" is literally what we would print. The trouble with
that approach is that it is hard to intercept large strings without
re-implementing all of stdio's formatting.

-Peff
