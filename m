From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] run-command: Call get_next_task with a clean child process.
Date: Tue, 20 Oct 2015 11:49:10 -0700
Message-ID: <xmqq61218jfd.fsf@gitster.mtv.corp.google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
	<1445279086-31066-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZobyG-0002sS-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 20:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbbJTStM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 14:49:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36600 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJTStL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 14:49:11 -0400
Received: by pacfv9 with SMTP id fv9so30092476pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=H43z5DQpbq92r/3KOdwePURcs7yXvMEviVjY/0/pJ4I=;
        b=l236zAUwbVWewkwxLQeuEhLYcqpcvuEEOgT1mZmvoeWod185KWRHajkHVoPUNRBtV5
         ZA3clD+q56iRxnLDCDbHVKnHz7M4JsY8c1F04/3tQfTQKCJYDQsB4Z3IRZZjWnrjlHyR
         5e47g4B59mYMJByd/Bt28skVQf9gX8uS8kq49cE98wjrf/3xNPo3GIf1rfiymwkyatMl
         v553+ny7Kkao8LxLNuHkaUOeznv0lCIV6n1/r+N5yn4Y5+n06cBNju5kent71z9ZBg+V
         p3K1C7j+FzT/qr39Oia+JCV+Zq9CNQzRTco00n2EvsE3WDNN6cOUxLv3afyCUOX4GjHT
         amOg==
X-Received: by 10.68.105.193 with SMTP id go1mr5481236pbb.59.1445366951567;
        Tue, 20 Oct 2015 11:49:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id we9sm5073245pab.3.2015.10.20.11.49.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 11:49:10 -0700 (PDT)
In-Reply-To: <1445279086-31066-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 19 Oct 2015 11:24:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279932>

Stefan Beller <sbeller@google.com> writes:

> If the `get_next_task` did not explicitly called child_process_init

I locally did "If get_next_task did not explicitly call child_process_init"

> and only filled in some fields, there may have been some stale data
> in the child process. This is hard to debug and also adds a review
> burden for each new user of that API. To improve the situation, we
> pass only cleanly initialized child structs to the get_next_task.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Again this makes sense.

Another way, which I suspect may be conceptually cleaner, would be
to do this clean-up where pp->children[i].in_use is set to false, as
that is where the particular task is declared to be available for
reuse.  That location should be responsible to ensure that the task
indeed is reusable by calling child_process_init().

By the way, does child_process_init() leak old argv/env arrays, or
have they already been cleared by calling finish_command() when we
come to this codepath?

>  run-command.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 8f47c6e..b8b5747 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1010,6 +1010,8 @@ static int pp_start_one(struct parallel_processes *pp)
>  	if (i == pp->max_processes)
>  		die("BUG: bookkeeping is hard");
>  
> +	child_process_init(&pp->children[i].process);
> +
>  	if (!pp->get_next_task(&pp->children[i].data,
>  			       &pp->children[i].process,
>  			       &pp->children[i].err,
