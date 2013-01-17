From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 17:56:38 +0100
Message-ID: <CALWbr2wPQkOyu5cUYq6tDAEA6S9jeykej=F5VomihweckTd3Rw@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
	<1358376443-7404-1-git-send-email-apelisse@gmail.com>
	<1358376443-7404-2-git-send-email-apelisse@gmail.com>
	<CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
	<20130117110008.GD4574@serenity.lan>
	<CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 17:57:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvsm5-0003Sz-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 17:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312Ab3AQQ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 11:56:43 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:45982 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab3AQQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 11:56:40 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so1083286eaa.39
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=30Z81im9UvZfu34xhhmljNwfflcTcXDUKlZIOH/ipoQ=;
        b=gjPpOvqf2yDPNV0ZbeVgEntixeRphcxZHTTFKwXGrbu9L/p0lDzlc+JnZnGYvM8hwG
         4kyT57HHEvxzrrNPNIYvHHqrYswzYh/qxAUr7BXIoqumkRL+vkkhfC1u9IQyJm9o04zB
         UlF2Tcr8rTHfzxangI5Z2zOegjKHV7vpE4AysHKsxvRgqcvZfw4K2AcEycniYxT+UQ7v
         jKBPYleC7i9Nv+iSrq2rfEiHPD6JXaw/cViWIqIOdOuSUHpOXGXhzc2PGrkbcI5TPJbk
         DhpTjoKdvRs7RlqypVoV7TOQ5Wj6qC2Of/tVN29FAWSj1ihF2ojxa0YipRqJghUjH8lr
         Y95w==
X-Received: by 10.14.223.135 with SMTP id v7mr15654161eep.41.1358441799139;
 Thu, 17 Jan 2013 08:56:39 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Thu, 17 Jan 2013 08:56:38 -0800 (PST)
In-Reply-To: <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213858>

BTW, I think it has been addressed [1] by clang already and that would
explain why you don't have the warning when using clang trunk version.

[1]: http://llvm-reviews.chandlerc.com/D113

Antoine,

On Thu, Jan 17, 2013 at 5:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jan 17, 2013 at 3:00 AM, John Keeping <john@keeping.me.uk> wrote:
>>
>> There's also a warning that triggers with clang 3.2 but not clang trunk, which
>> I think is a legitimate warning - perhaps someone who understands integer type
>> promotion better than me can explain why the code is OK (patch->score is
>> declared as 'int'):
>>
>> builtin/apply.c:1044:47: warning: comparison of constant 18446744073709551615
>>     with expression of type 'int' is always false
>>     [-Wtautological-constant-out-of-range-compare]
>>         if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>
> The warning seems to be very very wrong, and implies that clang has
> some nasty bug in it.
>
> Since patch->score is 'int', and UNLONG_MAX is 'unsigned long', the
> conversion rules for the comparison is that the int result from the
> assignment is cast to unsigned long. And if you cast (int)-1 to
> unsigned long, you *do* get ULONG_MAX. That's true regardless of
> whether "long" has the same number of bits as "int" or is bigger. The
> implicit cast will be done as a sign-extension (unsigned long is not
> signed, but the source type of 'int' *is* signed, and that is what
> determines the sign extension on casting).
>
> So the "is always false" is pure and utter crap. clang is wrong, and
> it is wrong in a way that implies that it actually generates incorrect
> code. It may well be worth making a clang bug report about this.
>
> That said, clang is certainly understandably confused. The code
> depends on subtle conversion rules and bit patterns, and is clearly
> very confusingly written.
>
> So it would probably be good to rewrite it as
>
>     unsigned long val = strtoul(line, NULL, 10);
>     if (val == ULONG_MAX) ..
>     patch->score = val;
>
> instead. At which point you might as well make the comparison be ">=
> INT_MAX" instead, since anything bigger than that is going to be
> bogus.
>
> So the git code is probably worth cleaning up, but for git it would be
> a cleanup. For clang, this implies a major bug and bad code
> generation.
>
>                    Linus
>                      Linus
