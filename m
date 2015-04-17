From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but
 not with other regexp-related options?
Date: Fri, 17 Apr 2015 10:45:42 -0700
Message-ID: <CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app> <55311831.6010004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 19:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjALA-0006YC-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 19:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934069AbbDQRqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 13:46:05 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36309 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbbDQRqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 13:46:03 -0400
Received: by oift201 with SMTP id t201so82832982oif.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Mk72DnAhU5kUy3TCJtMyzw3bGT/pggeTY+aFk0ker2I=;
        b=oL4jk/rAM7mzaMCW5Ph3wfVqgh3XZO3UaXhLVsdwWLMRBwPPwuyYztI+h8/5kH2dQT
         +Okog+8/iRIq2YEozxR/+l0pVVeYyhk6RIkMCgR7trySx+jGOGKg6Ibpd1hc4dZsyPqI
         eW55feq7CZIPXFb6N+q0W5FLs35Ie3nqC+zjL/JO64t1UCSd1mgCdtGr+d3+JlrnaJ49
         0M8ouPKn70IciWsSCWWHN7k1GDaw09hwNmgSbKgEiJlw++5tYJ4Bb557HppptkQUIUkO
         GiTg702YnfolaTQ316TioL7ODQSEuOyQ+CDWf6hm+YbeAoCAI32+UB+DXYESM3zaLd+z
         /yNQ==
X-Received: by 10.60.35.102 with SMTP id g6mr4074386oej.7.1429292762620; Fri,
 17 Apr 2015 10:46:02 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Fri, 17 Apr 2015 10:45:42 -0700 (PDT)
In-Reply-To: <55311831.6010004@drmicha.warpmail.net>
X-Google-Sender-Auth: cCgXpQRT-eosqlQsRr1zwqEFsfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267370>

On Fri, Apr 17, 2015 at 7:26 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>>
>> Similarly I think it is not very consistent that one cannot combine any of
>> the above options with the "S<string>" but instead have yet another option
>> called "pickaxe-regex" to toggle between "fixed-string" and
>> "extended-regexp" semantics for the argument passed to option "S".
>
> The defaults are different, and it is likely that users want to switch
> one without switching the other.
>
> E.g., with -S you often use strings that you'd rather not have to quote
> to guard them against the regexp engine.

But the hypothetical -G that would look for a fixed string would be
vastly different from -S, wouldn't it?

The -S<string> option was invented to find a commit where one side
of the comparison has that string in the blob and the other side
does not; it shows commits where <string> appears different number
of times in the before- and the after- blobs, because doing so does
not hurt its primary use case to find commits where one side has one
instance of <string> and the other side has zero.

But -G<regexp> shows commits whose "git show $that_commit" output
would have lines matching <regexp> as added or deleted.  So you get
different results from this history:

    (before)    (after)
    a           b
    b           a
    c           c

As "git show" for such a commit looks like this:

diff --git a/one b/one
index de98044..0c81c28 100644
--- a/one
+++ b/one
@@ -1,3 +1,3 @@
-a
 b
+a
 c

"git log -Ga" would say it is a match.  But from "git log -Sa"'s
point of view, it is not a match; both sides have the same number of
'a' [*1*].

I think it would make sense to teach --fixed-strings or whatever
option to -G just like it pays attention to ignore-case, but "-G
--fixed-strings" cannot be "-S".  They have different semantics.


[Footnote]

*1* This is because -S was envisioned as (and its behaviour has been
    maintained as such) a building block for Porcelain that does
    more than "git blame".  You feed a _unique_ block of lines taken
    from the current contents as the <string> to quickly find the
    last commit that touched that area, and iteratively dig deeper.
    The -S option was meant to be used for that single step of
    digging, as a part of much more grand vision in $gmane/217,
    which I would still consider one of the most important messages
    on the mailing list, posted 10 years ago ;-)



[jc: My mail provider seem to be queuing but not sending out SMTP
outgoing traffic, so I am trying to (re)send this in an alternate route.
If you got a duplicate of this message, my apologies.]
