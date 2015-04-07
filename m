From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH 2/3] p7300: added performance tests for clean
Date: Tue, 7 Apr 2015 21:35:07 +0200
Message-ID: <CAMpP7NaKdArh_AA=9fSdWvEzk6MVyptX-y25_j665UA07xTiBQ@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-3-git-send-email-erik.elfstrom@gmail.com>
	<5522EF29.9000008@web.de>
	<CAPig+cRSv0qsctJ_2-ZH2y_E7kU_f787ate_5CnnKHE+vBddNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:35:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZHI-0007zD-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbbDGTfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 15:35:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33962 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbbDGTfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 15:35:10 -0400
Received: by obbgh1 with SMTP id gh1so100403504obb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4OIg65+V7URlSmNmFkvoQNc+HmEHqoAJ3kLZuiku8AE=;
        b=hKBvO977TbUYYieQxEPLXGSBAd332CvxtEH32wbRlPr175eJJBp+fyCwk/yDHEO6gw
         mvtfoJMhEe9qiOF1/BG8Pe4MrOG4jLzgNp+aWNwlFhL3H9ly7ViTgjXZqgKmMg3T09KE
         rIFHcZD/EtBsUYQGxx8tkRAlzsDWsNEWfLjoAwIbQ84B+7TuT95jGNsCFboCJCL+6xrx
         krYu4fxbzAsmOHS9GJKiDo3zS6qFLf5MZt7q5JXQTCoX3odAtYqjao9wxohAnUC9HS0b
         MgWA29Z+yTyPS8/tlY2PSuLb8NJlpfKlnJAkNST2NzrIMCrZJobPoBYUrieP5czSLFB2
         3gdA==
X-Received: by 10.182.134.169 with SMTP id pl9mr6770503obb.32.1428435307955;
 Tue, 07 Apr 2015 12:35:07 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 7 Apr 2015 12:35:07 -0700 (PDT)
In-Reply-To: <CAPig+cRSv0qsctJ_2-ZH2y_E7kU_f787ate_5CnnKHE+vBddNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266934>

Will fix!

Also I forgot to ask, does anyone have a good way of moving the copy
out of the performance timing?

After the fix this test spends more time copying than cleaning and
that is not so good. I'm not very good at shell scripting and the only
way I could think of was to make multiple copies at the start and then
in the test check and clean the first non empty directory. That feels
kind of ugly and will fail if a different number of iterations per
test is used. Any suggestions?

I looked a bit at the framework code but I couldn't figure out if it
was easy to add a "setup" option to be called be before each
iteration.

On Tue, Apr 7, 2015 at 12:09 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Mon, Apr 6, 2015 at 4:40 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>> On 2015-04-06 13.48, Erik Elfstr=C3=B6m wrote:
>>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>>> ---
>>> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
>>> new file mode 100755
>>> index 0000000..3f56fb2
>>> --- /dev/null
>>> +++ b/t/perf/p7300-clean.sh
>>> @@ -0,0 +1,37 @@
>>> +#!/bin/sh
>>> +
>>> +test_description=3D"Test git-clean performance"
>>> +
>>> +. ./perf-lib.sh
>>> +
>>> +test_perf_large_repo
>>> +test_checkout_worktree
>>> +
>>> +test_expect_success 'setup untracked directory with many sub dirs'=
 '
>>> +     rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>>> +     mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>>> +     for i in $(seq 1 500)
>> I think "seq" is bash-only, and can be easily replaced by "test_seq"
>
> test_seq is definitely desirable. 'seq' is not present on some system=
s I use.
>
>>
>>> +     do
>>> +             mkdir 500_sub_dirs/dir$i
>
> You may want:
>
>     mkdir 500_sub_dirs/dir$i || return $?
>
> to catch failure of 'mkdir'.
>
>>> +     done &&
>>> +     for i in $(seq 1 100)
>>> +     do
>>> +             cp -r 500_sub_dirs 50000_sub_dirs/dir$i
>
> Ditto:
>
>     cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?
>
>>> +     done
>>> +'
>>> +
>>> +test_perf 'clean many untracked sub dirs, check for nested git' '
>>> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>>> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
>>> +     git clean -q -f -d  clean_test_dir/ &&
>>> +     test 0 =3D $(ls -A clean_test_dir/ | wc -l)
>>
>> Is the "ls -A" portable on all systems:
>> http://pubs.opengroup.org/onlinepubs/009695399/utilities/ls.html
>>
>> My feeling is that the "emptiness" of a directory can by tested by s=
imply removing it:
>>> +     git clean -q -f -d  clean_test_dir/ &&
>>> +     rmdir clean_test_dir
>> (And similar below)
>
> There's also the test_dir_is_empty() function which makes the intent
> even clearer than 'rmdir'.
