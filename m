From: Junio C Hamano <gitster@pobox.com>
Subject: Re: glibc mutex deadlock in signal handler
Date: Thu, 03 Sep 2015 11:12:38 -0700
Message-ID: <xmqqvbbrjrs9.fsf@gitster.mtv.corp.google.com>
References: <s5hfv2vn4wq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Thu Sep 03 20:12:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXZ0F-00062r-1t
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 20:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbbICSMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 14:12:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34059 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251AbbICSMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 14:12:41 -0400
Received: by padfa1 with SMTP id fa1so11333658pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1S0oOBp9eQY8JhY+QbH06jawJWpUPlXlsM1CktZbFNo=;
        b=x4Iu/nZlmE9KTE+Q1N1sbBSziPS6zINYaQqPIby1HW1ValRzIFfF+GOpzNnm0OJm52
         8rcRNHSVZdEm9zLjxk6mJw8Vn0Lm/XuNA7VeixOYEuB3APrnRUl2MKuL5tWU2ITy0Uh3
         X/3124VdarOL6oaKUX/bhlNSiD1vlJtaQytbvJxBh8qQsSqtj/bdZb86sup0fIaGoLTE
         QBbmhH8ciA0wJLbM1M9rwpsuwRgfMqbQVvEVNx7+Kn0c+sXbGBwqRUN51QhseeL4YUhf
         LzzSrTTwNMazU0rK9W5jm5z8b6/Ep6QG7gZiY+oZoob9yESiJ2x1vhYWW2tV1owXwaiD
         3ykA==
X-Received: by 10.68.109.97 with SMTP id hr1mr69628385pbb.110.1441303960545;
        Thu, 03 Sep 2015 11:12:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id si1sm25981158pbc.72.2015.09.03.11.12.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 11:12:39 -0700 (PDT)
