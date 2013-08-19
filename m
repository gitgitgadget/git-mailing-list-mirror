From: Jeff King <peff@peff.net>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Mon, 19 Aug 2013 16:40:44 -0400
Message-ID: <20130819204044.GA29258@sigill.intra.peff.net>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWFy-0000IQ-6u
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab3HSUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:40:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:58999 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab3HSUkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:40:49 -0400
Received: (qmail 3745 invoked by uid 102); 19 Aug 2013 20:40:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Aug 2013 15:40:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Aug 2013 16:40:44 -0400
Content-Disposition: inline
In-Reply-To: <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232561>

On Mon, Aug 19, 2013 at 09:03:21PM +0100, Philip Oakley wrote:

> In case other readers don't have a .xlsx reader here is Rick's list
> in plain text (may be white space damaged).
> 
> I expect some will be false positives, and some will just be being
> too cautious.
>
> [...]
> 
> description resourceFilePath fileName lineNumber
>      nullPointer(CppCheck) \git-master\builtin\add.c add.c 286

Hm. That code in v1.8.3.4 reads:

        if (pathspec)
                while (pathspec[pc])
                        pc++;

What's the problem? If pathspec is not properly terminated, we can run
off the end, but I do see anything to indicate that is the case. What
does the "nullPointer" check mean here?

>      wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c
> fetch.c 588

Line 588 does not have formatted I/O at all. Are these line numbers
somehow not matching what I have in v1.8.3.4?

>      nullPointer(CppCheck) \git-master\builtin\ls-files.c ls-files.c
> 144

This one looks like:

       if (tag && *tag && show_valid_bit &&
            (ce->ce_flags & CE_VALID)) {
                static char alttag[4];
                memcpy(alttag, tag, 3);
                if (isalpha(tag[0]))

where the final line is 144. But we have explicitly checked that tag is not
NULL...

>      doubleFree(CppCheck) \git-master\builtin\notes.c notes.c 275

This one looks like:

  if (...) {
    free(buf);
    die(...);
  }
  ...
  free(buf);

which might look like a double free if you do not know that die() will
never return (it is properly annotated for gcc, but I don't know whether
CppCheck understands such things).

So out of the 4 entries I investigated, none of them looks like an
actual problem. But I'm not even sure I am looking at the right place;
these don't even seem like things that would cause a false positive in a
static analyzer.

-Peff
