From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-http: use argv-array
Date: Tue, 9 Jul 2013 02:38:40 -0400
Message-ID: <20130709063840.GA8015@sigill.intra.peff.net>
References: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org>
 <CAKPyHN0DG0c2vxWtybYtDmFKMo369PZcbqCfDJaXeiRV+PP8pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 08:38:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwRZY-0004Vd-5p
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 08:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab3GIGio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 02:38:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:36153 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab3GIGin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 02:38:43 -0400
Received: (qmail 8090 invoked by uid 102); 9 Jul 2013 06:39:59 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 01:39:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 02:38:40 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN0DG0c2vxWtybYtDmFKMo369PZcbqCfDJaXeiRV+PP8pQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229919>

On Tue, Jul 09, 2013 at 08:05:19AM +0200, Bert Wesarg wrote:

> > +       argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status");
> 
> missing NULL sentinel. GCC has the 'sentinel' [1] attribute to catch
> such errors. Or use macro magic:
> 
> void argv_array_pushl_(struct argv_array *array, ...);
> #define argv_array_pushl(array, ...) argv_array_pushl_(array, __VA_ARGS__, NULL)

Nice catch. We cannot use variadic macros, because we support pre-C99
compilers that do not have them. But the sentinel attribute is a good
idea. Here's a patch.

-- >8 --
Subject: [PATCH] argv-array: add sentinel attribute to argv_array_pushl

This attribute can help gcc notice when callers forget to add a
NULL sentinel to the end of the function. We shouldn't need
to #ifdef for other compilers, as __attribute__ is already a
no-op on non-gcc-compatible compilers.

Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This is our first use of an __attribute__ that is not "noreturn" or
"format". I assume this one should be supported on other gcc-compatible
compilers like clang.

 argv-array.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/argv-array.h b/argv-array.h
index 40248d4..e805748 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -15,6 +15,7 @@ void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 void argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+__attribute__((sentinel))
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
-- 
1.8.3.rc3.24.gec82cb9
