From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Mon, 18 May 2015 11:18:44 -0700
Message-ID: <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 18 20:18:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPcp-0007hF-L7
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbbERSSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:18:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36781 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbERSSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:18:46 -0400
Received: by igbpi8 with SMTP id pi8so55798363igb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oD/A7rkOseMh1ONuEYoJxUUW9ZCJOm8DMaHdo2DqaWs=;
        b=irC5wG3WA3+0f9N9YG4wx6De9pcKOJRr+K0HAjXWufspLGHhlr4NxCOTYbXjWNtyIR
         p2FDLfJABo6iMF06WWAW32zjk1Z1038bzOVu4YJvjvYQBK/xrqmuFR/TdbaDK14F2Z3a
         he36v8pUzVkTENOcLdOahFl25a3su6SyLEtz7aVoBI6MUPe5/JZodLDHEcaNiaEk6VBo
         0CE9Pzg41/yJNYkCxh8e/iS7lFYwR53H3mGxjnAOkPmo/Hx1BkeFyq/W8KA4yCgiE99i
         tiOdZSNgu+PVqoVdGC0iJ/Ya/+yeYyV2T0BIYYWwpfy7vgBQqabL0ayYDfJY7O0yy8Co
         aE5A==
X-Received: by 10.107.9.88 with SMTP id j85mr4184360ioi.39.1431973125680;
        Mon, 18 May 2015 11:18:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id g1sm7866541iog.4.2015.05.18.11.18.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:18:45 -0700 (PDT)
In-Reply-To: <5661061272076a1883cfde1087be4a42@www.dscho.org> (Johannes
	Schindelin's message of "Mon, 18 May 2015 16:53:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269292>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Paul,
>
> On 2015-05-18 15:39, Paul Tan wrote:
>
>> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
>> index 8cccecc..eebb8c9 100755
>> --- a/t/t5524-pull-msg.sh
>> +++ b/t/t5524-pull-msg.sh
>> @@ -17,6 +17,9 @@ test_expect_success setup '
>>  		git commit -m "add bfile"
>>  	) &&
>>  	test_tick && test_tick &&
>> +	echo "second" >afile &&
>> +	git add afile &&
>> +	git commit -m "second commit" &&
>>  	echo "original $dollar" >afile &&
>>  	git add afile &&
>
> I completely forgot to send a mail last time where I wanted to mention
> the test_commit function. I *think* that above invocation is
> equivalent to
>
>     test_commit "second commit" afile second
>
> with the additional benefit that `test_tick` is called
> automatically. Maybe you want to use that more concise function call?

Sounds like a good idea especially when you are testing commands
that does not do things to tags implicitly.

I have been in love-hate relation with test_commit for a long time.
It is very nice that it gives us ticks (i.e. reproducible object
names) automatically and reduces the chance for new tests to forget
to do so, but I found it extremely annoying that it wants to always
add a light-weight tag to every commit it creates.

I suspect that this design decision largely comes from the fact that
back then we did not exactly trust the syntax like "master~3" and
wanted to have a set of fixed points, but often these auto-generated
tags get in the way by either contaminating the refs namespaces (and
we are testing pull here, which worries me that test authors need to
be aware that these tags may be transferred to the destination) or
anchoring the objects in the object database (e.g. when writing
"reset --hard branch branch~3 && prune" tests, you need to remember
to kill these tags).

So I dunno.  I really wish test_commit didn't create tags and either
left the tagging to the calling script.
