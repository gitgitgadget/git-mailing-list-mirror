From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Another squash on run-command: add an asynchronous parallel child processor
Date: Fri, 25 Sep 2015 12:32:16 -0700
Message-ID: <xmqq1tdm47nj.fsf@gitster.mtv.corp.google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<xmqq4mijuwyz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbpLwODzPrGcuvz2oY+XMMPAy9SRh1s_5wV8cvY-J79iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:32:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfYjG-0002Kg-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 21:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbbIYTcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 15:32:18 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35160 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbbIYTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 15:32:18 -0400
Received: by pacfv12 with SMTP id fv12so115948877pac.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Eszvjx0ZB9Yli/idM0eG+4WylxFw+3PV4pD6ihOPv2c=;
        b=yNol+VSdBTz99Sj7Y44+bniP3VD6kFCH7tzVKQKvjGw95EImwHrnHA7d3qkjkHYGSb
         iy6ITF6It/HV2Xz5jevd6z7i1cIL3cOR8Ucn/7MiDNwpIPM8shKZpzHEq67HeHsizO3i
         NsGvYLJrBX7wt1KmHyHJnPtdASpGTnXk032AUvxoFSwTpjQGAbY63gNccdWqJAwcAXaQ
         lcMKtyX+xQIc9xryAykMo2S747wmZQiGtjK8bNCHGRhX7p/lSYdiTQxI9zmzj3sE6LUV
         PFA0dyTSopshDZU6FGZoE8q4sZV7Jak4I3Szp56OaC3Kl1vCHTHNjaNEpYyqv8CuY0ea
         NTmA==
X-Received: by 10.68.108.101 with SMTP id hj5mr9314069pbb.156.1443209537448;
        Fri, 25 Sep 2015 12:32:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id qy5sm5312935pbb.16.2015.09.25.12.32.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 12:32:16 -0700 (PDT)
In-Reply-To: <CAGZ79kbpLwODzPrGcuvz2oY+XMMPAy9SRh1s_5wV8cvY-J79iw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Sep 2015 11:56:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278678>

Stefan Beller <sbeller@google.com> writes:

> We could also offer more access to the pp machinery and an implementation for
> (2) might look like this:
>
> static void fictious_start_failure(void *data,
>                                 void *pp,
>                                 struct child_process *cp,
>                                 struct strbuf *err)
> {
>         struct mydata *m = data;
>
>         if (m->failstrategy == 1)
>                 ; /* nothing here */
>         else if (m->failstrategy == 2)
>                 killall_children(pp);

That looks nice and clean in theory, but I highly doubt that it is a
good idea to have killall_children(pp) in a client code of the API
like this, especially if you are envisioning that that function
merely goes through the list of children and does kill on the
processes.  If killall_children(pp) is supplied by the API, it makes
things less insane (now it can know and keep up with the evolution
of the API implementation detail, such as how buffered output are
kept and such), but still such an API constrains the structure of
the overall scheduling loop and the helper functions that live on
the API side.  You need to make absolutely sure that calling
killall_children() is something that can be sanely done from inside
start_failure() callback, for example.

If you signal the "emergency" with a return value, the callchain on
the API side can choose to do the killing at a place it knows is
safe to do so in a more controlled way.  For example, the main loop
of the API side IIRC (I do not bother checking out 'pu' to read it
as my working tree is busy on another topic right now) is

    while (1) {
    	for (cnt = 0; cnt < 4 && we still have slots; cnt++)
		start_one();

	collect_output();
	drain_output_for_foreground();
	wait_and_flush();
    }

Imagine that you have 0 or more processes running and start another
iteration of this loop.  The first task started by start_one() fails
and the above fictitious_start_failure() calls killall_children()
itself.  What happens to the other three iteration of the inner
loop?  After existing ones are killed, it adds three more?

And to prevent that from happening, you also need to tell your
fictitious_next_task() that no more processes are desired.  The
client of the API is forced to coordinate across its multiple
callback functions.

And you did that to gain what?  One major thing I can think of is
that that way, the main scheduling loop does not have to know why
after attempting to spawn but failing, fictitious_next_task()
started saying "no more tasks".  For somebody who is coming from
"The main loop is a dumb bullet-list of things to do.  All smarts
are inside the callee", that might appear to be a good thing.

But I do not think it is a good thing at all.  That forces the
reader of the code to not just follow the API layer but even down to
its individual clients of the API to understand what is going on.

If you propagate the return from start_failure() callback upwards,
then the main scheduler would *know* that the client application
does not want any more new tasks, and it does want to abort even the
running tasks, so it will not call fictitious_next_task() in the
first place after the client application declares an "emergency
exit".

And that would make the overall logic a lot easier to follow.








	
