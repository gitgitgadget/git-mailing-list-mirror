From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Thu, 30 May 2013 08:01:03 -0700
Message-ID: <CANiSa6jEnzhJT3j8kYT03oz41wwbUJYgKeFFuP=kMLKCS=u97A@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
	<CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
	<51A74BFC.4020900@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 30 17:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4Ly-00062N-DI
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab3E3PBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 11:01:16 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:58117 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609Ab3E3PBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 11:01:04 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so341256wes.40
        for <git@vger.kernel.org>; Thu, 30 May 2013 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KPbIUoikDfuXQdMfmVqMijHZQOfy4r2ZCpxUr6ed09g=;
        b=iNfacIItuO6cBOfe68H7rJj3pxNIi4mgmjht6RyCwCvUDMF2f2UdJ1wVl5Pp6FeGXM
         WtGiLMXMoBVnvT6QbdIYwMTDhgb8MigaKdWRQkex4GlHI7M4pTBWsnoVfvJNDlSQSatC
         2oF/sq/DzPUMQsoHngWDi79ILDwhyYbnFxkFb+A1c9TwfvlWKCZUvjNIi0avw+L+Vop/
         JoJMvoE2+qov9yTT4OK5kGNSYWy9JwjLIfdvpl5Y07/xCXOXK5m73iV1UHAufvA2elR7
         MlI2VgTeRU0VPSsURovhiAqNAXRiPPt9RFMGc/MTpjGLCwlAuyT8r1Da7BlksFKTca7E
         E1+g==
X-Received: by 10.194.120.134 with SMTP id lc6mr5134472wjb.55.1369926063381;
 Thu, 30 May 2013 08:01:03 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Thu, 30 May 2013 08:01:03 -0700 (PDT)
In-Reply-To: <51A74BFC.4020900@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226007>

On Thu, May 30, 2013 at 5:54 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 30.05.2013 07:30, schrieb Martin von Zweigbergk:
>> On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>>>> +#       f
>>>> +#      /
>>>> +# a---b---c---g---h
>>>> +#      \
>>>> +#       d---G---i
>>> ...
>>>> +test_run_rebase () {
>>>> +     result=$1
>>>> +     shift
>>>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>>>> +             reset_rebase &&
>>>> +             git rebase $* --onto h f i &&
>>>> +             test_cmp_rev h HEAD~2 &&
>>>> +             test_linear_range 'd i' h..
>>>
>>> Isn't this expectation wrong? The upstream of the rebased branch is f, and
>>> it does not contain G. Hence, G should be replayed. Since h is the
>>> reversal of g, the state at h is the same as at c, and applying G should
>>> succeed (it is the same change as g). Therefore, I think the correct
>>> expectation is:
>>>
>>>                 test_linear_range 'd G i' h..
>>
>> Good question! It is really not obvious what the right answer is. Some
>> arguments in favor of dropping 'G':
>>
>> 1. Let's say origin/master points to 'b' when you start the 'd G i'
>> branch. You then send the 'G' patch to Junio who applies it as 'g'
>> (cherry-picking direction is reversed compared to figure, but same
>> effect). You then "git pull --rebase" when master on origin points to
>> 'h'. Because of the cleverness in 'git pull --rebase', it issues 'git
>> rebase --onto h b i'.
>
> The reason for this git pull cleverness is to be prepared for rewritten
> history:
>
>    b'--c'--g'--h'
>   /
>  a---b
>       \
>        d---G---i
>
> to avoid that b is rebased.

Right. It doesn't currently drop 'G' and maybe it shouldn't, so let's
leave it as is for now, I would say.

>> 2. In the test a little before the above one, we instead do 'git
>> rebase --onto f h i' and make sure that the 'G' is _not_ lost. In that
>> case it doesn't matter what's in $branch..$upstream. Do we agree that
>> $branch..$upstream should never matter (instead, $upstream is only
>> used to find merge base with $branch)?
>
> No, we do not agree. $branch..$upstream should be the set of patches
> that should be omitted. $branch..$onto should not matter. $onto is only
> used to specify the destination of the rebased commits.

Ok. As I said to Felipe, I'm not sure why I was so convinced that it's
bad to lose the patch in 'git rebase --onto f h i'. It can result in
lost work, but it seems rare enough that no one has reported it,
AFAIK.

I'll change those tests in a re-roll, and perhaps I'll drop a few of
them. Let me know if you (anyone) disagree.


Martin

PS. Thanks for a meticulous review!
