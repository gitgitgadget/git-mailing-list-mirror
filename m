From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Fri, 13 Jun 2014 03:15:50 -0400
Message-ID: <20140613071550.GC7908@sigill.intra.peff.net>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
 <20140612193144.GA17077@hudson.localdomain>
 <CAPig+cTVLJQOsW7H4Ht2NNYkeiMb=EWT7BG3sNu0wNsTQ=oZNA@mail.gmail.com>
 <20140612234637.GB17803@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 09:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLiO-0001uX-1N
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbaFMHPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:15:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:43226 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbaFMHPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:15:52 -0400
Received: (qmail 8624 invoked by uid 102); 13 Jun 2014 07:15:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:15:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:15:50 -0400
Content-Disposition: inline
In-Reply-To: <20140612234637.GB17803@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251522>

On Thu, Jun 12, 2014 at 04:46:37PM -0700, Jeremiah Mahler wrote:

> >     Although strbuf_set() does make the code a bit easier to read
> >     when strbufs are repeatedly re-used, re-using a variable for
> >     different purposes is generally considered poor programming
> >     practice. It's likely that heavy re-use of strbufs has been
> >     tolerated to avoid multiple heap allocations, but that may be a
> >     case of premature (allocation) optimization, rather than good
> >     programming. A different ("better") way to make the code more
> >     readable and maintainable may be to ban re-use of strbufs for
> >     different purposes.
> > 
> > But I deleted it before sending because it's a somewhat tangential
> > issue not introduced by your changes. However, I do see strbuf_set()
> > as a Band-Aid for the problem described above, rather than as a useful
> > feature on its own. If the practice of re-using strbufs (as a
> > premature optimization) ever becomes taboo, then strbuf_set() loses
> > its value.
> > 
> 
> I am getting the feeling that I have mis-understood the purpose of
> strbufs.  It is not just a library to use in place of char*.
> 
> If strbufs should only be added to and never reset a good test would be
> to re-write builtin/remote.c without the use of strbuf_reset.
> 
> builtin/remote.c does re-use the buffers.  But it seems if a buffer is
> used N times then to avoid a reset you would need N buffers.
> 
> But on the other hand I agree with your comment that re-using a variable
> for different purposes is poor practice.
> 
> Now I am not even sure if I want my own patch :-)

I think reusing buffers like remote.c does makes things uglier and more
confusing than necessary, and probably doesn't have any appreciable
performance gain. We are saving a handful of allocations, and have such
wonderful variable names as "buf2" (when is it OK to reuse that one,
versus regular "buf"?).

A better reason I think is to reuse allocations across a loop, like:

  struct strbuf buf = STRBUF_INIT;

  for (i = 0; i < nr; i++) {
	strbuf_reset(&buf);
	strbuf_add(&buf, foo[i]);
	... do something with buf ...
  }
  strbuf_release(&buf);

You can write that as:

  for (i = 0; i < nr; i++) {
	struct strbuf buf = STRBUF_INIT;
	strbuf_add(&buf, foo[i]);
	... do something ...
	strbuf_release(&buf);
  }

and it is definitely still a case of premature optimization. But:

  1. "nr" here may be very large, so the amortized benefits are greater

  2. It's only one call to strbuf_reset to cover many items. Not one
     sprinkled every few lines.

You'll note that strbuf_getline uses a "set" convention (making it
different from the rest of strbuf) to handle this looping case.

I don't have a problem with strbuf_set, but just peeking at remote.c, I
think I'd rather see it cleaned up. It looks like one of the major uses
is setting config variables. I wonder how hard it would be to make a
git_config_set variant that took printf-style formats, and handled the
strbuf itself.

-Peff
