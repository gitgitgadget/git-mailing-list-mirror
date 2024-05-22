Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD61E517
	for <git@vger.kernel.org>; Wed, 22 May 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394083; cv=none; b=B1dctubybjFFnCoDog4ezdqZLU9yc9IaVIN0YHoV60GHYboGLTspKMwG/U6TR4XwicHCSSNyvfiNy0+7jA5P/2pv76ZTtnpnLvQeH52aXqh/ORbDLsxYUUiQkyBuwI117eQzLwsIJnjOxPsD0eGi0jw3gYWb0YxDNyT634CaGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394083; c=relaxed/simple;
	bh=jFlRjTCdcTOmKeecCR7JNBXvAgw4+ee2CFmjWWaB2kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jQIUNFLRffqofVO1qPL+muJ2r/6EKt5nkciIMv7PDPJtIoh0FRTXf3ka1tRwDok7i0+mLefXCEDr0LR+Rtq78p2vIybOcIs4R01lHlgvyicPruNosLCxL2z/hpQYF373qE7ZGBAzrV7CKNqNQ0SvfGZtoH8CKL3nPX0/t/9KXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rXn5GxUW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXn5GxUW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 31F1D18268;
	Wed, 22 May 2024 12:08:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jFlRjTCdcTOmKeecCR7JNBXvAgw4+ee2CFmjWW
	aB2kc=; b=rXn5GxUWINrYeTp/ITg531Rvg79UbkjyPPk+y3EekgChk8oCioYOCN
	H5/FV1m7KoWZYNxUO3hAe4I6Ut+qj/cr0rE3YhP80n2l3/Pk8GajHiOL0+6fywWl
	QBbYBZJMbcGGkLJPpwoz/y0htlAWTEP2xnumHNAAySOnPxe80yjbk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A89018267;
	Wed, 22 May 2024 12:08:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E89918266;
	Wed, 22 May 2024 12:07:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] alias: document caveats and add trace of prepared command
In-Reply-To: <20240522024133.1108005-1-iwienand@redhat.com> (Ian Wienand's
	message of "Wed, 22 May 2024 12:41:33 +1000")
References: <20240522024133.1108005-1-iwienand@redhat.com>
Date: Wed, 22 May 2024 09:07:55 -0700
Message-ID: <xmqq8r017rtw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 742B2730-1855-11EF-91D5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> For a "split" alias, e.g. test = "!echo $*" you will see
>
>  $ GIT_TRACE=1 git test hello
>  11:00:45.959420 git.c:755               trace: exec: git-test hello
>  11:00:45.959737 run-command.c:657       trace: run_command: git-test hello
>  11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' hello
>  11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c 'echo $* "$@"' 'echo $*' hello
>  hello hello
>
> which clearly shows you the appended "$@".  

A question and a comment on this part.

Who are "you" in this context?

It is somewhat surprising if we do not consistently add "$@" (or do
an equivalent), as the point of adding "$@" is to allow an alias to
specify "the initial part of a command line", e.g.

	[alias] lg = log --oneline

to let you say "git lg" to mean "git log --oneline" and also you can
say "git lg --graph" to mean "git log --oneline --graph".  In other
words, what you type after "git lg" makes "the rest of the command
line", while alias gives "the initial part".

Are you sure that with

	[alias] lg = log

you get the rest of the command line ignored, in other words, if you
say "git lg --oneline", it does not do "git log --oneline"?

>  Documentation/config/alias.txt | 26 +++++++++++++++++++++-----
>  run-command.c                  |  1 +
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
> index 01df96fab3..a3f090d79d 100644
> --- a/Documentation/config/alias.txt
> +++ b/Documentation/config/alias.txt
> @@ -21,8 +21,24 @@ If the alias expansion is prefixed with an exclamation point,
>  it will be treated as a shell command.  For example, defining
>  `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
>  `git new` is equivalent to running the shell command
> -`gitk --all --not ORIG_HEAD`.  Note that shell commands will be
> -executed from the top-level directory of a repository, which may
> -not necessarily be the current directory.
> -`GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
> -from the original current directory. See linkgit:git-rev-parse[1].
> +`gitk --all --not ORIG_HEAD`.  Note:
> ++
> +* Shell commands will be executed from the top-level directory of a
> +  repository, which may not necessarily be the current directory.
> +* `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
> +  from the original current directory. See linkgit:git-rev-parse[1].
> +* Single commands will be executed directly.  Commands that can be "split"
> +  (contain whitespace or shell-reserved characters) will be run as shell
> +  commands via an argument to `sh -c`.
> +* When arguments are present to a "split" command running in a shell,
> +  the shell command will have `"$@"` appended.  The first non-command
> +  argument to `sh -c` (i.e. `$0` to the command) is always the alias
> +  string, and other user specified arguments will follow.
> +** This may initially be confusing if your command references argument
> +   variables or is not expecting the presence of `"$@"`.  For example:
> +   `alias.echo = "!echo $1"` when run as `git echo arg` will execute
> +   `sh -c "echo $1 $@" "echo $1" "1"` resulting in output `1 1`.
> +   An alias `alias.for = "!for i in 1 2 3; do echo $i; done"` will fail
> +   if any arguments are specified to `git for` as the appended `"$@"` will
> +   create invalid shell syntax.  Setting `GIT_TRACE=1` can help debug
> +   the command being run.

The above does a bit too many things in a single patch to be
reviewable.  Perhaps make the above change in two patches?

 (1) Reformulate the existing test into "Note:" followed by a
     bulletted list.

 (2) Add new items to the updated and easier-to-read form prepared
     by the first patch.

You have a lengthy new text in the documentation to help confused
users, but it looks to me that it places too much stress on the
mechanics (i.e. '$@' is added to the command line) without saying
much about the intent (i.e. you need to use '$@' to allow the
command line invocation to supply "the rest of the command line"
when you are running the alias via the shell).  I've learned over
the course of this project that readers learn better when the intent
behind the mechanics is given in an understandable form.

I think the idea is "we want the 'concatenation of what the alias
supplies and what the user gives when invoking the alias from the
command line' to work sensibly".  The most generic way to do so when
processing "git lg --graph -3" with "[alias] lg = !git log --oneline" is

    sh -c 'git log --oneline "$@"' - '--graph' '-3'

(readers can try this at home by adding 'echo ' before 'log').  We
may try to "optimize" the most generic pattern when there is no need
to use "sh -c" go a more direct route.  For example, if you have

    [alias] !foo = bar

then there is no need to use "sh -c" in the first place.  "git foo
baz quux" should behave just like when you said "sh bar baz quux" on
the command line, i.e. execute your shell script "bar" and give
"baz" and "quux" as two arguments to that script.  We can prepare
argv[] = ("sh", "bar", "baz", "quux") and fork-exec that, so the
command line the underlying exec(2) call sees may not have "$@" (and
it will not have "-c", either).

You can undo the "optimization" and rewrite the command line to

    sh -c 'bar "$@"' - 'baz' 'quux'

and it should mean the same thing.

> diff --git a/run-command.c b/run-command.c
> index 1b821042b4..36b2b2f194 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -435,6 +435,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
>  		}
>  	}
>  
> +	trace_argv_printf(&out->v[1], "trace: prepare_cmd:");
>  	return 0;
>  }

Hmph, we do not have much tests that look for 'trace: foo' in our
test suite, but t0014 seems to use it.  Don't we need to cover this
new trace output in the test in the same patch (probably becomes
patch 3 after the two documentation changes)?

Thanks.
