From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Wed, 29 May 2013 12:03:30 -0500
Message-ID: <CAMP44s2UCZQBfSkhc5jg-ipWKMy3M4R-YVODR4=OuAUbpgkD8A@mail.gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
	<1369448666-17515-8-git-send-email-felipe.contreras@gmail.com>
	<7vvc632g1s.fsf@alter.siamese.dyndns.org>
	<51a5686ba7f2c_807b33e189951a@nysa.mail>
	<7v38t5wxee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhjmi-0004dK-Ga
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab3E2RDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:03:33 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32824 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3E2RDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:03:31 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so6094969wgh.3
        for <git@vger.kernel.org>; Wed, 29 May 2013 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4sydzRlqO2QkZ5fPfMRa7ah98PKrTcGbW5wXtMqxMPU=;
        b=t/Iri6J32MHzlXUF5e2g+i5U0UG8LWzPKsCB7noKTzucV4z5rkeHUzQ46twDItdchb
         DVMMq/AVMczFMRiOsxXC7EvNGZi0MZTR6DZ8NJBskcwjIkArH30vei1RJhjU0+/w1xg9
         cLdzaPlJ0osSQE5uHWa3nnVmyfkI5RxstV++9EIvArlaO4jl5n0Hmb26ypNNTpF8NdBc
         1DP2zPne8wlvRIAyQ+u94xFFK1ElJIAm660cvnX2B22jaVfkxI02FkeFUBFhsvKO8Gxv
         xvoO5jsExmzyGL2YLhRB2djYTqgWyQSv45UymTXuZ5SVIO//o3a+yNF6STo63veQ/fpr
         hmxQ==
X-Received: by 10.194.122.225 with SMTP id lv1mr2072154wjb.21.1369847010562;
 Wed, 29 May 2013 10:03:30 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 10:03:30 -0700 (PDT)
In-Reply-To: <7v38t5wxee.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225844>

On Wed, May 29, 2013 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>> > +    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
>>>
>>> Two minor nits and one design suggestion:
>>>
>>>  - Why rstrip() not strip()?
>>
>> The purpose of the strip is to remove the _single_ "\n" at the end that
>> subprocess communicate. Maybe get_config() should do that.
>>
>>> It appears that this only is helping
>>>    an end-user "mistake" like this:
>>>
>>>      git config remote-bzr.branches 'trunk, devel, test '
>>>
>>>    without helping people who have done this:
>>>
>>>      git config remote-bzr.branches 'trunk,  devel, test'
>>
>> No, that's tnot it.
>
> Yes, rstrip() will also lose LF at the end.
>
> But it also is true that your code also removes the trailing extra
> SP in the first example above, while not losing the extra SP in the
> middle in the second example, no?
>
> So where does "that's tnot it" come from?  Is it true or false that
> the former is helped while the latter is not?

You said it is *only* helping the end-user with mistakes, but that's
not true, it _also_  gets rid of the new line, which is not only
helping, but it's required for the code to work, and it's actually the
purpose behind the code. The side-effect of removing extra spaces if
the user makes mistakes is irrelevant.

>>>  - Is
>>>
>>>      git config remote-bzr.branches trunk,devel,test
>>>
>>>    a grave sin?
>>>
>>>    In other words, wouldn't we want something like this instead?
>>>
>>>      map(lambda s: s.strip(), get_config('...').split(','))
>>
>> Yeah, that might make sense.
>
> If you go that route, you do not even have to even say "stupid
> python".  You can write a more meaningful list comprehension, e.g.
>
>         wanted = [s.strip() for s in get_config('...').split(',')]
>
> without an unsightly lambda in it.

Python would still do the stupid thing if there's no such configuration:

['']

But we can add 'if s' at the end, so the code to fix python's
stupidness is much smaller.

I wonder what 's' means. In C I use 'i', because that's what everybody
uses, but in more functional-like code we don't use an index, we
iterate directly with the element of an enumerable, so I say 'e' for
short.

>>>  - Doesn't allowing multi-valued variable, e.g.
>>>
>>>      [remote-bzr]
>>>             branches = trunk
>>>             branches = devel
>>>             branches = test
>>>
>>>    make it easier for the user to manage this configuration by
>>>    e.g. selectively removing or adding tracked branches?
>>
>> How would the 'git config' command look like?
>>
>> Either way, that's orthogonal to this patch.
>
> Yeah, I notice that "single variable, split at comma" comes way
> before this series anyway, so it is too late (and it is not worth)
> to fix it using multi-valued variables.  It was just an "if we were
> designing this from scratch" kind of suggestion.

It might be worth, I'm not sure, I'm not familiar with those, and I
don't know what the user would have to type, but my guess is that it
won't be as user friendly as 'git config foo one,two,three'.

-- 
Felipe Contreras
