From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Tue, 25 Aug 2015 14:09:12 -0700
Message-ID: <xmqq7fojxeh3.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 23:09:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZULT9-0003y3-RI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 23:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbbHYVJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 17:09:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36405 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbbHYVJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 17:09:13 -0400
Received: by pacgr6 with SMTP id gr6so2448550pac.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=G4PKO3O/JMZXLyW5fFoaYlmhI3wdT5n+GR/eNlTSLak=;
        b=mb7PtrxCluFKZznu7Q8ZnoSkmAS1OC9AxSUjg389bEZHuiXp5Sx36MnQFbLObCczSQ
         omEYXRLTtTPaAnUkCWlOQyeh+KU6LbJgauOVgj++tImOI8gg6PGZ8SV7i840gZLNToeA
         y8DvXbj/Mr1k9hCfHYcQXyTE9jWnCKjuQBChY9TCnSc9X2HgVXT/hOb3M/+L9ug0V1/s
         Rl5D3KoOKZh8NouSMJsJEdUH3khhGZdFSEc5XUHP3N6UmzJ8QTSnuYUJ8hGwKS0JzF1y
         sHoMTSLNaLcZpX08urcuotaeZoT+sSnoeFQ5elDAQjDxo2RVBWnPL3V4WDPipOBWzh4E
         jiGQ==
X-Received: by 10.66.219.5 with SMTP id pk5mr60285460pac.111.1440536953157;
        Tue, 25 Aug 2015 14:09:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id kr1sm22048962pbc.93.2015.08.25.14.09.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 14:09:12 -0700 (PDT)
In-Reply-To: <1440523706-23041-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 25 Aug 2015 10:28:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276574>

Stefan Beller <sbeller@google.com> writes:

> This runs a command on each submodule in parallel and should eventually
> replace `git submodule foreach`.
>
> There is a new option -j/--jobs (inspired by make) to specify the number
> of parallel threads.
>
> The jobs=1 case needs to be special cases to exactly replicate the current
> default behavior of `git submodule foreach` such as working stdin input.

"git submodule foreach-parallel -j1" feels like a roundabout way to
say "git submodule foreach"; "I want you to go parallel.  Oh, not
really, I want you to do one thing at a time".

I do not think these two have to be equivalent---users who need the
traditional one-by-one "foreach" behaviour (including the standard
input and other aspects that are unreasonable to expect
"foreach-parallel -jN" to replicate) can and should choose to use
"foreach", not "foreach-parallel -j1".

In any case, I do not think I saw any special casing of -j1 case that
attempts to leave the standard input operational.  Did I miss
something, or is the above describing what is left to do?

> For more than one job there is no input possible and the output of both
> stdout/stderr of the command are put into the stderr in an ordered fashion,
> i.e. the tasks to not intermingle their output in races.

To rephrase what I said earlier, "for parallel version, the above
things happen, even with numthreads==1", is perfectly fine.

> +	cp->no_stdin = 1;
> +	cp->out = 0;
> +	cp->err = -1;
> +	cp->dir = args->path;
> +	cp->stdout_to_stderr = 1;

So the standard error and the standard output are mixed to a single
pipe ...

> +	cp->use_shell = 1;
> +
> +	if (start_command(cp)) {
> +		die("Could not start command");
> +		for (i = 0; cp->args.argv; i++)
> +			fprintf(stderr, "%s\n", cp->args.argv[i]);
> +	}
> +
> +	while (1) {
> +		ssize_t len = xread(cp->err, buf, sizeof(buf));
> +		if (len < 0)
> +			die("Read from child failed");
> +		else if (len == 0)
> +			break;
> +		else {
> +			strbuf_add(&out, buf, len);
> +		}

... and the whole thing is accumulated in core???

> +	}
> +	if (finish_command(cp))
> +		die("command died with error");
> +
> +	sem_wait(args->mutex);
> +	fputs(out.buf, stderr);
> +	sem_post(args->mutex);

... and emitted to standard error?

I would have expected that the standard error would be left alone
(i.e. letting warnings from multiple jobs to be mixed together
simply because everybody writes to the same file descriptor), while
the standard output would be line-buffered, perhaps captured by the
above loop and then emitted under mutex, or something.

I think I said this earlier, but latency to the first output counts
as an activity feedback mechanism.

> +	if (module_list_compute(0, nullargv, NULL, &pathspec) < 0)
> +		return 1;
> +
> +	gitmodules_config();
> +
> +	aq = create_task_queue(number_threads);
> +
> +	for (i = 0; i < ce_used; i++) {
> +		const struct submodule *sub;
> +		const struct cache_entry *ce = ce_entries[i];
> +		struct submodule_args *args = malloc(sizeof(*args));
> +
> +		if (ce_stage(ce))
> +			args->sha1 = xstrdup(sha1_to_hex(null_sha1));
> +		else
> +			args->sha1 = xstrdup(sha1_to_hex(ce->sha1));
> +
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/.git", ce->name);
> +		if (!file_exists(sb.buf))
> +			continue;
> +
> +		args->path = ce->name;
> +		sub = submodule_from_path(null_sha1, args->path);
> +		if (!sub)
> +			die("No submodule mapping found in .gitmodules for path '%s'", args->path);
> +
> +		args->name = sub->name;
> +		args->toplevel = xstrdup(xgetcwd());
> +		args->cmd = argv;
> +		args->mutex = mutex;
> +		args->prefix = alternative_path;
> +		add_task(aq, run_cmd_submodule, args);
> +	}
> +
> +	finish_task_queue(aq, NULL);

This is very nice.  Declare a task queue with N workers, throw bunch
of task to it and then wait for all of them to complete.  Things
can't be simpler than that ;-).  One thing that other callers of the
mechanism might want may be to plug and unplug the task queue, but
that can wait until the need arises.
