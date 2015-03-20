From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/14] numparse: new module for parsing integral numbers
Date: Fri, 20 Mar 2015 04:54:42 -0400
Message-ID: <CAPig+cTht9bCoJx3dCj3m_z59zp0C-PdzUYJVbZ7kO5ryNaOQQ@mail.gmail.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<1426608016-2978-2-git-send-email-mhagger@alum.mit.edu>
	<CAPig+cTyCS2-gys0MQSsA4K_k2gnGRvitXzDybyhO5q41OMD_w@mail.gmail.com>
	<550A008B.3050900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:55:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYshl-0006kh-2U
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 09:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbCTIyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 04:54:50 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34827 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbCTIyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 04:54:43 -0400
Received: by ykfs63 with SMTP id s63so39457438ykf.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V+K8JsF5uRoGJNQlVMYV/i6hYgx3aOWSYXligcYLz+A=;
        b=rK4ujiepkKVB0s37vV6dahOmOcuZ+8P/Uu/d8rcbSmeF6i6Hd7+0SP4zLLoUfmUeAq
         f5ppuZlsZ3OsCqKhD4j2gHqbrp9eQRyXdMXaiGP6nH/wIc7wSIt/T+4o8JuDsh5gtBbE
         WJB8mAu9WkXZR3Fh8UBOL4+ne6ps2T1cCwlt2z2D8RnbTgovO50AcsgUT2Lj4y5iHhHE
         FzbzJLPpJ2X4OClOInY2zoC/gr6Y0Z1i6HB0t2gVBeWybBcfqXfK+IcEv5uzDopk5x1z
         bdcd6/cUuO2sTO+S1LfRpS5GO2nmuorPL7G92wplahHEojSI2nI14OBD9mxsIqUpzRWd
         O2yA==
X-Received: by 10.236.10.5 with SMTP id 5mr81549384yhu.148.1426841682995; Fri,
 20 Mar 2015 01:54:42 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 20 Mar 2015 01:54:42 -0700 (PDT)
In-Reply-To: <550A008B.3050900@alum.mit.edu>
X-Google-Sender-Auth: BHHhIQ2WX96odGdzHyJAJJWTISg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265870>

On Wed, Mar 18, 2015 at 6:47 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/18/2015 07:27 PM, Eric Sunshine wrote:
>> On Tuesday, March 17, 2015, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Implement wrappers for strtol() and strtoul() that are safer and more
>>> convenient to use.
>>> + * The lowest 6 bits of flags hold the numerical base that should be
>>> + * used to parse the number, 2 <= base <= 36. If base is set to 0,
>>> + * then NUM_BASE_SPECIFIER must be set too; in this case, the base is
>>> + * detected automatically from the string's prefix.
>>
>> Does this restriction go against the goal of making these functions
>> convenient, even while remaining strict? Is there a strong reason for
>> not merely inferring NUM_BASE_SPECIFIER when base is 0? Doing so would
>> make it consistent with strto*l() without (I think) introducing any
>> ambiguity.
>
> I thought about doing this. If it were possible to eliminate
> NUM_BASE_SPECIFIER altogether, then there is no doubt that it would be a
> good change. But NUM_BASE_SPECIFIER also has an effect when base==16;
> namely, that an "0x" prefix, if present, is consumed. So
>
>     parse_i("0xff", 16 | NUM_BASE_SPECIFIER, &result, &endptr)
>
> gives result==255 and endptr==s+4, whereas
>
>     parse_i("0xff", 16, &result, &endptr)
>
> gives result==0 and entptr==s+1 (it treats the "x" as the end of the
> string).
>
> We could forgo that feature, effectively allowing a base specifier if
> and only if base==0. But I didn't want to rule out allowing an optional
> base specifier for base==16, in which case NUM_BASE_SPECIFIER can't be
> dispensed with entirely.

Making base==0 a special case doesn't have to mean ruling out or
eliminating NUM_BASE_SPECIFIER for the base==16 case. However, a
special case base==0 would make the API a bit non-orthogonal and
require extra documentation. But for those familiar with how strto*l()
treats base==0 specially, the rule of least surprise may apply.

