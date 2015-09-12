From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Sat, 12 Sep 2015 12:11:45 -0700
Message-ID: <xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
	<1442012994-20374-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaqDg-0002Go-NW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 21:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbbILTLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 15:11:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34304 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbILTLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 15:11:47 -0400
Received: by padhy16 with SMTP id hy16so104543275pad.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fEoBvqz6RRuNeBQLNjInOQykR02iTKSo7aJCGfBlqNk=;
        b=Koy8BP8auzb8H2gOv2BwjxKHKHKzuA9nUH1YAzCpx58KO04OOJ8sJhFrX7+tk3cl8O
         wCmaMkaKJR+MotHa/5Zr9roWP5S2vxfzU1yDsG+iGe1JyDs0pGxKXX19NMRheko2InXC
         1f/Iv0RhdxgyIgnek+qWwnUAJPlWnAl19kB40l98b/wuMUyIf6+pgIzjGb0CJzzKaMAg
         PMJcVCGjpLFJFUin14BE+gCC+GleQ0k6NuW7YEtUxjuxxtXbBpwSk4VsUudZmf/NUfBW
         pcQ03cT8F/emtiItNmWnlMTn6ZGpFP8K4rAzZqPP3kX/E62H5amSO8u+D5bv4e+nm7d5
         3LNA==
X-Received: by 10.68.69.70 with SMTP id c6mr13243178pbu.28.1442085106795;
        Sat, 12 Sep 2015 12:11:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b563:b427:39df:b23])
        by smtp.gmail.com with ESMTPSA id jd12sm7206836pbd.44.2015.09.12.12.11.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 12 Sep 2015 12:11:46 -0700 (PDT)
In-Reply-To: <1442012994-20374-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 11 Sep 2015 16:09:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277733>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/run-command.c b/run-command.c
> index 28e1d55..b8ff67b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -852,3 +852,147 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
>  	close(cmd->out);
>  	return finish_command(cmd);
>  }
> +
> +int run_processes_async(int n, get_next_task fn, void *data)
> +{
> +	int i, wait_status;
> +	pid_t pid;
> +
> +	/* no more tasks. Also set when aborting early. */
> +	int all_tasks_started = 0;
> +	int nr_processes = 0;
> +	int child_in_foreground = 0;
> +	struct timeval timeout;
> +	struct child_process *children = xcalloc(n, sizeof(*children));
> +	char *slots = xcalloc(n, sizeof(*slots));
> +	struct strbuf *err = xcalloc(n, sizeof(*err));
> +	fd_set fdset;
> +	int maxfd;
> +	struct strbuf finished_children = STRBUF_INIT;
> +	int flags;
> +	for (i = 0; i < n; i++)
> +		strbuf_init(&err[i], 0);
> +
> +	while (!all_tasks_started || nr_processes > 0) {
> +		/* Start new processes. */
> +		while (!all_tasks_started && nr_processes < n) {
> +			for (i = 0; i < n; i++)
> +				if (!slots[i])
> +					break; /* found an empty slot */
> +			if (i == n)
> +				die("BUG: bookkeeping is hard");
> +
> +			if (fn(data, &children[i], &err[i])) {
> +				all_tasks_started = 1;
> +				break;
> +			}
> +			if (start_command(&children[i]))
> +				die(_("Could not start child process"));
> +			flags = fcntl(children[i].err, F_GETFL);
> +			fcntl(children[i].err, F_SETFL, flags | O_NONBLOCK);

This function in run-command.c looks as if it is a generic helper to
be called by anybody, but it seems to only care about the standard
error and not the standard output stream, which means potential
users that do not dup them together cannot use it.  Is that a big
downside, or is it sufficient to document the API to say that
children must do so?  I offhand do not think the latter is
unreasonable, but that may be only because I haven't thought things
through.

> +			nr_processes++;
> +			slots[i] = 1;
> +		}
> +
> +		/* prepare data for select call */
> +		FD_ZERO(&fdset);
> +		maxfd = 0;
> +		for (i = 0; i < n; i++) {
> +			if (!slots[i])
> +				continue;
> +			FD_SET(children[i].err, &fdset);
> +			if (children[i].err > maxfd)
> +				maxfd = children[i].err;
> +		}
> +		timeout.tv_sec = 0;
> +		timeout.tv_usec = 500000;
> +
> +		i = select(maxfd + 1, &fdset, NULL, NULL, &timeout);

I thought we try to use poll() and on systems with only select we
allow compat/ to emulate in our code.

> +		if (i < 0) {
> +			if (errno == EINTR)
> +				/* A signal was caught; try again */
> +				continue;
> +			else if (errno == ENOMEM)
> +				die_errno("BUG: keeping track of fds is hard");
> +			else if (errno == EINVAL)
> +				die_errno("BUG: invalid arguments to select");
> +			else if (errno == EBADF)
> +				die_errno("BUG: keeping track of fds is hard");
> +			else
> +				die_errno("Unknown error with select");

I doubt that the later part of elseif cascade adds any value.  You
will see errno printed anyway.
