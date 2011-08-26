From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 22:59:13 -0400
Message-ID: <20110826025913.GC17625@sigill.intra.peff.net>
References: <20110825200001.GA6165@sigill.intra.peff.net>
 <20110825204047.GA9948@sigill.intra.peff.net>
 <7v8vqhhzgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwmdd-00021n-Cq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 04:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab1HZC7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 22:59:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56171
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab1HZC7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 22:59:17 -0400
Received: (qmail 22588 invoked by uid 107); 26 Aug 2011 02:59:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 22:59:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 22:59:13 -0400
Content-Disposition: inline
In-Reply-To: <7v8vqhhzgd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180149>

On Thu, Aug 25, 2011 at 03:57:06PM -0700, Junio C Hamano wrote:

> > If you have any matching attribute line in your own files, it should
> > override. So:
> >
> >   foo/* -diff
> >
> > will still mark foo/bar.c as binary, even with this change.
> >
> > Can anyone think of other possible side effects?
> >
> > Also, any other extensions that would go into such a list? I have no
> > idea what the common extension is for something like pascal or csharp.
> 
> As long as the builtin ones are the lowest priority fallback, we should be
> Ok.
> 
> Do we say anywhere that "Ah, this has 'diff' attribute defined, so it must
> be text"? If so, we should fix _that_. In other words, having this one
> extra entry
> 
> 	"* diff=default"
> 
> in the builtin_attr[] array should be a no-op, I think.

No, certainly not since 122aa6f (diff: introduce diff.<driver>.binary,
2008-10-05). That commit's message claims that we did before it, but
looking at the patch, I am not so sure. But I'm not about to start
testing a 3-year-old patch to see if it really was the source of the
fix; the point is that it is correct now. :)

I think it could be a problem in the future if the builtin userdiff
drivers started growing more invasive options, like automatically
claiming to be non-binary (i.e., setting diff.cpp.binary = false by
default). In other words, I think we have two options:

  1. Builtin drivers like "cpp" can stay minimal, only setting funcname
     and color-words headers that aren't going to produce terrible
     results if we are wrong about detecting by extension.

  2. We force the user to identify file types manually, so we can't be
     wrong. The "cpp" diff driver means "you are a text C file", and if
     a user mis-marks a binary file with that diff driver, they are the
     one who is wrong.

So if it's an either/or situation, we should decide not only that
extension auto-detection is a good feature, but that it trumps adding
more advanced features to the builtin drivers in the future.

Or we could decide that the extensions really are good enough, and if
you really do have binary files named "foo.c", it's your problem to
override the defaults with "*.c -diff".

-Peff
