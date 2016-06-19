Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED452018B
	for <e@80x24.org>; Sun, 19 Jun 2016 03:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFSD6I (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 23:58:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751366AbcFSD6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 23:58:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6587D26CB2;
	Sat, 18 Jun 2016 23:58:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9d9QqyOa9wuZ2qi8OH3gm6naIkM=; b=xQpwIO
	gYzrE0qRRlZhU1SfPRoW/G21dpOZ6z5Ga5ISX1TOv2uCGHCsdEKjE2vBD1lkFw4O
	bzpSIpcqE14BcmDm5d21Ssw+mfx6xeyvbogRtPSbDfQPG33vJ/G9rRZpu5YvlsvR
	8WkT6PkzKRpM2DoG8Qy7Zc04cK5Xca4j84qfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cg5aEi+B0B+QN0bcpReGixDKFtvRmhjE
	OxKhcjs6oKI+WoUMNT+j2b/OZMmJYJ/rXSwkOpMoPu3XwIbSm0O4FlQkQGTOl4Qt
	P79dP/HD++kzlxILwz8zIChjyo9gN8c7oedynLP7J5WwsJ9T8V90dPoykYv1PYcC
	JiJn0WBNSZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E63726CB1;
	Sat, 18 Jun 2016 23:58:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAC0526CB0;
	Sat, 18 Jun 2016 23:58:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] prune: keep files created after process start
References: <20160619031338.GA5161@dcvr.yhbt.net>
Date:	Sat, 18 Jun 2016 20:58:03 -0700
In-Reply-To: <20160619031338.GA5161@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 19 Jun 2016 03:13:38 +0000")
Message-ID: <xmqqa8ihygms.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06742034-35D2-11E6-B2CD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Avoid pruning files which were written after the prune process
> starts, as it possible to concurrently create new objects while
> "git prune" is running.
>
> Tested on git.git by starting "git prune" in one terminal,
> creating a random loose object via "git hash-object --stdin -w"
> in a different terminal, and ensuring the loose object remains
> after "git prune" completes.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  I'm somewhat surprised this check didn't already exist;
>  but maybe nobody else runs prune manually, anymore.

The only time an end user would run "git prune" in their
repositories with working trees these days is "git repack" followed
by "git prune", I would guess.

The current behaviour is totally expected and that is why you do not
run "prune" without any grace period in an active repository.

Adding the proposed change however would not make anything worse, I
would think.  Those who run "git prune" without grace period accept
that the repository must be quiescent or otherwise the newly created
objects will be lost.  So they are unlikely to be doing anything to
create such objects, hence "things newer than 'start'" are unlikely
to appear, and their expectation that "repack && prune" will remove
all loose objects will not be broken.

You generally cannot compare a timestamp you read from the
filesystem and the timestamp you obtain from time(2) when network
filesystems are involved, so I am not sure the implementation is
quite right, though.

> diff --git a/builtin/prune.c b/builtin/prune.c
> index 8f4f052..d4cd054 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -14,6 +14,7 @@ static const char * const prune_usage[] = {
>  static int show_only;
>  static int verbose;
>  static unsigned long expire;
> +static time_t start;
>  static int show_progress = -1;
>  
>  static int prune_tmp_file(const char *fullpath)
> @@ -21,7 +22,7 @@ static int prune_tmp_file(const char *fullpath)
>  	struct stat st;
>  	if (lstat(fullpath, &st))
>  		return error("Could not stat '%s'", fullpath);
> -	if (st.st_mtime > expire)
> +	if (st.st_mtime > expire || st.st_ctime >= start)
>  		return 0;
>  	if (show_only || verbose)
>  		printf("Removing stale temporary file %s\n", fullpath);
> @@ -47,7 +48,7 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
>  		error("Could not stat '%s'", fullpath);
>  		return 0;
>  	}
> -	if (st.st_mtime > expire)
> +	if (st.st_mtime > expire || st.st_ctime >= start)
>  		return 0;
>  	if (show_only || verbose) {
>  		enum object_type type = sha1_object_info(sha1, NULL);
> @@ -111,6 +112,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  	};
>  	char *s;
>  
> +	start = time(NULL);
>  	expire = ULONG_MAX;
>  	save_commit_buffer = 0;
>  	check_replace_refs = 0;
