From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/5] Avoid file descriptor exhaustion in ref_transaction_commit()
Date: Fri, 24 Apr 2015 12:13:39 -0700
Message-ID: <CAGZ79kYDPgbD0x82ZREcavqaXxs6aaOo3HXAX6HAi2T+shOACA@mail.gmail.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
	<20150424172648.GB30592@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 21:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylj2o-0007um-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811AbbDXTNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 15:13:41 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38025 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbbDXTNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 15:13:40 -0400
Received: by igbhj9 with SMTP id hj9so22834141igb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w1MPRsp+qlw1+85ExOsv+kHJTztZom0Ky+n4uu3L8Hw=;
        b=fycJXj+Zo71Tcs7iD3NFRdgMXRlPUaILU2GIRzFfo6ZyJvRdNQ9co5zoT3xzk1NyjS
         SSQNtMl5wmhojgq+qU5iJbeIvwyi9U3RnIchxBwAf34mvQIOuV6MCbi9ORoiEGXTfPd5
         3ifip9xiFCqDbxrwqylDk2Y995MsbPNzMo0Yd4GqyA/upqbCatYfhpo3FelHaeSRHSj/
         0si/zopNf5PM2taaboHIFIY0tMSbqHQOG8/UeWjEEJujt4RNsT3roH28ATzJFyt9R4VE
         8Lw7fWPoOkDKvWa80e/ETcR+XHa2Rd8Z5vIBO9zdnf7DMb6qXiJ51x2ARkWhtQ7bclPU
         fLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w1MPRsp+qlw1+85ExOsv+kHJTztZom0Ky+n4uu3L8Hw=;
        b=Z/4UzhSM4AYTp0D30E25WC0UIyQTKrdIqE1H+sSYjJY/GIYMqq0ydgPP8QDWRNIjQG
         eLAdHdSPNRkAkY8pHEwFRFUlZ/Lll68XXWBdsdb/QQ9dfW4ygJWtUlZJQviLJmQ3hpj0
         y+q1c/gmoxizvO0LPNyg4Pyvzey6gPQNTSDjeEcDBqlFSO0sZUkPlr2EdkNLOV83v6el
         YYknQxUAVIqkm+YpvN87x5hmGaADau8OAmTniA7SFfmVEJ6EOMiVJdsV5ZIcL1TeIiH1
         +7SZsEFmqGlX9eB3A/4fHcsccej3xcmwvQUcUJ9cr8CYhKgraIiBKt0xk4pBiZ6xrjEC
         jCQQ==
X-Gm-Message-State: ALoCoQmYwPpPqXqjn4/uhjKMCxB3pULZh3rTJ2m7l5pJUZ7STn7fu1M5XYtbGASuGDdNvh/x//Y2
X-Received: by 10.107.132.223 with SMTP id o92mr13012846ioi.49.1429902819890;
 Fri, 24 Apr 2015 12:13:39 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 24 Apr 2015 12:13:39 -0700 (PDT)
In-Reply-To: <20150424172648.GB30592@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267749>

On Fri, Apr 24, 2015 at 10:26 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 24, 2015 at 01:35:44PM +0200, Michael Haggerty wrote:
>
>> In ref_transaction_commit(), close the reference lockfiles immediately
>> to avoid keeping too many file descriptors open at a time. This is
>> pretty easy, because in the first loop (where we create the locks) we
>> already know what, if anything, has to be written into the lockfile.
>> So write it and close the lockfile immediately. In the second loop,
>> rename the lockfiles for reference updates into place, and in the
>> cleanup loop, unlock any references that are still locked (i.e., those
>> that were only being verified or deleted).
>>
>> I think this is a cleaner solution than Stefan's approach [1] of
>> closing and reopening fds based on an estimate of how many fds we can
>> afford to waste--we only need a single file descriptor at a time, and
>> we never have to close then reopen a lockfile. But it is a bit more
>> intrusive, so it might still be preferable to use Stefan's approach
>> for release 2.4.0, if indeed any fix for this problem is still being
>> considered for that release.
>
> I like this approach much better. It seems like the best of all worlds
> (same performance, and we don't have to worry about whether and when to
> close lockfiles).

I would have guessed this approach to take more work to do it right.
Thanks Michael for tackling the problem in an elegant way!

>
> Stefan's patch is just in pu at this point, right? I do not think there
> is any rushing/release concern.

Yeah it's in pu, so it's easy to remove.

> It is too late for either to be in
> v2.4.0, so the only decision is whether to aim for "master" or "maint".
> To me, they both seem to be in the same ballpark as far as risking a
> regression.
>
> -Peff


Thanks,
Stefan
