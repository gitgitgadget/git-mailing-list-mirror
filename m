From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule: fix recursive execution from non root directory
Date: Fri, 25 Mar 2016 10:27:02 -0700
Message-ID: <CAGZ79kYGbdAonKwTcQACFRKKZ-6GJRVsXHu7nO9fXaUNoToP-w@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-3-git-send-email-sbeller@google.com>
	<xmqqtwju4iaj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:27:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVVv-0000BT-18
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbcCYR1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:27:06 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35280 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbcCYR1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:27:04 -0400
Received: by mail-ig0-f179.google.com with SMTP id cl4so16133039igb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hlA+92HW74C+/fF0NnqN6Q72aqeNugKRq66JaTNRT70=;
        b=ek64DAH1+zbtWxz/EMH78v/AsRpSsJvdeS24rH3r+hMuB+ADu2/3IthAu5I6MJwlbs
         mLBFS4hO5zjxjcucvPGPYmmW54m3RjEfbCD8j+9JAfMgY9Vjap7IFXUJx1Z3GWMFO0wV
         ihjRdQPRSex7yDKQheWwHhFlheLf8XehrpQKS+p98YMMg0D8ilAnt3Pa2S5CgEpCf93w
         CuqCKc3CBXKA9xc3cN+3t8qVk5Vs3vsUrMBEz98R6pOG5Q8ygkBsf/Ovswd100Tr3v5h
         MqWXk71ZXkHC8fWy/h0CIA8qlf3VKBpb6CZZgJMfzcSMzJN2MvBKW3x2Sd65A2Dnov6g
         EQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hlA+92HW74C+/fF0NnqN6Q72aqeNugKRq66JaTNRT70=;
        b=DbhgO6VM8uFjUvUM0D33OV6CqkeW3sUFBp8lix1Eeb7LztGnWORtmljYFmVJ4sJKKL
         H2z8LlNqGdEsrmh4QZokWb5EnhLv0tXCnV/jt80HPR/OEcasbiz+X1CcoIKeRrsDYJgq
         S3oDfdE7wTNoVn3/Bp/IlajjMeMkrQtVn1DSwqJKqy4UOXpwvQGQMVQDARTeTRZZedBI
         HHk4qEOtJogArHyXq6QFpaWi9OqS/9xMx6M3NBEfLm4nPZtharMpbJwZDqQsJ7niSW7Z
         aofx8/+VyoIBYhu9mlFc1+2sCCrRvDPn+3tlnnJYCPFbkEwebnlZh/Mp0ue+WutJXpfF
         8pkQ==
X-Gm-Message-State: AD7BkJKYEBN2RHI8plPPtGXFNnvv8O7MW5aC21ov1mO+2wHd71z+RHJM9nKT5aIAeg1p/znMV4Mv3vCNLeDYMzm1
X-Received: by 10.50.112.10 with SMTP id im10mr15658070igb.93.1458926822348;
 Fri, 25 Mar 2016 10:27:02 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 10:27:02 -0700 (PDT)
In-Reply-To: <xmqqtwju4iaj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289911>

On Fri, Mar 25, 2016 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Most times that directory doesn't exist and we error out. Fix this bug
>> by clearing wt_prefix, such that any recursive instances of will assume
>> to operate from the respective root of the respective submodule.
>
> As long as the recursive instances do not take any filenames and
> pathspecs that needs adjustment with respect to the prefix, this
> would be an OK change; I am not sure if that precondition holds,
> though.

If we give filenames and pathspecs relative to the prefix in a submodule,
the filename is not recognized by the superproject which would produce an
error at the superproject. Monkey-testing locally here supports my suspicion
and it is not possible to do things like

    git submodule status path/inside/submodule

so if that is already not working, we should not expect to have

    git -C subdir  submodule status ../path/inside/submodule

working.





>
> Thanks.
>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 536ba68..6b18a03 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -827,6 +827,7 @@ Maybe you want to use 'update --init'?")"
>>                       (
>>                               prefix="$(relative_path $prefix$sm_path)/"
>>                               clear_local_git_env
>> +                             wt_prefix=
>>                               cd "$sm_path" &&
>>                               eval cmd_update
>>                       )
>> @@ -1159,6 +1160,7 @@ cmd_status()
>>                       (
>>                               prefix="$displaypath/"
>>                               clear_local_git_env
>> +                             wt_prefix=
>>                               cd "$sm_path" &&
>>                               eval cmd_status
>>                       ) ||
>> @@ -1240,6 +1242,7 @@ cmd_sync()
>>
>>                               if test -n "$recursive"
>>                               then
>> +                                     wt_prefix=
>>                                       eval cmd_sync
>>                               fi
>>                       )
