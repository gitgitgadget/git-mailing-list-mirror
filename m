From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Thu, 28 May 2009 14:43:34 -0400
Message-ID: <20090528184334.GB13499@coredump.intra.peff.net>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org> <20090525092027.GA22382@coredump.intra.peff.net> <zik8bR55cIiktB2euEByCZIZJ1jtx64yA5n1Ki8IMrW1wLBzuBR8Yw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 20:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9kaQ-0008Up-M3
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204AbZE1Snm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 14:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbZE1Snm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:43:42 -0400
Received: from peff.net ([208.65.91.99]:53068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839AbZE1Snl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 14:43:41 -0400
Received: (qmail 22242 invoked by uid 107); 28 May 2009 18:43:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 14:43:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 14:43:34 -0400
Content-Disposition: inline
In-Reply-To: <zik8bR55cIiktB2euEByCZIZJ1jtx64yA5n1Ki8IMrW1wLBzuBR8Yw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120207>

On Tue, May 26, 2009 at 09:56:26AM -0500, Brandon Casey wrote:

> It also appears from looking at /usr/include/iconv.h that Solaris 10 does
> not need it as long as _XPG6 is defined since that file has:
> 
>   #ifdef _XPG6
>   extern size_t   iconv(iconv_t, char **_RESTRICT_KYWD,
>                   size_t *_RESTRICT_KYWD, char **_RESTRICT_KYWD,
>                   size_t *_RESTRICT_KYWD);
>   #else
>   extern size_t   iconv(iconv_t, const char **_RESTRICT_KYWD,
>                   size_t *_RESTRICT_KYWD, char **_RESTRICT_KYWD,
>                   size_t *_RESTRICT_KYWD);
>   #endif
> 
> I haven't tested, but I will.  I think Solaris 7 needs it though.

Hmph. On Solaris 8, there is no such conditional; iconv is defined
similar to the second version you quoted above:

  extern size_t iconv(iconv_t, const char **, size_t *, char **, size_t *);

So it would seem we do need OLD_ICONV there. But it compiles just fine
without any warnings.

> >   t3900 - still problems in the eucJP test. I haven't looked closely,
> >           but my understanding is that this might need extra language
> >           packs installed (I know virtually nothing about Solaris
> >           administration and the box is not mine).
> 
> t3900.2[23] ?

Yes.

> The iconv libraries seem to be named according to the conversions that
> they can perform.  So in /usr/lib/iconv/ you'll see:
> 
>    UTF-8%eucJP.so
>    eucJP%UTF-8.so
>    ISO-2022-JP%UTF-8.so
>    UTF-8%ISO-2022-JP.so
>    etc.
> 
> but you won't see (at least I don't)
> 
>    eucJP%ISO-2022-JP.so
>    ISO-2022-JP.so%eucJP

Ah, I didn't know about that. Thanks. I also have the ones for UTF-8
conversion, but not for direct eucJP to ISO-2022-JP conversion.

> >   t8005 - git produces incorrect (or at least not expected) results for
> >           the iso8859-5 to sjis conversion. It all looks like control
> >           characters to me, so I'm not sure how to diagnose (and it may
> >           just be an installation issue again).
> 
> t8005.[23]
> 
> Same reason as above, no conversion between ISO8859-5 and SJIS.  t8005.4
> passes since conversion for both of those to UTF-8 is installed.

OK, makes sense.

> On Solaris 7, I additionally must skip:
> 
>    t5100.[56] t5100.1[026-9] t5100.2[0-6]

Those work just fine for me on Solaris 8.

> Also, if you want to test with the Korn shell (you'll need a couple minor
> tweaks to the test lib), t6030.1[23] must be skipped.  It seems even Solaris

I do all of my testing with bash, having given up on Solaris /bin/sh. In
fact, I have found that bash 2.05 works, but bash 2.03 does _not_ (it
doesn't like sourcing the files with non-ascii characters in t8005.

-Peff
