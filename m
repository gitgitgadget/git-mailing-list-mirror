From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] p7300: added performance tests for clean
Date: Mon, 6 Apr 2015 18:09:46 -0400
Message-ID: <CAPig+cRSv0qsctJ_2-ZH2y_E7kU_f787ate_5CnnKHE+vBddNw@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-3-git-send-email-erik.elfstrom@gmail.com>
	<5522EF29.9000008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfFDM-0003Qe-R0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 00:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbbDFWJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 18:09:48 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33989 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbDFWJr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 18:09:47 -0400
Received: by laat2 with SMTP id t2so22106616laa.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oMAgi4usb89RuGBaVie3AwoB1UJ6dPXVfvQsB3VceEI=;
        b=cMHhnhpicZ2vy1EJlUjhrXtHytT7jaXf2rp3oKiYNxNtikCdOFtZoVXFYIE328IC07
         OaeG3eMPaBBmeWnOF0FbTO8Mgor7mk2f77rk1WnrZtcCjYpX3kqsEMXbV2mvO82MUpkb
         790BNUl6Rb7cDle4aRIvnOkQxCrpr07zDvwUOfvOOWLce+I3jrRTm8LUAp9PddxARgFU
         qEZsixgUB2rDBHNkQUKaQ9ghQcXjfdgtx1f5emMPqpQZ0uMGFnzroN9SsxAZ0xmnPyxZ
         WniA7xUtz6SlaKbV7NwXJIknjdohj+ggDikww16ePq1W60hgpLRXCfBMCSeY40vnaWsW
         8sRw==
X-Received: by 10.112.146.129 with SMTP id tc1mr15078727lbb.27.1428358186515;
 Mon, 06 Apr 2015 15:09:46 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 15:09:46 -0700 (PDT)
In-Reply-To: <5522EF29.9000008@web.de>
X-Google-Sender-Auth: rfX8IuEuJaaMkUI_e8ABVmrn5xQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266891>

On Mon, Apr 6, 2015 at 4:40 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2015-04-06 13.48, Erik Elfstr=C3=B6m wrote:
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> ---
>> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
>> new file mode 100755
>> index 0000000..3f56fb2
>> --- /dev/null
>> +++ b/t/perf/p7300-clean.sh
>> @@ -0,0 +1,37 @@
>> +#!/bin/sh
>> +
>> +test_description=3D"Test git-clean performance"
>> +
>> +. ./perf-lib.sh
>> +
>> +test_perf_large_repo
>> +test_checkout_worktree
>> +
>> +test_expect_success 'setup untracked directory with many sub dirs' =
'
>> +     rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>> +     mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
>> +     for i in $(seq 1 500)
> I think "seq" is bash-only, and can be easily replaced by "test_seq"

test_seq is definitely desirable. 'seq' is not present on some systems =
I use.

>
>> +     do
>> +             mkdir 500_sub_dirs/dir$i

You may want:

    mkdir 500_sub_dirs/dir$i || return $?

to catch failure of 'mkdir'.

>> +     done &&
>> +     for i in $(seq 1 100)
>> +     do
>> +             cp -r 500_sub_dirs 50000_sub_dirs/dir$i

Ditto:

    cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?

>> +     done
>> +'
>> +
>> +test_perf 'clean many untracked sub dirs, check for nested git' '
>> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
>> +     git clean -q -f -d  clean_test_dir/ &&
>> +     test 0 =3D $(ls -A clean_test_dir/ | wc -l)
>
> Is the "ls -A" portable on all systems:
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/ls.html
>
> My feeling is that the "emptiness" of a directory can by tested by si=
mply removing it:
>> +     git clean -q -f -d  clean_test_dir/ &&
>> +     rmdir clean_test_dir
> (And similar below)

There's also the test_dir_is_empty() function which makes the intent
even clearer than 'rmdir'.
