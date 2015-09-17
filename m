From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/10] run-command: add an asynchronous parallel child processor
Date: Thu, 17 Sep 2015 16:19:35 -0700
Message-ID: <CAGZ79kbgBOkiii6B3BFwB778DM=mNcKyOoS-KQGuLf=At7hG0g@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-4-git-send-email-sbeller@google.com>
	<xmqqbnd0iuv6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 01:19:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZciSs-000427-6s
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 01:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbIQXTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 19:19:37 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35557 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbIQXTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 19:19:36 -0400
Received: by ykdu9 with SMTP id u9so31930083ykd.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f/2qL2yEPEqja+m22skZpLA124WArzUx2GGPtdGVKTw=;
        b=meFHZ4xXMIzCHyNHOq0ifKgPtkQJzg24+nXBpgdbzUS9mQjhck4fuLg50yGuUwq+39
         i6gvj27ZPjvhgd2oZvZs9bUrEOhTJfO9/mQYPdOolrlzzpY0bAOBZyGFLkTkdjyGQXiV
         HxU/fCE1lNGLEF6DzgPXqXaI/wLboBvROFtqmP3v4E/KHfPEmWavNIOnT/6V6aBcDd+7
         1uRL6jtNpGw3EKmkOmlPLbWsASYusq8NC5Lk+ibd0GxnO5ye/OZIceQWR4LeYg0J3tA6
         UGpJ9yESRT15n8NpRmGa4BtjV6VlKUVvQHLI4DT7tuWIs/6xKqDbl0V0BrQmdxUlQ1wd
         UmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=f/2qL2yEPEqja+m22skZpLA124WArzUx2GGPtdGVKTw=;
        b=eGX22g481A8/CgfGhmIithdzOdVLWV1eWiMyqr5KVSCjbfCL0yXzJvnwmvYTdjwqtB
         AksSIhpKzFEKtOCdyHcWKhqPRPc+7qy+2ZtJMF5/V8TZzXsmnxyJ74jacPIQo84Bb1vx
         gAWtIPsSGV4kSKkOgBZc7zontE5Of6SGd4IyLImAd8xDO9TB60OYHuVdlQs69i/dCSx6
         L74/hJ0E/F0DkoP/YxU32ZyhwBB+TUXA3e9O8VWObZedFBhaGOAcrt+UacVU5b7vX/gG
         QaTZoXgysePVk62PpSHUAlEz++msw/hx6xhGHJL6Vqef+ZEPr53Vd8uOk6c7u/cVk6VA
         U3VA==
X-Gm-Message-State: ALoCoQnMuK4lr95lwXhJLBP0Nm/YY/6eKqAX9XRLYv2o/D6jKJ2us2neSrI2jbQurlykKdxY4MB3
X-Received: by 10.170.173.1 with SMTP id p1mr2039462ykd.101.1442531975480;
 Thu, 17 Sep 2015 16:19:35 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 16:19:35 -0700 (PDT)
In-Reply-To: <xmqqbnd0iuv6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278176>

On Thu, Sep 17, 2015 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Hmm, you are relying on the fact that a valid pid can never be 0, so
> you can just use pp->children[i].child.pid to see if a "slot" is
> occupied without even using pp->slots[] (or pp->children[i].in_use).

We could either use the pid as accessed via children[i].process.pid
or we could rely on the children[i].process.err != -1 as start_process
will set it to an actual fd, and when it's done we reset it to -1.

I am unsure if this make it less readable though (all your other
suggestions improve readability a lot!)

>
>> +                     if (i == pp->max_number_processes)
>> +                             /*
>> +                              * waitpid returned another process id
>> +                              * which we are not waiting for.
>> +                              */
>> +                             return;
>> +             }
>> +             strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
>
> This is to read leftover output?
>
> As discussed elsewhere, read_nonblock() will have to have "read
> some, not necessarily to the end" semantics to serve the caller in
> run_processes_parallel_buffer_stderr(), so you'd need a loop around
> it here to read until you see EOF.
>
> Or you may be able to just call strbuf_read() and the function may
> do the right thing to read things through to the EOF.  It depends on
> how you redo the patch [2/10].

strbuf_read sounds like the logical choice here (and the redo of 2/10
supports that).


>> +                      * NEEDSWORK:
>> +                      * For now we pick it randomly by doing a round
>> +                      * robin. Later we may want to pick the one with
>> +                      * the most output or the longest or shortest
>> +                      * running process time.
>> +                      */
>> +                     for (i = 0; i < n; i++)
>> +                             if (pp->slots[(pp->foreground_child + i) % n])
>> +                                     break;
>> +                     pp->foreground_child = (pp->foreground_child + i) % n;
>
> ... and then picks a new owner of the output channel.
>
> Up to this point it looks sensible.
>
>> +                     fputs(pp->err[pp->foreground_child].buf, stderr);
>> +                     strbuf_reset(&pp->err[pp->foreground_child]);
>
> I do not think these two lines need to be here, especially if you
> follow the above advice of separating buffering and draining.

They are outputting the buffer, if the next selected child is still running.
I mean it would output eventually anyway, but it would only output after
the next start of processes and poll() is done. Yeah maybe that's what we
want (starting new processes earlier is better than outputting earlier as we're
talking microseconds here).

>
>> +int run_processes_parallel(int n, void *data,
>> +                        get_next_task fn,
>> +                        handle_child_starting_failure fn_err,
>> +                        handle_child_return_value fn_exit)
>> +{
>> +     struct parallel_processes pp;
>> +     run_processes_parallel_init(&pp, n, data, fn, fn_err, fn_exit);
>> +
>> +     while (!pp.all_tasks_started || pp.nr_processes > 0) {
>
> The former is true as long as more_task() says there may be more.
> The latter is true as long as we have something already running.
>
> In either case, we should keep collecting and spawning as needed.
>
>> +             run_processes_parallel_start_new(&pp);
>
> But calling start_new() unconditionally feels sloppy.  It should at
> least be something like
>
>         if (pp.nr_processes < pp.max_processes &&
>             !pp.all_task_started)
>                 start_new_process()
>
> no?

That's the exact condition we have in start_new_process
so I don't want to repeat it here? We could move the while
loop outside of it though. That looks better, done.
