From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Fri, 30 May 2014 13:29:44 -0400
Message-ID: <20140530172944.GC25443@sigill.intra.peff.net>
References: <1401311055-480-2-git-send-email-dturner@twitter.com>
 <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross>
 <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
 <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
 <20140529234109.GA28683@sigill.intra.peff.net>
 <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com>
 <20140530000728.GC28683@sigill.intra.peff.net>
 <538853B5.1080308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 30 19:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQco-00030n-N0
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbaE3R3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:29:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:34274 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933015AbaE3R3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:29:46 -0400
Received: (qmail 15230 invoked by uid 102); 30 May 2014 17:29:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 12:29:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 13:29:44 -0400
Content-Disposition: inline
In-Reply-To: <538853B5.1080308@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250449>

On Fri, May 30, 2014 at 11:47:33AM +0200, Michael Haggerty wrote:

> > I could guess something like "the writer has a different idea of what a
> > valid refname is than we do". But that applies as well to (2), but just
> > as "the reader who wrote packed-refs.stat has a different idea than we
> > do".
> 
> If we want to be robust to future changes to refname rules, we could add
> a header flag like
> 
>     # pack-refs with: peeled fully-peeled check-level=1.0
> 
> which promises that the reference names in the file conform to the
> current ("version 1.0") check_refname_format() rules.

Yeah, I thought about mentioning something like that. But really, this
just seems like a lot of complexity to solve the problem in a wrong way.

It's not running check_refname_format that is the real problem. It's the
fact that we do O(# of refs) work whenever we have to access the
packed-refs file. check_refname_format is part of that, surely, but so
is reading the file, creating all of the refname structs in memory, etc.

I'd much rather see a solution that lets us do O(log N) or O(1) work to
access a ref, and then we don't have to care about optimizing
check_refname_format specifically.

I don't mind internal code speedups to micro-optimize check_refname_format.
They may make the code uglier, but they're fairly contained. But things
like check-level are much more invasive, and we'll need to keep
compatibility with them in future versions.

-Peff
