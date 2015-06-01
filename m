From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: allow multiple emails using --cc, --to and --bcc
Date: Mon, 01 Jun 2015 09:52:39 -0700
Message-ID: <xmqqmw0j74mg.fsf@gitster.dls.corp.google.com>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqqiob78nij.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:52:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSxG-00016T-ON
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbbFAQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 12:52:47 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35754 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbbFAQwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:52:43 -0400
Received: by igbyr2 with SMTP id yr2so66668832igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YV2GK+5Fu8T1uOuYzXgZihuIFmMIp0Yx98yiiDKUMEQ=;
        b=si2G94jAEvZzidicQ2KPBqXT+fo/xTGNkiVJNXbNDe5oSWSSoaMcOE3qqaHF3+v6qy
         nSNqBe7Ht2yayuixAzNYDUTf1kVNCQgepIpruEjiAqCHpgjL8S1aQxcd4lvtIclRY74m
         iorX5ewr2wviW1U+JjbQi37JgrOhOnvqSBVzcIoDK0vCumInNVFJCqetu/PpirNaGU89
         vhWXT6b/ULS8zzzc7cBJ6lXtqwMk6HJt4nqY/QCpUKxp1InV7iJTYVoRpCv1b9oFX5Px
         qutnox/oB/wDUwIjpplno0AJXlsy8r3ab39dSd64mWqlcayHTF/04aVW9SMgSQAcyHeM
         5XxQ==
X-Received: by 10.43.162.136 with SMTP id mk8mr29622893icc.28.1433177561642;
        Mon, 01 Jun 2015 09:52:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id y124sm10761126iod.13.2015.06.01.09.52.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 09:52:41 -0700 (PDT)
In-Reply-To: <xmqqiob78nij.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 08:19:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270437>

Junio C Hamano <gitster@pobox.com> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> Accept a list of emails separated by commas in flags --cc, --to and
>> --bcc.  Multiple addresses can already be given by using these options
>> multiple times, but it is more convenient to allow cutting-and-pasting
>> a list of addresses from the header of an existing e-mail message,
>> which already lists them as comma-separated list, as a value to a
>> single parameter.
>>
>> The following format can now be used:
>>
>>     $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'
>>
>> However format using commas in names doesn't work:
>>
>>     $ git send-email --to='"Jane, Doe" <jdoe@example.com>'
>
> That looks as if you are doing "Remi, Lespinet", which is not a good
> example.  I think you want "Doe, Jane", the use of comma is when a
> name is spelled in the "LastName, FirstName" order.

Having thought about this topic (not how the example should be
spelled in the log message ;-) a bit more, I do not think the
implementation of split_address_list_items in this patch is
acceptable.

The reason why we have the "verify the input" thing, allow users to
supply multiple --to/--cc/etc., and do not try to split the
addresses ourselves is because we want to avoid mistakenly splitting
a single address like the above into two and producing syntactically
incorrect addresses.  People have relied on the current behaviour
for a long time, without manually dropping comma when they send
their patches with --to='"Jane, Doe" <jdoe@example.com>'.

Until we can reliably split the address list, accepting this patch
will introduce a regression.

Note that I do agree with the goal of this series and appreciate the
effort.  I am only rejecting the current implementation of
split_address_list_items().

Thanks.
