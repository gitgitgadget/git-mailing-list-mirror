From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv6 0/8] fetch submodules in parallel
Date: Thu, 1 Oct 2015 19:55:51 +0100
Message-ID: <560D81B7.6090304@ramsayjones.plus.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 20:56:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhj1Q-0005D0-FW
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 20:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536AbbJASz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 14:55:56 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55037 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbbJASzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 14:55:53 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout07 with smtp
	id Puvq1r0032FXpih01uvrSe; Thu, 01 Oct 2015 19:55:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=zmZjtmYc9y-94Ms7E0QA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278901>

Hi Stefan,

On 01/10/15 02:54, Stefan Beller wrote:
[snip]

While skimming the interdiff for this series, ...

> diff --git a/run-command.c b/run-command.c
> index df84985..28048a7 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -863,12 +863,13 @@ struct parallel_processes {
>  
>  	get_next_task_fn get_next_task;
>  	start_failure_fn start_failure;
> -	return_value_fn return_value;
> +	task_finished_fn task_finished;
>  
>  	struct {
>  		unsigned in_use : 1;
>  		struct child_process process;
>  		struct strbuf err;
> +		void *data;
>  	} *children;
>  	/*
>  	 * The struct pollfd is logically part of *children,
> @@ -882,9 +883,10 @@ struct parallel_processes {
>  	struct strbuf buffered_output; /* of finished children */
>  } parallel_processes_struct;
>  
> -static int default_start_failure(void *data,
> -				 struct child_process *cp,
> -				 struct strbuf *err)
> +static int default_start_failure(struct child_process *cp,
> +				 struct strbuf *err,
> +				 void *pp_cb,
> +				 void *pp_task_cb)
>  {
>  	int i;
>  
> @@ -895,10 +897,11 @@ static int default_start_failure(void *data,
>  	return 0;
>  }
>  
> -static int default_return_value(void *data,
> -				struct child_process *cp,
> -				struct strbuf *err,
> -				int result)
> +static int default_task_finished(int result,
> +				 struct child_process *cp,
> +				 struct strbuf *err,
> +				 void *pp_cb,
> +				 void *pp_task_cb)
>  {
>  	int i;
>  
> @@ -930,10 +933,11 @@ static void handle_children_on_signal(int signo)
>  	raise(signo);
>  }
>  
> -static struct parallel_processes *pp_init(int n, void *data,
> +static struct parallel_processes *pp_init(int n,
>  					  get_next_task_fn get_next_task,
>  					  start_failure_fn start_failure,
> -					  return_value_fn return_value)
> +					  task_finished_fn task_finished,
> +					  void *data)
>  {
>  	int i;
>  	struct parallel_processes *pp = &parallel_processes_struct;
> @@ -948,7 +952,7 @@ static struct parallel_processes *pp_init(int n, void *data,
>  	pp->get_next_task = get_next_task;
>  
>  	pp->start_failure = start_failure ? start_failure : default_start_failure;
> -	pp->return_value = return_value ? return_value : default_return_value;
> +	pp->task_finished = task_finished ? task_finished : default_task_finished;
>  
>  	pp->nr_processes = 0;
>  	pp->output_owner = 0;
> @@ -1006,15 +1010,17 @@ static int pp_start_one(struct parallel_processes *pp)
>  	if (i == pp->max_processes)
>  		die("BUG: bookkeeping is hard");
>  
> -	if (!pp->get_next_task(pp->data,
> +	if (!pp->get_next_task(&pp->children[i].data,
>  			       &pp->children[i].process,
> -			       &pp->children[i].err))
> +			       &pp->children[i].err,
> +			       pp->data))
>  		return 1;

... the above hunk caught my eye. I don't know that it matters that
much, but since you have reordered parameters on some functions, should
pp->get_next_task() take the 'task_cb' as the last parameter, rather than
the first?

I have not looked at the final result yet (just the interdiff), so please
just ignore the above if I've missed something obvious. :-D

ATB,
Ramsay Jones
