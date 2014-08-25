From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Mon, 25 Aug 2014 09:07:32 -0400
Message-ID: <20140825130732.GD17288@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <53FA0054.5060808@gmail.com>
 <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:08:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLu0J-0002Fp-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 15:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbaHYNHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 09:07:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:58391 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755715AbaHYNHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 09:07:34 -0400
Received: (qmail 11095 invoked by uid 102); 25 Aug 2014 13:07:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 08:07:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 09:07:32 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255823>

On Sun, Aug 24, 2014 at 04:39:37PM -0700, Junio C Hamano wrote:

> On Sun, Aug 24, 2014 at 8:10 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
> >>       for (p = list, i = 0; i < cnt; i++) {
> >> -             struct name_decoration *r = xmalloc(sizeof(*r) + 100);
> >> +             char name[100];
> >
> > Would it make sense to convert the 'name' into a git strbuf?
> > Please have a look at Documentation/technical/api-strbuf.txt
> 
> Why not go one step further and format it twice, once only
> to measure the necessary size to allocate, allocate and
> then format into it for real? Then you do not need to print
> into a temporary strbuf, copy the result and free the strbuf,
> no?
> 
> BUT.
> 
> The string will always be "dist=" followed by decimal representation of
> a count that fits in "int" anyway, so I actually think use of strbuf is way
> overkill (and formatting it twice also is); the patch as posted should be
> just fine.

I think you are right, and the patch is the right direction (assuming we
want to do this; I question whether there are enough elements in the
list for us to care about the size, and if there are, we are probably
better off storing the int and formatting the strings on the fly).

I wonder if there is a way we could get rid of the magic "100" here,
though. Its meaning is "enough to hold 'dist=' and any integer". But you
have to read carefully to see that this call to sprintf is not a buffer
overflow. A strbuf is one way to get rid of it, though it is awkward
because we then have to copy the result into a flex-array structure.

It would be nice if there was some way to abstract the idea of
formatting a buffer directly into a flex-array. That would involve the
double-format you mention, but we could use it in lots of places to make
the code nicer. Maybe like:

  void *fmt_flex_array(size_t base, const char *fmt, ...)
  {
          va_list ap;
	  size_t flex;
	  unsigned char *ret;

	  va_start(ap, fmt);
	  flex = vsnprintf(NULL, 0, fmt, ap);
	  va_end(ap);

	  ret = xmalloc(base + flex + 1);
	  va_start(ap, fmt);
	  /* Eek, see below */
	  vsnprintf(ret + flex, flex + 1, fmt, ap);

	  return ret;
  }

and you'd call it like:

  struct name_decoration *r = fmt_flex_array(sizeof(*r), "dist=%d", x);

Except that I don't think we are guaranteed that offsetof(mystruct,
flex_member) is equal to sizeof(mystruct). If FLEX_ARRAY is 0, it should
be, but some platforms use FLEX_ARRAY=1. So you'd have to pass in the
offset like:

  struct name_decoration *r = fmt_flex_array(sizeof(*r),
                                             offsetof(*r, name),
					     "dist=%d", x);

which is a little less nice. You could make it nicer with a macro, but
we don't assume variadic macros. <sigh>

-Peff
