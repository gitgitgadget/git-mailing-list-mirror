From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-remote-mediawiki: Fix a bug in a regexp
Date: Sun, 9 Jun 2013 01:21:43 -0400
Message-ID: <CAPig+cSCLsMQ3Xg9UKury41G0vHddnL1PVKBJL_N2amA9e0eyQ@mail.gmail.com>
References: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
	<vpqmwr0v45b.fsf@anie.imag.fr>
	<20130609025708.GB30393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 07:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlY4h-00087z-Qc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab3FIFVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:21:51 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:62683 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIFVp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 01:21:45 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so535271lbd.32
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a6c78TAxuO5rRk2Xu3e1abO2iJwkxKi0bSUcW7ErHiA=;
        b=Knmy40VhNMJ9zuEq+901Q8VLL4e1e+zvPHFyyV8Ryh68mUbB0zzVSALccsNIfppQgh
         eF75Y8mo6VoaGENd+j77QmW8K10ym6yZLjYOfzsJzebJusEjmbDny4h0m6gbf1N0To9l
         11IBnNxnDaQEmsAufdGNBZeqUWCpQXZmhgNqg8U/bMzmFBDtCPFSvFLUInbKRWvXL9WC
         m7dSPoQyBLc4G6oDTO5ABeoAaFdgBPrboxfxsy2VbFcUOvqpZYo5DBnEfD9gb8xPxk6D
         ISiY8VIWKBFkeLyJUS+48a07EQbZK6gCnv9aQghPDXdK5SYM4XjFAlrZz82XJ7muIKIT
         Cwyg==
X-Received: by 10.112.204.231 with SMTP id lb7mr3866916lbc.4.1370755303245;
 Sat, 08 Jun 2013 22:21:43 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sat, 8 Jun 2013 22:21:43 -0700 (PDT)
In-Reply-To: <20130609025708.GB30393@sigill.intra.peff.net>
X-Google-Sender-Auth: xSF5eyN-AH_1NNFMf8tLJEYBF2Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226884>

On Sat, Jun 8, 2013 at 10:57 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 08:38:56PM +0200, Matthieu Moy wrote:
>
>> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>>
>> > In Perl, '\n' is not a newline, but instead a literal backslash fo=
llowed by an
>> > "n". As the output of "rev-list --first-parent" is line-oriented, =
what we want
>> > here is a newline.
>>
>> This is right, but the code actually worked the way it was. I'm not
>> sure, but my understanding is that '\n' is the string "backslash
>> followed by n", but interpreted as a regexp, it is a newline.
>
> Yes, the relevant doc (from "perldoc -f split") is:
>
>   The pattern "/PATTERN/" may be replaced with an expression to speci=
fy
>   patterns that vary at runtime.  (To do runtime compilation only onc=
e,
>   use "/$variable/o".)
>
> So it is treating "\n" as an expression and compiling the regex each
> time through ...

I read this as saying only that static /PATTERN/ can also be a
composed /$PATTERN/. It does not indicate how string 'PATTERN' is
treated, nor does any other part of "perldoc -f split" make special
mention of string 'PATTERN'. In fact, the only explanation I found
regarding string 'PATTERN' is in my Camel book (3rd edition, page 796)
in a parenthesized comment:

    (... if you supply a string instead of a regular expression, it'll =
be
    interpreted as a regular expression anyway.)

>> The new code looks better than the old one, but the log message may =
be
>> improved.
>
> Agreed. I think the best explanation is something like:
>
>   Perl's split function takes a regex pattern argument. You can also
>   feed it an expression, which is then compiled into a regex at runti=
me.
>   It therefore works to pass your pattern via single quotes, but it i=
s
>   much less obvious to a reader that the argument is meant to be a
>   regex, not a static string. Using the traditional slash-delimiters
>   makes this easier to read.

Sounds good to me.
