From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 07/29] Added test cases for "guilt fold".
Date: Wed, 14 May 2014 10:49:51 +0200
Message-ID: <CAP=KgsTNP0L98Pdnyd5qZ9422+xGmomcpVVMSAD+2DHRAa0KkA@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-8-git-send-email-cederp@opera.com>
	<20140513213024.GF4791@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 14 10:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkUsv-0006YI-BL
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 10:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbaENIty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 04:49:54 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57318 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbaENItw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 04:49:52 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so1483446iec.25
        for <git@vger.kernel.org>; Wed, 14 May 2014 01:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nyYBuXFzmS2lrbXq8HcCprjHs67yGlnwcmSA+L2hI/w=;
        b=CNU/PGAbEkhzDpXAgbinV76nzqQRGVspbGnnegfSTPqgrMjU5I773Mg5PbZorIJKod
         aqaPblOaBnL+3DIuQyASsAKJUrsSYNyOj2iztuB+7m2sNHhz54U5xpQoZHXgfnFIBqFg
         PtQKszXY74Ee4eKXbtR9HXJJoCcEogHGZAw9vt27DibPmYicPCe+b/mTbpypryRt6goV
         VNGKZvRL2pCiZFI/4hokXm/ZOrEGSpOvThc28ljFYRR3G/RMVNfj8CFY9kABGrMpdR28
         S6cHv8AxVicGKMMwFz4cspf1S2DBjmrJ2jesu0GbMG+p9pVXJjVAYjrRbGkcl8MQk+qe
         Tt3A==
X-Gm-Message-State: ALoCoQnOzHVm8bicYs5jvnF+DlaPCerXiStYzrgzq+qjvY+TpY+SnIG/a6jn2logCVlygrZpBmqJ
X-Received: by 10.50.147.9 with SMTP id tg9mr65099577igb.31.1400057392026;
 Wed, 14 May 2014 01:49:52 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 14 May 2014 01:49:51 -0700 (PDT)
In-Reply-To: <20140513213024.GF4791@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248898>

On Tue, May 13, 2014 at 11:30 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 10:30:43PM +0200, Per Cederqvist wrote:
>> Test that we can combine any combination of patches with empty and
>> non-empty messages, both with and without guilt.diffstat.  (All
>> patches are empty.)
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  regression/t-035.out | 467 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-035.sh  |  62 +++++++
>>  2 files changed, 529 insertions(+)
>>  create mode 100644 regression/t-035.out
>>  create mode 100755 regression/t-035.sh
>>
> ...
>> diff --git a/regression/t-035.sh b/regression/t-035.sh
>> new file mode 100755
>> index 0000000..e914b32
>> --- /dev/null
>> +++ b/regression/t-035.sh
>> @@ -0,0 +1,62 @@
>> +#!/bin/bash
>> +#
>> +# Test the fold code
>> +#
>> +
>> +source "$REG_DIR/scaffold"
>> +
>> +cmd setup_repo
>> +
>> +function fixup_time_info
>> +{
>> +     cmd guilt pop
>> +     touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
>> +     cmd guilt push
>> +}
>> +
>> +function empty_patch
>> +{
>> +     cmd guilt new "empty$1"
>> +     fixup_time_info "empty$1"
>> +}
>> +
>> +function nonempty_patch
>> +{
>> +     if [ "$1" = -2 ]; then
>> +             msg="Another commit message."
>> +     else
>> +             msg="A commit message."
>> +     fi
>> +
>> +     cmd guilt new -f -s -m "$msg" "nonempty$1"
>> +     fixup_time_info "nonempty$1"
>> +}
>> +
>> +for using_diffstat in true false; do
>> +     cmd git config guilt.diffstat $using_diffstat
>> +     for patcha in empty nonempty; do
>> +             for patchb in empty nonempty; do
>> +
>> +                     if [ $patcha = $patchb ]
>> +                     then
>
> I know that this is before patch 29, but ... style? ;)
>
> Otherwise, looks good.  I like this way better than the unrolled loop in v1
> of this patch.
>
> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

It is hard to change a habit. :-)

I'll fix this and add your signed-off-by.

    /ceder

>
>> +                             suffixa=-1
>> +                             suffixb=-2
>> +                     else
>> +                             suffixa=
>> +                             suffixb=
>> +                     fi
>> +
>> +                     echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
>> +                     ${patcha}_patch $suffixa
>> +                     ${patchb}_patch $suffixb
>> +                     cmd guilt pop
>> +                     cmd guilt fold $patchb$suffixb
>> +                     fixup_time_info $patcha$suffixa
>> +                     cmd list_files
>> +                     cmd guilt pop
>> +                     cmd guilt delete -f $patcha$suffixa
>> +                     cmd list_files
>> +
>> +             done
>> +     done
>> +done
>> --
>> 1.8.3.1
>>
>
> --
> *NOTE: This message is ROT-13 encrypted twice for extra protection*
