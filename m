From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] thread-utils: add a threaded task queue
Date: Thu, 27 Aug 2015 14:59:33 +0200
Organization: gmx
Message-ID: <a35977776a7ea97b0ddd4d1921e3e95f@www.dscho.org>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
 <1440636766-12738-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 15:00:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUwme-0001In-CC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 15:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbbH0M74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 08:59:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:56148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbbH0M7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 08:59:55 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MegeC-1Z6pHa4A1I-00ODof; Thu, 27 Aug 2015 14:59:35
 +0200
In-Reply-To: <1440636766-12738-3-git-send-email-sbeller@google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:xFSkQQfI1V567VCws4ipFT73j5DzgGstzgvSOMkhbGkSZwuUx71
 lLmT12JD0GfMl88OPg6jLCIvgJdXtJSzD1VH8aTY8zbQkVSOcwdHfZrq8+U4z8xYh6DAvXr
 ZXPunlifu85OIt7ktlbkZkNeCQzNSnq2w9WSsuKF+hwHGDXKPYo2+pJDBeVPzXo8AWMN0Rn
 poXwN5Yk3T8pJqibmYm0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2HcJ+BlaVgE=:yQ11auLl7b8Op28ds6rLQd
 EScAUlAXLDDXFrz1nlIs4SYpKq5jD4CgrLj1yXRPX74LBHIFr8yY8clvtFv8Q+/aj1eEVdpWe
 KD4sJ45zaD3DOBEg2j52inc6+dlEMlV1urj/MXvYhnXoC6CXn8xUOaIASPM3vgkOawUvf7nKC
 amZOq5tFKEBgzLxOVHjgbOE95sAZd4ZmBZFlHvSzhqjlHRIisJErSiVaxAyuw4UxC5U6Vc+qK
 F6V1yC45jDQuZCeR/LedvnFVVRUWCbIOGBahouSOwPqHWv6x0JsJo7XwWEvb6In7MutmU1XJa
 aT8ciX8upkJQPw7MXZoZwKNYeDP56SIYO/0KoXvjueocfcxbnzun/QsBjEmgrMoiml3XyGzKY
 YE3H8+g1jnZUH5DJrU0C4WQh8ZRhRwYRWXAFqfAKk4+a6KBDffEedh9DjnjdUDM0epr8JeaRk
 bdcliWonmE7oUUPK8+1Qe2u607Lg/KkJeegRXiBuAV0Zk6qO+uTEORgMuBytEjyHnlmSKxhFJ
 TCokUnDo5Bxk/dPIICkWonP1TB95/VRqSJUfuYkjgjYvilO4L5BYgA1IRR3+p+uOlvDsoYh2N
 /LR+Z1aQMgBT40cwikW8iVkxmrZA14yyStRYJ6VeDfoV9zj8AIMbg6KWTMN86OfBDkEDwE7oQ
 nNJWLvcOB81seUn7SFqjYJRggWu6/thrg3SeI7kE2zFtGCkSZGrWlWJ+okpCXrO90yWSY572U
 001QAK79rn0NE7SqckeDH3y3rWf84Dr1gj/qfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276673>

Hi Stefan,

On 2015-08-27 02:52, Stefan Beller wrote:

> diff --git a/run-command.c b/run-command.c
> index 28e1d55..cb15cd9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -668,6 +668,22 @@ int git_atexit(void (*handler)(void))
>  
>  #endif
>  
> +void setup_main_thread(void)
> [...]
>
> diff --git a/thread-utils.c b/thread-utils.c
> index a2135e0..b45ab92 100644
> --- a/thread-utils.c
> +++ b/thread-utils.c
> [...]
> +/* FIXME: deduplicate this code with run-command.c */
> +static void setup_main_thread(void)

Do you remember off-hand why the code could not be moved to thread-utils.c wholesale? Just curious.

> +#else /* NO_PTHREADS */
> +
> +struct task_queue {
> +	int early_return;
> +};
> +
> +struct task_queue *create_task_queue(unsigned max_threads)
> +{
> +	struct task_queue *tq = xmalloc(sizeof(*tq));
> +
> +	tq->early_return = 0;
> +}
> +
> +void add_task(struct task_queue *tq,
> +	      int (*fct)(struct task_queue *tq, void *task),

Might make sense to typedef this... Maybe task_t?

> +	      void *task)
> +{
> +	if (tq->early_return)
> +		return;

Ah, so "early_return" actually means "interrupted" or "canceled"?

I guess I will have to set aside some time to wrap my head around the way tasks are handled here, in particular how the two `early_return` variables (`dispatcher()`'s local variable and the field in the `task_queue`) interact.

Thanks!
Dscho
