From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Tue, 25 Aug 2015 15:23:18 -0700
Message-ID: <xmqqy4gzvwh5.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-4-git-send-email-sbeller@google.com>
	<xmqq7fojxeh3.fsf@gitster.dls.corp.google.com>
	<CAGZ79kb2N_5_tJv-GURL9_ESFs=pHp=L-Mujn3Df_+-T74_9Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUMcn-0000B7-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbbHYWXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:23:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36111 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbHYWXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:23:21 -0400
Received: by pacgr6 with SMTP id gr6so4138235pac.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rfMKZKFzzLgzc8yCZruEzoBA67Xk4KD2hY2xzIRjbxw=;
        b=sfTvaVy8kMoFQPUBZk6Fz3TrYwXwQ0w9tGByf170fKpzPJU9hKZbfq2GIH0mAONNfu
         OAZEdlfBEb0mr0owrVaZ0sUCMeTJDX606YLQNf1su4mT8j9DToxwL5IIl6bry/m69EdZ
         8ZkInBJnAjluwKbEkE2vlsZZxbICaTR6EcK5OA9WNxPwjmoutZtK5NDIENyeWtHnLvTF
         m8ukjWhFZaTqUrlGsMvfLhZTY16nAMPuzbOah2K8GwpRrQL0SCbJHVbLYBx6bsbUvExE
         ExfGp2/5dYtYeWxvkZYl1YhdJJfZm4yAOHfNyqZwoB1OF/rbvryvNI55tbVPh4HvS3d8
         teWg==
X-Received: by 10.66.192.162 with SMTP id hh2mr61817959pac.71.1440541400691;
        Tue, 25 Aug 2015 15:23:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id m2sm22228598pdr.64.2015.08.25.15.23.18
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 15:23:18 -0700 (PDT)
In-Reply-To: <CAGZ79kb2N_5_tJv-GURL9_ESFs=pHp=L-Mujn3Df_+-T74_9Dg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 25 Aug 2015 14:42:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276581>

Stefan Beller <sbeller@google.com> writes:

>>> +     while (1) {
>>> +             ssize_t len = xread(cp->err, buf, sizeof(buf));
>>> +             if (len < 0)
>>> +                     die("Read from child failed");
>>> +             else if (len == 0)
>>> +                     break;
>>> +             else {
>>> +                     strbuf_add(&out, buf, len);
>>> +             }
>>
>> ... and the whole thing is accumulated in core???
>
> The pipes have a limit, so we need to empty them to prevent back-pressure?

Of course.  But that does not lead to "we hold everything in core".
This side could choose to emit (under protection of args->mutex)
early, e.g. after reading a line, emit it to our standard output (or
our standard error).

> And because we want to have the output of one task at a time, we need to
> save it up until we can put out the whole output, no?

I do not necessarily agree, and I think I said that already:

  http://thread.gmane.org/gmane.comp.version-control.git/276273/focus=276321

>>> +     }
>>> +     if (finish_command(cp))
>>> +             die("command died with error");
>>> +
>>> +     sem_wait(args->mutex);
>>> +     fputs(out.buf, stderr);
>>> +     sem_post(args->mutex);
>>
>> ... and emitted to standard error?
>>
>> I would have expected that the standard error would be left alone
>
> `git fetch` which may be a good candidate for such an operation
> provides progress on stderr, and we don't want to intermingle
> 2 different submodule fetch progress displays
> ("I need to work offline for a bit, so let me get all of the latest stuff,
> so I'll run `git submodule foreach -j 16 -- git fetch --all" though ideally
> we want to have `git fetch --recurse-submodules -j16` instead )
>
>> (i.e. letting warnings from multiple jobs to be mixed together
>> simply because everybody writes to the same file descriptor), while
>> the standard output would be line-buffered, perhaps captured by the
>> above loop and then emitted under mutex, or something.
>
>>
>> I think I said this earlier, but latency to the first output counts
>
> "to the first stderr"
> in this case?

I didn't mean "output==the standard output stream".  As I said in
$gmane/276321, an early output, as an indication that we are doing
something, is important.

> Why would we want to unplug the task queue from somewhere else?

When you have a dispatcher more intelligent than a stupid FIFO, I
would imagine that you would want to be able to do this pattern,
especially when coming up with a task (not performing a task) takes
non-trivial amount of work:

	prepare task queue and have N threads waiting on it;

	plug the queue, i.e. tell threads that do not start picking
	tasks out of it yet;

	large enough loop to fill the queue to a reasonable size
	while keeping the threads waiting;

	unplug the queue.  Now the threads can pick tasks from the
	queue, but they have many to choose from, and a dispatcher
	can do better than simple FIFO can take advantage of it;

	keep filling the queue with more tasks, if necessary;

        and finally, wait for everything to finish.

Without "plug/unplug" interface, you _could_ do the above by doing
something stupid like

	prepare a task queue and have N threads waiting on it;

	loop to find enough number of tasks but do not put them to
	task queue, as FIFO will eat them one-by-one; instead hold
	onto them in a custom data structure that is outside the
	task queue system;

	tight and quick loop to move them to the task queue;

	keep finding more tasks and feed them to the task queue;

        and finally, wait for everything to finish.
