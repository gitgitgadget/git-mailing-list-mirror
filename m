From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 14:47:52 +0200
Message-ID: <CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 14:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKSn0-0001KV-HR
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 14:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab3IMMry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 08:47:54 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:63217 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3IMMrx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 08:47:53 -0400
Received: by mail-la0-f51.google.com with SMTP id lv10so981002lab.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mUvYeKiFpyKRgqdkVldZylUw+Y5xOR80B7tZnVd+vRY=;
        b=qxyD8KDu3X/H++u04DjHJMLHHQSEAHjznjUlN7idqaNueCkxDG79EkILc+mUJ5TFTJ
         xPze+uW8TkiOj7ZUwrd4etofM91yo6FdWjZbYmrHCC4cze9PEZ6+QuAua7+LyJD7NDuA
         nFt+2JumcO0s3/0sdE3QVWlCsPDds6yeoYzRhSuISsnh6teu0fzj3EEXZ8lQWEJSYmqZ
         7BUKnQ4D119k3/sGsHo1pO2snHDlyUuTsErXDlZP7ACU0mFrOY1NHP+hma1D9yAdyz3E
         dKpWXw3rOt50wvxk4sTRM+az/Wxk2MeJsZJaY4ujjt5qFntP08nfW9YE6GT1iT4Jmoa2
         PJSA==
X-Received: by 10.152.19.1 with SMTP id a1mr10618371lae.8.1379076472492; Fri,
 13 Sep 2013 05:47:52 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Fri, 13 Sep 2013 05:47:52 -0700 (PDT)
In-Reply-To: <xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234751>

On Thu, Sep 12, 2013 at 10:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
>
>> I think there are basically three classes of solution:
>>
>>   1. Declare __NO_INLINE__ everywhere. I'd worry this might affect other
>>      environments, who would then not inline and lose performance (but
>>      since it's a non-standard macro, we don't really know what it will
>>      do in other places; possibly nothing).
>>
>>   2. Declare __NO_INLINE__ on mingw. Similar to above, but we know it
>>      only affects mingw, and we know the meaning of NO_INLINE there.
>>
>>   3. Try to impact only the uses as a function pointer (e.g., by using
>>      a wrapper function as suggested in the thread).
>>
>> Your patch does (1), I believe. Junio's patch does (3), but is a
>> maintenance burden in that any new callsites will need to remember to do
>> the same trick.

Well, if by "everywhere" in (1) you mean "on all platforms" then
you're right. But my patch does not define __NO_INLINE__ globally, but
only at the time string.h / strings.h is included. Afterwards
__NO_INLINE__ is undefined. In that sense, __NO_INLINE__ is not
defined "everywhere".

> Agreed.  If that #define __NO_INLINE__ does not appear in the common
> part of our header files like git-compat-util.h but is limited to
> somewhere in compat/, that would be the perfect outcome.

It's not that easy to move the definition of __NO_INLINE__ into
compat/ because git-compat-util.h includes string.h / strings.h before
anything of compat/. More over, defining __NO_INLINE__ in somewhere in
compat/ would not limit its definition to the string.h / strings.h
headers only. So how about something like this on top of my original
patch:

--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,12 +85,16 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1

+#ifdef __MINGW32__
 #define __NO_INLINE__ /* do not inline strcasecmp() */
+#endif
 #include <string.h>
+#ifdef __MINGW32__
+#undef __NO_INLINE__
+#endif
 #ifdef HAVE_STRINGS_H
 #include <strings.h> /* for strcasecmp() */
 #endif
-#undef __NO_INLINE__

 #ifdef WIN32 /* Both MinGW and MSVC */
 #ifndef _WIN32_WINNT

-- 
Sebastian Schuberth
