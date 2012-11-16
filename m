From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 5/6] completion: refactor __gitcomp related tests
Date: Fri, 16 Nov 2012 20:53:56 +0100
Message-ID: <CAMP44s2ESxhQQGxy-E4LpiBwPnZLgVwBFDk4Ck90ySTXdC=DYA@mail.gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
	<1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
	<7v8va1mkcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZRzP-0005My-TH
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab2KPTx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:53:57 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63325 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab2KPTx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:53:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3153666obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bosAkvNeMEqIpqewMrM0PE3d9Qzw37lhiwpZ746dbXI=;
        b=D9uQJNvmFaWqJ7Xig1huNd2k5GGLky5yilQ7Axdg1REr7CGJuLfhhpyT1L0QY7eNaR
         ZBeJ7OovrlxTpTrExhotPB4WViONhIGpFjW3MQC87HLf3h1anSArtWlx2lgHzWKHkomq
         Y2kJrYeXBJx3ydM6KOHfHqM1MqHnDIIrprYMHfWa2vg8StsIrlLRSRAS+Z0M3pUbnneX
         RFo5HhVywx/aMwweVXqq/r6OVXZiNo/1ZC+3eDeDE3m6slH7f0AWaBwUZyZUe3shmLh3
         MOnJ0MIGG0X3FU6Ez0FGd02fw8X7ta9TaQa+rNsTTUJDI2jJfPJvAfkiAhdH2t6wngUq
         RWdw==
Received: by 10.182.10.6 with SMTP id e6mr4799835obb.16.1353095636869; Fri, 16
 Nov 2012 11:53:56 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 11:53:56 -0800 (PST)
In-Reply-To: <7v8va1mkcv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209898>

On Fri, Nov 16, 2012 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Not asking for a re-roll but am asking for clarification so that I
> can locally update before queuing.
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Lots of duplicated code!
>
> ... removed, you mean?

Yes.

>> No functional changes.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 76 ++++++++++++++++++---------------------------------
>>  1 file changed, 27 insertions(+), 49 deletions(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 59cdbfd..66c7af6 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -71,87 +71,65 @@ test_completion ()
>>
>>  newline=$'\n'
>>
>> -test_expect_success '__gitcomp - trailing space - options' '
>> -     sed -e "s/Z$//" >expected <<-\EOF &&
>> -     --reuse-message=Z
>> -     --reedit-message=Z
>> -     --reset-author Z
>> -     EOF
>> +# Test __gitcomp.
>> +# Arguments are:
>> +# 1: typed text so far (cur)
>> +# *: arguments to pass to __gitcomp
>
> s/\*/remainder/, perhaps?  I think you shift $1 out and do not pass
> it to __gitcomp.

Right, by * I meant the rest.

> And expected output is from the standard input just like
> test_completion?

Correct.

>> +test_gitcomp ()
>> +{
>> +     sed -e 's/Z$//' > expected &&
>>       (
>>               local -a COMPREPLY &&
>> -             cur="--re" &&
>> -             __gitcomp "--dry-run --reuse-message= --reedit-message=
>> -                             --reset-author" &&
>> +             cur="$1" &&
>> +             shift &&
>> +             __gitcomp "$@" &&
>>               IFS="$newline" &&
>>               echo "${COMPREPLY[*]}" > out
>>       ) &&
>>       test_cmp expected out
>> +}
>> +
>> +test_expect_success '__gitcomp - trailing space - options' '
>> +     test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
>> +             --reset-author" <<-EOF
>> +     --reuse-message=Z
>> +     --reedit-message=Z
>> +     --reset-author Z
>> +     EOF
>>  '
>
> Nice shrinkage.

That's a comment about the whole patch series I hope :)

Cheers.

-- 
Felipe Contreras
