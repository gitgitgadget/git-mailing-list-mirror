From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] regex: fix a SIZE_MAX macro redefinition warning
Date: Tue, 7 Jun 2016 01:35:33 +0100
Message-ID: <575616D5.8000008@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 02:35:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA4zh-0006tg-De
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbcFGAfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:35:41 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33527 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbcFGAfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 20:35:40 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 3cba1t0025VX2mk01cbb9y; Tue, 07 Jun 2016 01:35:37 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296580>


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

In order to suppress the warning, we move the #include of <stdint.h>
from regcomp.c to the start of the compilation unit, close to the top
of regex.c, prior to the #include of the regex_internal.h header.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Change from v1:
	- add the #include <stdint.h> to the top of regex.c, rather than
	  use HAVE_STDINT_H to 'activate' the conditional inclusion of
	  <stdint.h> in the regex_internal.h header.

Junio and Johannes - thanks for the feedback on v1 of the patch.

ATB,
Ramsay Jones

 compat/regex/regcomp.c | 2 --
 compat/regex/regex.c   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

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
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 6aaae00..5cb23e5 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -60,6 +60,7 @@
    GNU regex allows.  Include it before <regex.h>, which correctly
    #undefs RE_DUP_MAX and sets it to the right value.  */
 #include <limits.h>
+#include <stdint.h>
 
 #ifdef GAWK
 #undef alloca
-- 
2.8.0
