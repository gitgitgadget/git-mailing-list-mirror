From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 14:07:28 -0500
Message-ID: <CAMP44s1NRMbk2DpgyWqnyEKV+WkxAg1Gjn3UZQKMopJUDBZ4jw@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
	<7vhaj37nr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 21:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USuBD-0001ze-6L
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab3DRTHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:07:31 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38377 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3DRTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:07:30 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so3019387lbi.39
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U1p2RYyOv3p5FYF07H4CBjTooweBgRKMmJxOzMwkG4E=;
        b=V1/Ysg6IVb9X2Grq90emYl0KkhF7S92jF2nvBz15vCU9Uled5noMM/9TwqXwDB8QxJ
         Z43nZ3OHYTURs5+DxzxGpUDsWPfCCKou6Tn+NhGQqcQLDuufuleP8tk86dnSulwrNDd4
         rIhPsjHax5eO1xWP4RZjXpWaZMVj0wayqFH6x4P47N982+ftclMrzPrXEVEElf08oBMh
         oGWtxHpNEX0ltT/RijsAG6ixqQvoM91R/u7im52TQQjJ8vqep3+zARdcf4quN8Y9/eL7
         CHMpIU3W/6MFujaU2ByCqOvfrBgrQC/4rZdyBUn6/QqfhSkhfxpbXrjoPsJ4v3u/xyl8
         dYYA==
X-Received: by 10.112.135.3 with SMTP id po3mr3379928lbb.103.1366312048950;
 Thu, 18 Apr 2013 12:07:28 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 12:07:28 -0700 (PDT)
In-Reply-To: <7vhaj37nr5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221683>

On Thu, Apr 18, 2013 at 12:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The *:* refspec doesn't work, and never has, clarify the code and
>> documentation to reflect that. This in effect reverts commit 9e7673e
>> (gitremote-helpers(1): clarify refspec behaviour).
>> ...
>>  applicable refspec takes precedence.  The left-hand of refspecs
>>  advertised with this capability must cover all refs reported by
>> -the list command.  If a helper does not need a specific 'refspec'
>> -capability then it should advertise `refspec *:*`.
>> +the list command.  If no 'refspec' capability is advertised,
>> +there is an implied `refspec *:*`.
>
> I presume
>
>     s/.$/, but `*:*` does not work so do not use it./
>
> is implied?

I believe

  s/.$/, but you should specify an apropriate one as described above./

Would be better.

>> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
>> index f387027..cd1873c 100755
>> --- a/t/t5801-remote-helpers.sh
>> +++ b/t/t5801-remote-helpers.sh
>> @@ -120,21 +120,6 @@ test_expect_failure 'pushing without refspecs' '
>>       compare_refs local2 HEAD server HEAD
>>  '
>>
>> -test_expect_success 'pulling with straight refspec' '
>> -     (cd local2 &&
>> -     GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
>> -     compare_refs local2 HEAD server HEAD
>> -'
>
> This one made me raise my eyebrows, first.
>
> The only reason this test "passes" is because this particular
> "pull", due to what local2 and server happens to have before this
> test runs, is an "Already up-to-date" and a no-op.  You are removing
> this because it is not really testing anything useful, and if you
> change it to test something real, e.g. by rewinding local2, it will
> reveal the breakage.
>
> Am I reading you correctly?

Not really. This particular fetch does work, and it's tricky to
explain all the reasons why, even if you update the server ref before
fetching. The reason it's written this way is that it comes from from
a branch of mine that has a hack to make the push above works, and
since the transport-helper's push doesn't update the ref in this
version, the test did actually do something and was working.

I am removing the test because we don't care if it works or not,
remote-helpers should not be doing that. The fact that the test wasn't
actually doing anything is icing on the cake.

Cheers.

-- 
Felipe Contreras
