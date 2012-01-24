From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Tue, 24 Jan 2012 17:22:39 -0600
Message-ID: <20120124232239.GG8222@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 00:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rppha-0005ae-KE
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 00:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab2AXXWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 18:22:53 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46700 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2AXXWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 18:22:52 -0500
Received: by iacb35 with SMTP id b35so6002059iac.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fu8uKovaNZxhN0VHPSvEx/sC0OEjYlvmD+jf+TsvSzc=;
        b=X0TI4Xwxwu9pWw6tJKv3ko7wjIrijhsin4tZJhBP1HNmXLac5N1SYVIKiURZW8B03L
         dOjMhs6N4uG3DuKI19dgLLxX5mUn31nzBFq7rT9FjOt90LczxiYnNQBJMVZP8t6LAI9x
         IBw0DmO6kv8txFJCk1ockWXVW+zPDeq089ieU=
Received: by 10.43.52.129 with SMTP id vm1mr13369372icb.15.1327447371997;
        Tue, 24 Jan 2012 15:22:51 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ba5sm24230241igb.6.2012.01.24.15.22.51
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 15:22:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189085>

Klaver wrote:

> The interpretation of errors from execvp was rather terse. For user
> convenience communication of the nature of the error can be improved.

Could you give an example?

[...]
> --- a/run-command.c
> +++ b/run-command.c
> @@ -2,6 +2,7 @@
>  #include "run-command.h"
>  #include "exec_cmd.h"
>  #include "argv-array.h"
> +#include "dir.h"
>  
>  static inline void close_pair(int fd[2])
>  {
> @@ -134,6 +135,140 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
>  	return code;
>  }
>  
> +#ifndef WIN32

Not related to this patch, but I wonder if there should be a separate
run-command-unix.c file so these ifdefs would no longer be necessary.

What happens on Windows?

> +static void die_file_error(const char *file, int err)
> +{
> +	die("cannot exec '%s': %s", file, strerror(err));
> +}

I suspect it might be clearer to use die() inline in the two call
sites so the reader does not have to figure out the calling
convention.

> +
> +static char *get_interpreter(const char *first_line)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	size_t start = strspn(first_line + 2, " \t") + 2;
> +	size_t end = strcspn(first_line + start, " \t\r\n") + start;
> +
> +	if (start >= end)
> +		return NULL;
> +
> +	strbuf_add(&sb, first_line + start, end - start);
> +	return strbuf_detach(&sb, NULL);
> +}

What does this function do?  What happens if first_line doesn't start
with "#!"?  What should happen when there is a newline instead of a
command name?  How about commands with quoting characters like " and
backslash --- are the semantics portable in these cases?

No need to use a strbuf here: xmemdupz would take care of the
allocation and copy more simply.

> +static void inspect_failure(const char *argv0, int silent_exec_failure)
> +{
> +	int err = errno;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	/* errors not related to path */
> +	if (errno == E2BIG || errno == ENOMEM)
> +		die_file_error(argv0, err);
> +
> +	if (strchr(argv0, '/')) {
> +		if (file_exists(argv0)) {
> +			strbuf_add(&sb, argv0, strlen(argv0));
> +			inspect_file(&sb, err, argv0);
> +		}
> +	} else {
> +		char *path, *next;
> +		path = getenv("PATH");

I wonder if it's possible to rearrange this code to avoid deep
nesting.  What does the function do, anyway?  (If the reader has to
ask, it needs a comment or to be renamed.)

I guess the idea is to diagnose after the fact why execvp failed.
Might be simplest like this:

	To diagnose execvp failure:
		if filename does not contain a '/':
			if we can't find it on the search path:
				That's the problem, dummy!
			replace filename with full path
		if file does not exist:
			just report strerror(errno)
		if not executable:
			...
		if interpreter does not exist:
			...
		if interpreter not executable:
			...
		otherwise, just report strerror(errno)

with a separate function to find a command on the PATH, complaining
when it encounters an unsearchable entry.

Thanks for a fun read.

Jonathan
