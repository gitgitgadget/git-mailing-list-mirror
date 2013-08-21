From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 3/3] Revert "bash prompt: avoid command substitution when
 finalizing gitstring"
Date: Wed, 21 Aug 2013 15:08:25 -0700
Message-ID: <CA+sFfMc0BPo8pSLngi=bAWxYNT8xKFEOo77z3a12q+-Sq4qiiA@mail.gmail.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
	<1377118173-23405-3-git-send-email-bcasey@nvidia.com>
	<xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, szeder@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGZr-0006mw-6V
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab3HUWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:08:27 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:44450 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3HUWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:08:26 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so965692wes.10
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J2FHjz6zvYZ0X0CoUFUUmwrVZlWpHe8pKkGwmimxsBA=;
        b=nm6zlsu/TD9+er+ksIXMF3Y7SnJnOyiFGrkYZeTEUrqOrjnXCM/VoO+JSUnR91c0qi
         pPPyXSN3vyiME7nV+AtNQtdL95vo2UfjpWHfChfvEjQq19jdVJJH+xAd74E/D5O3EVQi
         KgEYLLVDZ2n4h7RYxnX8Rq3a7CHTkWmVTmL18jxZRCb55u321mJcd3D4Vec39D0U/zBP
         KScm3XCXFctycczqfmrY3hUYTXTsP1Bv3rmdjCqSJqVEskuKxw8VfYiZG7i/DYM5i/LT
         RGnOVen5lHWfc82bQTK2eDBm9PhkIhpKNAIyY+tFbyq166hz9zuF4WtyK77E4sK8c/V0
         G3aA==
X-Received: by 10.180.212.51 with SMTP id nh19mr7148709wic.14.1377122905452;
 Wed, 21 Aug 2013 15:08:25 -0700 (PDT)
Received: by 10.194.85.168 with HTTP; Wed, 21 Aug 2013 15:08:25 -0700 (PDT)
In-Reply-To: <xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232742>

On Wed, Aug 21, 2013 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <bcasey@nvidia.com> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> This reverts commit 69a8141a5d81925b7e08cb228535e9ea4a7a02e3.
>>
>> Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
>> platforms that are still in wide use, does not have a printf that
>> supports -v.  Let's revert this patch and go back to using printf
>> in the traditional way.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>
> Is this something you can detect at load-time once, store the result
> in a private variable and then switch on it at runtime, something
> along the lines of...
>
>
>         # on load...
>         printf -v __git_printf_supports_v -- "%s" yes >/dev/null 2>&1
>
>         ...
>
>         if test "${__git_printf_supports_v}" = yes
>         then
>                 printf -v gitstring -- "$printf_format" "$gitstring"
>         else
>                 gitstring=$(printf -- "$printf_format" "$gitstring")
>         fi

Yes, that appears to work.

-Brandon


>>  contrib/completion/git-prompt.sh | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index a81ef5a..7698ec4 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -433,11 +433,7 @@ __git_ps1 ()
>>       local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
>>
>>       if [ $pcmode = yes ]; then
>> -             if [[ -n ${ZSH_VERSION-} ]]; then
>> -                     gitstring=$(printf -- "$printf_format" "$gitstring")
>> -             else
>> -                     printf -v gitstring -- "$printf_format" "$gitstring"
>> -             fi
>> +             gitstring=$(printf -- "$printf_format" "$gitstring")
>>               PS1="$ps1pc_start$gitstring$ps1pc_end"
>>       else
>>               printf -- "$printf_format" "$gitstring"
