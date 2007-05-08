From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-fetch Segmentation fault
Date: Tue, 08 May 2007 13:04:47 -0700
Message-ID: <7vfy672iao.fsf@assigned-by-dhcp.cox.net>
References: <20070508162735.6c530a70@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, boiko@mandriva.com.br
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Tue May 08 22:05:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVvc-0005rY-W2
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031941AbXEHUEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031897AbXEHUEv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:04:51 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48461 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031938AbXEHUEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:04:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508200447.HZZR13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 16:04:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wk4n1W0051kojtg0000000; Tue, 08 May 2007 16:04:47 -0400
In-Reply-To: <20070508162735.6c530a70@localhost> (Luiz Fernando
	N. Capitulino's message of "Tue, 8 May 2007 16:27:35 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46616>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> escreveu:

>  A friend of mine reported an easy to reproduce segmentation fault
> when cloning through http from his repository:
>
> """
> ~/ git clone http://people.mandriva.com/~boiko/mandrivamenu.git
> got 299cdadd846913a052df361e973a947622f23198
> walk 299cdadd846913a052df361e973a947622f23198
> ...
> got 0ecd10d9d6ab020c2469a961777854afda705776
> /home/lcapitulino/git//bin/git-clone: line 33: 22353 Segmentation fault      (core dumped) git-http-fetch $v -a -w "$tname" "$sha1" "$1"
> """
>
>  Sometimes it shows up as a corrupted double-linked list, detected by
> glibc:

Does not seem to reproduce for me on my x86_64 box nor an i386
box I happened to have access to.  Both run Debian etch.

Here is an excerpt from a valgrind run on the x86_64 box.  It
does seem to find a handful "problematic" accesses, but all seem
to be in the system libraries.  I did not get any errors on the
i386 box.

: gitster v/master; valgrind git-http-fetch -v -a -w remotes/origin/master 299cdadd846913a052df361e973a947622f23198 http://people.mandriva.com/~boiko/mandrivamenu.git/

==2120== Conditional jump or move depends on uninitialised value(s)
==2120==    at 0x4010AEE: (within /lib/ld-2.3.6.so)
==2120==    by 0x4006CB6: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==    by 0x51B7C06: getaddrinfo (in /lib/libc-2.3.6.so)
==2120==    by 0x4ED31E2: (within /usr/lib/libcurl.so.3.0.0)
==2120== 
==2120== Conditional jump or move depends on uninitialised value(s)
==2120==    at 0x4010AF9: (within /lib/ld-2.3.6.so)
==2120==    by 0x4006CB6: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==    by 0x51B7C06: getaddrinfo (in /lib/libc-2.3.6.so)
==2120==    by 0x4ED31E2: (within /usr/lib/libcurl.so.3.0.0)
==2120== 
==2120== Conditional jump or move depends on uninitialised value(s)
==2120==    at 0x4010B04: (within /lib/ld-2.3.6.so)
==2120==    by 0x4006CB6: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==    by 0x51B7C06: getaddrinfo (in /lib/libc-2.3.6.so)
==2120==    by 0x4ED31E2: (within /usr/lib/libcurl.so.3.0.0)
==2120== 
==2120== Conditional jump or move depends on uninitialised value(s)
==2120==    at 0x4010C61: (within /lib/ld-2.3.6.so)
==2120==    by 0x4006E47: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==    by 0x51B7C06: getaddrinfo (in /lib/libc-2.3.6.so)
==2120==    by 0x4ED31E2: (within /usr/lib/libcurl.so.3.0.0)
==2120== 
==2120== Invalid read of size 8
==2120==    at 0x4010C54: (within /lib/ld-2.3.6.so)
==2120==    by 0x4008D38: (within /lib/ld-2.3.6.so)
==2120==    by 0x4004CF2: (within /lib/ld-2.3.6.so)
==2120==    by 0x4006D6C: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==  Address 0x5F096F0 is 16 bytes inside a block of size 23 alloc'd
==2120==    at 0x4A1B858: malloc (vg_replace_malloc.c:149)
==2120==    by 0x4007113: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FF260: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x51FECF7: _dl_open (in /lib/libc-2.3.6.so)
==2120==    by 0x5201497: (within /lib/libc-2.3.6.so)
==2120==    by 0x400B7D0: (within /lib/ld-2.3.6.so)
==2120==    by 0x52014E1: __libc_dlopen_mode (in /lib/libc-2.3.6.so)
==2120==    by 0x51DC456: __nss_lookup_function (in /lib/libc-2.3.6.so)
==2120==    by 0x51B6FCE: (within /lib/libc-2.3.6.so)
==2120==    by 0x51B7C06: getaddrinfo (in /lib/libc-2.3.6.so)
==2120==    by 0x4ED31E2: (within /usr/lib/libcurl.so.3.0.0)
...
==2120== 
==2120== IN SUMMARY: 6 errors from 5 contexts (suppressed: 9 from 1)
==2120== 