In-Reply-To: <s5hfv2vn4wq.wl-tiwai@suse.de> (Takashi Iwai's message of "Thu,
	03 Sep 2015 13:00:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277236>

Takashi Iwai <tiwai@suse.de> writes:

> we've got a bug report of git-log stall in below:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=942297
>
> In short, git-log is left unterminated sometimes when pager is
> aborted.  When this happens, git process can't be killed by SIGTERM,
> but only by SIGKILL.  And, further investigation revealed the possible
> mutex deadlock used in glibc *alloc()/free().
>
> I tried to reproduce this by adding a fault injection in glibc code,
> and actually got the similar stack trace as reported.  The problem is
> that glibc malloc (in this case realloc() and free()) takes a private
> mutex.  Thus calling any function does *alloc() or free() in a signal
> handler may deadlock.  In the case of git, it was free() calls in
> various cleanup codes and the printf() / strerror() invocations.
>
> Also, basically it's not safe to call fflush() or raise(), either.
> But they seem to work practically on the current systems.
>
> Below is a band-aid patch I tested and confirmed to work in the
> fault-injection case.  But, some unsafe calls mentioned in the above
> are left.  If we want to be in a safer side, we should really limit
> the things to do in a signal handler, e.g. only calling close() and
> doing waitpid(), I suppose.
>
> Any better ideas?

Sorry, but I am not with better ideas (at least offhand right now).

Essentially the idea seems to be to avoid calling allocation-related
functions in the signal handler codepath that is used for cleaning
things up.  Not calling free() in the codepaths is perfectly fine as
we know we will be soon exiting anyway.  Not being able to call
error() and strerror() to report funnies (other than the fact that
we were interrupted) is somewhat sad, though.




> diff --git a/pager.c b/pager.c
> index 27d4c8a17aa1..57dda0142fa9 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -14,19 +14,25 @@
>  static const char *pager_argv[] = { NULL, NULL };
>  static struct child_process pager_process = CHILD_PROCESS_INIT;
>  
> -static void wait_for_pager(void)
> +static void flush_pager(void)
>  {
>  	fflush(stdout);
>  	fflush(stderr);
>  	/* signal EOF to pager */
>  	close(1);
>  	close(2);
> +}
> +
> +static void wait_for_pager(void)
> +{
> +	flush_pager();
>  	finish_command(&pager_process);
>  }
>  
>  static void wait_for_pager_signal(int signo)
>  {
> -	wait_for_pager();
> +	flush_pager();
> +	finish_command_in_signal(&pager_process);
>  	sigchain_pop(signo);
>  	raise(signo);
>  }
> diff --git a/run-command.c b/run-command.c
> index 3277cf797ed4..a8cdc8f32944 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -18,26 +18,27 @@ struct child_to_clean {
>  static struct child_to_clean *children_to_clean;
>  static int installed_child_cleanup_handler;
>  
> -static void cleanup_children(int sig)
> +static void cleanup_children(int sig, int in_signal)
>  {
>  	while (children_to_clean) {
>  		struct child_to_clean *p = children_to_clean;
>  		children_to_clean = p->next;
>  		kill(p->pid, sig);
> -		free(p);
> +		if (!in_signal)
> +			free(p);
>  	}
>  }
>  
>  static void cleanup_children_on_signal(int sig)
>  {
> -	cleanup_children(sig);
> +	cleanup_children(sig, 1);
>  	sigchain_pop(sig);
>  	raise(sig);
>  }
>  
>  static void cleanup_children_on_exit(void)
>  {
> -	cleanup_children(SIGTERM);
> +	cleanup_children(SIGTERM, 0);
>  }
>  
>  static void mark_child_for_cleanup(pid_t pid)
> @@ -220,7 +221,7 @@ static inline void set_cloexec(int fd)
>  		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
>  }
>  
> -static int wait_or_whine(pid_t pid, const char *argv0)
> +static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  {
>  	int status, code = -1;
>  	pid_t waiting;
> @@ -231,13 +232,17 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  
>  	if (waiting < 0) {
>  		failed_errno = errno;
> -		error("waitpid for %s failed: %s", argv0, strerror(errno));
> +		if (!in_signal)
> +			error("waitpid for %s failed: %s", argv0,
> +			      strerror(errno));
>  	} else if (waiting != pid) {
> -		error("waitpid is confused (%s)", argv0);
> +		if (!in_signal)
> +			error("waitpid is confused (%s)", argv0);
>  	} else if (WIFSIGNALED(status)) {
>  		code = WTERMSIG(status);
>  		if (code != SIGINT && code != SIGQUIT)
> -			error("%s died of signal %d", argv0, code);
> +			if (!in_signal)
> +				error("%s died of signal %d", argv0, code);
>  		/*
>  		 * This return value is chosen so that code & 0xff
>  		 * mimics the exit code that a POSIX shell would report for
> @@ -254,10 +259,12 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  			failed_errno = ENOENT;
>  		}
>  	} else {
> -		error("waitpid is confused (%s)", argv0);
> +		if (!in_signal)
> +			error("waitpid is confused (%s)", argv0);
>  	}
>  
> -	clear_child_for_cleanup(pid);
> +	if (!in_signal)
> +		clear_child_for_cleanup(pid);
>  
>  	errno = failed_errno;
>  	return code;
> @@ -437,7 +444,7 @@ fail_pipe:
>  		 * At this point we know that fork() succeeded, but execvp()
>  		 * failed. Errors have been reported to our stderr.
>  		 */
> -		wait_or_whine(cmd->pid, cmd->argv[0]);
> +		wait_or_whine(cmd->pid, cmd->argv[0], 0);
>  		failed_errno = errno;
>  		cmd->pid = -1;
>  	}
> @@ -536,12 +543,18 @@ fail_pipe:
>  
>  int finish_command(struct child_process *cmd)
>  {
> -	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
> +	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
>  	argv_array_clear(&cmd->args);
>  	argv_array_clear(&cmd->env_array);
>  	return ret;
>  }
>  
> +int finish_command_in_signal(struct child_process *cmd)
> +{
> +	return wait_or_whine(cmd->pid, cmd->argv[0], 1);
> +}
> +
> +
>  int run_command(struct child_process *cmd)
>  {
>  	int code;
> @@ -772,7 +785,7 @@ error:
>  int finish_async(struct async *async)
>  {
>  #ifdef NO_PTHREADS
> -	return wait_or_whine(async->pid, "child process");
> +	return wait_or_whine(async->pid, "child process", 0);
>  #else
>  	void *ret = (void *)(intptr_t)(-1);
>  
> diff --git a/run-command.h b/run-command.h
> index 5b4425a3cbe1..275d35c442ac 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -50,6 +50,7 @@ void child_process_init(struct child_process *);
>  
>  int start_command(struct child_process *);
>  int finish_command(struct child_process *);
> +int finish_command_in_signal(struct child_process *);
>  int run_command(struct child_process *);
>  
>  /*
