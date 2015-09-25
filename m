From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Another squash on run-command: add an asynchronous parallel child processor
Date: Fri, 25 Sep 2015 12:04:54 -0700
Message-ID: <xmqq612y48x5.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Fri Sep 25 21:05:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfYIn-0001DM-R4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbbIYTE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 15:04:57 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33649 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789AbbIYTE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 15:04:56 -0400
Received: by pacex6 with SMTP id ex6so113285358pac.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0XCUc2cKwXA1P9xZu8z7h1/ILVBXYVdCnxTx9uAbqwk=;
        b=FogiP6+sHddFzJv2mxGdupWlaB/wlC9mhluYgZxfR+qhN5ibx4pYW5jaOwHmFlojE2
         BDQxAexCDsDS9TBrfI9txwSZl6vEnQFNeW2vvAV9JVz7O7QY+4Bc/MzRSOVV+Ca1VVEJ
         4dT13eU2TDWjXXe8ABBbYhyCxzmuHyJzNqHxO91AdBJDc7qO57TyMFwci5HC2NJe7prJ
         AomwCTlmE/8ba1SnoLksDBLTZgNJJz4H7M62r06s0j3NuoOtD3gV0f9N4GRSJQElbGZ4
         D9Ike5hYlUDY0a4l1XCnP6fbTERcwydb3iukAzhT4JOMnao7e34ve/yP6uxklWG1klEv
         ihoA==
X-Received: by 10.68.142.130 with SMTP id rw2mr9271404pbb.107.1443207896232;
        Fri, 25 Sep 2015 12:04:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id fm5sm5255039pab.24.2015.09.25.12.04.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 12:04:55 -0700 (PDT)
In-Reply-To: <CAGZ79kbpLwODzPrGcuvz2oY+XMMPAy9SRh1s_5wV8cvY-J79iw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Sep 2015 11:56:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278676>

Stefan Beller <sbeller@google.com> writes:

>> I think two sensible choices that start-failure and return-value can
>> make are
>>
>>  (1) This one task failed, but that is OK.  Please let the other
>>      tasks run [*1*].
>>
>>  (2) There is something seriously wrong with the whole world and I
>>      declare an emergency.  Please kill the other ones and exit.
>
>   (3) There is something wrong, such that I cannot finish my
>       job, but I know the other 15 processes help towards the goal,
>       so I want to let them live on until they are done. E.g: fetch submodules
>       may want to take this strategy if it fails to start another sub
> process fetching.

How is that different from (1)?  Do you meann "let other ones that
are already running continue, but do not spawn any new ones?"

> We could also offer more access to the pp machinery and an implementation for
> (2) might look like this:
> ...
> By having the pointer to the pp struct passed around, we allow
> for adding new callback functions to be added later to the
> pp machinery, which may not be expressed via a return code.

What you are suggesting would lead to the same "different smart
participants making decisions locally, so you need to run around and
follow all the detailed codepaths to understand what is going on"
design.

I was hoping that we have already passed discussing that stage.

The whole point of that "SQUASH???" commit was to correct the design
of the overall structure so that we make the central dispatcher that
uses bunch of "dumb" helpers (that do not make policy decisions
locally on their own) as the single place you need to read in order
to understand the logic.
