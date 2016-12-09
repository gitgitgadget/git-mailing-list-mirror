Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFCA1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbcLIOdf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:33:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:51220 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932594AbcLIOde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:33:34 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tZvqH67Csz5tlc;
        Fri,  9 Dec 2016 15:33:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 111AD1CFD;
        Fri,  9 Dec 2016 15:33:29 +0100 (CET)
Subject: Re: [PATCH v2 1/4] real_path: resolve symlinks by hand
To:     Brandon Williams <bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481241494-6861-2-git-send-email-bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <944a3e91-934a-7923-2b2a-639af81e707d@kdbg.org>
Date:   Fri, 9 Dec 2016 15:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481241494-6861-2-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.2016 um 00:58 schrieb Brandon Williams:
> The current implementation of real_path uses chdir() in order to resolve
> symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
> process as a whole and not just an individual thread.  Instead perform
> the symlink resolution by hand so that the calls to chdir() can be
> removed, making real_path one step closer to being reentrant.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  abspath.c | 183 +++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 122 insertions(+), 61 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 2825de8..92f2a29 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -11,8 +11,38 @@ int is_directory(const char *path)
>  	return (!stat(path, &st) && S_ISDIR(st.st_mode));
>  }
>
> +/* removes the last path component from 'path' except if 'path' is root */
> +static void strip_last_component(struct strbuf *path)
> +{
> +	if (path->len > offset_1st_component(path->buf)) {
> +		char *last_slash = find_last_dir_sep(path->buf);
> +		strbuf_setlen(path, last_slash - path->buf);
> +	}
> +}

This implementation is not correct because when the input is "/foo", the 
result is "" when it should be "/". Also, can the input be a 
non-normalized path? When the input is "foo///bar", should the result be 
"foo" or would "foo//" be an acceptable result? I think it should be the 
former. find_last_dir_sep() returns the last of the three slashes, not 
the first one. Therefore, I've rewritten the function thusly:

static void strip_last_component(struct strbuf *path)
{
	size_t offset = offset_1st_component(path->buf);
	size_t len = path->len;
	while (offset < len && !is_dir_sep(path->buf[len - 1]))
		len--;
	while (offset < len && is_dir_sep(path->buf[len - 1]))
		len--;
	strbuf_setlen(path, len);
}

> +
> +/* get (and remove) the next component in 'remaining' and place it in 'next' */
> +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> +{
> +	char *start = NULL;
> +	char *end = NULL;
> +
> +	strbuf_reset(next);
> +
> +	/* look for the next component */
> +	/* Skip sequences of multiple path-separators */
> +	for (start = remaining->buf; is_dir_sep(*start); start++)
> +		; /* nothing */
> +	/* Find end of the path component */
> +	for (end = start; *end && !is_dir_sep(*end); end++)
> +		; /* nothing */
> +
> +	strbuf_add(next, start, end - start);
> +	/* remove the component from 'remaining' */
> +	strbuf_remove(remaining, 0, end - remaining->buf);
> +}

Mental note: This function strips leading slashes and the first path 
component; post-condition: remaining is empty or has leading slashes.

