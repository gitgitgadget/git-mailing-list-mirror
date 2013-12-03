From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Move check-ref-format code into separate function
Date: Tue, 3 Dec 2013 20:38:39 +0100
Message-ID: <CANQwDwd0_bgKfjsRFjohmzBAnN7vDm-pYYsfe0Q71Za2K7Hw4w@mail.gmail.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
 <1386082603-8404-2-git-send-email-krzesimir@endocode.com> <xmqqd2ldoj0s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnvoq-0006j9-QO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3LCTjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:39:21 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60731 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3LCTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:39:20 -0500
Received: by mail-wi0-f174.google.com with SMTP id z2so5588614wiv.13
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9Hmm3Li+LqTfI7zfD5wqPBCQ0OLjvF7L/Fg+ek7MNYA=;
        b=jzDORtMe/eoi8CAQ2I1X6M6ABLWG4FTNwNrOTK+6vyqgo6tAauFkyIvDmpHsx02Kjk
         lqTtTmVKckdt8Qh33l3zXG3bVlhy6hF23bi9pix1EzuzQg4uxcDgIMCLEKapxbKLJVN5
         G2gaCvAZiFOJaks+urIc1Mw3+8/Mi6rYkol9td5asyb6VJNKDtDVSb64a8X1ZmEB+Dg3
         ggvu6Ob82UBlLfkmootpMdhWVYVsqGphwdnlbEEDIK4aTlRu+tIJQiZOfqFr9xrDZLZY
         NbwHlVv9sXWynNCdNAj1FmMHw7VihZVd2WfACxsoJGLnGK9dI/hF3OvwuR1wTkcg3oBQ
         Pycg==
X-Received: by 10.180.10.135 with SMTP id i7mr4141828wib.1.1386099559492; Tue,
 03 Dec 2013 11:39:19 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Tue, 3 Dec 2013 11:38:39 -0800 (PST)
In-Reply-To: <xmqqd2ldoj0s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238725>

On Tue, Dec 3, 2013 at 8:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:

>> +sub check_ref_format {
>> +     my $input = shift || return undef;
>> +
>> +     # restrictions on ref name according to git-check-ref-format
>> +     if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
>> +             return undef;
>> +     }
>> +     return $input;
>> +}
[...]
>> @@ -1462,10 +1472,9 @@ sub validate_refname {
>>       # it must be correct pathname
>>       $input = validate_pathname($input)
>>               or return undef;
>> -     # restrictions on ref name according to git-check-ref-format
>> -     if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
>> -             return undef;
>> -     }
>
> So far, so good.
>
>> +     # check git-check-ref-format restrictions
>> +     $input = check_ref_format($input)
>> +             or return undef;
>>       return $input;
>
> Hmmm.  Why do you need "<LF><INDENT>or return under" here?  It would
> not hurt too much per-se (strictly speaking, if the $input were a
> string "0", this will return undef instead of "0", which should be
> an OK name as far as the regexp is concerned), but it seems to be
> making the logic unnecessarily complex for no real gain.

I think this simply follows  "$input = validate_sth($input) or return undef;"
pattern used in this area of gitweb code (perhaps mis-used).

Stricly speaking pure refactoring (no functional change, e.g. no assign
to $input) would be  "check_ref_format($input) or return undef;", or even
"return check_ref_format($input);" if we keep check_ref_format() passthru
on valid refname.

-- 
Jakub Narebski
