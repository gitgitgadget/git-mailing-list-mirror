From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 4 Feb 2013 04:45:26 -0500
Message-ID: <20130204094526.GB32095@sigill.intra.peff.net>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
 <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
 <7vobg04ebe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 10:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Icq-0005Q1-86
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 10:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3BDJpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 04:45:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60013 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab3BDJpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 04:45:45 -0500
Received: (qmail 17311 invoked by uid 107); 4 Feb 2013 09:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 04:47:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 04:45:26 -0500
Content-Disposition: inline
In-Reply-To: <7vobg04ebe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215373>

On Mon, Feb 04, 2013 at 01:29:41AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As I understand how the current set-up works:
> >
> >  * Initially, we do not have foo.o but foo.c.  We automatically
> >    build foo.o because it depends on foo.c via the "%.o : %.c" rule,
> >    and as a side effect, we also build .depend/foo.o.d file;
> >
> >  * Then, if any real dependency used to build the existing foo.o
> >    that is recorded in .depend/foo.o.d file changes, foo.o gets
> >    rebuilt, which would update .depend/foo.o.d again for the next
> >    invocation.
> 
> This is unrelated to the case you mentioned, but I wonder what
> happens if you did this:
> 
>  * You are on branch 'next', where foo.c includes (perhaps
>    indirectly) frotz.h.  Compile and you get foo.o and also the
>    dependency recorded for it, "foo.o: foo.c frotz.h", in the
>    .depend/foo.o.d file.
> 
>  * You check out branch 'master', where foo.c does not include
>    frotz.h.  Indeed, the include file does not even exist on the
>    branch.
> 
> Do we get confused, because Makefile includes the depend file from
> the previous build, finds that you need foo.c and frotz.h up to date
> in order to get foo.o, but there is no rule to generate frotz.h?

No, because the .d files look like this:

  foo.o: frotz.h

  frotz.h:

So make sees that it can build frotz.h, which of course does nothing.
But that's OK, because foo.c doesn't actually include it anymore, and
when we recompile it (as we must, since it is different between the two
branches), we will rewrite the .d file without frotz.h.

-Peff