> +
>  /* We allow "recursive" symbolic links. Only within reason, though. */
> -#define MAXDEPTH 5
> +#define MAXSYMLINKS 5
>
>  /*
>   * Return the real path (i.e., absolute path, with symlinks resolved
> @@ -21,7 +51,6 @@ int is_directory(const char *path)
>   * absolute_path().)  The return value is a pointer to a static
>   * buffer.
>   *
> - * The input and all intermediate paths must be shorter than MAX_PATH.
>   * The directory part of path (i.e., everything up to the last
>   * dir_sep) must denote a valid, existing directory, but the last
>   * component need not exist.  If die_on_error is set, then die with an
> @@ -33,22 +62,16 @@ int is_directory(const char *path)
>   */
>  static const char *real_path_internal(const char *path, int die_on_error)
>  {
> -	static struct strbuf sb = STRBUF_INIT;
> +	static struct strbuf resolved = STRBUF_INIT;
> +	struct strbuf remaining = STRBUF_INIT;
> +	struct strbuf next = STRBUF_INIT;
> +	struct strbuf symlink = STRBUF_INIT;
>  	char *retval = NULL;
> -
> -	/*
> -	 * If we have to temporarily chdir(), store the original CWD
> -	 * here so that we can chdir() back to it at the end of the
> -	 * function:
> -	 */
> -	struct strbuf cwd = STRBUF_INIT;
> -
> -	int depth = MAXDEPTH;
> -	char *last_elem = NULL;
> +	int num_symlinks = 0;
>  	struct stat st;
>
>  	/* We've already done it */
> -	if (path == sb.buf)
> +	if (path == resolved.buf)
>  		return path;
>
>  	if (!*path) {
> @@ -58,74 +81,112 @@ static const char *real_path_internal(const char *path, int die_on_error)
>  			goto error_out;
>  	}
>
> -	strbuf_reset(&sb);
> -	strbuf_addstr(&sb, path);
> -
> -	while (depth--) {
> -		if (!is_directory(sb.buf)) {
> -			char *last_slash = find_last_dir_sep(sb.buf);
> -			if (last_slash) {
> -				last_elem = xstrdup(last_slash + 1);
> -				strbuf_setlen(&sb, last_slash - sb.buf + 1);
> -			} else {
> -				last_elem = xmemdupz(sb.buf, sb.len);
> -				strbuf_reset(&sb);
> -			}
> +	strbuf_reset(&resolved);
> +
> +	if (is_absolute_path(path)) {
> +		/* absolute path; start with only root as being resolved */
> +		int offset = offset_1st_component(path);
> +		strbuf_add(&resolved, path, offset);
> +		strbuf_addstr(&remaining, path + offset);

OK.

> +	} else {
> +		/* relative path; can use CWD as the initial resolved path */
> +		if (strbuf_getcwd(&resolved)) {
> +			if (die_on_error)
> +				die_errno("unable to get current working directory");
> +			else
> +				goto error_out;
> +		}
> +		strbuf_addstr(&remaining, path);
> +	}
> +
> +	/* Iterate over the remaining path components */
> +	while (remaining.len > 0) {
> +		get_next_component(&next, &remaining);
> +
> +		if (next.len == 0) {
> +			continue; /* empty component */

Can this happen? I think it can: when 'path' is a root directory, or 
ends with path separators.

> +		} else if (next.len == 1 && !strcmp(next.buf, ".")) {
> +			continue; /* '.' component */

Good.

I don't mind strcmp(), but others might point out that a single 
character comparison should be sufficient.

> +		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
> +			/* '..' component; strip the last path component */
> +			strip_last_component(&resolved);
> +			continue;

Good.

>  		}
>
> -		if (sb.len) {
> -			if (!cwd.len && strbuf_getcwd(&cwd)) {
> +		/* append the next component and resolve resultant path */
> +		if (!is_dir_sep(resolved.buf[resolved.len - 1]))
> +			strbuf_addch(&resolved, '/');

Can we access resolved.buf[resolved.len - 1] here? At this point, 
resolved has been filled with an absolute path or from getcwd(); it 
cannot be empty in the first iteration. In subsequent iterations, it 
cannot be empty as long as strip_last_component() does not make it 
empty. Your original version of strip_last_component() could make it 
empty; my rewrite should not.

Do we have to check for the path separator at all? Typically, resolved 
does not end with a slash, but if we went all the way up to the root, 
there is a trailing slash. Good; the condition is required.

> +		strbuf_addbuf(&resolved, &next);
> +
> +		if (lstat(resolved.buf, &st)) {
> +			/* error out unless this was the last component */
> +			if (!(errno == ENOENT && !remaining.len)) {

Perhaps it was easier to _write_ the condition in this way, but I would 
have an easier time to _read_ it when it is

			if (errno != ENOENT || remaining.len) {

>  				if (die_on_error)
> -					die_errno("Could not get current working directory");
> +					die_errno("Invalid path '%s'",
> +						  resolved.buf);
>  				else
>  					goto error_out;
>  			}
> +		} else if (S_ISLNK(st.st_mode)) {
> +			ssize_t len;
> +			strbuf_reset(&symlink);
>
> -			if (chdir(sb.buf)) {
> +			if (num_symlinks++ > MAXSYMLINKS) {
>  				if (die_on_error)
> -					die_errno("Could not switch to '%s'",
> -						  sb.buf);
> +					die("More than %d nested symlinks "
> +					    "on path '%s'", MAXSYMLINKS, path);
>  				else
>  					goto error_out;
>  			}
> -		}
> -		if (strbuf_getcwd(&sb)) {
> -			if (die_on_error)
> -				die_errno("Could not get current working directory");
> -			else
> -				goto error_out;
> -		}
> -
> -		if (last_elem) {
> -			if (sb.len && !is_dir_sep(sb.buf[sb.len - 1]))
> -				strbuf_addch(&sb, '/');
> -			strbuf_addstr(&sb, last_elem);
> -			free(last_elem);
> -			last_elem = NULL;
> -		}
>
> -		if (!lstat(sb.buf, &st) && S_ISLNK(st.st_mode)) {
> -			struct strbuf next_sb = STRBUF_INIT;
> -			ssize_t len = strbuf_readlink(&next_sb, sb.buf, 0);
> +			len = strbuf_readlink(&symlink, resolved.buf,
> +					      st.st_size);
>  			if (len < 0) {
>  				if (die_on_error)
>  					die_errno("Invalid symlink '%s'",
> -						  sb.buf);
> +						  resolved.buf);
>  				else
>  					goto error_out;
>  			}
> -			strbuf_swap(&sb, &next_sb);
> -			strbuf_release(&next_sb);
> -		} else
> -			break;
> +
> +			if (is_absolute_path(symlink.buf)) {
> +				/* absolute symlink; set resolved to root */
> +				int offset = offset_1st_component(symlink.buf);
> +				strbuf_reset(&resolved);
> +				strbuf_add(&resolved, symlink.buf, offset);
> +				strbuf_remove(&symlink, 0, offset);

Good. I would have expected some kind of "goto repeat;" because when we 
encounter a symlink to an absolute path, most, if not all, work done so 
far is obsoleted. But I haven't thought too deeply about this.

> +			} else {
> +				/*
> +				 * relative symlink
> +				 * strip off the last component since it will
> +				 * be replaced with the contents of the symlink
> +				 */
> +				strip_last_component(&resolved);
> +			}
> +
> +			/*
> +			 * if there are still remaining components to resolve
> +			 * then append them to symlink
> +			 */
> +			if (remaining.len) {
> +				strbuf_addch(&symlink, '/');
> +				strbuf_addbuf(&symlink, &remaining);
> +			}
> +
> +			/*
> +			 * use the symlink as the remaining components that
> +			 * need to be resloved
> +			 */
> +			strbuf_swap(&symlink, &remaining);

Good. This looks very reasonable.

> +		}
>  	}
>
> -	retval = sb.buf;
> +	retval = resolved.buf;
> +
>  error_out:
> -	free(last_elem);
> -	if (cwd.len && chdir(cwd.buf))
> -		die_errno("Could not change back to '%s'", cwd.buf);
> -	strbuf_release(&cwd);
> +	strbuf_release(&remaining);
> +	strbuf_release(&next);
> +	strbuf_release(&symlink);
>
>  	return retval;
>  }
>

