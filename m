From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect
 line-ending-like chars
Date: Sun, 23 Mar 2014 05:35:43 -0400
Message-ID: <CAPig+cTFNsmQPmUpax-rbqkk5JzgAw4fK0tM4U013Z_x7o-ZyA@mail.gmail.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<CAPig+cTw8pyRVOHToGRPBdxv+TX8Vcj5OrX-CmLWRCigZRS4MA@mail.gmail.com>
	<CAByyCQBmCTfW0HBL04MMqwm+bDe4Rb6n+MfWdYUQ6M6yW_u=yw@mail.gmail.com>
	<CAPig+cTct-42w5S=OUS_DQ2cD5X9nWa_eUVoFBGTT7nAEahi5g@mail.gmail.com>
	<CAByyCQAqZnnc91ZgmxdKgc7T0POLqd+iXmKvaKEPMOx6CNQkKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 10:36:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRepG-0001Ow-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 10:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaCWJfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 05:35:45 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:40679 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaCWJfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 05:35:44 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so11392387ykt.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=odyK/2iD2WJQswvKVUd3VdOi9n0Z0wrLB8FxnL2NETA=;
        b=0RpnsPVIDVqKaJLsp2r7JoWTG3IliALB+2y8vgBpjmlxFU+I8uh80ZoB4KX9KP70GX
         z6YKE7Vbnmm+FQ00DtxjjR+1fmIRAzCo+kkqCdYuZsRnmxjstnYX9n23Uaw+taJfBNRE
         1PrdPYNXMlRfN2H+yFRKrvWegmabjeDET2hwgh0+DOGuH9Wlh+Yhst41TzME57EIfpI2
         vt23ZOMhusVOKXowfIXgWZtBaf1K7XdecpPRXAtRZqa1BAKY6fbr/phSAAErlbtoA1CW
         GjruG+ckuLd3Un3K3fAOIlBXF+WqwRR8PswzniWnqreSWGHFVE3jOWk2IYoxPaIJpbJt
         6s2A==
X-Received: by 10.236.71.161 with SMTP id r21mr156817yhd.112.1395567343266;
 Sun, 23 Mar 2014 02:35:43 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 23 Mar 2014 02:35:43 -0700 (PDT)
In-Reply-To: <CAByyCQAqZnnc91ZgmxdKgc7T0POLqd+iXmKvaKEPMOx6CNQkKQ@mail.gmail.com>
X-Google-Sender-Auth: 5qdt5baVdTv1qjXDO0RT3cUDlyY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244792>

On Sat, Mar 22, 2014 at 5:33 AM, George Papanikolaou
<g3orge.app@gmail.com> wrote:
> On Sat, Mar 22, 2014 at 12:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Because it's unnecessary and invites confusion from people reading the
>> code since they now have to wonder if there is something unusual and
>> non-obvious going. Worse, the two loops immediately below the ones you
>> changed, as well as the rest of the function, use plain isspace(),
>> which really ramps up the "huh?"-factor from the reader.
>>
>> The original code has the asset of being clear and obvious. Changing
>> these two loops to use a wide-character function makes it less so.
>>
> Yes I understand it does add a factor of ambiguity.
>
>> Neither the function comment nor the existing code implies that it is
>> checking for "any non-readable characters". (I'm not even sure what
>> that means.) The only thing the existing code says at that point is
>> that it is ignoring line-endings.
>>
> I mean characters that are not printable like letters, numbers, dots etc

It's still not clear how this answer relates to my question about why
you used iswspace() rather than isspace().

Nothing in the code or comments indicates that it wants to ignore
non-printing characters. Even if the intention of your change had
indeed been to ignore such characters, you would have used !isprint()
or !iswprint().

>> You're changing the behavior of the function (assuming I'm reading it
>> correctly), which is why I asked if you verified that doing so was
>> safe. The existing code considers "foo bar" and "foo bar " to be
>> different. With your change, they are considered equal, which is
>> actually more in line with what the function comment says.
>> Nevertheless, callers may be relying upon the existing behavior.
>>
>> At the very least, the unit tests should be run as a quick check of
>> whether if this behavior change introduces problems. Manual inspection
>> of callers also wouldn't hurt.
>>
> I did not think about that possibility, because I ran `make` and the
> tests passed so I thought that that would be ok.

Unit tests may cover a lot of functionality, but there will always be
holes in the coverage. Thus, it's a good idea to examine callers and
surrounding code manually, as well.

Since this is a behavior change, it deserves mention in the commit
message, as well as assurance that you verified (as best you can) that
it did not break existing callers. (It also wouldn't hurt to mention
that it brings the code more in line with the function documentation.)

> Anyway, do you have any ideas on how to improve that function?

Michael gave you a strong clue when he asked what would happen, with
your change in place, if the string consisted only of whitespace. The
loops you touched are already fragile, even without your change.
Making them more robust would likely be considered an improvement.

> Thanks again for the feedback.
>
> --
> papanikge's surrogate email.
> I may reply back.
> http://www.5slingshots.com/I did not think about that possibility.
