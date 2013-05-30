From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Wed, 29 May 2013 23:14:33 -0700
Message-ID: <CANiSa6hxhiFYn1atdh+zA76H=XsiAHown8Ndn0T6fXRPJEaWEw@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
	<CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
	<CAMP44s0x8e2xpycOEswnYDBM5WKn=fCp7hcUEniARGVZUw1XkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 08:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhw8F-0001CS-7k
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 08:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967559Ab3E3GOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 02:14:36 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:39593 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967549Ab3E3GOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 02:14:34 -0400
Received: by mail-we0-f179.google.com with SMTP id m46so6895200wev.38
        for <git@vger.kernel.org>; Wed, 29 May 2013 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XLbnBskgJwb8ujvY0ArRhTo9ZzhQgFsjZfIqEgZ21b4=;
        b=rTW+3PxNmtJyW4dZKWLyF1SBbVsBJMzNjmqC2slyEdXYvYGk7Z229f0KNILUwcQmXp
         j5nwyrTdvMcgmroeh0PTbqikaa/aEOWMS1XQAlesXqosv/EptmJqzT6xfOCaVMQjecND
         bsk9Ap2ekE8sN0wuM3tLXPHdQmWkbavYKBiuzVgvYfW5pXnNRE5UOJ1DZqn0pV1qYjWk
         mcFtz5Ht0oumfrWLvd7iD0pNI1DjaTHRgTBOsCxWFs9bM33uuE1PWGbdLreI6HGhrSdW
         FhD4vpEdkh7m2wck1dXRAQmFw/uK6cTUyXbrO09cfEhptKUt/4lijyHkSn8v1Ig9HAI7
         7HlA==
X-Received: by 10.180.184.101 with SMTP id et5mr3028944wic.45.1369894473478;
 Wed, 29 May 2013 23:14:33 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Wed, 29 May 2013 23:14:33 -0700 (PDT)
In-Reply-To: <CAMP44s0x8e2xpycOEswnYDBM5WKn=fCp7hcUEniARGVZUw1XkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225930>

On Wed, May 29, 2013 at 10:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 30, 2013 at 12:30 AM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
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
>
> I think the answer is obvious; G should not be dropped. Maybe it made
> sense to drop g in upstream, but d fixes an issue, and it makes sense
> to apply G on upstream.

Well, maybe I was wrong in thinking that dropping 'G' in 'git rebase
--onto f h i' is bad. It seems to complicate things a lot, so maybe we
should just decide that it's fine to do that (to drop 'G' in that
case). Since that's mostly how it has worked forever and no one seems
to have reported a problem with it, I'm probably just being paranoid.
Thoughts?
