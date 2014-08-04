From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert: Stream from fd to required clean filter instead of mmap
Date: Mon, 04 Aug 2014 12:03:27 -0700
Message-ID: <xmqq4mxsrsao.fsf@gitster.dls.corp.google.com>
References: <1407056176-8231-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENXp-0004Q8-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 21:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaHDTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 15:03:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59152 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaHDTDg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 15:03:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F7C82EE6D;
	Mon,  4 Aug 2014 15:03:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v4D1GcMsDtQ4CiD0w9J1mtqHG5c=; b=VNa545
	vKbVNmcGbV6Z58wwjIyAjXBQOEQH30VbNsBk2aZOQ3X1Of/fGSNJxCMSVIMJrZir
	EfgRTQKZTogvLxBy56J6rRlZNMySU6XeHQbxVv/3gbVTTI1JIzpIN9DSYZs+pqJw
	DfjB8wug58sQhVISZ+1V6dWSJXscAyjmfqBrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVlOgHDauFhFzyPJ5j4W/n0kDB39+5Gt
	sm5oMLylMXrzcLg81IAe7dntriMQ8+aPFMbchFQNm/Nif3wt4JPneTSw9M7lw+3X
	jqHxa6io7J9+Lz1Mihz3WnUA1cWpb2z4EmBPTstcJsRvZfFAwz33a5W3BAssa8gW
	Obg0COt9rxk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7584E2EE6C;
	Mon,  4 Aug 2014 15:03:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91FCF2EE5C;
	Mon,  4 Aug 2014 15:03:28 -0400 (EDT)
In-Reply-To: <1407056176-8231-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 3 Aug 2014 10:56:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04F0C656-1C0A-11E4-B1E5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254768>

Steffen Prohaska <prohaska@zib.de> writes:

> The data is streamed to the filter process anyway.  Better avoid mapping
> the file if possible.  This is especially useful if a clean filter
> reduces the size, for example if it computes a sha1 for binary data,
> like git media.  The file size that the previous implementation could
> handle was limited by the available address space; large files for
> example could not be handled with (32-bit) msysgit.  The new
> implementation can filter files of any size as long as the filter output
> is small enough.
>
> The new code path is only taken if the filter is required.  The filter
> consumes data directly from the fd.  The original data is not available
> to git, so it must fail if the filter fails.

Yay ;-)

>
> The test that exercises required filters is modified to verify that the
> data actually has been modified on its way from the file system to the
> object store.
>
> The expectation on the process size is tested using /usr/bin/time.  An
> alternative would have been tcsh, which could be used to print memory
> information as follows:
>
>     tcsh -c 'set time=(0 "%M"); <cmd>'
>
> Although the logic could perhaps be simplified with tcsh, I chose to use
> 'time' to avoid a dependency on tcsh.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  convert.c             | 58 ++++++++++++++++++++++++++++++++++++++-----
>  convert.h             | 10 +++++---
>  sha1_file.c           | 29 ++++++++++++++++++++--
>  t/t0021-conversion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 149 insertions(+), 16 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index cb5fbb4..58a516a 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -312,11 +312,12 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
>  struct filter_params {
>  	const char *src;
>  	unsigned long size;
> +	int fd;
>  	const char *cmd;
>  	const char *path;
>  };
>  
> -static int filter_buffer(int in, int out, void *data)
> +static int filter_buffer_or_fd(int in, int out, void *data)
>  {
>  	/*
>  	 * Spawn cmd and feed the buffer contents through its stdin.
> @@ -325,6 +326,7 @@ static int filter_buffer(int in, int out, void *data)
>  	struct filter_params *params = (struct filter_params *)data;
>  	int write_err, status;
>  	const char *argv[] = { NULL, NULL };
> +	int fd;
>  
>  	/* apply % substitution to cmd */
>  	struct strbuf cmd = STRBUF_INIT;
> @@ -355,7 +357,17 @@ static int filter_buffer(int in, int out, void *data)
>  
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> -	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
> +	if (params->src) {
> +	    write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
> +	} else {
> +	    /* dup(), because copy_fd() closes the input fd. */
> +	    fd = dup(params->fd);
> +	    if (fd < 0)
> +		write_err = error("failed to dup file descriptor.");
> +	    else
> +		write_err = copy_fd(fd, child_process.in);
> +	}
> +
>  	if (close(child_process.in))
>  		write_err = 1;
>  	if (write_err)
> @@ -371,7 +383,7 @@ static int filter_buffer(int in, int out, void *data)
>  	return (write_err || status);
>  }
>  
> -static int apply_filter(const char *path, const char *src, size_t len,
> +static int apply_filter(const char *path, const char *src, size_t len, int fd,
>                          struct strbuf *dst, const char *cmd)
>  {
>  	/*
> @@ -392,11 +404,12 @@ static int apply_filter(const char *path, const char *src, size_t len,
>  		return 1;
>  
>  	memset(&async, 0, sizeof(async));
> -	async.proc = filter_buffer;
> +	async.proc = filter_buffer_or_fd;
>  	async.data = &params;
>  	async.out = -1;
>  	params.src = src;
>  	params.size = len;
> +	params.fd = fd;
>  	params.cmd = cmd;
>  	params.path = path;
>  
> @@ -747,6 +760,22 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  	}
>  }
>  
> +int would_convert_to_git_filter_fd(const char *path) {

Style; opening brace on its own line:

	int would_convert_to_git_filter_fd(const char *path)
        {

> +	struct conv_attrs ca;
> +	convert_attrs(&ca, path);
> +
> +	if (!ca.drv)

As we do not allow decl-after-stmt, it is easier to read if the
first blank line in the function was between the local variable
definition and the first statement.  I.e.

	int would_convert_to_git_filter_fd(const char *path)
        {
		struct ...;

		convert_attrs(...);
                if (!ca.drv)


> +	    return 0;
> +
> +	/* Apply a filter to an fd only if the filter is required to succeed.
> +	 * We must die if the filter fails, because the original data before
> +	 * filtering is not available. */

 /*
  * multi-line
  * comment style.
  */

> +	if (!ca.drv->required)
> +	    return 0;
> +
> +	return apply_filter(path, 0, 0, -1, 0, ca.drv->clean);

What's the significance of "-1" here?  Does somebody in the
callchain from apply_filter() check if fd < 0 and act differently
(not a complaint nor rhetoric question)?

Spell out the first "0" as "NULL" if you meant src == NULL
(similarly for dst).

> diff --git a/convert.h b/convert.h
> index 0c2143c..d9d853c 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -40,11 +40,15 @@ extern int convert_to_working_tree(const char *path, const char *src,
>  				   size_t len, struct strbuf *dst);
>  extern int renormalize_buffer(const char *path, const char *src, size_t len,
>  			      struct strbuf *dst);
> -static inline int would_convert_to_git(const char *path, const char *src,
> -				       size_t len, enum safe_crlf checksafe)
> +static inline int would_convert_to_git(const char *path)
>  {
> -	return convert_to_git(path, src, len, NULL, checksafe);
> +	return convert_to_git(path, NULL, 0, NULL, 0);
>  }

Is this change because there was only one caller that passed nothing
meaningful but "path"?  It would have been nicer to see such a change
as a clean-up _before_ the real patch, if that was the case.
