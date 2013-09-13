From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 21:53:04 +0200
Message-ID: <CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 21:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZQW-0005s1-6b
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 21:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3IMTxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 15:53:08 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:44039 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3IMTxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 15:53:06 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so1378054lab.36
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/2e7XwVLylC7g808EhouAG89YosasoCwLtW5VciG6/A=;
        b=nlT2MW9znxQC4AfnmSvsUHiNUPmbXhajAIbZ1wkxqHJxrZhw5Wr7T0soMMambqTwRv
         VkfsK0vAN5Gssktavtlq5RXcHZwfVEG2FzxdSpL+T9CSbrA/lWRS3t2fmAhwt7qkaWcr
         iW0cao+MkmId/hTy15BR3EdqKEqoRntj+U6Os+FQbxaPtEUel9IR3pyuisawhVZIUIk+
         SD1iWcpfiSe7/3+WXCprfm5mEjUsyA/NCUUBS8YikyVcCmENSWgi7jFlNr+FCGf41NHa
         iUHIFHuPqGZkx/pZT82A/MXLZOWQJdL2YxMo54DSn/2nZTqeW1D6i8whtCeaGuUtZKGN
         mv/Q==
X-Received: by 10.112.0.242 with SMTP id 18mr12938980lbh.18.1379101984553;
 Fri, 13 Sep 2013 12:53:04 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 12:53:04 -0700 (PDT)
In-Reply-To: <xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234765>

On Fri, Sep 13, 2013 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Which means people who do want to see that macro defined will be
> broken after that section of the header file which unconditionally
> undefs it, right?

Right, but luckily you've fixed that in our proposed patch :-)

> That is certainly better than the unconditional one, but I wonder if
> it is an option to add compat/mingw/string.h without doing the
> above, though.

I don't like the idea of introducing a compat/mingw/string.h because
of two reasons: You would have to add a conditional to include that
string.h instead of the system one anyway, so we could just as well
keep the conditional in git-compat-util.h along with the logic. And I
don't like the include_next GCC-ism, especially as I was planning to
take a look at compiling Git with LLVM / clang under Windows. So how
about this:

--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,25 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1

+#ifdef __MINGW32__
+#ifdef __NO_INLINE__
+#define __NO_INLINE_ALREADY_DEFINED
+#else
+#define __NO_INLINE__ /* do not inline strcasecmp() */
+#endif
+#endif
+#include <string.h>
+#ifdef __MINGW32__
+#ifdef __NO_INLINE_ALREADY_DEFINED
+#undef __NO_INLINE_ALREADY_DEFINED
+#else
+#undef __NO_INLINE__
+#endif
+#endif
+#ifdef HAVE_STRINGS_H
+#include <strings.h> /* for strcasecmp() */
+#endif
+
 #ifdef WIN32 /* Both MinGW and MSVC */
 #define _WIN32_WINNT 0x0502
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
@@ -99,10 +118,6 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdarg.h>
-#include <string.h>
-#ifdef HAVE_STRINGS_H
-#include <strings.h> /* for strcasecmp() */
-#endif
 #include <errno.h>
 #include <limits.h>
 #ifdef NEEDS_SYS_PARAM_H

-- 
Sebastian Schuberth
