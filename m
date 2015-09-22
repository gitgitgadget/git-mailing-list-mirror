From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 15:23:04 -0700
Message-ID: <xmqq4mim14c7.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
	<xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYwMrpU-gW6FsbH1W4TRPisZH9GJoyZ6hoimXdxz4HCYQ@mail.gmail.com>
	<xmqqh9mm1690.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZFoTUugFdOuikOBUbg0DG+TJ3tNTuZaCs7WSaa2r7=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 00:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVxy-0000lS-6v
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 00:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934926AbbIVWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 18:23:09 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36444 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbIVWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 18:23:07 -0400
Received: by pacbt3 with SMTP id bt3so2749686pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=prpltViq26Ldlvre6WKOLtDNOI/+cv2+Q/8zutGHeus=;
        b=flLVoIAcw2VCuVRUG+FG+jDkZVHiN5BYqNmKIeDFSW825Jmy+kQm1672OX6iNltncz
         euCQKo0SeeoWbdDU2wgZRcHyJmCRHRQsHF05fqf9ixXyQUsGtB9NenhfpDLjOmlYqY3j
         QpGLvzyf2o6JSIMROYFH5iC2BJdSW7Ewy79qX3KB3qdTxL6/QrweZ2O/YlsYzPd7xaI+
         XYsLaKdWT2W5igUVj/PbBHOZKqEWmfISOIZfadA3rsJGF4E9K0l0e4kuxXmesTMZbwrC
         CLQXPPaejF0reBDMfS8N7Nla0EUoX1+I41Oddp81Tx0yRNuth/N3Xo8S6VJvhywfxC+J
         GwjQ==
X-Received: by 10.66.100.225 with SMTP id fb1mr528038pab.138.1442960587343;
        Tue, 22 Sep 2015 15:23:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id j16sm4171755pbq.23.2015.09.22.15.23.05
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 15:23:05 -0700 (PDT)
In-Reply-To: <CAGZ79kZFoTUugFdOuikOBUbg0DG+TJ3tNTuZaCs7WSaa2r7=Bg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Sep 2015 14:54:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278446>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Sep 22, 2015 at 2:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Tue, Sep 22, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>> So how would you find out when we are done?
>>>>
>>>>         while (1) {
>>>>                 if (we have available slot)
>>>>                         ask to start a new one;
>>>>                 if (nobody is running anymore)
>>>>                         break;
>>>>                 collect the output from running ones;
>>>>                 drain the output from the foreground one;
>>>>                 cull the finished process;
>>>>         }
>>>>
>>>
>>> Personally I do not like the break; in the middle of
>>> the loop, but that's personal preference, I'd guess.
>>> I'll also move the condition for (we have available slot)
>>> back inside the called function.
>>>
>>> So I am thinking about using this in the reroll instead:
>>>
>>>     run_processes_parallel_start_as_needed(&pp);
>>>     while (pp.nr_processes > 0) {
>>>         run_processes_parallel_buffer_stderr(&pp);
>>>         run_processes_parallel_output(&pp);
>>>         run_processes_parallel_collect_finished(&pp);
>>>         run_processes_parallel_start_as_needed(&pp);
>>>     }
>>
>> If you truly think the latter is easier to follow its logic (with
>> the duplicated call to the same function only to avoid break that
>> makes it clear why we are quitting the loop,
>
> I dislike having the call twice, too.
> ...
>> and without the
>> explicit "start only if we can afford to"), then I have to say that
>> our design tastes are fundamentally incompatible.
> ...
> I'll think about that.

Don't waste too much time on it ;-)  This is largely a taste thing,
and taste is very hard to reason about, understand, teach and learn.

Having said that, if I can pick one thing that I foresee to be
problematic the most (aside from these overlong names of the
functions that are private and do not need such long names), it is
that "start as many without giving any control to the caller"
interface.  I wrote "start *a* new one" in the outline above for a
reason.

Even if you want to utilize a moderate number of processes, say 16,
working at the steady state, I suspect that we would find it
suboptimal from perceived latency point of view, if we spin up 16
processes all at once at the very beginning before we start to
collect output from the designated foreground process and relay its
first line of output.  We may want to be able to tweak the caller to
spin up just a few first and let the loop ramp up to the full blast
gradually so that we can give an early feedback to the end user.
That is not something easy to arrange with "start as many without
giving control to the caller" interface.  We probably will discover
other kinds of scheduling issues once we get familiar with this
machinery and would find need for finer grained control.

And I consider such a ramp-up logic shouldn't be hidden inside the
"start_as_needed()" helper function---it is the way how the calling
loop wants its processes started, and I'd prefer to have the logic
visible in the caller's loop.

But that is also largely a "taste" thing.
