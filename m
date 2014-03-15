From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-terminal: make TTY a lazy prerequisite
Date: Fri, 14 Mar 2014 21:55:29 -0400
Message-ID: <20140315015529.GB9979@sigill.intra.peff.net>
References: <53237228.10809@web.de>
 <20140314213715.GA10299@sigill.intra.peff.net>
 <xmqqtxb0fo65.fsf@gitster.dls.corp.google.com>
 <20140314215723.GB10299@sigill.intra.peff.net>
 <xmqqpplofnba.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 02:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOdpO-0005Gy-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 02:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbaCOBzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 21:55:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:39824 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754780AbaCOBzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 21:55:31 -0400
Received: (qmail 2395 invoked by uid 102); 15 Mar 2014 01:55:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 20:55:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 21:55:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpplofnba.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244132>

On Fri, Mar 14, 2014 at 03:05:45PM -0700, Junio C Hamano wrote:

> > Actually, we don't need to do this, as of 94221d2 (t: use perl instead
> > of "$PERL_PATH" where applicable, 2013-10-28). If only the author of
> > that commit were here to correct me...
> 
> Yuck. I forgot all about that, too.
> 
> I wonder if that commit (actually the one before it) invites subtle
> bugs by tempting us to say
> 
> 	sane_unset VAR &&
> 	VAR=VAL perl -e 0 &&
>         test "${VAR+isset}" != "isset"

I dunno. A more subtle case is:

  write_script foo <<-\EOF
  perl ...
  EOF

which uses the real "perl" and not the function. So it's not as airtight
as I would like, but I think it may be a net win, as the common case can
just use "perl".

Hmph. It seems like I raised both of those concerns initially:

  http://article.gmane.org/gmane.comp.version-control.git/236879

We can revisit it if you want. I think the only options besides leaving
it or reverting it would be to put "perl" into bin-wrappers as a wrapper
script. That's fine for the tests, but I suspect it might annoy people
who use bin-wrappers to run git straight out of the build directory
without installing.

> > -- >8 --
> > Subject: t/lib-terminal: make TTY a lazy prerequisite
> [...]
> 
> Thanks.

By the way, I checked for other cases that could use the same treatment
by grepping for test_expect_* in t/lib-*.sh. Most of them are inside
functions, so presumably the scripts call them at the appropriate time.

The exceptions are:

  1. lib-read-tree-m-3way.sh; this one has a whole battery of tests
     that sourced into t1000 and t4002. It could be split into functions
     and modernized, but it's probably not worth the effort. It's not
     causing ordering problems, and it's not likely to get used
     elsewhere.

  2. lib-pager.sh; this one is weird, as it is really about setting the
     "$less" variable to git's default pager. And then the prereq is
     really just checking that said pager is syntactically simple, I
     think, so we can override it by writing to a file with the same
     name. At least that's my impression; frankly I found it a bit
     confusing to read.

     Converting it to a lazy prereq wouldn't work because we care about
     its side effect of setting the "less" variable.  There are no
     ordering issues with it currently, so I'm inclined to leave it.

-Peff
