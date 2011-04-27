From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv3 5/6] Allow specifying --dirstat cut-off percentage as a
 floating point number
Date: Wed, 27 Apr 2011 01:37:17 -0700
Message-ID: <BANLkTi=xJXFKwzu4cCZAW_T2dXQ8wOq70w@mail.gmail.com>
References: <1303870359-26083-1-git-send-email-johan@herland.net>
 <1303892653-3958-1-git-send-email-johan@herland.net> <1303892653-3958-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0Fr-0007OT-96
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab1D0Ihm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 04:37:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58419 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754689Ab1D0Ihk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 04:37:40 -0400
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3R8bbrh024384
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:37:39 -0700
Received: by eyx24 with SMTP id 24so437199eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:37:37 -0700 (PDT)
Received: by 10.14.1.71 with SMTP id 47mr822525eec.128.1303893457293; Wed, 27
 Apr 2011 01:37:37 -0700 (PDT)
Received: by 10.14.124.148 with HTTP; Wed, 27 Apr 2011 01:37:17 -0700 (PDT)
In-Reply-To: <1303892653-3958-6-git-send-email-johan@herland.net>
X-Spam-Status: No, hits=-103.466 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172199>

On Wed, Apr 27, 2011 at 1:24 AM, Johan Herland <johan@herland.net> wrot=
e:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 options->dirstat_permil=
le =3D strtoul(p, &end, 10) * 10;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D end;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*p =3D=3D '.' && is=
digit(*(++p))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int per=
mille =3D strtoul(p, &end, 10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D e=
nd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (=
permille >=3D 10)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 permille /=3D 10; /* only use first digit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 options=
->dirstat_permille +=3D permille;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Heh. That's both unnecessarily complicated, and doesn't work.

It gets the wrong answer for something like "0.0001", since 'permille'
in that case ends up starting out as '0001', ie just 1, so you never
actually do that whole while-loop.

So the right approach is just something like

  if (*p =3D=3D '.' && isdigit(*++p)) {
    /* only use first digit */
    options->dirstat_permille +=3D *p - '0';
    /* .. and ignore any further digits */
    while (isdigit(*++p))
      /* nothing */;
  }

(totally untested, of course)

                    Linus
