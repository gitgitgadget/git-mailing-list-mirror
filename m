From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 14:41:47 -0700
Message-ID: <xmqqh9mm1690.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
	<xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYwMrpU-gW6FsbH1W4TRPisZH9GJoyZ6hoimXdxz4HCYQ@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 22 23:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVK5-0006NE-ID
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934828AbbIVVlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:41:51 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36420 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934121AbbIVVlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:41:50 -0400
Received: by pacbt3 with SMTP id bt3so1913175pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y7BUybXWZvt1k24x/BplFPGdc2Wbjz6DuN6PPu/AP0E=;
        b=XcPdfNvUE1/4tL0R7pGgCu4OEv3OWWs3xU31JL5jhjBNto5M97vuLAsUHBaoWzsOKr
         toqqQRtpXe5CIP/fWaVI3ftll8KP/SM/5x90d4TkBgi791efekz7KhCRot/XRABfDAQy
         1QaGbQbE3Pv9WH4dPaIi4ybwLim0nCElOEiGnSR3s8vSGyTYze9svae/5dI5kPMm8K3B
         yfFFNrwwrtOVUeipFDMXSq6qq1HOMXs4Vasmo3Zqwj5+ei4VYln7SAwWnPg5DWufW3y+
         a+eqmGBaGX5dTF+K/BQvIWXOod14wvIBTDQlsDUhukRglCnGjf16M4qFFt/0BtMDzOQf
         rw1Q==
X-Received: by 10.66.182.135 with SMTP id ee7mr33620053pac.95.1442958109661;
        Tue, 22 Sep 2015 14:41:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id sj6sm4107214pbc.7.2015.09.22.14.41.48
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 14:41:48 -0700 (PDT)
In-Reply-To: <CAGZ79kYwMrpU-gW6FsbH1W4TRPisZH9GJoyZ6hoimXdxz4HCYQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Sep 2015 14:31:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278441>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Sep 22, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> So how would you find out when we are done?
>>
>>         while (1) {
>>                 if (we have available slot)
>>                         ask to start a new one;
>>                 if (nobody is running anymore)
>>                         break;
>>                 collect the output from running ones;
>>                 drain the output from the foreground one;
>>                 cull the finished process;
>>         }
>>
>
> Personally I do not like the break; in the middle of
> the loop, but that's personal preference, I'd guess.
> I'll also move the condition for (we have available slot)
> back inside the called function.
>
> So I am thinking about using this in the reroll instead:
>
>     run_processes_parallel_start_as_needed(&pp);
>     while (pp.nr_processes > 0) {
>         run_processes_parallel_buffer_stderr(&pp);
>         run_processes_parallel_output(&pp);
>         run_processes_parallel_collect_finished(&pp);
>         run_processes_parallel_start_as_needed(&pp);
>     }

If you truly think the latter is easier to follow its logic (with
the duplicated call to the same function only to avoid break that
makes it clear why we are quitting the loop, and without the
explicit "start only if we can afford to"), then I have to say that
our design tastes are fundamentally incompatible.  I have nothing
more to add.
