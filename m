From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 21:46:51 +0200
Message-ID: <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 21:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCqv-0007Qo-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3ILTqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:46:53 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:43561 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541Ab3ILTqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:46:52 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so244053lab.19
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9ihX3vOGvA8oZQarcGXSRNt3aNIjCMzeuTNffxpZ/Bs=;
        b=nYQzPnMV7aigkU12+4F6tgcStQrzz6755qYVdnTJQMjZIjOmXHR0E11BsPrBqUJZru
         JakKy8Jophxz0bMlm0w+jFa0p8rNkViORHofspd0/rHPK21pW2GfnuN4Bj9VgU3oD6AJ
         hd0/qExZYEKMAHLAtEbEE5rYygP7IaxlqlBCGuj1TikF2ry66Vn7LECrZupvlHrh8Smf
         2Ly7UUN3CwQqDSiVykMojXoN1LKFGMVMQZ5NM6QJRtWag1t5p+Iy4Skc/vOUzGVmtjUP
         WtEmgVmOxZmezNk9Ok3rUMeytTjaKQv67DtK4DAuKrvu9DEPN4hMoEbUdPZBUF5qjeTg
         88EQ==
X-Received: by 10.152.37.103 with SMTP id x7mr3452913laj.28.1379015211187;
 Thu, 12 Sep 2013 12:46:51 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 12 Sep 2013 12:46:51 -0700 (PDT)
In-Reply-To: <20130912182057.GB32069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234682>

On Thu, Sep 12, 2013 at 8:20 PM, Jeff King <peff@peff.net> wrote:

>> > I wonder if GCC has changed it's behaviour to more closely match C99.
>> > Clang as a compatibility article about this sort of issue:
>> >
>> >     http://clang.llvm.org/compatibility.html#inline
>>
>> Interesting.  The ways the page suggests as fixes are
>>
>>  - change it to a "statis inline";
>>  - remove "inline" from the definition;
>>  - provide an external (non-inline) def somewhere else;
>>  - compile with gnu899 dialect.
>
> Right, option 3 seems perfectly reasonable to me, as we must be prepared
> to cope with a decision not to inline the function, and there has to be
> _some_ linked implementation. But shouldn't libc be providing an
> external, linkable strcasecmp in this case?

MinGW / GCC is not linking against libc, but against MSVCRT, Visual
Studio's C runtime. And in fact MSVCRT has a non-inline implementation
of a "case-insensitive string comparison for up to the first n
characters"; it just happens to be called "_strnicmp", not
"strncasecmp". Which is why I still think just having a "#define
strncasecmp _strnicmp" is the most elegant solution to the problem.
And that's exactly what defining __NO_INLINE__ does. Granted, defining
__NO_INLINE__ in the scope of string.h will also add a "#define
strcasecmp _stricmp"; but despite it's name, defining __NO_INLINE__
does not imply a performance hit due to functions not being inlined
because it's just the "strncasecmp" wrapper around "_strnicmp" that's
being inlined, not "_strnicmp" itself.

-- 
Sebastian Schuberth
