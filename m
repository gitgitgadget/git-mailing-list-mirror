From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 13:52:57 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061319590.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>  <7vir00lski.fsf@gitster.siamese.dyndns.org>
  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>  <alpine.LSU.1.00.0803061153400.15786@racer.site>
 <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXFbh-0002Lq-Jv
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765765AbYCFMxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764606AbYCFMxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:53:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:60829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765694AbYCFMxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:53:01 -0500
Received: (qmail invoked by alias); 06 Mar 2008 12:52:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 06 Mar 2008 13:52:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+cjZtRpc+duYTPse80Z7VMrZFXKP2F41OetGman
	CXuBleu5E10s0p
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76390>

Hi,

On Thu, 6 Mar 2008, Reece Dunn wrote:

> On 06/03/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Thu, 6 Mar 2008, Reece Dunn wrote:
> >
> >  > On 06/03/2008, Mike Hommey <mh@glandium.org> wrote:
> >  > > On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
> >  > >  >
> >  > >  > The most common use of addf() was to init a strbuf and addf() 
> >  > >  > right away. Since it is so common, it makes sense to have a 
> >  > >  > function strbuf_initf() to wrap both calls into one.
> >  > >  >
> >  > >  > Unfortunately, C (and cpp) has no way to make this easy 
> >  > >  > without code duplication, as we need to va_init() in 
> >  > >  > strbuf_addf() possibly a few times.  So the code for addf() is 
> >  > >  > copied.  Fortunately, the code is pretty short, so not too 
> >  > >  > much had to be copied as-is.
> >  >
> >  > Why not have a strbuf_vaddf and strbuf_vinitf that take a va_arg as 
> >  > a parameter. This would mean that you don't have code duplication, 
> >  > and it is flexible enough if you want to add more customisations in 
> >  > the future. No macro needed. This is what the printf/scanf family 
> >  > of functions do.
> 
> Is it possible to pass a void * to a strbuf_vaddf function that you can 
> pass to va_start, so you can then restart the va_list?

AFAIU va_list() works on the stack (on less register-challenged systems 
than x86, the first parameters are possibly passed as registers, too, but 
it has to resort to the stack at a certain number of parameters).

Since the stack is also used (at least on register-challenged yadda yadda) 
to store the return address, va_list() would most likely pick that up, 
too.

Now, that just _might_ still work, since the printf() family determines 
the number of arguments from the format string.

But then there are machines which are _not_ completely stack-based, for 
example SPARC.  IIRC the first 8 parameters are passed by a so-called 
register window, which changes with each function call.

So no, I think there is no portable way to pass them around.

Of course, having a simple implementation for addf() _not_ using 
vsnprintf() could help, too (and make the process more efficient, 
probably).

I thought.

The formats we'd have to support are:

$ git grep strbuf_addf |
	sed -e 's/^[^"]*"\([^"]*\)".*$/\1/' -e 's/%%//g' -e 's/%/\
&/g' | sed -n -e 's/\(%[^a-zA-Z]*[a-zA-Z]\).*/\1/p' | sort | uniq

%02X
%06o
%c
%d
%l
%o
%s
%.*s
%u

So it does not look too bad.  'X', 'o', 'd', 'l' and 'u', possibly with a 
size specifier (left 0-padded), 'c' and 's' (possibly with a length 
parameter).

The implementation wouldn't be _too_ short, I'd say, but doable.

Ciao,
Dscho

