From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use macro HANDLER_WRAPPER in sigchain to wrap clean
 function of sigchain
Date: Tue, 13 Mar 2012 16:55:01 -0400
Message-ID: <20120313205501.GB27436@sigill.intra.peff.net>
References: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
 <7vmx7kweus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5b6Q6L+q?= <xudifsd@gmail.com>,
	Git =?utf-8?B?6YKu5Lu25YiX6KGo?= <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7YkS-0002rv-Az
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab2CMUzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 16:55:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48681
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2CMUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 16:55:04 -0400
Received: (qmail 1996 invoked by uid 107); 13 Mar 2012 20:55:15 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 16:55:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 16:55:01 -0400
Content-Disposition: inline
In-Reply-To: <7vmx7kweus.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193067>

On Tue, Mar 13, 2012 at 11:11:23AM -0700, Junio C Hamano wrote:

> =E5=BE=90=E8=BF=AA <xudifsd@gmail.com> writes:
>=20
> > The sigchain APIs require user to code like:
> >
> > void clean_foo_on_signal(int sig)
> > {
> >  clean_foo();
> >  sigchain_pop(sig);
> >  raise(sig);
> > }
>=20
> I can see the repetition, but I do not think your macro is a very goo=
d way
> to reduce it.  Can't we fix the sigchain API a bit, perhaps first by
> making a bit more state available to the sigchain stack?
>
> 	typedef void (*sigchain_fn)(int, void *);
>         int sigchain_push(int sig, sigchain_fn fn, void *cb_data);
>         int sigchain_pop(int sig);
>         void sigchain_push_common(sigchain_fn fn, void *cb_data);

=46WIW, when I wrote the original sigchain implementation I considered
doing something more complex like this. The calling code ends up
shorter, but I wonder if the end result is really any easier to
understand. Ditto for the macro. It's shorter, but much harder for a
reader to understand. The boilerplate, while ugly, reads very simply,
and is not error-prone.

So I don't like boilerplate or repetition, but this may be one of those
times where it is simply more clear to just be verbose.

> *1* Yes, I know, this casts between a data pointer and a function poi=
nter
> that is not portable, but the purpose of this pseudo-code is primaril=
y to
> illustrate the high level view of the idea.  We would probably want t=
o be
> able to pass callback value to the clean_foo() function and at that p=
oint,
> we would likely to be passing a pointer to a struct, and we could dec=
lare
> the first element of such a struct is a pointer to a sigchain_fn, or
> something.

That is the correct way to do it, but where does the struct memory come
from? You'd have to allocate it on the heap, unless you want to burden
the caller.

-Peff
