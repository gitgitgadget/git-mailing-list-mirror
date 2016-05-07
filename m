From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] gc --auto: don't lie about running in background on
 Windows
Date: Sat, 07 May 2016 16:44:51 +0200
Message-ID: <20160507164451.Horde.S4kJBIYRkpnmQt7tw82MHDH@webmail.informatik.kit.edu>
References: <20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@webmail.informatik.kit.edu>
 <20160505151646.13189-1-szeder@ira.uka.de>
 <xmqqbn4kcvuc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 16:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az3Ti-0002Yd-53
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 16:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcEGOo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 10:44:59 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44112 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011AbcEGOo6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 May 2016 10:44:58 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1az3TS-0006sD-Fx; Sat, 07 May 2016 16:44:54 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1az3TP-00031d-U1; Sat, 07 May 2016 16:44:51 +0200
Received: from x4db257bf.dyn.telefonica.de (x4db257bf.dyn.telefonica.de
 [77.178.87.191]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 07 May 2016 16:44:51 +0200
In-Reply-To: <xmqqbn4kcvuc.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462632294.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293899>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Arguably this helper function could be just a simple variable.  I
>> opted for a function because:
>>
>>   - I preferred a single '#ifdef NO_POSIX_GOODIES', and putting a
>>     static variable so near to EOF felt just wrong.  (And this is wh=
y
>>     it's not an inline-able function defined in a header file.)
>>
>>   - currently we know already at compile time that Windows can't
>>     daemonize, but in the future we might want to extend this helper
>>     function to perform some runtime checks, too.  But this is perha=
ps
>>     like preparing for crossing a bridge where we'll never get to.
>
> Alternatively, the implementation of daemonize() and can_daemonize()
> can live in compat/ and have the #ifdef switch in git-compat-util.h,
> e.g. something along the lines of these:
>
> 	<< git-compat-util.h >>
> 	... after conditional inclusion of compat/mingw.h ...
> 	#ifndef can_daemonize
>         #define can_daemonize() 1
> 	#endif
>
> 	<< compat/mingw.h >>
> 	#define can_daemonize() 0
> 	#define daemonize() mingw_daemonize()
>
> 	<< setup.c >>
>         ...
>         #ifndef NO_POSIX_GOODIES
>         int daemonize(void)
>         {
>             ... no ifdef around here ...
> 	}
> 	#endif

config.mak.uname sets NO_POSIX_GOODIES only for Windows builds, but
NO_POSIX_GOODIES doesn't sound Windows-specific at all.  Currently if
somebody were to decide to build with NO_POSIX_GOODIES=3DUnfortunatelyY=
es,
then he would get a working git in the end, even on non-Windows
platforms.  With the proposed alternative above we would only provide a=
n
alternative daemonize() implementation for MINGW, breaking the build of
those setting NO_POSIX_GOODIES by themselves.

I don't know whether there are platforms out there besides Windows that
need the NO_POSIX_GOODIES treatment, but we don't explicitly support
them in config.mak.uname, or people who for whatever reason build with
this knob turned on.
