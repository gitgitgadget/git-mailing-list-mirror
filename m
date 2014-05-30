From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Thu, 29 May 2014 20:07:28 -0400
Message-ID: <20140530000728.GC28683@sigill.intra.peff.net>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com>
 <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross>
 <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
 <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
 <20140529234109.GA28683@sigill.intra.peff.net>
 <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 02:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqAMC-0004Go-CR
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 02:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbaE3AHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 20:07:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:33800 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbaE3AHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 20:07:30 -0400
Received: (qmail 30536 invoked by uid 102); 30 May 2014 00:07:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 19:07:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 20:07:28 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250423>

On Fri, May 30, 2014 at 06:43:18AM +0700, Duy Nguyen wrote:

> >> The first time we read packed_refs, check_refname_format() is called
> >> in read_packed_refs()->create_ref_entry() as usual. If we find no
> >> problem, we store packed_refs stat() info in maybe packed_refs.stat.
> >> Next time we read packed_refs, if packed_refs.stat is there and
> >> indicates that packed_refs has not changed, we can make
> >> create_ref_entry() ignore check_refname_format() completely.
> >
> > I'm confused. Why would we re-open packed-refs at all if the stat
> > information hasn't changed?
> 
> No, not in the same process. In the next run.

Ah, I thought "packed_refs.stat" was a struct member, but I guess you
mean it as a filename.

But then we're just trusting that the "trust me" flag on disk is
correct. Why not just trust that packed-refs is correct in the first
place?

IOW, consider this progression of changes:

  1. Check refname format when we read packed-refs (the current
     behavior).

  2. Keep a separate file "packed-refs.stat" with stat information. If
     the packed-refs file matches that stat information, do not bother
     checking refname formats.

  3. Put a flag in "packed-refs" that says "trust me, I'm valid". Check
     the refnames when it is generated.

  4. Realize that we already check the refnames when we write it out.
     Don't bother writing "trust me, I'm valid"; readers can assume that
     it is.

What is the scenario that option (2) protects against that options (3)
and (4) do not?

I could guess something like "the writer has a different idea of what a
valid refname is than we do". But that applies as well to (2), but just
as "the reader who wrote packed-refs.stat has a different idea than we
do".

As a side note, while it is nice that we might make check_refname_format
faster, I think if you _really_ want to make repos with a lot of refs
faster, it would make more sense to introduce an on-disk format that
does not need linear parsing (e.g., something we could mmap and binary
search, or even something dbm-ish that could be updated without
rewriting the whole file (deletions, for example, must rewrite the
whole file, giving quadratic performance when deleting all refs one by
one).

-Peff
