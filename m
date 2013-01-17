From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 08:44:20 -0800
Message-ID: <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net> <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com> <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
 <20130117110008.GD4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Antoine Pelisse <apelisse@gmail.com>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 17:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvsaM-0004Cn-R0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 17:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257Ab3AQQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 11:44:42 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:39648 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3AQQol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 11:44:41 -0500
Received: by mail-vc0-f169.google.com with SMTP id gb23so2678027vcb.14
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=jp7JJaSUZtDD/Ubyc9wD9GD6518jTSGAwLSaz8qvvXg=;
        b=d06LsKFT0SfLONZ7cq1UxFhmlTLC+j6Xj3R5IHELjG0dtVZN2leDttAG1bbPNVs6OG
         muOtFbS6EEzpJhCgWw/qTt0x7jNTVD/EXNT9SnNtbl/UXs83TffxGAfoG2F76mdx75x9
         49+FNVB+dh4jr3MAL6U2j+ck+MMuMtXPPbK184UqA+S7T/bAn/OK5Fxzgef1DON27BnX
         K7ykkI51kHSlAplo88Xvr/EARYVljKpP+zpBPgFkyrR+tNDEqOdKHbZfH3dwhnVwTxSE
         9Cu3D/D4nwOzGchO1iNkL5mEkpF3YgH+naM9dxrUwum24zVyJARKgmaKoEFb+KVMKqbl
         l2Fg==
X-Received: by 10.52.92.42 with SMTP id cj10mr5333083vdb.102.1358441080711;
 Thu, 17 Jan 2013 08:44:40 -0800 (PST)
Received: by 10.220.249.199 with HTTP; Thu, 17 Jan 2013 08:44:20 -0800 (PST)
In-Reply-To: <20130117110008.GD4574@serenity.lan>
X-Google-Sender-Auth: xzMKvuGmKJ-cpWxXecgdFcyOK4E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213857>

On Thu, Jan 17, 2013 at 3:00 AM, John Keeping <john@keeping.me.uk> wrote:
>
> There's also a warning that triggers with clang 3.2 but not clang trunk, which
> I think is a legitimate warning - perhaps someone who understands integer type
> promotion better than me can explain why the code is OK (patch->score is
> declared as 'int'):
>
> builtin/apply.c:1044:47: warning: comparison of constant 18446744073709551615
>     with expression of type 'int' is always false
>     [-Wtautological-constant-out-of-range-compare]
>         if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~

The warning seems to be very very wrong, and implies that clang has
some nasty bug in it.

Since patch->score is 'int', and UNLONG_MAX is 'unsigned long', the
conversion rules for the comparison is that the int result from the
assignment is cast to unsigned long. And if you cast (int)-1 to
unsigned long, you *do* get ULONG_MAX. That's true regardless of
whether "long" has the same number of bits as "int" or is bigger. The
implicit cast will be done as a sign-extension (unsigned long is not
signed, but the source type of 'int' *is* signed, and that is what
determines the sign extension on casting).

So the "is always false" is pure and utter crap. clang is wrong, and
it is wrong in a way that implies that it actually generates incorrect
code. It may well be worth making a clang bug report about this.

That said, clang is certainly understandably confused. The code
depends on subtle conversion rules and bit patterns, and is clearly
very confusingly written.

So it would probably be good to rewrite it as

    unsigned long val = strtoul(line, NULL, 10);
    if (val == ULONG_MAX) ..
    patch->score = val;

instead. At which point you might as well make the comparison be ">=
INT_MAX" instead, since anything bigger than that is going to be
bogus.

So the git code is probably worth cleaning up, but for git it would be
a cleanup. For clang, this implies a major bug and bad code
generation.

                   Linus
                     Linus
