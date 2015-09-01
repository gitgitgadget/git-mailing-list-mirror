From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: provide in_async query function
Date: Tue, 01 Sep 2015 15:09:56 -0700
Message-ID: <xmqq613trdu3.fsf@gitster.mtv.corp.google.com>
References: <20150901202215.GA17370@sigill.intra.peff.net>
	<20150901202243.GA6931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:10:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtlJ-0006i1-0h
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbbIAWK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:10:26 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33654 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbIAWJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:09:58 -0400
Received: by paap5 with SMTP id p5so1410182paa.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Kkuf4qVWfVxBwWPrh5b5LIDuQV5Rqarcdpl+y8tsbFk=;
        b=KhtiuzcpKDb5B3rxLQBHh88HvhIse24qj48VnWoJ0n/1HRltFUTdXm+PKbnjYaN4ZP
         84fKfWxTTxfxpu2G14lbIlnQIs/q9cOV+SFaRE+M5MryYPY0DGuzNyWfUZVasL+H+aeS
         ygdwvmKppPJvvVXoqw+M0V/kDJWDiJVekzg5TfzEXZJ6wtFf4ux52BGdDoiG9ccUOHkR
         ytsF6dTqv5+b3p2w3VNwMG6vzNOiZkw3hfF0qbatjkQpLuyFJH7ojVNcaeZkCQaX9/Xr
         6nqjSjwPQLv4BAPVNrjHgLHR+BVr6dx9YqnpfzhOtjDunc6Bq49AiPFCGwP8q2nQ8sSk
         9iGA==
X-Received: by 10.69.12.33 with SMTP id en1mr50593627pbd.97.1441145398493;
        Tue, 01 Sep 2015 15:09:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id if9sm19246023pbc.89.2015.09.01.15.09.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 15:09:57 -0700 (PDT)
In-Reply-To: <20150901202243.GA6931@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2015 16:22:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277050>

Jeff King <peff@peff.net> writes:

> It's not easy for arbitrary code to find out whether it is
> running in an async process or not. A top-level function
> which is fed to start_async() can know (you just pass down
> an argument saying "you are async"). But that function may
> call other global functions, and we would not want to have
> to pass the information all the way through the call stack.
>
> Nor can we simply set a global variable, as those may be
> shared between async threads and the main thread (if the
> platform supports pthreads). We need pthread tricks _or_ a
> global variable, depending on how start_async is
> implemented.
>
> The callers don't have enough information to do this right,
> so let's provide a simple query function that does.
> Fortunately we can reuse the existing infrastructure to make
> the pthread case simple (and even simplify die_async() by
> using our new function).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

What is not immediately obvious from the above description is why a
code may want to care if it is in_async() in the first place.

If there weren't the die_async() update, the readers might have been
left utterly baffled (or they can somehow see this is related to
2/2) but it is a bit hard to arrange in "git log" as going to child
is harder.

The patch looks good.  Thanks.

>  run-command.c | 16 +++++++++++++++-
>  run-command.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 3277cf7..c8029f2 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -595,7 +595,7 @@ static NORETURN void die_async(const char *err, va_list params)
>  {
>  	vreportf("fatal: ", err, params);
>  
> -	if (!pthread_equal(main_thread, pthread_self())) {
> +	if (in_async()) {
>  		struct async *async = pthread_getspecific(async_key);
>  		if (async->proc_in >= 0)
>  			close(async->proc_in);
> @@ -614,6 +614,13 @@ static int async_die_is_recursing(void)
>  	return ret != NULL;
>  }
>  
> +int in_async(void)
> +{
> +	if (!main_thread_set)
> +		return 0; /* no asyncs started yet */
> +	return !pthread_equal(main_thread, pthread_self());
> +}
> +
>  #else
>  
>  static struct {
> @@ -653,6 +660,12 @@ int git_atexit(void (*handler)(void))
>  }
>  #define atexit git_atexit
>  
> +static int process_is_async;
> +int in_async(void)
> +{
> +	return process_is_async;
> +}
> +
>  #endif
>  
>  int start_async(struct async *async)
> @@ -712,6 +725,7 @@ int start_async(struct async *async)
>  		if (need_out)
>  			close(fdout[0]);
>  		git_atexit_clear();
> +		process_is_async = 1;
>  		exit(!!async->proc(proc_in, proc_out, async->data));
>  	}
>  
> diff --git a/run-command.h b/run-command.h
> index 5b4425a..629fab7 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -118,5 +118,6 @@ struct async {
>  
>  int start_async(struct async *async);
>  int finish_async(struct async *async);
> +int in_async(void);
>  
>  #endif
