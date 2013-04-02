From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 18:12:45 -0600
Message-ID: <CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
	<20130401233313.GB30935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 02:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMoqh-00081s-P7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 02:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab3DBAMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 20:12:47 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:40676 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963Ab3DBAMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 20:12:46 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so2399445lbi.23
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ef7Mf5GdnzOCsYjJ+FxYtOjpr4WUPrxkpibg90eVe14=;
        b=NIY+t2chch55c86uT0NMi1Jn6K0n0JHsVNSexRwvHnQGDpJiF7wh2OZuPu0p/SORsn
         Ltwh0L8E5LJbG1ZmLAJGyIIT/of7AkPRS+uFZLxhY7Uubi/M6z4s7Ru7wlZqASL2S9LC
         FH2BtRBF70cbXC7fr12ekhG3Z7WovPqYPn9eSAfVKvDYR9fb7c9nMUvzTxa1ofu2+MvO
         ZEY43elzPtW6Es54Br7/6HrDvW77oRK4CPXc61BncI7I2+TwfBPO+VnbGUOgwQgTePQJ
         0XI0iavF8vi/bBrxN7vYqK+vesp9l5TaGE0RnNWBucdtBtDRChpNG+qltq3uhQSPWr2w
         aE3w==
X-Received: by 10.152.105.109 with SMTP id gl13mr6580226lab.40.1364861565365;
 Mon, 01 Apr 2013 17:12:45 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 17:12:45 -0700 (PDT)
In-Reply-To: <20130401233313.GB30935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219728>

On Mon, Apr 1, 2013 at 5:33 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 03:46:42PM -0600, Felipe Contreras wrote:
>
>> Otherwise transport-helper will continue checking for refs and other
>> things what will confuse the user more.
>> [...]
>> diff --git a/transport-helper.c b/transport-helper.c
>> index cb3ef7d..dfdfa7a 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
>>
>>       if (finish_command(&fastimport))
>>               die("Error while running fast-import");
>> +
>> +     if (!check_command(data->helper))
>> +             die("Error while running helper");
>> +
>>       argv_array_free_detached(fastimport.argv);
>
> Can you be more specific about what happens when we miss the death here,
> what happens next, etc?

I have seen problems sporadically, like git trying to update refs to
object that don't exist. I also remember seeing mismatches between the
marks and the remote branches refs.

> Checking asynchronously for death like this is subject to a rac
> condition; the helper may be about to die but not have died yet. In
> practice we may catch some cases, but this seems like an indication that
> the protocol is not well thought-out. Usually we would wait for a
> confirmation over the read pipe from a child, and know that the child
> failed when either:
>
>   1. It tells us so on the pipe.
>
>   2. The pipe closes (at which point we know it is time to reap the
>      child).
>
> Why doesn't that scheme work here? I am not doubting you that it does
> not; the import helper protocol is a bit of a mess, and I can easily
> believe it has such a problem. But I'm wondering if it's possible to
> improve it in a more robust way.

The pipe is between fast-export and the remote-helper, "we"
(transport-helper) are not part of the pipe any more. That's the
problem.

Cheers.

-- 
Felipe Contreras
