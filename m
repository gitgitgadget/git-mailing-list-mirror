From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [RFC] Support for HP NonStop
Date: Sat, 25 Aug 2012 10:03:23 +0200
Message-ID: <000f01cd8298$19988c00$4cc9a400$@schmitz-digital.de>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de> <7v4nnsyrp7.fsf@alter.siamese.dyndns.org> <005701cd8239$1a828300$4f878900$@schmitz-digital.de> <7vvcg8x8lo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 10:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5BLQ-0001RQ-2m
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 10:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab2HYIDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 04:03:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52711 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab2HYIDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 04:03:35 -0400
Received: from DualCore (dsdf-4d0a03be.pool.mediaWays.net [77.10.3.190])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MfSEV-1TH6De33l5-00Oa27; Sat, 25 Aug 2012 10:03:33 +0200
In-Reply-To: <7vvcg8x8lo.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJdqfapyoHz4H9Ne772bOxBhhZ91QJGkyzrAdYNcY0CuX4hZpYTIn5g
Content-Language: de
X-Provags-ID: V02:K0:Ml19eiLhgGlbxAH1gpy+85J53hbAV5e5BYBx4YbWCmV
 krrC+FVkVPYQbNiIUNwBgi0pFG6BKpvkI1mTIdDq+FFpG9uWI5
 JmdVnHAxrx/I/FaHxwJ11U8r7QyDqqODMmxEIXrrevehxF9Q25
 6G2hj0p2mx9oytJBynBsg0rokZdsAQKNXKr5a4tU3SA8tM743w
 1oBcjlhjT/es1HiaBwrOzhbqH5Y8cFFJpmm4ZjVzgWPhJsbLMq
 djfzW0k6N4WSSVSoResXv2OtLzkz01hrf4FzyZj+JSgegawaZ3
 BJ4N2vhfP2RUork7zffz0AnCBxLO2G8g8c3l+OaBQBlngD4wG5
 +OMXvTVtSbjOLzdOYQGLHORZATqivajcsUR2WeYDmjlwI8XN2D
 bFKdU9G8pbHbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204269>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 11:51 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [RFC] Support for HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Reminds me of a related issue: in compat/fnmatch/fnmatch.c there is this:
> > #if HAVE_STRING_H || defined _LIBC
> > # include <string.h>
> > #else
> > # include <strings.h>
> > #endif
> >
> > There's no place where HAVE_STRING_H get set
> > This looks wrong to me,...
> 
> This is because it is a borrowed file from glibc, and we try to
> minimize changes to such a file.
> 
> If you need HAVE_STRING_H to force inclusion of <string.h> on your
> platform, doing this:
> 
> >        COMPAT_CFLAGS += -DHAVE_STRING_H=1 # needed in compat/fnmatch/fnmatch.c
> 
> is perfectly the right thing to do.

It should be set by default and those that don't have it, should (have to) disable it.
In Makefile:

ifndef NO_STRING_H
        COMPAT_CFLAGS += -DHAVE_STRING_H=1 # needed in compat/fnmatch/fnmatch.c 
endif

> > Do platforms exist without string.h?
> > Maybe fnmatch.c should look like this instead?
> 
> We try to minimize changes to such a file we borrow from upstream;

Valid point, but...

> especially we do not do so lightly when we have to ask "do platforms
> exist?"  Of course, they do---otherwise glibc folks wouldn't have
> written such a conditional.

Hmm, well, why then doesn't git-compat.util.h use the same mechanism? (and no ,it should not!)
I guess because as of now nobody ever tried to port git to a platform that doesn't have string.h.

string.h is C89 ANSI/ISO standard (and was part of even the earliest K&C C), in place since more than 22 years now! It may not be
available on embedded platforms, but those won't be able to run git anyway I'd guess.

Newer version of gnulib's fnmatch.c don't use this anymore, git's is from 99, according to the Copyright:
Copyright (C) 1991, 92, 93, 96, 97, 98, 99

The current gnulib one shows:
Copyright (C) 1991-1993, 1996-2007, 2009-2012

Time to upgrade, if you'd ask me...

Same may go for poll.c BTW

Bye, Jojo
