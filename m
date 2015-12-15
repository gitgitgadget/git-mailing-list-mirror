From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Introduce grep threads param
Date: Tue, 15 Dec 2015 12:06:16 -0800
Message-ID: <xmqq60zzfpdz.fsf@gitster.mtv.corp.google.com>
References: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
	<1450193500-22468-2-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com, sunshine@sunshineco.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 21:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8vrg-0001Nd-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 21:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbbLOUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 15:06:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753203AbbLOUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 15:06:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C22D32714;
	Tue, 15 Dec 2015 15:06:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=vfo+0ki9kpcC8TMNoce2OKHPHWg=; b=OZfPdhjJu2EpngVIYxrU
	nMJ5QMx7xM3BtOC3cRzBPRtJG82oCjzVW8YzzscEzwWOTtBbCQZAg8ckGpnH5hG1
	NgNtNbWVL7+3vx/leWNRb7hdjV5mIppKkNvkl7UKfUrwr8yjSar8hEBI8HG9k1SA
	Csm/me71CWfu5qQBq5SiAsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gXXA2nRNyw2RP6KHSDdPVC7VKwQq0KBmAOFJf+HoLNGiB/
	RzzxGLN1qaB313ySQXH3NHf9rVB+viMZfuZxAD0RoSmPBdmlvU3mgmbiYZQtv9cH
	SRCBRu6AnausEjp459CV/qTGOd8OAxfQxtNoMSgP0OMQTLRYh+xM2De2GpCRw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 735C532712;
	Tue, 15 Dec 2015 15:06:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DED2132711;
	Tue, 15 Dec 2015 15:06:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FC5542C-A367-11E5-8EC1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282497>

Victor Leschuk <vleschuk@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Introduce grep threads param

I'll retitle this to something like

    grep: add --threads=<num> option and grep.threads configuration

while queuing (which I did for v7 earlier).

>  "git grep" can now be configured (or told from the command line)
>  how many threads to use when searching in the working tree files.
>
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
> ...
> +grep.threads::
> +	Number of grep worker threads.

"Number of grep worker threads to use"?

> +	See `grep.threads` in linkgit:git-grep[1] for more information.
> ...
> +grep.threads::
> +	Number of grep worker threads, use it to tune up performance on
> +	your machines. Leave it unset (or set to 0) for default behavior,
> +	which is using 8 threads for all systems.
> +	Default behavior may change in future versions
> +	to better suit hardware and circumstances.

The last sentence is too noisy.  Perhaps drop it and phrase it like
this instead?

    grep.threads::
            Number of grep worker threads to use.  If unset (or set to 0),
            to 0), 8 threads are used by default (for now).

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4229cae..e9aebab 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -24,11 +24,11 @@ static char const * const grep_usage[] = {
>  	NULL
>  };
>  
> -static int use_threads = 1;
> +#define GREP_NUM_THREADS_DEFAULT 8
> +static int num_threads = 0;

Please do not initialize static to 0 (or NULL).

> @@ -267,6 +270,12 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
>  	int st = grep_config(var, value, cb);
>  	if (git_color_default_config(var, value, cb) < 0)
>  		st = -1;
> +
> +	if (!strcmp(var, "grep.threads")) {
> +		/* Sanity check of value will be perfomed later */

Hmm, is that a good design?

A user may hear "invalid number of threads specified (-4)" later,
but if that came from "grep.threads", especially when the user did
not say "--threads=-4" from the command line, would she know to
check her configuration file?

If she had "grep.threads=Yes" in her configuration, we would
helpfully tell her that 'Yes' given to grep.threads is not a valid
integer.  Shouldn't we do the same for '-4' given to grep.threads,
too?

	if (!strcmp(var, "grep.threads")) {
		num_threads = git_config_int(var, value);
		if (num_threads < 0)
			die(_("invalid number of threads specified (%d) for %s"),
			    num_threads, var);
	}

perhaps.

> @@ -817,14 +827,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	}
>  
>  #ifndef NO_PTHREADS
> -	if (list.nr || cached || online_cpus() == 1)
> -		use_threads = 0;
> +	if (list.nr || cached || online_cpus() == 1 || show_in_pager) {
> +		/* Can not multi-thread object lookup */
> +		num_threads = 0;

Removing 'use_threads = 0' from an earlier part and moving the check
to show_in_pager is a good idea, but it invalidates this comment.
The earlier three (actually two and a half) are "cannot" cases,
i.e. the object layer is not easily threaded without locking, and
when you have a single core, you do not truly run multiple
operations at the same time, but as [PATCH 2/2] does, threading in
"grep" is not about CPU alone, so that is why I am demoting it to
just a half ;-).  But show_in_pager is "we do not want to", I think.

In any case, this comment and "User didn't specify" below are not
telling the reader something very much useful.  You probably should
remove them.

> +	}
> +	else if (num_threads == 0) {
> +		/* User didn't specify value, or just wants default behavior */
> +		num_threads = GREP_NUM_THREADS_DEFAULT;
> +	}
> +	else if (num_threads < 0) {
> +		die(_("invalid number of threads specified (%d)"), num_threads);
> +	}

Many unnecessary braces.

I think [2/2] and also moving the code to disable threading when
show-in-pager mode should be separate "preparatory clean-up" patches
before this main patch.  I'll push out what I think this topic
should be on 'pu' later today (with fixups suggested above squashed
in); please check them and see what you think.

Thanks.
