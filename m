From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] diffcore-rename with duplicate tree entries can segfault
Date: Thu, 26 Feb 2015 20:38:47 -0500
Message-ID: <20150227013847.GA2983@peff.net>
References: <20150224214311.GA8622@peff.net>
 <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
 <20150224224918.GA24749@peff.net>
 <xmqqd24yq517.fsf@gitster.dls.corp.google.com>
 <20150224234737.GA8370@peff.net>
 <xmqq8ufmpouz.fsf@gitster.dls.corp.google.com>
 <20150225214032.GA32295@peff.net>
 <xmqq1tldoe35.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 02:38:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR9tH-0006DF-DT
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 02:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbbB0Biv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 20:38:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:53993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbbB0Biu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 20:38:50 -0500
Received: (qmail 28270 invoked by uid 102); 27 Feb 2015 01:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 19:38:50 -0600
Received: (qmail 30132 invoked by uid 107); 27 Feb 2015 01:38:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 20:38:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 20:38:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tldoe35.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264486>

On Wed, Feb 25, 2015 at 01:50:38PM -0800, Junio C Hamano wrote:

> > So to go forward, I'm happy to prepare a patch, but I'd like to know:
> >
> >   1. Does something like the above look reasonable to you (I'd probably
> >      refactor it to avoid the bizarre return value semantics from
> >      locate_rename_dst, though)?
> >
> >   2. If so, do you want something minimal like what's above, or do you
> >      mind if I build it on top of a hashmap conversion? I suspect the
> >      logic may also end up more clear with the hashmap (since inserting
> >      versus lookup will be more distinct in the callers).
> 
> No, I don't mind.  The diff-b-m topic seems to need a lot deeper
> rethink than I originally anticipated anyway, and it can wait for a
> clean-up to use hashmap to stabilize.

I tried switching to a hashmap, but the diff_score code actually wants
to index into the array using an int. In a hashmap, we'd use a pointer
instead, but that increases the size of "struct diff_score", which is
something that we have to allocate a lot of (src * dst, I think).

So I punted on that and just cleaned up the locate_rename_dst interface
a bit.  Here's the result.

  [1/2]: diffcore-rename: split locate_rename_dst into two functions
  [2/2]: diffcore-rename: avoid processing duplicate destinations

-Peff
