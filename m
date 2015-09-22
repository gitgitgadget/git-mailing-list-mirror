From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Mon, 21 Sep 2015 18:08:33 -0700
Message-ID: <xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:08:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeC4W-0001lM-3S
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 03:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbbIVBIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 21:08:35 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34236 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbbIVBIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 21:08:35 -0400
Received: by padhy16 with SMTP id hy16so131574854pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iX8sq9Ru1PU0ZD41L6SsnnMpKcbFIvhd+8s8ZVjE2EI=;
        b=DaHh2fFVbufHxbHrTKzI96nlB+i1RSOtqCMBXEiEi/2lLnsM8YSc2Ru+m8ZFrJbrkl
         s7hUvpuA+twgrgh1kcvKdEYixBQxvhn/Azt/mbwLatJPsBK1LuFdDqWQL62C0Yo1yrPz
         4EhrownCiW62WKH+EKqoqRTNovgXfCoNMC7AnuH2Sq4iaW/y7hF/v0B7p6qZp9ORcgJi
         sxH1z+24PqBv0OkvtQ4Bnyt/LDVA7t7GPCcSTA0QSDifgcGL5CzJ3ZepWQFAV9i8unHH
         zSoyNZ/+eqedaGxn6fzjrsfbyEq5ubMbU3OYVBmNfTPAlsIGmsmpEyBzSyHxzSOUTOdW
         ad0g==
X-Received: by 10.66.235.226 with SMTP id up2mr28482953pac.89.1442884114549;
        Mon, 21 Sep 2015 18:08:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id ox2sm26851959pbb.87.2015.09.21.18.08.33
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 18:08:33 -0700 (PDT)
In-Reply-To: <1442875159-13027-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278372>

Stefan Beller <sbeller@google.com> writes:

> +void default_start_failure(void *data,
> +			   struct child_process *cp,
> +			   struct strbuf *err)
> +{
> +	int i;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	for (i = 0; cp->argv[i]; i++)
> +		strbuf_addf(&sb, "%s ", cp->argv[i]);
> +	die_errno("Starting a child failed:\n%s", sb.buf);

Do we want that trailing SP after the last element of argv[]?
Same question applies to the one in "return-value".

> +static void run_processes_parallel_init(struct parallel_processes *pp,
> +					int n, void *data,
> +					get_next_task_fn get_next_task,
> +					start_failure_fn start_failure,
> +					return_value_fn return_value)
> +{
> +	int i;
> +
> +	if (n < 1)
> +		n = online_cpus();
> +
> +	pp->max_processes = n;
> +	pp->data = data;
> +	if (!get_next_task)
> +		die("BUG: you need to specify a get_next_task function");
> +	pp->get_next_task = get_next_task;
> +
> +	pp->start_failure = start_failure ? start_failure : default_start_failure;
> +	pp->return_value = return_value ? return_value : default_return_value;

I would actually have expected that leaving these to NULL will just
skip pp->fn calls, instead of a "default implementation", but a pair
of very simple default implementation would not hrtut.

> +static void run_processes_parallel_cleanup(struct parallel_processes *pp)
> +{
> +	int i;

Have a blank between the decl block and the first stmt here (and
elsewhere, too---which you got correct in the function above)?

> +	for (i = 0; i < pp->max_processes; i++)
> +		strbuf_release(&pp->children[i].err);

> +static void run_processes_parallel_start_one(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i = 0; i < pp->max_processes; i++)
> +		if (!pp->children[i].in_use)
> +			break;
> +	if (i == pp->max_processes)
> +		die("BUG: bookkeeping is hard");

Mental note: the caller is responsible for not calling this when all
slots are taken.

> +	if (!pp->get_next_task(pp->data,
> +			       &pp->children[i].process,
> +			       &pp->children[i].err)) {
> +		pp->all_tasks_started = 1;
> +		return;
> +	}

Mental note: but it is OK to call this if get_next_task() previously
said "no more task".

The above two shows a slight discrepancy (nothing earth-breaking).

I have this suspicion that the all-tasks-started bit may turn out to
be a big mistake that we may later regret.  Don't we want to allow
pp->more_task() to say "no more task to run at this moment" implying
"but please do ask me later, because I may have found more to do by
the time you ask me again"?

That is one of the reasons why I do not think the "very top level is
a bulleted list" organization is a good idea in general.  A good
scheduling decision can seldom be made in isolation without taking
global picture into account.

> +static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
> +{
> +	int i = 0;
> +	pid_t pid;
> +	int wait_status, code;
> +	int n = pp->max_processes;
> +
> +	while (pp->nr_processes > 0) {
> +		pid = waitpid(-1, &wait_status, WNOHANG);
> +		if (pid == 0)
> +			return;
> +
> +		if (pid < 0)
> +			die_errno("wait");
> +
> +		for (i = 0; i < pp->max_processes; i++)
> +			if (pp->children[i].in_use &&
> +			    pid == pp->children[i].process.pid)
> +				break;
> +		if (i == pp->max_processes)
> +			/*
> +			 * waitpid returned another process id
> +			 * which we are not waiting for.
> +			 */
> +			return;

If we culled a child process that this machinery is not in charge
of, waitpid() in other places that wants to see that child will not
see it.  Perhaps such a situation might even warrant an error() or
BUG()?  Do we want a "NEEDSWORK: Is this a bug?" comment here at
least?

> +		if (strbuf_read_once(&pp->children[i].err,
> +				     pp->children[i].process.err, 0) < 0 &&
> +		    errno != EAGAIN)
> +			die_errno("strbuf_read_once");

Don't we want to read thru to the end here?  The reason read_once()
did not read thru to the end may not have anything to do with
NONBLOCK (e.g. xread_nonblock() caps len, and it does not loop).
