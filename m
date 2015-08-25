From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 13:59:04 -0700
Message-ID: <CAGZ79kZ9V35KmJSExt=EqYFcyOSysaFsJA0E+dx46Qg+Pm+Ybg@mail.gmail.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
	<xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:59:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZULJI-0003Yx-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbbHYU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 16:59:07 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35675 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbHYU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:59:06 -0400
Received: by qgj62 with SMTP id 62so114449855qgj.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C81FM0p+swoLvIp8vpHJy/w9vS4f+amUTqLoS9kt6XI=;
        b=gyQuvxtCDyRLFvXB5mjH+YvlH0HoCRehScNwqFqomQ3aQ5oVDJXlWe68UaQPyYd6Qk
         QpX8vxQcJhsxWnUhX9ajC3vTOb89PdIReRwOfuXEUIy6EyqlYrUX0mJ8zvPeGbGJ9EXe
         mEL0c+B9VBs26BL3ofz22AezM3XYkPz7bIVn61jlDjFUJAlfkVeFbNrTNNH5lUJtxgjd
         k7pom6ngAS2fuaDYjYc6WQ1sYuk+uhketfvSf/qzWu7pdlEtVuh3vwt0hknX2yj7MpLx
         SmqiR2tY0RNtkg2yOwOLrvbjA3+bnGnyAcei/TDBh9OFByeGSbsSD/SyPoNYHD4coIhE
         dNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C81FM0p+swoLvIp8vpHJy/w9vS4f+amUTqLoS9kt6XI=;
        b=N7Ogsv8SqQqH8Sr1FoLfMCL56fQzZ6jDfvpuc5Pb8ifkMlXIufO1a/z6fwXYcwybzd
         3hs2zTpUTTO0CjOXL8Q0oWa+ZQWAhZcLNB9J1zvPhAtUWB7o0iB+xmqEHPym83/m5MIm
         TOnimy9Lto4yU+8wqbCSxTkkbltzmY5j4I8cukwzIv/LijzKStboIr+Ks2dydD1S+8oe
         4ozgWR3IlQ0+izi8lSndkyhHwCLTV9PR6URjQXrpzp3XPcLLX9VqBePwx3JZqGHSVmFL
         e/3jOYNb/IPn+9YrpdC6YGvIyzkDXYrUTx3sjvQaSW6j6E5W1Q4UsP26bPSa3wHGxiN1
         7Ijw==
X-Gm-Message-State: ALoCoQk2rr3o57/tfRmd9mXFPXLsrcF5bvjJQxOVjILYdYxaan2m3f3KEghFLShM2WFXiePKWCPt
X-Received: by 10.140.237.140 with SMTP id i134mr73499619qhc.81.1440536344968;
 Tue, 25 Aug 2015 13:59:04 -0700 (PDT)
Received: by 10.140.41.198 with HTTP; Tue, 25 Aug 2015 13:59:04 -0700 (PDT)
In-Reply-To: <xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276573>

On Tue, Aug 25, 2015 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Aug 25, 2015 at 10:28:25AM -0700, Stefan Beller wrote:
>>
>>> By treating each object as its own task the workflow is easier to follow
>>> as the function used in the worker threads doesn't need any control logic
>>> any more.
>>
>> Have you tried running t/perf/p5302 on this?
>>
>> I seem to get a pretty consistent 2%-ish slowdown, both against git.git
>> and linux.git. That's not a lot, but I'm wondering if there is some
>> low-hanging fruit in the locking, or in the pattern of work being
>> dispatched. Or it may just be noise, but it seems fairly consistent.
>
> The pattern of work dispatch hopefully is the same, no?  add_task()
> does the "append at the end" thing and next_task() picks from the
> front of the queue.  The original is "we have globally N things,
> so far M things have been handled, and we want a new one, so we pick
> the M+1th one and do it".
>
> The amount of memory that is used to represent a single task may be
> much larger than the original, with overhead coming from job_list
> structure and the doubly-linked list.  We may not be able to spin up
> 30 threads and throw a million tasks at them using this, because of
> the overhead.

I thought about making the add_task block after a certain size of job_list
such that there is always just enough tasks available to process.
Then we would not need to used a huge amount of memory for having
a long line of waiting tasks; the shorter the line is the less we can tolerate
burst behavior in the threads.

> It would be more suited to handle a pattern in which
> an overlord actively creates new tasks while worker threads chew
> them, using the add_task/dispatch as the medium for communication
> between them.

Not sure I follow there.

Original implementation:
We have M threads sitting around the table, all of them trying to obtain food
from the one bowl on the table and then eating it.
Once the bowl is all eaten, we can stop.

New pattern:
One cook puts all the food items on the sushi-go-round-belt with a fancy plate
and the threads grab them one by one still using locks (but they are internal to
the belt).

Are you saying we're content with just a bowl and everyone helps themselves
for getting food?
