From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] sparse: avoid sse2 code which renders sparse useless
Date: Wed, 23 Jul 2014 20:09:31 +0100
Message-ID: <53D0086B.4090309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1v3-0005ha-IG
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbaGWTJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:09:37 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:50663 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932514AbaGWTJh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:09:37 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D990BA64B07;
	Wed, 23 Jul 2014 19:03:40 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 900BCA64AFF;
	Wed, 23 Jul 2014 19:03:40 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Wed, 23 Jul 2014 19:03:40 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254110>


Commit 745224e0 ("refs.c: SSE2 optimizations for check_refname_\
component", 18-06-2014) introduces (on x86_64) the use of sse2
code, and associated header files, to optimize some reference
handling code. This causes sparse to implode and exit with "too
many errors", among other things, while attempting to parse the
code contained in those headers. For example, the following shows
just the last few messages:

    $ make abspath.sp
    ...
    /usr/lib/gcc/x86_64-pc-cygwin/4.8.3//include/mmintrin.h:724:38: error:
    attribute '__gnu_inline__': unknown attribute
    /usr/lib/gcc/x86_64-pc-cygwin/4.8.3//include/mmintrin.h:732:38: error:
    too many errors
    /usr/lib/gcc/x86_64-pc-cygwin/4.8.3//include/xmmintrin.h:91:34: error:
    constant 0.0f is not a valid number
    Makefile:2297: recipe for target 'abspath.sp' failed
    make: *** [abspath.sp] Error 1
    $

The most numerous errors (about 100 for the above file) relate to
the use of the __gnu_inline__ attribute. A simple 'one line' patch
to sparse (actually it is three lines), can fix this up without too
much problem. However, the final error above is not as simple (and
quick) to fix. The code in question (.../xmmintrin.h:91), looks
like this:

    return __extension__ (__m128){ 0.0f, 0.0f, 0.0f, 0.0f };

Until sparse learns to parse this gcc extension (if ever), we can avoid
the issue by simply not attempting to parse this code. In order to do
this, use the preprocessor symbol __CHECKER__, automatically defined by
sparse, in the #if conditional already used to guard the code.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I've been sitting on this patch for some time, while I try to
gauge how long it would take to fix sparse to cope with this
vectorised code. Unfortunately, it would probably require adding
a considerable amount of code to add the same level of support
for __SSE__, __SSE2__, __MMX__, etc, that gcc provides.

This is marked RFC, because this would be the first use of
__CHECKER__ in the git code-base. I have been cherry-picking
this on top of any branch I want to check. At first this
wasn't too much of a hassle, but now commit 745224e0 has
progressed to master ... (last night I cherry-picked this
patch approx a dozen times, so I was getting a little
irritated! :D ).

ATB,
Ramsay Jones

 git-compat-util.h | 2 +-
 refs.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 26e92f1..1aae883 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -731,7 +731,7 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
-#if defined(__GNUC__) && defined(__x86_64__)
+#if defined(__GNUC__) && defined(__x86_64__) && !defined(__CHECKER__)
 #include <emmintrin.h>
 /*
  * This is the system memory page size; it's used so that we can read
diff --git a/refs.c b/refs.c
index 84b9070..ffd4016 100644
--- a/refs.c
+++ b/refs.c
@@ -124,7 +124,7 @@ static int check_refname_format_bytewise(const char *refname, int flags)
 	return 0;
 }
 
-#if defined(__GNUC__) && defined(__x86_64__)
+#if defined(__GNUC__) && defined(__x86_64__) && !defined(__CHECKER__)
 #define SSE_VECTOR_BYTES 16
 
 /* Vectorized version of check_refname_format. */
-- 
2.0.0
