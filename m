From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Fri, 18 Jan 2013 12:15:05 -0500
Message-ID: <CABURp0pj35j7+W_0gYNud2uuEoahugOMBW9ezTgPZ7YvgnBz8w@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net> <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com> <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
 <20130117110008.GD4574@serenity.lan> <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 18:15:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwFXf-0004Wk-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 18:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab3ARRP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 12:15:27 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39352 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3ARRP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 12:15:26 -0500
Received: by mail-vc0-f181.google.com with SMTP id d16so1606945vcd.12
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/Rri/zTpVIHAYv48NuGnc0tNlN9YG7Tj62jLeohjsDQ=;
        b=ku5sk8XE4Q5U8kN65JYCcI0Xq1ersUpes/yWuW7XZtnSxzOl6iX10S9eDImZ9unOeJ
         i2obNF9nYjjht1srbGRFhe0hPXm42pPwpH9N+x+yEjymC16ba9QixbeSVzvzQz29zBa5
         4cREcapMFpnWy99Bc8jGsgKD7kFleEuqAFv4MQVmRgNBWm5eRR3ROzL2K/3hzYqz6+eK
         KaUe6ejh+777LKCFBe/JWBTpI0ZoeM3sIaRb6olGYE2xSM7PfojkhAy9lQAozM6LQwMT
         fcCdnqmmuV3Gl5/QdTyHP/MCCwbTlfCoAn9XIj4fUY8h0f20E2OIGMBl4Uv/fY8XQXoP
         fZiQ==
X-Received: by 10.52.71.174 with SMTP id w14mr9050629vdu.122.1358529325871;
 Fri, 18 Jan 2013 09:15:25 -0800 (PST)
Received: by 10.58.241.203 with HTTP; Fri, 18 Jan 2013 09:15:05 -0800 (PST)
In-Reply-To: <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213918>

On Thu, Jan 17, 2013 at 11:44 AM, Linus Torvalds
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


Yes, I can tell by the wording of the error message that you are right
and clang has a problem.  But the git code it complained about does
have a real problem, because the result of "signed int a = ULONG_MAX"
is implementation-defined.  It cannot be guaranteed or expected that
patch->score will ever be assigned -1 there, and so the comparison may
always be false.  I guess the warning is correct, but only
accidentally.  :-)

Your rewrite is more sane and corrects the problem, I think.

Phil
