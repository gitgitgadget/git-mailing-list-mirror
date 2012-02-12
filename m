From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: [PATCH] Re: 1.7.9, libcharset missing from EXTLIBS
Date: Sun, 12 Feb 2012 17:23:36 +0100
Message-ID: <4F37E788.7030202@aegee.org>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org> <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com> <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org> <7vd39mph9x.fsf@alter.siamese.dyndns.org> <4F370DE5.70400@aegee.org> <7vfwegl4x8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030808010300070602020408"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 17:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwcDQ-0002wX-LI
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 17:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2BLQXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 11:23:48 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:33166 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487Ab2BLQXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 11:23:47 -0500
Received: from smtp.aegee.org (aegeeserv.aegee.uni-karlsruhe.de [129.13.131.80])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1RwcDH-0007iu-HF; Sun, 12 Feb 2012 17:23:43 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
Received: from [192.168.2.104] (p4FDCFE97.dip.t-dialin.net [79.220.254.151])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.5/8.14.5) with ESMTP id q1CGNfqU018671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 12 Feb 2012 16:23:42 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <7vfwegl4x8.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: clamav-milter 0.97.3 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190579>

This is a multi-part message in MIME format.
--------------030808010300070602020408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function locale_charset might appear in libiconv as local symbol.  In
this case linking with -lcharset delivers locale_charset, when the function
is exported from that library.  This patch defines a new Autoconf/make
variable CHARSET_LIB to contain the library exporting locale_charset and
fixes configure.ac to fill CHARSET_LIB with " -lcharset", when
locale_charset is not exported from libiconv, but is exported from
libcharset, and amends EXTLIBS to include CHARSET_LIB when HAVE_LIBCHARSET_H
is defined.

Signed-off-by: Дилян Палаузов <git-dpa@aegee.org>
---
 Makefile      |    6 ++++++
 config.mak.in |    1 +
 configure.ac  |   10 ++++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 87fb30a..571d864 100644
--- a/Makefile
+++ b/Makefile
@@ -56,6 +56,11 @@ all::
 # FreeBSD can use either, but MinGW and some others need to use
 # libcharset.h's locale_charset() instead.
 #
+# Define CHARSET_LIB to contain the additional library exporting the symbol
+# locale_charset to link against.  configure.ac checks if locale_charset is
+# exported from libiconv, if not, it checks if locale_charset is
exported from
+# libcharset and defines then CHARSET_LIB to -lcharset .
+#
 # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
 # need -lintl when linking.
 #
@@ -1698,6 +1703,7 @@ endif

 ifdef HAVE_LIBCHARSET_H
 	BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
+	EXTLIBS +=$(CHARSET_LIB)
 endif

 ifdef HAVE_DEV_TTY
diff --git a/config.mak.in b/config.mak.in
index 10698c8..b2ba710 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -74,3 +74,4 @@ SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
 PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
 PTHREAD_LIBS=@PTHREAD_LIBS@
+CHARSET_LIB=@CHARSET_LIB@
diff --git a/configure.ac b/configure.ac
index 630dbdd..1c21a5b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -836,6 +836,16 @@ AC_CHECK_HEADER([libcharset.h],
 [HAVE_LIBCHARSET_H=YesPlease],
 [HAVE_LIBCHARSET_H=])
 AC_SUBST(HAVE_LIBCHARSET_H)
+# Define CHARSET_LIB if libiconv does not export the locale_charset symbol
+# and libcharset does
+CHARSET_LIB=
+AC_CHECK_LIB([iconv], [locale_charset],
+       [],
+       [AC_CHECK_LIB([charset], [locale_charset],
+                     [CHARSET_LIB=" -lcharset"])
+       ]
+)
+AC_SUBST(CHARSET_LIB)
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
-- 
1.7.9



On 12.02.2012 11:30, Junio C Hamano wrote:
> Дилян Палаузов  <dilyan.palauzov@aegee.org> writes:
> 
>> diff -u git-1.7.9.orig/config.mak.in git-1.7.9/config.mak.in
>> --- git-1.7.9.orig/config.mak.in        2012-01-27 20:51:04.000000000 +0000
>> +++ git-1.7.9/config.mak.in     2012-02-12 00:52:41.457968080 +0000
>> @@ -74,3 +74,4 @@
>>  NO_PTHREADS=@NO_PTHREADS@
>>  PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
>>  PTHREAD_LIBS=@PTHREAD_LIBS@
>> +LINK_CHARSET=@LINK_CHARSET@
>> diff -u git-1.7.9.orig/configure.ac git-1.7.9/configure.ac
>> --- git-1.7.9.orig/configure.ac 2012-01-27 20:51:04.000000000 +0000
>> +++ git-1.7.9/configure.ac      2012-02-12 00:44:29.222967868 +0000
>> @@ -836,6 +836,18 @@
>>  [HAVE_LIBCHARSET_H=YesPlease],
>>  [HAVE_LIBCHARSET_H=])
>>  AC_SUBST(HAVE_LIBCHARSET_H)
>> +# Define LINK_LIBCHARSET if libiconv does not export the
> 
> Because the use of configure is optional in our build infrastructure, I
> wouldn't have objected if this comment were missing from configure.ac, but
> the new variable *must* be described in Makefile (see the top 250 lines or
> so of that file).
> 
> I also need to point out that LINK_LIBCHARSET does not sit very well with
> the way how existing Makefile variables are named. Perhaps make the new
> variable contain the necessary string ("-lcharset" in your case), and name
> it CHARSET_LIB or something?  By doing so, when we find a platform that
> has the necessary locale_charset() not in libcharset.{a,so} but somewhere
> else, e.g. libxyzzy.a, we can accomodate it with "CHARSET_LIB = -lxyzzy".
> 
> Thanks.  Also as Ævar pointed out, please do not forget to sign off your
> patch.

--------------030808010300070602020408
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
--------------030808010300070602020408--
