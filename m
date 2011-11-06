From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH na/strtoimax] Compatibility: declare strtoimax() under
 NO_STRTOUMAX
Date: Sun, 06 Nov 2011 18:21:30 +0000
Message-ID: <4EB6D02A.4010000@ramsay1.demon.co.uk>
References: <4EB5583E.2030306@kdbg.org> <4EB56593.6090402@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nick Alcock <nix@esperi.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 19:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN7NO-0000Fn-7t
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 19:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1KFSXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 13:23:21 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:35485 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753644Ab1KFSXU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 13:23:20 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RN7NH-0006vd-mb; Sun, 06 Nov 2011 18:23:19 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4EB56593.6090402@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184921>

Johannes Sixt wrote:
> Am 05.11.2011 16:37, schrieb Johannes Sixt:
>> Commit f696543d (Add strtoimax() compatibility function) introduced an
>> implementation of the function, but forgot to add a declaration.
> 
> On second thought, I'm puzzled: Without this patch and without noticing
> the warning that strtoimax() was not declared, I had built with
> NO_STRTOUMAX on MinGW before, and the build succeeded. This means that
> even though MinGW's headers are not C99, we must have pulled in function
> strtoimax() from somewhere. I'll investigate later this weekend.

Yes, I've noticed the same thing, viz:

    ramsay (pu)$ find /mingw/include -type f | xargs egrep 'strto(imax|umax|ull)'
    /mingw/include/inttypes.h:intmax_t __cdecl __MINGW_NOTHROW strtoimax (const char
    * __restrict__ nptr,
    /mingw/include/inttypes.h:uintmax_t __cdecl __MINGW_NOTHROW strtoumax (const cha
    r* __restrict__ nptr,
    /mingw/include/stdlib.h:unsigned long long  __cdecl __MINGW_NOTHROW strtoull (co
    nst char* __restrict__, char** __restrict__, int);

    ramsay (pu)$ nm /mingw/lib/libmingwex.a | egrep 'strto(imax|umax|ull)'
    strtoimax.o:
    00000000 T _strtoimax
    strtoumax.o:
    00000000 T _strtoull
    00000000 T _strtoumax

    ramsay (pu)$

So, I assume, an earlier version of MinGW did not have the inttypes.h header
file and the NO_STRTOUMAX etc. settings are stale; dunno ;-)

In any event, I guess an '#include <inttypes.h>' on MinGW will be part of the
solution. [Without breaking the MSVC build, of course; see the NO_INTTYPES_H
make variable.] However, I haven't given it too much thought, so take that with
a bucket of salt!

Note, also, that very similar comments apply to NO_LIBGEN_H; viz:

    ramsay (pu)$ find /mingw/include -type f | xargs egrep 'char \*(dir|base)name'
    /mingw/include/libgen.h:extern __cdecl __MINGW_NOTHROW char *basename (char *);
    /mingw/include/libgen.h:extern __cdecl __MINGW_NOTHROW char *dirname  (char *);

    ramsay (pu)$ nm /mingw/lib/libmingwex.a | egrep '(dir|base)name'
    basename.o:
    00000000 T _basename
    dirname.o:
    00000000 T _dirname

    ramsay (pu)$

[having said that, I have a patch that adds a compat/dirname.c and modifies
the existing compat/basename.c; the MinGW dirname()/basename() functions 
have problems.]

HTH

ATB,
Ramsay Jones
