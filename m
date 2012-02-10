From: Dilyan Palauzov <Dilyan.Palauzov@aegee.org>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 20:52:42 +0100
Message-ID: <20120210205242.Horde.Ip6kLu3yGeFPNXWKXsdW3wA@webmail.aegee.org>
References: <4F3472F4.4060605@aegee.org>
 <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; DelSp=Yes
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 20:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwWg-0006fm-CG
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760019Ab2BJTwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:52:53 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:36926 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759958Ab2BJTwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:52:53 -0500
Received: from AEGEEserv.aegee.uni-karlsruhe.de (aegeeserv.aegee.uni-karlsruhe.de [129.13.131.80])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1RvwWY-0002AC-Lc; Fri, 10 Feb 2012 20:52:50 +0100
Received: from localhost (localhost [127.0.0.1])
	(authenticated bits=0)
	by AEGEEserv.aegee.uni-karlsruhe.de (8.14.5/8.14.5) with ESMTP id q1AJqgmp023869
	for <git@vger.kernel.org>; Fri, 10 Feb 2012 19:52:43 GMT
Received: from rz-a-154.stud.uni-karlsruhe.de
 (rz-a-154.stud.uni-karlsruhe.de [172.21.71.20]) by webmail.aegee.org (Horde
 Framework) with HTTP; Fri, 10 Feb 2012 20:52:42 +0100
In-Reply-To: <7vipjer0yn.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.18)
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.97.3 at aegeeserv
X-Virus-Status: Clean
X-Aegee-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=ham version=3.3.2
X-Aegee-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
X-Aegee-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	aegeeserv.aegee.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190442>

Hello,

on my system locale_charset is included in libiconv as local symbol  
and thus linking with -liconv is not sufficient.

   nm /usr/lib64/libiconv.so.2.5.1 | grep locale
   0000000000012694 t locale_charset

whereas in libcharset the symbol is global:

   nm /usr/lib64/libcharset.so.1 |grep locale
   0000000000000c50 T locale_charset

looking at libiconv-1.4/lib/Makefile.in there is written

SOURCES = $(srcdir)/iconv.c $(srcdir)/../libcharset/lib/localcharset.c  
$(srcdir)/relocatable.c

OBJECTS = iconv.lo localcharset.lo relocatable.lo  
$(OBJECTS_EXP_@WOE32DLL@) $(OBJECTS_RES_@WOE32@)

libiconv.la : $(OBJECTS)
         $(LIBTOOL_LINK) $(CC) $(LDFLAGS) $(CFLAGS) -o libiconv.la  
-rpath $(libdir) -version-info $(LIBICONV_VERSION_INFO) -no-undefined  
$(OBJECTS)

this means, that libiconv.la includes $(OBJECTS) and thus  
libiconv-1.4/libcharset/lib/localecharset.c .

In libiconv-1.4/libcharset/lib/localecharset.c is written

#ifdef STATIC
STATIC
#endif
const char *
locale_charset (void) { ...}

and the preliminary localcharset.o still has locale_charset as global symbol:

libiconv-1.14/lib/.libs # nm localcharset.o |grep locale
0000000000000000 T locale_charset

Digging further, in libiconv-1.4/include/iconv.h some functions are  
prefixed with LIBICONV_DLL_EXPORTED , which is the same as
#define LIBICONV_DLL_EXPORTED  
__attribute__((__visibility__("default"))) , all the rest including  
locale_charset is compiled with  
__attribute__((__visibility__("hidden"))), and hence locale_charset is  
not exported from libiconv.

Greetings
   Dilian


----- Message from Дилян Палаузов <dilyan.palauzov@aegee.org> ---------
    Date: Fri, 10 Feb 2012 02:29:24 +0100
    From: Дилян Палаузов <dilyan.palauzov@aegee.org>
Subject: 1.7.9, libcharset missing from EXTLIBS
      To: git@vger.kernel.org


> Hello,
>
> git 1.7.9 makes use of libcharset and /Makefile contains:
>
> ifdef HAVE_LIBCHARSET_H
>         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
> endif
>
> when building git-daemon., the compiler reports
> make V=1
> cc  -I. -DUSE_LIBPCRE -pthread -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H  
> -DHAVE_DEV_TTY -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -o  
> git-daemon -L/usr/lib64 -L/lib64  daemon.o libgit.a xdiff/lib.a   
> -lpcre -lz  -liconv  -lcrypto -pthread
> /tmp/ccvPEthi.ltrans0.ltrans.o: In function `main':
> ccvPEthi.ltrans0.o:(.text.startup+0x59): undefined reference to  
> `locale_charset'
> collect2: ld returned 1 exit status
> make: *** [git-daemon] Error 1
>
>
> and the problem is, that libcharset is not used when linking.  To  
> solve this, please replace the above extract from /Makefile with
>
> ifdef HAVE_LIBCHARSET_H
>         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
> 	EXTLIBS += -lcharset
> endif
>
> Със здраве
>   Дилян


----- End message from Дилян Палаузов <dilyan.palauzov@aegee.org> -----
