From: Jeff King <peff@peff.net>
Subject: Re: Bug: .gitconfig folder
Date: Thu, 28 May 2015 03:51:42 -0400
Message-ID: <20150528075142.GB3688@peff.net>
References: <5565C6A7.60007@gmx.es>
 <xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
 <20150527221813.GF23259@peff.net>
 <xmqq1ti1k5nv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxsbb-0006rl-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbbE1Hvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:51:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:37090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751556AbbE1Hvp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 03:51:45 -0400
Received: (qmail 15787 invoked by uid 102); 28 May 2015 07:51:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 02:51:45 -0500
Received: (qmail 14052 invoked by uid 107); 28 May 2015 07:51:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 03:51:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 03:51:42 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1ti1k5nv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270128>

On Wed, May 27, 2015 at 03:38:12PM -0700, Junio C Hamano wrote:

> The patch was meant to be a tongue-in-cheek tangent that is a vast
> improvement for cases where we absolutely need to use mmap but does
> not help the OP at all ;-)  I do not think there is any need for the
> config reader to read the existing file via mmap interface; just
> open it, strbuf_read() the whole thing (and complain when it cannot)
> and we should be ok.
> 
> Or do we write back through the mmaped region or something?

No, I think we must never do that in our code because our compat mmap
implementation uses pread(). So all maps must be MAP_PRIVATE (and our
compat mmap barfs if it is not).

I started to go the strbuf_read() route, but it just felt so dirty to
change the way the code works only to try to get a better error message.
So here's my attempt at making it better while still using mmap. The end
result is:

  $ mkdir foo
  $ git config --file=foo some.key value
  error: unable to mmap 'foo': Is a directory

Having looked through the code, I think the _ideal_ way to implement it
would actually be with read() and seek(). We read through the config
once (with the normal parser, which wraps stdio) and mark the offsets of
chunks we want to copy to the output. Then we mmap the original (under
lock, at least, so it shouldn't be racy) and output the existing chunks
and any new content in the appropriate order.

So ideally writing each chunk would just be seek() and copy_fd(). But
our offsets aren't quite perfect. In some cases we read backwards in our
mmap to find the right cutoff point. I'm sure this is fixable given
sufficient refactoring, but the config-writing code is such a tangled
mess that I don't want to spend the time or risk the regressions.

  [1/4]: read-cache.c: drop PROT_WRITE from mmap of index
  [2/4]: config.c: fix mmap leak when writing config
  [3/4]: config.c: avoid xmmap error messages
  [4/4]: config.c: rewrite ENODEV into EISDIR when mmap fails

-Peff
