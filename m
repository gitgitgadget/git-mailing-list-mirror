From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] run-command: Call get_next_task with a clean child process.
Date: Tue, 20 Oct 2015 16:05:49 -0700
Message-ID: <xmqq37x56sz6.fsf@gitster.mtv.corp.google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofyh-0006Ft-M4
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 01:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbbJTXFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 19:05:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32890 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbbJTXFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 19:05:51 -0400
Received: by pabrc13 with SMTP id rc13so34296266pab.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=MKA9LhiVtAZYM949EQMeUbLUpZgD6F/2i/lSDVjPROc=;
        b=fnqIyf8Jc3HGZ1sK7ItUtuj3p1AicQD4KqP2TAp04/jFSkbCr5L0nrNS7SuAoZgffI
         vuvDQOCIlQvbjQBxTbWRtk9GsONtI6ImZFNhxDsRo3bUns7XnFd9bmtJYSFr5J+Yroao
         v0YmK5sZVrHfKqDfC/I+jVdb/128Nu8YjhNIyKLI6KficiTCU5lxennArstsnH5vr/vW
         JwqK7Pn5MGSAfQiCCCnipj0x6toF+JrRtqjv5u2JBNIM5RMcCiMjje42hvAUnagaCkON
         vpOt2G2jFPfHL8SlxD2UzbhLhni3IVIl39YEbO9GtCUlipwV77xINHVizJ/2BFIARexQ
         zR8w==
X-Received: by 10.66.228.97 with SMTP id sh1mr6597436pac.91.1445382350745;
        Tue, 20 Oct 2015 16:05:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id nz4sm5645621pbb.47.2015.10.20.16.05.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 16:05:50 -0700 (PDT)
In-Reply-To: <1445381030-23912-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 20 Oct 2015 15:43:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279958>

Stefan Beller <sbeller@google.com> writes:

> If the `get_next_task` did not explicitly called child_process_init
> and only filled in some fields, there may have been some stale data
> in the child process. This is hard to debug and also adds a review
> burden for each new user of that API. To improve the situation, we
> pass only cleanly initialized child structs to the get_next_task.
>
> As an invariant you can now assume any child not in use is
> cleaned up and ready for its next reuse.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  run-command.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index b9363da..a5ef874 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -13,6 +13,12 @@ void child_process_init(struct child_process *child)
>  	argv_array_init(&child->env_array);
>  }
>  
> +void child_process_deinit(struct child_process *child)
> +{
> +	argv_array_clear(&child->args);
> +	argv_array_clear(&child->env_array);
> +}
> +

Is this necessary (and is it necessary to make it global)?
I thought that finish_command() already clears them....

    ... goes and looks ...

Ahh, of course, pp_*() functions do use start_command() but do not
use finish_command(), which sort of breaks symmetry, but that cannot
be helped.  Because we want to wait for any of the multiple tasks
running, we cannot call finish_command() that explicitly says "I
want to wait for this one to finish".

And that is why you already have two calls to array-clear inside
collect_finished(), just after calling task_finished().

And of course we already have these array-clear calls in
finish_command().

So I agree that deinit helper should exist, but

 * it should be file-scope static;

 * it should be called by finish_command(); and

 * if you are calling it from collect_finished(), then existing
   calls to array-clear should go.

Other than that, this looks good.

Thanks.
