From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Tue, 26 May 2009 09:56:26 -0500
Message-ID: <zik8bR55cIiktB2euEByCZIZJ1jtx64yA5n1Ki8IMrW1wLBzuBR8Yw@cipher.nrlssc.navy.mil>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org> <20090525092027.GA22382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 17:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8y8H-0000OS-J3
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 17:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZEZO7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 10:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZEZO7x
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 10:59:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34167 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZEZO7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 10:59:52 -0400
Received: by mail.nrlssc.navy.mil id n4QEuQuq023730; Tue, 26 May 2009 09:56:26 -0500
In-Reply-To: <20090525092027.GA22382@coredump.intra.peff.net>
X-OriginalArrivalTime: 26 May 2009 14:56:26.0613 (UTC) FILETIME=[24DED250:01C9DE12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120005>

Jeff King wrote:
> On Fri, May 22, 2009 at 06:06:06PM -0700, Junio C Hamano wrote:
> 
>> It also appears that we do not need OLD_ICONV anymore, as our Makefile
>> suggests for older releases.
>>
>> It would be nice if people with older Solaris can check if I am not
>> breaking things for them...

I will.

> Git builds fine on my Solaris 8 test box with this patch. It also builds
> fine if I drop OLD_ICONV, so it may be that we can unconditionally do
> so (but I don't have any older boxen to test with).

It also appears from looking at /usr/include/iconv.h that Solaris 10 does
not need it as long as _XPG6 is defined since that file has:

  #ifdef _XPG6
  extern size_t   iconv(iconv_t, char **_RESTRICT_KYWD,
                  size_t *_RESTRICT_KYWD, char **_RESTRICT_KYWD,
                  size_t *_RESTRICT_KYWD);
  #else
  extern size_t   iconv(iconv_t, const char **_RESTRICT_KYWD,
                  size_t *_RESTRICT_KYWD, char **_RESTRICT_KYWD,
                  size_t *_RESTRICT_KYWD);
  #endif

I haven't tested, but I will.  I think Solaris 7 needs it though.

> With current 'next' and NO_PERL set, I can pass every test except:
> 
>   t3900 - still problems in the eucJP test. I haven't looked closely,
>           but my understanding is that this might need extra language
>           packs installed (I know virtually nothing about Solaris
>           administration and the box is not mine).

t3900.2[23] ?

Yes, Solaris 7 and 10 fail for me on those tests.  Neither can convert
between eucJP and ISO-2022-JP.  The other tests pass because it can
convert from either of those to UTF-8 and vice versa.

The iconv libraries seem to be named according to the conversions that
they can perform.  So in /usr/lib/iconv/ you'll see:

   UTF-8%eucJP.so
   eucJP%UTF-8.so
   ISO-2022-JP%UTF-8.so
   UTF-8%ISO-2022-JP.so
   etc.

but you won't see (at least I don't)

   eucJP%ISO-2022-JP.so
   ISO-2022-JP.so%eucJP

>   t8005 - git produces incorrect (or at least not expected) results for
>           the iso8859-5 to sjis conversion. It all looks like control
>           characters to me, so I'm not sure how to diagnose (and it may
>           just be an installation issue again).

t8005.[23]

Same reason as above, no conversion between ISO8859-5 and SJIS.  t8005.4
passes since conversion for both of those to UTF-8 is installed.

>   t4116,t5000,t5001 - Solaris tar doesn't like pax headers that
>                       git-archive generates

Same here.


On Solaris 7, I additionally must skip:

   t5100.[56] t5100.1[026-9] t5100.2[0-6]

This is because iconv on Solaris 7 doesn't understand charset 'us-ascii'.
If I change 'charset=us-ascii' to 'charset=646' everywhere in t5100/sample.mbox
and t5100/rfc2047-samples.mbox, then all of t5100 passes.  It seems '646' is
the only name by which Solaris 7 recognizes ISO 646 aka ascii.  Other platforms
do not recognize '646'.


Also, if you want to test with the Korn shell (you'll need a couple minor
tweaks to the test lib), t6030.1[23] must be skipped.  It seems even Solaris
10 has what I consider a bug in ksh which affects how traps are handled.  A
trap set in one function, will not be called in the second sub-function.

i.e.

   f1()
     sets a trap on EXIT
     calls f2()
       calls f3()
         calls exit

   The trap set in f1() will _not_ be executed.

I have only observed this behavior on Solaris.  git-bisect sets such a trap,
but I think it is being rewritten in c, so hopefully this issue will go away
soon.

-brandon
