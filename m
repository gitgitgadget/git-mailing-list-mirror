From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 07:31:48 +0700
Message-ID: <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan> <20150318210458.GA3376@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 01:32:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYONu-0002JQ-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 01:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbbCSAcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 20:32:20 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34097 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbbCSAcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 20:32:19 -0400
Received: by iecsl2 with SMTP id sl2so53165531iec.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 17:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hjn7V+y0IgVMxWbKF63ApGGVwq+lbRK8FexyC7kQzh0=;
        b=JTC6fqs96RGDSCP0+NZ1ZbndSQTlD3NZNVJL6lmOsYj3afZocaE0ZXKcR0GhwlTyIi
         pNf7u2zIS7ODWoSDojbfHMjfukZ4YppiKGAtwgSZBcr7U8b6FcnL1QPo8rwbbv/1YsYi
         pbd+QE1luUElYVrQOteeTsZdb0BtM1QHhKTbKvy08DC9GLergk8DJhCFPUfOKAZsQeAK
         hYb0mYDt1gEMRPbcr6L674kCML/AKfBexBtXsbQ+svTH//KAA0iqm+UpNy8+Wb7quqDj
         QYAqzJAE7Ek9Fy28aNvtdOMolIRFBAN+CRbNGJ+d71IRnehi6TQRfdKrHfdC1qQCGLLX
         orCg==
X-Received: by 10.42.250.9 with SMTP id mm9mr32967602icb.56.1426725138909;
 Wed, 18 Mar 2015 17:32:18 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 17:31:48 -0700 (PDT)
In-Reply-To: <20150318210458.GA3376@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265774>

On Thu, Mar 19, 2015 at 4:04 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 18, 2015 at 02:58:15PM +0000, John Keeping wrote:
>
>> On Wed, Mar 18, 2015 at 09:41:59PM +0700, Duy Nguyen wrote:
>> > On Wed, Mar 18, 2015 at 9:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > > If not, I made some mistake in analyzing this and we'll start again.
>> >
>> > I did make one mistake, the first "gc" should have reduced the number
>> > of loose objects to zero. Why didn't it.?  I'll come back to this
>> > tomorrow if nobody finds out first :)
>>
>> Most likely they are not referenced by anything but are younger than 2
>> weeks.
>>
>> I saw a similar issue with automatic gc triggering after every operation
>> when I did something equivalent to:
>>
>>       git add <lots of files>
>>       git commit
>>       git reset --hard HEAD^
>>
>> which creates a log of unreachable objects which are not old enough to
>> be pruned.
>
> Yes, this is almost certainly the problem. Though to be pedantic, the
> command above will still have a reflog entry, so the objects will be
> reachable (and packed). But there are other variants that don't leave
> the objects reachable from even reflogs.
>
> I don't know if there is an easy way around this. Auto-gc's object count
> is making the assumption that running the gc will reduce the number of
> objects, but obviously it does not always do so. We could do a more
> thorough check and find the number of actual packable and prune-able
> objects. The "prune-able" part of that is easy; just omit objects from
> the count that are newer than 2 weeks. But "packable" is expensive. You
> would have to compute reachability by walking from the tips. That can
> take tens of seconds on a large repo.

Or we could count/estimate the number of loose objects again after
repack/prune. Then we can maybe have a way to prevent the next gc that
we know will not improve the situation anyway. One option is pack
unreachable objects in the second pack. This would stop the next gc,
but that would screw prune up because st_mtime info is gone.. Maybe we
just save a file to tell gc to ignore the number of loose objects
until after a specific date.
-- 
Duy
