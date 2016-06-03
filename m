From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] regex: fix a SIZE_MAX macro redefinition warning
Date: Sat, 4 Jun 2016 00:29:35 +0100
Message-ID: <575212DF.90209@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:29:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yXE-0004le-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbcFCX3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 19:29:45 -0400
Received: from avasout04.plus.net ([212.159.14.19]:56036 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcFCX3n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:29:43 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 2PVc1t0045VX2mk01PVdzh; Sat, 04 Jun 2016 00:29:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=8Jlqrp-XWLw1LHWrE3kA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296427>


Since commit 56a1a3ab ("Silence GCC's \"cast of pointer to integer of a
different size\" warning", 26-10-2015), sparse has been issuing a macro
redefinition warning for the SIZE_MAX macro. However, gcc did not issue
any such warning.

After commit 56a1a3ab, in terms of the order of #includes and #defines,
the code looked something like:

  $ cat -n junk.c
       1	#include <stddef.h>
       2
       3	#define SIZE_MAX ((size_t) -1)
       4
       5	#include <stdint.h>
       6
       7	int main(int argc, char *argv[])
       8	{
       9		return 0;
      10	}
  $
  $ gcc junk.c
  $

However, if you compile that file with -Wsystem-headers, then it will
also issue a warning. Having set -Wsystem-headers in CFLAGS, using the
config.mak file, then (on cygwin):

  $ make compat/regex/regex.o
      CC compat/regex/regex.o
  In file included from /usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h:9:0,
                   from compat/regex/regcomp.c:21,
                   from compat/regex/regex.c:77:
  /usr/include/stdint.h:362:0: warning: "SIZE_MAX" redefined
   #define SIZE_MAX (__SIZE_MAX__)
   ^
  In file included from compat/regex/regex.c:69:0:
  compat/regex/regex_internal.h:108:0: note: this is the location of the previous definition
   # define SIZE_MAX ((size_t) -1)
   ^
  $

The compilation of the compat/regex code is somewhat unusual in that the
regex.c file directly #includes the other c files (regcomp.c, regexec.c
and regex_internal.c). Commit 56a1a3ab added an #include of <stdint.h>
to the regcomp.c file, which results in the redefinition, since this is
included after the regex_internal.h header. This header file contains a
'fallback' definition for SIZE_MAX, in order to support systems which do
not have the <stdint.h> header (the HAVE_STDINT_H macro is not defined).

In order to suppress the warning, we remove the #include of <stdint.h>
from regcomp.c and set the HAVE_STDINT_H macro, using the regex.o build
rule within the Makefile, to ensure that <stdint.h> is #included from
the regex_internal.h header.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

About seven months ago, sparse started complaining but, because gcc wasn't, I
just assumed this was a sparse bug. I put it on my sparse TODO list and pretty
much forgot about it. Tonight I decided to take a quick look and was a bit
surprised by what I found. ;-)

I spent some time worrying about the 'unconditional inclusion' of <stdint.h>
(there used to be systems that didn't supply that header that we wanted to
support), but I suspect that is now a non-issue. In any event, I don't
think this patch makes things any worse.

[Just a flavour of the rabbit holes I went down; HP-NONSTOP seems to supply
both <inttypes.h> and <stdint.h> but it doesn't supply the intptr_t and
uintptr_t types (ie it defines NO_INTPTR_T). So, I checked the C99 and C11
standards and, blow me down, but the standard states that those types are
_optional_. (C99 7.18.1.4) :-D ]

ATB,
Ramsay Jones

 Makefile               | 2 +-
 compat/regex/regcomp.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0d59718..3f6c70a 100644
--- a/Makefile
+++ b/Makefile
@@ -1987,7 +1987,7 @@ endif
 
 ifdef NO_REGEX
 compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
-	-DGAWK -DNO_MBSUPPORT
+	-DGAWK -DNO_MBSUPPORT -DHAVE_STDINT_H
 endif
 
 ifdef USE_NED_ALLOCATOR
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index fba5986..d8bde06 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -18,8 +18,6 @@
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301 USA.  */
 
-#include <stdint.h>
-
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
-- 
2.8.0