> If you agree with that, then the remaining question is: which policy is
> less error-prone? My thinking was that forcing the caller to specify
> NUM_BASE_SPECIFIER explicitly when they select base==0 will serve as a
> reminder that the two features are intertwined.

Since base==0 would unambiguously imply NUM_BASE_SPECIFIER, being able
to tersely say convert_i(s, 0, &result) would be a win from a
convenience perspective. However...

> Because another
> imaginable policy (arguably more consistent with the policy for base!=0)
> would be that
>
>     convert_i(s, 0, &result)
>
> , because it *doesn't* specify NUM_BASE_SPECIFIER, doesn't allow a base
> prefix, and therefore indirectly only allows base-10 numbers.
>
> But I don't feel strongly about this.

I don't feel strongly about it either, and can formulate arguments
either way. Assuming you stick with your current design, if the
strictness of having to specify NUM_BASE_SPECIFIER for base==0 proves
too burdensome, it can be loosened later by making base==0 a special
case.

On the other hand, if you go with Junio's suggestion of choosing names
for these functions which more closely mirror strto*l() names, then
the rule of least surprise might suggest that a special case for
base==0 has merit.

>>> + * Return 0 on success or a negative value if there was an error. On
>>> + * failure, *result and *entptr are left unchanged.
>>> + *
>>> + * Please note that if NUM_TRAILING is not set, then it is
>>> + * nevertheless an error if there are any characters between the end
>>> + * of the number and the end of the string.
>>
>> Again, on the subject of convenience, why this restriction? The stated
>> purpose of the parse_*() functions is to parse the number from the
>> front of the string and return a pointer to the first non-numeric
>> character following. As  a reader of this API, I interpret that as
>> meaning that NUM_TRAILING is implied. Is there a strong reason for not
>> inferring NUM_TRAILING for the parse_*() functions at the API level?
>> (I realize that the convert_*() functions are built atop parse_*(),
>> but that's an implementation detail.)
>
> Yes, I'd also thought about that change:
>
> * Make NUM_TRAILING private.
> * Make the current parse_*() functions private.
> * Add new parse_*(s, flags, result, endptr) functions that imply
> NUM_TRAILING (and maybe they should *require* a non-null endptr argument).
> * Change the convert_*() to not allow the NUM_TRAILING flag.
>
> This would add a little bit of code, so I didn't do it originally. But
> since you seem to like the idea too, I guess I will make the change.

The other option (as Junio also suggested) is to collapse this API
into just the four parse_*() functions. All of the call-sites you
converted in this series invoked convert_*(), but it's not clear that
having two sets of functions which do almost the same thing is much of
a win. If the default is for NUM_TRAILING to be off, and if NULL
'endptr' is allowed, then:

    parse_ul(s, 10, &result, NULL);

doesn't seem particularly burdensome compared with:

    convert_ul(s, 10, &result);

A more compact API, with only the parse_*() functions, means less to
remember and less to document, and often is more orthogonal.

The argument for dropping the convert_*() functions is strengthened if
you follow Junio's suggestion to name these functions after the
strto*l() variations.

>>> +int parse_l(const char *s, unsigned int flags,
>>> +           long *result, char **endptr);
>>
>> Do we want to perpetuate the ugly (char **) convention for 'endptr'
>> from strto*l()? Considering that the incoming string is const, it
>> seems undesirable to return a non-const pointer to some place inside
>> that string.
>
> Yes, I guess we could do some internal casting and expose endptr as
> (const char **). It would make it a bit harder if the user actually
> wants to pass a non-const string to the function and then modify the
> string via the returned endptr, but I haven't run into that pattern yet
> so let's make the change you suggested.

I don't feel strongly about this either. It always struck me as a bit
of an API wart, but I can see the convenience value of non-const
'endptr' if the caller intends to modify the string. If you rename
these functions to mirror strto*l(), then the rule of least surprise
would suggest that 'endptr' should remain non-const.
