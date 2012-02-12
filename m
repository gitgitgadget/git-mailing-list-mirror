From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Sun, 12 Feb 2012 01:55:01 +0100
Message-ID: <4F370DE5.70400@aegee.org>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org> <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com> <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org> <7vd39mph9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080309090605030900050701"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 01:55:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNjF-0001S6-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2BLAzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 19:55:12 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:44143 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2BLAzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:55:11 -0500
Received: from smtp.aegee.org (aegeeserv.aegee.uni-karlsruhe.de [129.13.131.80])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1RwNid-0005Xv-JH; Sun, 12 Feb 2012 01:55:07 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
Received: from [192.168.2.104] (p4FDCFE97.dip.t-dialin.net [79.220.254.151])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.5/8.14.5) with ESMTP id q1C0t8tN017452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 12 Feb 2012 00:55:09 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <7vd39mph9x.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: clamav-milter 0.97.3 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190555>

This is a multi-part message in MIME format.
--------------080309090605030900050701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

please consider the patch below as fix for the problem.  It checks if 
locale_charset is not in libiconv, but in libcharset and in this case 
appends -lcharset to EXTLIBS.

Със здраве
   Дилян

diff -u git-1.7.9.orig/config.mak.in git-1.7.9/config.mak.in
--- git-1.7.9.orig/config.mak.in        2012-01-27 20:51:04.000000000 +0000
+++ git-1.7.9/config.mak.in     2012-02-12 00:52:41.457968080 +0000
@@ -74,3 +74,4 @@
  NO_PTHREADS=@NO_PTHREADS@
  PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
  PTHREAD_LIBS=@PTHREAD_LIBS@
+LINK_CHARSET=@LINK_CHARSET@
diff -u git-1.7.9.orig/configure.ac git-1.7.9/configure.ac
--- git-1.7.9.orig/configure.ac 2012-01-27 20:51:04.000000000 +0000
+++ git-1.7.9/configure.ac      2012-02-12 00:44:29.222967868 +0000
@@ -836,6 +836,18 @@
  [HAVE_LIBCHARSET_H=YesPlease],
  [HAVE_LIBCHARSET_H=])
  AC_SUBST(HAVE_LIBCHARSET_H)
+# Define LINK_LIBCHARSET if libiconv does not export the locale_charset 
symbol
+# and liblibcharset does
+LINK_CHARSET=
+AC_CHECK_LIB([iconv], [locale_charset],
+       [],
+       [AC_CHECK_LIB([charset], [locale_charset],
+                     [LINK_CHARSET=Yes])
+       ]
+)
+AC_SUBST(LINK_CHARSET)
+
+
  #
  # Define NO_STRCASESTR if you don't have strcasestr.
  GIT_CHECK_FUNC(strcasestr,
diff -u git-1.7.9.orig/Makefile git-1.7.9/Makefile
--- git-1.7.9.orig/Makefile     2012-01-27 20:51:04.000000000 +0000
+++ git-1.7.9/Makefile  2012-02-12 00:35:23.982967555 +0000
@@ -1692,6 +1692,9 @@

  ifdef HAVE_LIBCHARSET_H
         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
+ifdef LINK_CHARSET
+       EXTLIBS += -lcharset
+endif
  endif

  ifdef HAVE_DEV_TTY

On 10.02.2012 21:25, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Дилян Палаузов<dilyan.palauzov@aegee.org>  writes:
>>
>>>>> What I am wondering is there are systems that need to include the header,
>>>>> but locale_charset() does not live in /lib/libcharset.a, in which case we
>>>>> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.
>>>
>>> I do not understand this.  If you want to use a function from
>>> libcharset, you have to use both #include<libcharset.h>  and
>>> -lcharset.
>>
>> You are mistaken.
>>
>> The only constraint is that you have to "#include<libcharset.h>" and need
>> to link with the library that has locale_charset() defined.
>
> I think the follow-ups in this thread already demonstrated why it is an
> insufficient solution to make HAVE_LIBCHARSET_H imply -lcharset.
>
> We would instead need:
>
> 	ifeq ($(uname_S),MyHomeBrewLinux)
>          	HAVE_LIBCHARSET_H = YesPlease
>                  EXTLIBS += -lcharset
> 	endif
>
> or
>
> 	# Define NEEDS_CHARSETLIB if you use HAVE_LIBCHARSET_H and
>          # need to link with -lcharset
> 	NEEDS_CHARSETLIB =
>
> 	ifeq ($(uname_S),MyHomeBrewLinux)
>          	HAVE_LIBCHARSET_H = YesPlease
> 		NEEDS_CHARSETLIB = YesPlease
> 	endif
>
> 	ifdef NEEDS_CHARSETLIB
>          	EXTLIBS += -lcharset
> 	endif
>
> or something like that, I guess.
>

--------------080309090605030900050701
Content-Type: text/x-vcard; charset=utf-8;
 name="dilyan_palauzov.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dilyan_palauzov.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUQwPTk0PUQwPUI4PUQwPUJCPUQx
PThGPUQwPUJEID1EMD05Rj1EMD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT0N
Cgk9RDA9QjINCm47cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOj1EMD05Rj1E
MD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT1EMD1CMjs9RDA9OTQ9RDA9Qjg9
RDA9QkI9RDE9OEY9RDA9QkQNCmVtYWlsO2ludGVybmV0OmRpbHlhbi5wYWxhdXpvdkBhZWdl
ZS5vcmcNCnRlbDtob21lOis0OS03MjEtOTQxOTMyNzANCnRlbDtjZWxsOis0OS0xNjItNDA5
MTE3Mg0Kbm90ZTpzaXA6ODM3MkBhZWdlZS5vcmcNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQN
Cg0K
--------------080309090605030900050701--
