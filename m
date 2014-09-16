From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Mon, 15 Sep 2014 20:19:49 -0400
Message-ID: <20140916001948.GC5019@peff.net>
References: <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
 <20140913212504.GA25190@peff.net>
 <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
 <20140914004725.GA28010@peff.net>
 <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
 <20140914010120.GA28498@peff.net>
 <20140914013038.GA5974@peff.net>
 <xmqqha087lwv.fsf@gitster.dls.corp.google.com>
 <xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTgUt-00038b-BI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 02:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbaIPATw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 20:19:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48648 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756973AbaIPATv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 20:19:51 -0400
Received: (qmail 12835 invoked by uid 102); 16 Sep 2014 00:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 19:19:51 -0500
Received: (qmail 26327 invoked by uid 107); 16 Sep 2014 00:20:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 20:20:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2014 20:19:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257119>

On Mon, Sep 15, 2014 at 01:15:35PM -0700, Junio C Hamano wrote:

> > If we only want to skip ">?From" in pasted format-patch output, we
> > would want a rule in mailinfo that is tighter than is_from_line() in
> > mailsplit.
> 
> That is, something like this on top of your patch.  Or is this a bit
> too strict?

The only cases that I can think of that would be a problem with this
strictness are:

  1. Somebody writes format-patch output to a file, reads in the mbox
     using another program, and then writes out the result (munging the
     mbox From line). And then pastes the whole thing into their email
     body.

     I can see the first part happening. But given that it is totally
     irrelevant _unless_ they then screw up and paste the From line in
     the body (which is already a corner case), it probably doesn't
     matter.

  2. We change the static From lines that git generates. We can always
     update the parser, of course, but it may be running a different
     version of git than the sender.  People with an old git running
     "git am" would stop skipping past "From" lines in messages from
     people on newer gits.

Again, this eating of the in-body "From" line is already a corner case,
so it's not the end of the world if it breaks in a few cases. But I'd
also be fine with just leaving it looser.

>  Makefile            |  1 +
>  builtin/mailinfo.c  |  3 ++-
>  builtin/mailsplit.c |  1 +
>  cache.h             |  6 ------
>  mbox.c              | 15 +++++++++++++++
>  5 files changed, 19 insertions(+), 7 deletions(-)

I think you forgot to "git add" mbox.h. That being said, if we did go
this route, I do not see any reason to share the code at all. This can
be purely a mailinfo.c thing.

-Peff
