From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 09/12] t4150: am with post-applypatch hook
Date: Tue, 7 Jul 2015 14:47:19 +0800
Message-ID: <CACRoPnQ_bUtLuavFCdJGFAW08EY_LGV5Q=RR9Ey3jsoPk6-C3w@mail.gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<1435861000-25278-10-git-send-email-pyokagan@gmail.com>
	<17f64cb49c820eb41d0fb58435c91c40@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 08:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCMf8-0005KC-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 08:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbGGGrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 02:47:23 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35742 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbGGGrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 02:47:21 -0400
Received: by labgy5 with SMTP id gy5so30499064lab.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IQ3TQiISAqzgLDQNre0L7Ze3cBLQ0lIEQ4KSb/FfEiI=;
        b=ycGm6RqRT17lcaPxhfr+lFr93zfAGwd4BRxsrczzYhwWQS+D9lCAhqCx8ba0o4ScDl
         G4q7W/z8Bb7N4Eyhx/mmf6b+k1GAnmjWg3TyqlMarT39H7J1xp5xGeN8q2KoUHtMi4o2
         SzOjob20nHriItMZ+u1DjAQoJChfJQcwaZUFG7jVJR9STF5DkRpoTkyWV6rUZgFbxxur
         yw12v91VcZ0bFkntDz7C1XVkMEiF6NeAEXrgygStRSeodJQfz76rBtyueGqOXxKuNmKj
         hE+32ThHEGQG7NCPlIldSauWydLdwKJ21GbLgmNBTINbhLAatJJFzgf9L3jNII2Gsq1l
         F54g==
X-Received: by 10.152.6.105 with SMTP id z9mr2500239laz.98.1436251639832; Mon,
 06 Jul 2015 23:47:19 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 6 Jul 2015 23:47:19 -0700 (PDT)
In-Reply-To: <17f64cb49c820eb41d0fb58435c91c40@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273481>

On Sun, Jul 5, 2015 at 11:58 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-07-02 20:16, Paul Tan wrote:
>
>> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
>> index dd6fe81..62b678c 100755
>> --- a/t/t4150-am.sh
>> +++ b/t/t4150-am.sh
>> @@ -275,6 +275,48 @@ test_expect_success 'am with failing pre-applypatch hook' '
>>       test_cmp_rev first HEAD
>>  '
>>
>> +test_expect_success 'am with post-applypatch hook' '
>> +     test_when_finished "rm -f .git/hooks/post-applypatch" &&
>> +     rm -fr .git/rebase-apply &&
>> +     git reset --hard &&
>> +     git checkout first &&
>> +     mkdir -p .git/hooks &&
>> +     cat >.git/hooks/post-applypatch <<-\EOF &&
>> +     #!/bin/sh
>> +     git rev-parse HEAD >head.actual
>> +     git diff second >diff.actual
>> +     exit 0
>> +     EOF
>> +     chmod +x .git/hooks/post-applypatch &&
>> +     git am patch1 &&
>> +     test_path_is_missing .git/rebase-apply &&
>> +     test_cmp_rev second HEAD &&
>> +     git rev-parse second >head.expected &&
>> +     test_cmp head.expected head.actual &&
>> +     git diff second >diff.expected &&
>> +     test_cmp diff.expected diff.actual
>> +'
>> +
>> +test_expect_success 'am with failing post-applypatch hook' '
>> +     test_when_finished "rm -f .git/hooks/post-applypatch" &&
>> +     rm -fr .git/rebase-apply &&
>> +     git reset --hard &&
>> +     git checkout first &&
>> +     mkdir -p .git/hooks &&
>> +     cat >.git/hooks/post-applypatch <<-\EOF &&
>> +     #!/bin/sh
>> +     git rev-parse HEAD >head.actual
>> +     exit 1
>> +     EOF
>> +     chmod +x .git/hooks/post-applypatch &&
>> +     git am patch1 &&
>> +     test_path_is_missing .git/rebase-apply &&
>> +     git diff --exit-code second &&
>> +     test_cmp_rev second HEAD &&
>> +     git rev-parse second >head.expected &&
>> +     test_cmp head.expected head.actual
>> +'
>
> These 2 tests as well as the previous patches look to me as if they could be refactored (the paradigm is the same: add a certain hook after resetting and then apply the patch, verify that the hook ran/failed)... do you think there is a chance for that?

I had a look, but I think that while it is true that the overall
sequence of each test is the same, the details differ enough that
there's no obvious way to refactor the tests sensibly. For example,
the contents of the hook scripts are not the same, as we need to check
that the hooks are run at the correct stage of git-am execution. And
as such, the verification tests are also different as well.

Junio did correctly point out though that we can shave off 2 lines if
the write_script helper is used (the shebang and the chmod).

Thanks,
Paul
