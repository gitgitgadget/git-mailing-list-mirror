From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 10:12:11 -0700
Message-ID: <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNCN-0003vO-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbbH1RMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:12:15 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35341 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbH1RMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:12:14 -0400
Received: by pacdd16 with SMTP id dd16so68523445pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hFkZqbdSZcBZPoauU6b48MAzWxSY7b4SznkGWAHo6Jk=;
        b=Ezqe+o7tiss4C8uX2drheekP8XLCNJCoBBEFSSAXN/aPTovP0rlL9JQ+jvTtkEFaWM
         LfLyLnEaWbAXyg5PqAArSSeUnoBcsOAYAZJfo+Mv6qf+rdXsiSsEntxeyDE7myOdf3bq
         qtNL0TxR0MmuXNl2zaRKJgkJcX91NhwM4Uswk9BilMIvwEIE8I3shoZWaXKK5l/Rp5vy
         oHkbNzlSe/4mgSMah4CF/GQPPXWPfhb0GwwIVjKzW5G36smzDH+tMR1EGfNfa3nDFL4e
         9toQt7f7OZFQbh8pxu3wRnkX4mpHP7766gpihaimu7o++kCyI1kcEysqt/QHoRJBywV6
         Wu0A==
X-Received: by 10.66.139.234 with SMTP id rb10mr16954012pab.118.1440781933601;
        Fri, 28 Aug 2015 10:12:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id i3sm4595381pdp.73.2015.08.28.10.12.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 10:12:12 -0700 (PDT)
In-Reply-To: <20150828170141.GB8165@google.com> (Jonathan Nieder's message of
	"Fri, 28 Aug 2015 10:01:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276735>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>> On Thu, Aug 27, 2015 at 6:14 PM, Stefan Beller <sbeller@google.com> wrote:
>
>>> This makes use of the new task queue and the syncing feature of
>>> run-command to fetch a number of submodules at the same time.
>>>
>>> The output will look like it would have been run sequential,
>>> but faster.
>>
>> And it breaks the tests t5526-fetch-submodules.sh as the output is done
>> on stderr only, instead of putting "Fetching submodule <submodule-path>
>> to stdout. :(
>>
>> I guess combining stdout and stderr is not a good strategy after all now.
>
> IMHO the "Fetching submodule <submodule-path>" output always should have
> gone to stderr.  It is not output that scripts would be relying on ---
> it is just progress output.
>
> So a preliminary patch doing that (and updating tests) would make sense
> to me.

Sounds good.

I personally do not think the "we still do all the output from a
single process while blocking output from others" buffering
implemented in this n-th round (by the way, please use [PATCH v$n
N/M]) is worth doing, though.  It does not make the output machine
parseable, because the reader does not get any signal in what order
output of these subprocesses arrive anyway.  The payload does not
even have "here is the beginning of output from the process that
handled the submodule X" to delimit them.

My preference is still (1) leave standard error output all connected
to the same fd without multiplexing, and (2) line buffer standard
output so that the output is at least readable as a text, in a
similar way a log of an irc channel where everybody is talking at
the same time.
