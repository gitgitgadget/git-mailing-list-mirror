From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 11:36:56 +0200
Message-ID: <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:37:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3Kh-0007fY-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab3ILJg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:36:59 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56324 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3ILJg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:36:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so669409lbh.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RO7NWFaLe9us9h/H7rErOl6An2RfAk9XP15euxfJPrE=;
        b=BWt6PiMYT1cxAKpRGd8eTkshgYSO4JbczE5U1kddi3mTVgahpU91RvIHfNqFQk3XpB
         xf4oXhKpIS6ZiK33AN3PKKQ2wmsN9mHCBBxmt0Qqtkeo3TBWyqkeQxBb46QKkN05BwNI
         e8DSbnRRv6TVzTorN+1b5zk0dHxl+VlTBrKLh9BomKJXpVIubib8BsT6zP2XOIi/1vIp
         E6IAXC3nqoo9V70h1M6JBCdvMSOGBZPi9A8KbnkD6H8j+yR77GSyE0uMaEYqILl2gMGp
         NWOvGtgQPykPwCshsTqOlz9xdZkxw0gMuZCOSflSShlhQCKinLPk+6JdRS8bHRDEnVs2
         v0ow==
X-Received: by 10.112.159.166 with SMTP id xd6mr6671055lbb.22.1378978616814;
 Thu, 12 Sep 2013 02:36:56 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 12 Sep 2013 02:36:56 -0700 (PDT)
In-Reply-To: <20130911214116.GA12235@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234634>

On Wed, Sep 11, 2013 at 11:41 PM, Jeff King <peff@peff.net> wrote:

>> I'm on Windows using MSYS / MinGW. Since MinGW runtime version 4.0,
>> string.h contains the following code (see [1]):
>>
>> #ifndef __NO_INLINE__
>> __CRT_INLINE int __cdecl __MINGW_NOTHROW
>> strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
>> {return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}
>> #else
>> #define strncasecmp _strnicmp
>> #endif
>
> What is the error the compiler reports? Can it take the address of other

The error message of GCC 4.8.1 is:

    LINK git-credential-store.exe
libgit.a(mailmap.o): In function `read_mailmap':
C:\mingwGitDevEnv\git/mailmap.c:238: undefined reference to `strcasecmp'
collect2.exe: error: ld returned 1 exit status
make: *** [git-credential-store.exe] Error 1

So it's a linker error, not a compiler error.

> inline functions? For example, can it compile:
>
>     inline int foo(void) { return 5; }
>     extern int bar(int (*cb)(void));
>     int call(void) { return bar(foo); }

I had to modify the example slightly to:

inline int foo(void) { return 5; }
extern int bar(int (*cb)(void)) { return cb(); }
int main(void) { return bar(foo); }

And this compiles.

> Just wondering if that is the root of the problem, or if maybe there is
> something else subtle going on. Also, does __CRT_INLINE just turn into
> "inline", or is there perhaps some other pre-processor magic going on?

This is the function definition from string.h after preprocessing:

extern __inline__ int __attribute__((__cdecl__)) __attribute__ ((__nothrow__))
strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
  {return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}

-- 
Sebastian Schuberth
