From: Bryan Turner <bturner@atlassian.com>
Subject: Re: 2.2.0-rc behavior changes (2/2)
Date: Mon, 10 Nov 2014 21:45:22 +1100
Message-ID: <CAGyf7-E0KCqqceH_PmE1Tsm=2bR-Qin1RV9s-fJa6oY2zdTU8A@mail.gmail.com>
References: <CAGyf7-GWBWrV9SjMY3n3B-0gCMZGfEsYfX-0vSvz6GT6r=vO6A@mail.gmail.com>
	<20141110093128.GB11387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnmTS-0004hj-Ga
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 11:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaKJKpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 05:45:25 -0500
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:39209 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752313AbaKJKpX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 05:45:23 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]) (using TLSv1) by na3sys009aob122.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGCXQywd2jiezVfV4+36wSX+SZq328Qc@postini.com; Mon, 10 Nov 2014 02:45:23 PST
Received: by mail-oi0-f42.google.com with SMTP id a3so5225216oib.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 02:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4TjRSSf+prT//puP770iiDAhyNY0lZnNnn5Gxxlv3bM=;
        b=e+MDtgD+EKuhSUs62Cc7I8kocs2A9WkaeGlPiNrDLcvsXX+BsQ2lOa7his2Ju5yLaO
         tGl8IW0XZ5SNLWz8u32OZyL2DuIaXn8euM8o1XBJqsinoSn2Yo8QLzVbQXIca8WvkTfP
         KQlSLTIeT9Bo/hyKM7ZyZLivUhW43myczh2Q2CX2dJAlb+1J46KK79V4ZXHKbK4nqi6D
         kkuWVm1rOpLg2kLQohdFMQnnPErkB9I/tOUtfOalwngC13AGWszT6Om3nr3QZRTsItrD
         X+n5p5mFMFia9i9ajkIqNhZ7gyTR3THxuJ6mfjGYfVdmpPcnZMyTcutEtZeY/bvQ4U2L
         sttg==
X-Gm-Message-State: ALoCoQkies0/XWybO5X4PBI3OHdqoQDTzI0OC6o+lL0O69oqgBQfUmwHWmBl1cWC2BX3Jf9pVSmmalB9/qBibxNnU6eTjhfjz+bdmDjOCz4fHDN0SJj6Wrd8/sz+o3eNrnZQdNH6uasXZ6J/OhBOZGl1l5/yCsZ8JA==
X-Received: by 10.60.76.72 with SMTP id i8mr1145698oew.53.1415616322719;
        Mon, 10 Nov 2014 02:45:22 -0800 (PST)
X-Received: by 10.60.76.72 with SMTP id i8mr1145693oew.53.1415616322644; Mon,
 10 Nov 2014 02:45:22 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 10 Nov 2014 02:45:22 -0800 (PST)
In-Reply-To: <20141110093128.GB11387@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 8:31 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 10, 2014 at 07:51:00PM +1100, Bryan Turner wrote:
>
>> Second change: git gc --auto now fails if there are loose empty blobs.
>>
>> We have a test which just touched empty files in objects/17 to trigger
>> the gc --auto preconditions (Note: I realize this is completely
>> invalid, and I've changed the test to no longer do this; I'm only
>> surfacing the behavioral change).
>
> This is expected. As you noticed here:
>
>> error: object file
>> .git/objects/17/02d54e8fba95ef9968a0c9b183fe22ec551c86 is empty
>> fatal: unable to get object info for 1702d54e8fba95ef9968a0c9b183fe22ec551c86
>> error: failed to run prune
>
> the error comes from "git prune" failing. It is using unreachable but
> "recent" objects as graph tips to keep around. If we can't load a tip
> object, we abort the prune, because we would not want to delete objects
> that might have been referenced (e.g., if it were a real corrupted
> object that we could not read).
>
> The second behavior (die on broken objects) has been around for a while.
> The new change (in the commit you bisected to) is that we are
> considering more objects.
>
> I'll admit I didn't really consider the impact on sticking broken object
> files into the object directory, but I think the code is doing the
> sensible and safe thing.

I agree. I wasn't aware this particular test was using such a
questionable mechanism to trigger automatic garbage collection. I
think the change to make git gc --auto more sensitive to this type of
thing is definitely an improvement. As noted, I just wanted to surface
the behavior change.

Thanks again for your quick response!

>
> -Peff
