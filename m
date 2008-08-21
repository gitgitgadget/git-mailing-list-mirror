From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] compat/snprintf.c: handle snprintf's that always return the
 # chars transmitted
Date: Wed, 20 Aug 2008 20:53:50 -0500
Message-ID: <nYV6zI97uDEOlIEFjH5oAZW1lTFm0mOVlTrIxzRyOY5CCrUJw7ROgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVzO3-0005jl-US
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbYHUBxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYHUBxw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:53:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53697 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYHUBxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:53:51 -0400
Received: by mail.nrlssc.navy.mil id m7L1roEq005633; Wed, 20 Aug 2008 20:53:50 -0500
X-OriginalArrivalTime: 21 Aug 2008 01:53:50.0171 (UTC) FILETIME=[C1CFE2B0:01C90330]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93087>

Some platforms provide a horribly broken snprintf. More broken than the
platforms that return -1 when there is too little space in the target buffer
for the formatted string. Some platforms provide an snprintf which _always_
returns the number of characters transmitted to the buffer, regardless of
whether there was enough space or not.

IRIX 6.5 is such a platform. IRIX does have a working snprintf(), but it
is only provided when _NO_XOPEN5 evaluates to zero, and this only happens
if _XOPEN_SOURCE is defined, but definition of _XOPEN_SOURCE prevents
inclusion of many other common functions and defines. So it must be avoided.

Work around these horribly broken snprintf implementations by detecting an
snprintf call which results in the number of transmitted characters exactly
equal to the length of our buffer and retrying with a larger buffer just to
be safe.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---

I was cautious about this change and how it would affect the calling sequence
in strbuf_addf where after an initial failure of vsnprintf, strbuf_grow is
used to increase the strbuf by exactly the number of characters needed and
then vsnprintf is called again.

If strbuf_grow often allocated exactly the number of characters requested,
then the failure code path of git_vsnprintf would be triggered after each
such strbuf_grow. The result of git_vsnprintf would still be successful,
but an unnecessary malloc and vsnprintf would be called.

Thanks to ALLOC_GROW, I don't think it is common for strbuf_grow to allocate
exactly the number of characters that are requested. That is if the test
suite is any indication.

I ran the test suite and counted how many times git_vsnprintf was called,
and how many times the return of the first vsnprintf was equal to maxsize-1.

    379056: git_vsnprintf called
      2954: ret == maxsize-1 happened (meaning possible failure, but possibly
                                       a buffer exactly the right size)

    failure code path .779%

Out of the 379056 times that git_vsnprintf was called during the tests, it
was only 2954 of those times that the initial vsnprintf returned maxsize-1.

That compares to this count on linux (more tests enabled):

    405135: git_vsnprintf called
      3609: ret >= maxsize (meaning called with buffer too small)
        68: ret == maxsize-1 happened (buffer exactly the right size)

    failure code path .891%

So, it doesn't seem like it is necessary to complicate this change with more
Makefile options like SNPRINTF_RETURNS_CRAP and then protect the additions
below with preprocessor tests. But that can be done.

-brandon


 compat/snprintf.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 580966e..357e733 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -17,6 +17,8 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 
 	if (maxsize > 0) {
 		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		if (ret == maxsize-1)
+			ret = -1;
 		/* Windows does not NUL-terminate if result fills buffer */
 		str[maxsize-1] = 0;
 	}
@@ -34,6 +36,8 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 			break;
 		s = str;
 		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		if (ret == maxsize-1)
+			ret = -1;
 	}
 	free(s);
 	return ret;
-- 
1.6.0.13.ge1c8
