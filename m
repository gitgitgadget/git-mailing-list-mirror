From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Fri, 7 Sep 2012 09:39:15 +0200
Message-ID: <000e01cd8ccb$e20301b0$a6090510$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de> <5048B3D0.2070809@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
	"'Erik Faye-Lund'" <kusmabite@gmail.com>, <bug-gnulib@gnu.org>,
	<rsbecker@nexbridge.com>
To: "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9tAT-0000jE-JU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 09:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618Ab2IGHjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 03:39:49 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:49298 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758519Ab2IGHjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 03:39:48 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MLOsc-1TAROD0Rpy-000Zrj; Fri, 07 Sep 2012 09:39:23 +0200
In-Reply-To: <5048B3D0.2070809@gnu.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULAgLpIAgCxd+aWgIK9t7YAl1Rw+2WfYGAsA==
Content-Language: de
X-Provags-ID: V02:K0:D2PVqVq7RFV03kvzLZWTwUlVNfQPWVWJ3HHg9DEYL1U
 qtnFYJC+jx+71NCabbS3WIufi+uWlvoW6DAHtcZmCeLx0Gvydf
 B5vlgzIkWWDUEhmGJcxMn5YLn2PuYlhW7mcGBvGxmzFBBKoMoE
 h6WP3P4oEA+SoQlDilAMbNhWiyYdYGUg9HITLuwtqSPCqHNkFB
 OdxmV2zwiKCkUNufj8J8aGUibCcmIfp9x50FmdWRuBzVFx43vu
 6IyUpbKLMRSta+GI6USzuxB8zb3/iTCauV45OadsxhUqqxpx1J
 IcetnfQZ4cdAcjMAVHWIEohQhKb04FiI2AN5kY8z4QroesS3DO
 9K9h4rObWKgNyyF0DYcng6KkhAg5TubOcirSZSUDsg8USFDIZZ
 ylMqrl+vQDXbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204950>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> Sent: Thursday, September 06, 2012 4:32 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Junio C Hamano'; 'Erik Faye-Lund'; bug-gnulib@gnu.org; rsbecker@nexbridge.com
> Subject: Re: poll() emulation in git
> 
> Il 06/09/2012 16:02, Joachim Schmitz ha scritto:
> > ...
> > # else
> >       char data[64];
> >       r = recv (fd, data, sizeof (data), MSG_PEEK);
> >       socket_errno = (r < 0) ? errno : 0;
> > # endif
> >       if (r == 0)
> >         happened |= POLLHUP;
> >
> >       /* If the event happened on an unconnected server socket,
> >          that's fine. */
> >       else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
> >         happened |= (POLLIN | POLLRDNORM) & sought;
> >
> >       /* Distinguish hung-up sockets from other errors.  */
> >       else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
> >                || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
> >         happened |= POLLHUP;
> >
> > #ifdef __TANDEM /* as we can't recv(...,MSG_PEEK) on a non-socket */
> >       else if (socket_errno == ENOTSOCK)
> >         happened |= (POLLIN | POLLRDNORM) & sought;
> > #endif
> >       else
> >         happened |= POLLERR;
> >     }
> > ...
> >
> > We won't detect POLLHUP that way I think. However it seems to work, we've been able to clone, push, pull, branch that way with
> > NonStop being the (ssh-)server, something that didn't work at all without that hack (and yes, I believe it is just that).
> > Someone in for a cleaner way of managing this?
> 
> I suppose it works to always handle ENOTSOCK that way, even on
> non-__TANDEM systems.

Will you be fixing this in gnulib? How?

Bye, Jojo
