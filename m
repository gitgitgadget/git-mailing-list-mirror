From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but
 not with other regexp-related options?
Date: Mon, 20 Apr 2015 11:33:31 -0700
Message-ID: <CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
	<55311831.6010004@drmicha.warpmail.net>
	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
	<5534BD87.8020709@drmicha.warpmail.net>
	<xmqqbniin1cw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:33:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGVm-0005F3-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbbDTSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:33:33 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36999 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbDTSdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:33:32 -0400
Received: by igblo3 with SMTP id lo3so67979814igb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kXQErS9O0mzmGfgKYaH4gpAmzzDAim/NjfN+ub1IEDA=;
        b=rjhag6nn+qQQ7VW9dOHRmIzJIIGeNj+S6n4mdEofGh9mtpZ2Mgh+Fhs3f8vL7bQCQe
         zdIWgpJkVlq6aAYECnS5gn4HblJ2c7A8w7Va9xXctBgTPPbu7J+d+daSQVKd8ZU5qT+B
         p+kaOVh4AT3U6xC9c2/psYa7WNK2rryuwnISvaHI2hyfbsiU0wB1Zd1uGBwqgaT+FM/i
         oZ26mMzkA9dvVCENvh/30F4t/IrBUjIhjFPdahMvowO9fYCTeTfNuWNxfV9ymT+pSxQP
         Xmq4TICha277664WUCBi02YjBRsqNuundDcqjt81paZz/zm9kq/mjpk0ITcGqXJret5u
         jWSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kXQErS9O0mzmGfgKYaH4gpAmzzDAim/NjfN+ub1IEDA=;
        b=h84acYkRBHtXxLNyuOkfcSxIIqf9RmiV14wgi/7m4fwS2KoqfHX7IQCnE4i9UFxcgB
         eJttDZcYYorsZr403bJ0mYrD06yg43ptupIx2a/FtMzb42Dldhbvr1acmSGpY+1SQp8M
         gZPfF1hbzqsLGtrV9iVCMEHOD2FTRvonQIP1c=
X-Received: by 10.50.122.39 with SMTP id lp7mr22384269igb.24.1429554812070;
 Mon, 20 Apr 2015 11:33:32 -0700 (PDT)
Received: by 10.36.53.141 with HTTP; Mon, 20 Apr 2015 11:33:31 -0700 (PDT)
In-Reply-To: <xmqqbniin1cw.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: NAn_5nxmlwAJD0VBuoqX-OoYi_8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267483>

On Mon, Apr 20, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ahh, OK.  And not just -S and -G, the "fields in headers" may be
> something user may want to switch independently?

So personally, I hate extra command line flags for this. I'd much
rather see is use something in the regular expression itself, and make
*that* be the way you do it, and make it be the preferred format.

Otherwise, you'll always have the issue that you want *part* to be
case-ignoring, and another entry not, and then it's just messy with
the "ignore case" being some other thing.

And we support that with perl regexps, but those are only enabled with
libpcre. I wonder if we could just make some simple pattern extension
that we make work even *without* libpcre.

IOW, instead of making people use "-regexp-ignore-case", could we just
say that we *always* support the syntax of appending "(?i)" in front
of the regexp. So that your

    git log --regexp-ignore-case --author=tiM --grep=wip

example would be

    git log --author="(?i)tiM" --grep=wip

and it would match the _author_ with ignoring case, but the
"--grep=wip" part would be an exact grep.

Right now the above already works (I think) if you:

 - build with USE_LIBPCRE

 - add that "--perl-regexp" switch.

but what I'm suggesting is that we'd make a special case for the
magical perl modifier pattern at the beginning for "(?i)", and make it
work even without USE_LIBPCRE, and without specifying "--perl-regexp".

We'd just special-case that pattern (and perhaps _only_ that special
four-byte sequence of "(?i)" at the beginning of the search string),
but perhaps we could support '(?s)' too?

Hmm? I realize that this would be theoretically an incompatible
change, but it would be very convenient and if we document it well it
might be ok. I doubt people really search for "(?i)" at the beginning
of strings _except_ if they already know about the perl syntax and
want it.

And to clarify: I don't suggest always building with libpcre. I
literally suggest having something like

     /* hacky mac-hack hack */
    if (strncmp("(?i)", p->pattern, 4)) {
        p->pattern += 4;
        p->ignore_case = true;
    }

just in front of the "regcomp() call, and nothing more fancy than that.

                           Linus
