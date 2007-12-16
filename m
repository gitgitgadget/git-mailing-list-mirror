From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] threaded pack-objects: Use condition variables for
	thread communication.
Date: Sun, 16 Dec 2007 13:05:58 +0100
Message-ID: <20071216120558.GA4999@xp.machine.xx>
References: <200712160018.54171.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Dec 16 13:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3sGd-00033L-Nd
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 13:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491AbXLPMGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 07:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934488AbXLPMGI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 07:06:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:34327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934367AbXLPMGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 07:06:05 -0500
Received: (qmail invoked by alias); 16 Dec 2007 12:06:01 -0000
Received: from p54AAB2DC.dip0.t-ipconnect.de (EHLO localhost) [84.170.178.220]
  by mail.gmx.net (mp019) with SMTP; 16 Dec 2007 13:06:01 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18sx75gXN8s8wUyAxVbDaNuKQ6zSroecxQdQox10S
	ymrfFP8cosr1kt
Content-Disposition: inline
In-Reply-To: <200712160018.54171.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68458>

On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
> In the threaded pack-objects code the main thread and the worker threads
> must mutually signal that they have assigned a new pack of work or have
> completed their work, respectively. Previously, the code used mutexes that
> were locked in one thread and unlocked from a different thread, which is
> bogus (and happens to work on Linux).
> 
> Here we rectify the implementation by using condition variables: There is
> one condition variable on which the main thread waits until a thread
> requests new work; and each worker thread has its own condition variable
> on which it waits until it is assigned new work or signaled to terminate.
> 
> As a cleanup, the worker threads are spawned only after the initial work
> packages have been assigned.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  builtin-pack-objects.c |  129 +++++++++++++++++++++++++++++------------------
>  1 files changed, 79 insertions(+), 50 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 7dd0d7f..451e48e 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1594,6 +1594,15 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
>  
>  #ifdef THREADED_DELTA_SEARCH
>  
> +/*
> + * The main thread waits on the condition that (at least) one of the workers
> + * has stopped working (which is indicated in the .working member of
> + * struct thread_params).
> + * When a work thread has completed its work, it sets .working to 0 and
> + * signals the main thread and waits on the condition that .data_ready
> + * becomes 1.
> + */
> +
>  struct thread_params {
>  	pthread_t thread;
>  	struct object_entry **list;
> @@ -1601,37 +1610,50 @@ struct thread_params {
>  	unsigned remaining;
>  	int window;
>  	int depth;
> +	int working;
> +	int data_ready;
> +	pthread_mutex_t mutex;
> +	pthread_cond_t cond;
>  	unsigned *processed;
>  };
>  
> -static pthread_mutex_t data_request  = PTHREAD_MUTEX_INITIALIZER;
> -static pthread_mutex_t data_ready    = PTHREAD_MUTEX_INITIALIZER;
> -static pthread_mutex_t data_provider = PTHREAD_MUTEX_INITIALIZER;
> -static struct thread_params *data_requester;
> +static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
>  
>  static void *threaded_find_deltas(void *arg)
>  {
>  	struct thread_params *me = arg;
>  
> -	for (;;) {
> -		pthread_mutex_lock(&data_request);
> -		data_requester = me;
> -		pthread_mutex_unlock(&data_provider);
> -		pthread_mutex_lock(&data_ready);
> -		pthread_mutex_unlock(&data_request);
> -
> -		if (!me->remaining)
> -			return NULL;
> -
> +	while (me->remaining) {
>  		find_deltas(me->list, &me->remaining,
>  			    me->window, me->depth, me->processed);
> +
> +		progress_lock();
> +		me->working = 0;
> +		progress_unlock();
> +		pthread_cond_signal(&progress_cond);

Shouldn't the pthread_cond_signal be inside the lock?
e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)

> +
> +		/*
> +		 * We must not set ->data_ready before we wait on the
> +		 * condition because the main thread may have set it to 1
> +		 * before we get here. In order to be sure that new
> +		 * work is available if we see 1 in ->data_ready, it
> +		 * was initialized to 0 before this thread was spawned
> +		 * and we reset it to 0 right away.
> +		 */
> +		pthread_mutex_lock(&me->mutex);
> +		while (!me->data_ready)
> +			pthread_cond_wait(&me->cond, &me->mutex);
> +		me->data_ready = 0;
> +		pthread_mutex_unlock(&me->mutex);
>  	}
> +	/* leave ->working 1 so that this doesn't get more work assigned */
> +	return NULL;
>  }

[...]


-Peter
