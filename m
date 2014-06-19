From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 11:29:21 -0700
Message-ID: <CAPc5daW5hsKeJsG8+2nxFzFL9gMnLR2gMBXG5__dhSCLKkBWmA@mail.gmail.com>
References: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
 <1403165242-16849-2-git-send-email-jmmahler@gmail.com> <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxh5r-0007N8-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 20:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934288AbaFSS3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 14:29:45 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:38201 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbaFSS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 14:29:43 -0400
Received: by mail-la0-f47.google.com with SMTP id s18so1688306lam.20
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8uhNLycd1V+in8nWPGIodjEKj3IJv9jEWnBQU30jRoo=;
        b=iRluPPpq+Wnd3AbnepytIuVFfCxSCEFh30oU5bAByVj+bKA7DY9SR4IrpiRHyyRSCM
         MCUfJxtAwePUyMw4UYCbzcoIM8ckBHlR8xOrs4aLQIV/FP201G4oBmIeYOE18NWoS+Ck
         VwNVvlfCevSxpRC0eG6//beSOKcahrY4JI8wQpZuXBG3HvVZJtnQvCc/ZtaAQodxchpN
         Rh8dKC83llL7PolATGpI5CbL/s08lCR2tvlZ7TKrdGxguF2JATKTuKSlDmFQ1ocgxEZD
         ZRY+2NiDx1Yx3PiM4s4hmUArzWUsoCeDMkdY1BrDZpGb7puzPEC9B1saKDKmn3c0uYJI
         fqVw==
X-Received: by 10.152.21.169 with SMTP id w9mr2335735lae.90.1403202581701;
 Thu, 19 Jun 2014 11:29:41 -0700 (PDT)
Received: by 10.112.172.103 with HTTP; Thu, 19 Jun 2014 11:29:21 -0700 (PDT)
In-Reply-To: <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 5uLpHxYmIDxSVjvQhP9IfJiT8oU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252171>

On Thu, Jun 19, 2014 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> You chose to use the one that loses the information by unifying
> these two into the variant that only returns -1/0/+1.  We know that
> it does not matter for the current callers, but is it expected that
> no future callers will benefit by having the magnitude information?

Heh, I was being silly, partly fooled by your reference to
"magnitude".

You are not losing information at all, because the caller cannot
tell if the return value came from an earlier memcmp(), whose only
guarantee is that the sign of the returned value is all that
matters, or from the later subtraction between lengths.

So unifying to the -1/0/+1 variant is entirely justifiable.  It is
just your rationale was a bit misleading.

    We often represent our strings as a counted string, i.e. a pair of
    the pointer to the beginning of the string and its length, and the
    string may not be NUL terminated to that length.

    To compare a pair of such counted strings, unpack-trees.c and
    read-cache.c implement their own name_compare() functions
    identically.  In addition, cache_name_compare() function in
    read-cache.c is nearly identical.  The only difference is when one
    string is the prefix of the other string, in which case the former
    returns -1/+1 to show which one is longer and the latter returns the
    difference of the lengths to show the same information.

    Unify these three functions by using the implementation from
    cache_name_compare().  This does not make any difference to the
    existing and future callers, as they must be paying attention only
    to the sign of the returned value (and not the magnitude) because
    the original implementations of these two functions return values
    returned by memcmp(3) when the one string is not a prefix of the
    other string, and the only thing memcmp(3) guarantees its callers is
    the sign of the returned value, not the magnitude.

or something like that, perhaps?
