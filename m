From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v3 09/31] Test suite: properly check the exit status of commands.
Date: Sun, 18 May 2014 21:12:59 +0200
Message-ID: <CAP=KgsSXL=rGb0PABSHQVBB1izZMKnxMVxegdu7NZAfSoRAHSQ@mail.gmail.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
	<1400251578-17221-10-git-send-email-cederp@opera.com>
	<20140516154513.GI1770@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sun May 18 21:13:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm6W9-0000xY-KT
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 21:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbaERTNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 15:13:00 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34344 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaERTM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 15:12:59 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so2662593igb.6
        for <git@vger.kernel.org>; Sun, 18 May 2014 12:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iS9uE71J+sPSBK/QVAWwakYcl4R/S70aLsEILwjBZeU=;
        b=Wfs30Pe1UCj+/Sjyokg7v+tAwbvT5+P/NwogMgVokoGrppwktciFpmF1MAoDY8XREI
         ct2ut2XJzS4O7g85PEQrzfDiHxpBjn84KRaNpDZZ0rO2bUrQYlq6CK/4ZyWrqc9yJBBU
         Y/Ucl+/uAunowLFw/IAYEM2OUAL6lIVkeQDlnc0Lj99vLc2ziMHsd53PdLiaRgi9MZ0e
         WJugkdn2PE+eB4BejnyTvBUG4DRJ8VwK7mydx0fAPQdpy1Py8XaZzKygmT+wUWTotDvj
         27y963s3Oa6hOxLEuKrKnqHRzby6Rx5g6E67V7Rp+tttrh8lySNCp1S5RsFhrKmsovqm
         Uetw==
X-Gm-Message-State: ALoCoQkLNCPiz78yyGrr1tTYINjhVDZ2roRXJrdEBkrd0UTN/cV18mwYlhMZyMu1yPX6Ct+elIvb
X-Received: by 10.50.79.161 with SMTP id k1mr11976138igx.31.1400440379288;
 Sun, 18 May 2014 12:12:59 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Sun, 18 May 2014 12:12:59 -0700 (PDT)
In-Reply-To: <20140516154513.GI1770@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249506>

On Fri, May 16, 2014 at 5:45 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Fri, May 16, 2014 at 04:45:56PM +0200, Per Cederqvist wrote:
>> The "cmd" and "shouldfail" functions checked the exit status of the
>> replace_path function instead of the actual command that was running.
>> (The $? construct checks the exit status of the last command in a
>> pipeline, not the first command.)
>>
>> Updated t-032.sh, which used "shouldfail" instead of "cmd" in one
>> place.  (The comment in the script makes it clear that the command is
>> expected to succeed.)
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  regression/scaffold | 17 +++++++++++------
>>  regression/t-032.sh |  2 +-
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/regression/scaffold b/regression/scaffold
>> index 5c8b73e..e4d7487 100644
>> --- a/regression/scaffold
>> +++ b/regression/scaffold
>> @@ -51,18 +51,23 @@ function filter_dd
>>  function cmd
>>  {
>>       echo "% $@"
>> -     "$@" 2>&1 | replace_path && return 0
>> -     return 1
>> +     (
>> +             exec 3>&1
>> +             rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
>
> Wow.  This took a while to decipher :)

Ancien wisdom from the "Csh Programming Considered Harmful"
article: http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/

These functions work only because of the "set -e" earlier in scaffold.
The final return statements are not actually reached. I don't like that.
So the next version of the patch series will print an explicit message
like "% FAIL: The above command should succeed but failed." or
"% FAIL: The above command should fail but succeeded." and do
an explicit "exit 1" on failure. I think it makes it easier to debug issues.
(I recently spent a few hours trying to figure our why the test just silently
exited. Turns out the old git version I was running didn't like my .gitconfig,
so it exited with a non-zero exit code...)

> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

I'll let you re-check the next version of the code.

    /ceder

>> +             exit $rv
>> +     )
>> +     return $?
>>  }
>>
>>  # usage: shouldfail <cmd>..
>>  function shouldfail
>>  {
>>       echo "% $@"
>> -     (
>> -             "$@" 2>&1 || return 0
>> -             return 1
>> -     ) | replace_path
>> +     ! (
>> +             exec 3>&1
>> +             rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
>> +             exit $rv
>> +     )
>>       return $?
>>  }
>>
>> diff --git a/regression/t-032.sh b/regression/t-032.sh
>> index b1d5f19..bba401e 100755
>> --- a/regression/t-032.sh
>> +++ b/regression/t-032.sh
>> @@ -28,7 +28,7 @@ shouldfail guilt import -P foo3 foo
>>  cmd guilt import -P foo2 foo
>>
>>  # ok
>> -shouldfail guilt import foo
>> +cmd guilt import foo
>>
>>  # duplicate patch name (implicit)
>>  shouldfail guilt import foo
>> --
>> 1.8.3.1
>>
>
> --
> Fact: 28.1% of all statistics are generated randomly.
