From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] trace.h: suppress some sparse warnings and errors
Date: Thu, 03 Jul 2014 23:54:33 +0100
Message-ID: <53B5DF29.6010900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: karsten.blees@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 04 00:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2ptr-00055z-2d
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbaGCWyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 18:54:39 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:41307 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752275AbaGCWyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:54:38 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id B7C5A12809B;
	Thu,  3 Jul 2014 23:54:38 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 70819128089;
	Thu,  3 Jul 2014 23:54:38 +0100 (BST)
Received: from [192.168.254.16] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu,  3 Jul 2014 23:54:37 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252888>


Commit 07896a5c ("trace: improve trace performance", 02-07-2014) added
a 'trace_key' structure to the trace.h header file which provokes sparse
to issue numerous (837) warnings and errors, like so:

        SP abspath.c
    trace.h:8:26: warning: duplicate const
    trace.h:10:29: error: dubious one-bit signed bitfield
    trace.h:11:28: error: dubious one-bit signed bitfield

In order to suppress the warning, we simply remove the redundant
'const' keyword in the declaration of the key field.

The bit-field errors are addressed by changing the declaration to
use an 'unsigned int' type for each bit-field. Note that the C
standard says that using anything other than _Bool, signed int
and unsigned int for the type of a bit-field is implementation
defined. (In addition, the signed-ness of the 'char' type is also
implementation defined).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Karsten,

If you need to re-roll your 'kb/perf-trace' branch, could you
please squash this (or something like it) into the patch which
corresponds to commit 07896a5c. Thanks!

Note that, if you had intended to declare the key field as a
'constant pointer to const char', then that would be spelt
like: 'const char *const key;' instead.

I suspect that most (but maybe not all) compilers support
'unsigned char' bit-field types, which _may_ result in using
a byte-sized storage unit for the two bit-fields combined.
However, because of the alignment requirements of the other
fields, the sizeof(struct trace_key) is 12 for both versions
of the struct ('unsigned int' vs 'unsigned char') on 32-bit
Linux (for both gcc and clang).

If you turn up the compiler warning levels (-Wall -Wextra)
then both gcc and clang complain about missing initialisers
for the trailing structure fields. These fields will be
default initialised to zero anyway, but it also doesn't
hurt to be more explicit.

So, an alternative patch may look like this:

      |diff --git a/trace.h b/trace.h
      |index 74d7396..1a193bf 100644
      |--- a/trace.h
      |+++ b/trace.h
      |@@ -5,13 +5,13 @@
      | #include "strbuf.h"
      | 
      | struct trace_key {
      |-	const char const *key;
      |+	const char *const key;
      | 	int fd;
      |-	char initialized : 1;
      |-	char need_close : 1;
      |+	unsigned int initialized : 1;
      |+	unsigned int need_close : 1;
      | };
      | 
      |-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
      |+#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
      | 
      | extern void trace_repo_setup(const char *prefix);
      | extern int trace_want(struct trace_key *key);

ATB,
Ramsay Jones


 trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/trace.h b/trace.h
index 74d7396..1bbb341 100644
--- a/trace.h
+++ b/trace.h
@@ -5,10 +5,10 @@
 #include "strbuf.h"
 
 struct trace_key {
-	const char const *key;
+	const char *key;
 	int fd;
-	char initialized : 1;
-	char need_close : 1;
+	unsigned int initialized : 1;
+	unsigned int need_close : 1;
 };
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
-- 
2.0.0
