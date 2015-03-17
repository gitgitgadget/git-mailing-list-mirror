From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 22:35:18 -0700
Message-ID: <xmqqd248p4o9.fsf@gitster.dls.corp.google.com>
References: <20150316142026.GJ7847@inner.h.apk.li>
	<xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
	<20150316184040.GA8902@inner.h.apk.li>
	<20150317024005.GA26313@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 06:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXkA3-00046p-J7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbCQFfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:35:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751303AbbCQFfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:35:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D76536888;
	Tue, 17 Mar 2015 01:35:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J7R+xdt7yNJKVw8Xw6mC+Bcu2h0=; b=gmpyq4
	LC8ZYsErJ5VmpGP1mt63f9nGSs2uArrj9PWuBFgPrL+1l8X/5odtraC2wu86EeY6
	DFgoFMqknLtPqF2El3x5YCpX0u4A7JeP90rPfnQRmU1ckeMfktCKbYZqw2S6phVu
	ydYtA42bXAla+htaR9cO41F1XiaLk40sNTZxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DikxnbREbDYevtk3XQy9WSoXcXJbo0gI
	TbWaMAxXz+2gspwwdCv0bcs2RYwXIqDxkmqTG7cR81M+qXQ4gtX2sOpjUryaPoDS
	xwGvxjZsoYSU6snvZEfKNiwuWGp99HBCa/ra7Amq8v7bFVsLO+tvHEady54w5kdw
	vV/a7CtGxw0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34D0636886;
	Tue, 17 Mar 2015 01:35:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B50FD36884;
	Tue, 17 Mar 2015 01:35:19 -0400 (EDT)
In-Reply-To: <20150317024005.GA26313@peff.net> (Jeff King's message of "Mon,
	16 Mar 2015 22:40:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6646A264-CC67-11E4-A989-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265608>

Jeff King <peff@peff.net> writes:

> The get_ref_cache code was designed to scale to the actual number of
> submodules. I do not mind seeing it become a hash if people really do
> have a large number of submodules, but that is not what is happening
> here.
> ...
> So git-clean speculatively asks "what is HEAD in this maybe-submodule?". The
> right solution is probably one of:
>
>   1. In remove_dirs, find out if we have an actual submodule before calling
>      resolve_gitlink_ref.
>
>   2. Teach get_ref_cache a "read-only" mode that will not auto-vivify the cache
>      if it does not already exist.
>
> Of the two, I think (1) is probably cleaner (I think the way the ref
> code is structured, we have to create the submodule ref_cache in order
> to start looking things up in it).

Thanks for a great analysis.  I too wondered if we should be growing
the per-submodule ref-cache when we are only probing.

> It looks like we don't even really care about the value of HEAD. We just
> want to know "is it a git directory?". I think in other places (like
> "git add"), we just do an existence check for "$dir/.git". That would
> not catch a bare repository, but I do not think the current check does
> either (it is looking for submodules, which always have a .git).

If we wanted to be consistent, perhaps we should be reusing the "is
this a git repository?" check used by the auto-discovery codepath
(setup.c:is_git_directory(), perhaps?), but the idea looks simple
enough and sounds sensible.

> Maybe something like (largely untested):
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 98c103f..e2cc47b 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -148,6 +148,32 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int dir_is_repo(struct strbuf *path)
> +{
> +	size_t orig = path->len;
> +	int ret;
> +
> +	strbuf_addstr(path, "/.git");
> +	if (!access(path->buf, F_OK))
> +		ret = 1; /* definitely */
> +	else if (errno == ENOENT)
> +		ret = 0; /* definitely not */
> +	else {
> +		/*
> +		 * We couldn't tell. It would probably be safer to err
> +		 * on the side of saying "yes" here, because we are
> +		 * deciding what to delete, and are more likely to keep
> +		 * a sub-repo. But it would probably also create annoying
> +		 * false positives, where a directory we do not have
> +		 * permission to read would say something misleading
> +		 * like "not deleting sub-repo foo..."
> +		 */
> +		ret = 0;
> +	}
> +	strbuf_setlen(path, orig);
> +	return ret;
> +}
> +
>  static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  		int dry_run, int quiet, int *dir_gone)
>  {
> @@ -155,13 +181,11 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  	struct strbuf quoted = STRBUF_INIT;
>  	struct dirent *e;
>  	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
> -	unsigned char submodule_head[20];
>  	struct string_list dels = STRING_LIST_INIT_DUP;
>  
>  	*dir_gone = 1;
>  
> -	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> -			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
> +	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && dir_is_repo(path)) {
>  		if (!quiet) {
>  			quote_path_relative(path->buf, prefix, &quoted);
>  			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
