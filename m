From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] run-command: add an asynchronous parallel child processor
Date: Thu, 17 Sep 2015 18:05:53 -0700
Message-ID: <xmqqk2ro7czy.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-4-git-send-email-sbeller@google.com>
	<xmqqbnd0iuv6.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbgBOkiii6B3BFwB778DM=mNcKyOoS-KQGuLf=At7hG0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 03:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zck7p-0005P9-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 03:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbbIRBF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 21:05:56 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33595 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbbIRBFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 21:05:55 -0400
Received: by pacex6 with SMTP id ex6so34390092pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nsFniq2DUw5QAB9ZTSARjGGJalk1R6yaEu2XQLDX8s8=;
        b=i+Mr1ewgs4bTtm007g9BscOa5bZbBtQwjaUCFN+8+OagkYtY2TKEeEnayyhVI0666L
         ILThjpe3FE3xpyWdpAEDKBT1iQzoVDVZgNKlJ99xH+zcHEm30cP8j+2O9IB81Amajnq6
         +eRBAuC9gQWJpAv+Pvy/vw7nCM3tndgH0iBLXM+4IROoN9atT2uIqy6JBGjTajnpfL4c
         GWx3GbkP+naUWL0TCZxPMxrhviBZIpTrnRY2F7vXQZbhXJoJvorvPQRM8Q9JjmXw0PV3
         rfFDx+6cmvNWGqEAAMSfjeiTxSHtY+Mz8keuv6NZxlxO3YzSsVY2MBROOXAgS/SMxDoF
         D60w==
X-Received: by 10.69.2.69 with SMTP id bm5mr3839523pbd.41.1442538355478;
        Thu, 17 Sep 2015 18:05:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5827:db2a:bd27:bbb])
        by smtp.gmail.com with ESMTPSA id x10sm5593245pas.12.2015.09.17.18.05.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 18:05:54 -0700 (PDT)
In-Reply-To: <CAGZ79kbgBOkiii6B3BFwB778DM=mNcKyOoS-KQGuLf=At7hG0g@mail.gmail.com>
	(Stefan Beller's message of "Thu, 17 Sep 2015 16:19:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278177>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 17, 2015 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Hmm, you are relying on the fact that a valid pid can never be 0, so
>> you can just use pp->children[i].child.pid to see if a "slot" is
>> occupied without even using pp->slots[] (or pp->children[i].in_use).
>
> We could either use the pid as accessed via children[i].process.pid
> or we could rely on the children[i].process.err != -1 as start_process
> will set it to an actual fd, and when it's done we reset it to -1.
>
> I am unsure if this make it less readable though (all your other
> suggestions improve readability a lot!)

Sorry, the above was not a suggestion but merely an observation with
a bit of thinking aloud mixed in.  I should have marked it as such
more clearly.

>> ... and then picks a new owner of the output channel.
>>
>> Up to this point it looks sensible.
>>
>>> +                     fputs(pp->err[pp->foreground_child].buf, stderr);
>>> +                     strbuf_reset(&pp->err[pp->foreground_child]);
>>
>> I do not think these two lines need to be here, especially if you
>> follow the above advice of separating buffering and draining.
>
> They are outputting the buffer, if the next selected child is still running.
> I mean it would output eventually anyway, but it would only output after
> the next start of processes and poll() is done. Yeah maybe that's what we
> want (starting new processes earlier is better than outputting earlier as we're
> talking microseconds here).

I am not talking about microseconds but refraining from doing the
same thing in multiple places.

>> But calling start_new() unconditionally feels sloppy.  It should at
>> least be something like
>>
>>         if (pp.nr_processes < pp.max_processes &&
>>             !pp.all_task_started)
>>                 start_new_process()
>>
>> no?
>
> That's the exact condition we have in start_new_process
> so I don't want to repeat it here?

You are advocating to have a function whose definition is "this may
or may not start a new process and the caller should not care", and
then make the caller keep calling it, knowing/hoping that the caller
does not care if we spawn a new thing or not.

I somehow find it a highly questionable design taste to base the
decision on "don't want to repeat it here".

Stepping back and thinking about it, what is suggested is more
explicit in the caller.  "If we know we need a new worker and we can
have a new worker, then start it." is the logic in the caller in the
suggested structure, and we would have a well defined helper whose
sole task is to start a new worker to be called from the caller.
The helper may want to check if the request to start a new one makes
sense (e.g. if slots[] are all full, it may even want to return an
error), but the checks are primarily for error checking (i.e. "we
can have max N processes, so make sure we do not exceed that limit"),
not a semantic one (i.e. the caller _could_ choose to spawn less
than that max when there is a good reason to do so).
