From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 22:59:28 +0100
Message-ID: <CAMP44s3SeGgyAq_5G=t3iR8LB0Yo7drh7Hc4poo6eEbsS-i_yA@mail.gmail.com>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
	<20121119151845.GA29678@shrek.podlesie.net>
	<7vk3thxuj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaZNY-0005JV-HK
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab2KSV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 16:59:30 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50897 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab2KSV73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 16:59:29 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5324552oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t09xU1SFyIOYhlvKyYEv57Q2VFfiT/+zB69fVPnvP0k=;
        b=iWYGyKwrZUczzIAy2JzUoLOV2BZ71yZUHoJgnBWeNPPqNF6Rs7UZfCPAYoB8P0xgFI
         eeJBU+jb7OS0xs5gpZ/98GYk1T9N/aiUG5PwLTMyFv1KWjc0igLKKnTmTbqG3fQgEP9s
         rRWWT3fF5Dl22bZUTbUjlD62GY2zjhnRVUva5kvUF19qzNAWJS0y079mBfLdUhnwh4RX
         2Tj7OwjDwb/yzGFOjO/tzw8k4fBoItxB1zD5pXAAQlC+jL77AEYJrX9MhzH8dhueMinE
         wxUNZ/V2qumV3CdUEqL2/Gg6vOtIkVU5XcHPXUc3sDkxItvmM3oaesNZWLKnWoyEUcRq
         /dHw==
Received: by 10.182.194.70 with SMTP id hu6mr11788986obc.4.1353362369063; Mon,
 19 Nov 2012 13:59:29 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 19 Nov 2012 13:59:28 -0800 (PST)
In-Reply-To: <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210059>

On Mon, Nov 19, 2012 at 8:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
>
>> On Mon, Nov 19, 2012 at 11:57:47AM +0200, Felipe Balbi wrote:
>>> Hi guys,
>>>
>>> for whatever reason my git has started acting up with
>>> stable@vger.kernel.org addresses. It doesn't manage to extract a valid
>>> adress from the string:
>>>
>>>  Cc: <stable@vger.kernel.org> # v3.4 v3.5 v3.6
>>>
>>> Removing the comment at the end of the line makes things work again. I
>>> do remember, however, seeing this working since few weeks back I sent a
>>> mail to stable (in fact the same one I'm using to test), so this could
>>> be related to some perl updates, who knows ?!?
>>
>> You probably just installed Email::Valid package.
>>
>> The current git-send-email works a little better and just prints an error:
>>
>> W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4 v3.5 v3.6
>>
>>
>> This patch should fix the problem, now after <email> any garbage is
>> removed while extracting address.
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 5a7c29d..bb659da 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -828,7 +828,7 @@ sub extract_valid_address {
>>       # check for a local address:
>>       return $address if ($address =~ /^($local_part_regexp)$/);
>>
>> -     $address =~ s/^\s*<(.*)>\s*$/$1/;
>> +     $address =~ s/^\s*<(.*)>.*$/$1/;
>>       if ($have_email_valid) {
>>               return scalar Email::Valid->address($address);
>>       } else {
>
> Given that the problematic line
>
>         Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y
>
> is not even a valid e-mail address, doesn't this new logic belong to
> sanitize_address() conceptually?

That would be great, it would also help the cc-cmd stuff. The
get_maintainer.pl patch from the Linux kernel outputs something like:

David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Ben Skeggs <bskeggs@redhat.com>
(commit_signer:17/19=89%,commit_signer:43/46=93%)
Maxim Levitsky <maximlevitsky@gmail.com> (commit_signer:3/19=16%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/19=11%)
Dave Airlie <airlied@redhat.com> (commit_signer:2/19=11%,commit_signer:3/46=7%)
Alex Deucher <alexander.deucher@amd.com> (commit_signer:1/19=5%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

-- 
Felipe Contreras
