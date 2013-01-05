From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid
 overwrites
Date: Fri, 04 Jan 2013 17:17:19 -0800
Message-ID: <7vsj6gqvhc.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrIPj-0003FC-Sk
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 02:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab3AEBRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 20:17:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab3AEBRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 20:17:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1A5B9C6;
	Fri,  4 Jan 2013 20:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=m92el4ErHsRkVBMh84WUFaM8D2Y=; b=tNPTXavZ+2Y7wOmVi0zs
	IqjeauJ0mqw/V7mK/XSAv44r1cXgDswBEJC9HxOVFnrwp3Dc+ZFvZItiL6UkGUjD
	M0MVUnfpyWE8f3ltiS9xWviByLQXbd7mRx2MdbMMtlYVUZySgDhZ5m/E3hmtyj/1
	a+zFAH1l+/f70Iatz0tSrCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KTs7EC5fvR2AFvZeXHtMGA3RLpwBc+80XFRoz6bksz9eMx
	azjtjpb6d3aW9XxPD+D+jqLuxgfwqlwXAb/Glf1LNMCo0lz0N3P9PMblWPY9h3bL
	2vaS7riTw51wY+z0XxSNP47Np6il6pYc3/Rb2R4fzFd38ahRYWAc/b+fib7So=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA4EB9C5;
	Fri,  4 Jan 2013 20:17:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 701C2B9C2; Fri,  4 Jan 2013
 20:17:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A79D6892-56D5-11E2-95C4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212658>

David Michael <fedora.dm0@gmail.com> writes:

> I have encountered an issue with consecutive calls to getenv
> overwriting earlier values.  Most notably, it prevents a plain "git
> clone" from working.
>
> Long story short: This value of GIT_DIR gets passed around setup.c
> until it reaches check_repository_format_gently.  This function calls
> git_config_early, which eventually runs getenv("HOME").  When it
> returns back to check_repository_format_gently, the gitdir variable
> contains my home directory path.  The end result is that I wind up
> with ~/objects/ etc. and a failed repository clone.  (Simply adding a
> bare getenv("GIT_DIR") afterwards to reset the pointer also corrects
> the problem.)
>
> Since other platforms are apparently working, yet this getenv behavior
> is supported by the standards, I am left wondering if this could be a
> symptom of something else being broken on my platform (z/OS).

The execve(2) function

       int execve(const char *filename, char *const argv[],
                  char *const envp[]);

takes a NULL terminated array of NUL terminated strings of form
"VAR=VAL" in envp[], and this is kept in:

	extern char **environ;

of the new image that runs.

The most naive and straight-forward way to implement getenv(3) is to
iterate over this environ[] array to look for an element that begins
with "GIT_DIR=", and return the pointer pointing at the location one
byte past that equal sign.  So even if the standard allowed the
returned value to be volatile across calls to getenv(3), it will
take *more* work for implementations if they want to break our use
pattern.  They have to deliberately return a string that they will
overwrite in subsequent calls to getenv(3).

Also the natural way to implement putenv(3) and setenv(3) is to
replace the pointer in the environ[] array (not overwrite the
existing string in environ[] that holds the "VAR=VAL" string that
represents the current value, which might be shorter than the new
value of the enviornment variable), hence even calling these
functions is unlikely to invalidate the result you previously
received from getenv(3).

I am not at all surprised that nobody from other platforms has seen
this breakage.

In fact,

    http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html

says that only setenv(), unsetenv() and putenv() may invalidate
previous return values.  Note that getenv() is not listed as a
function that is allowed to break return values from a previous call
to getenv().

So in short, your platform's getenv(3) emulation may be broken.  We
have other calls to getenv() where we rely on the result of it being
stable, and you might discover these places also break.

Having said that, we do have codepaths to update a handful of
environment variables ourselves (GIT_DIR is among them), so I think
your patch is a good safety measure in general.

>  setup.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index f108c4b..64fb160 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -675,8 +675,12 @@ static const char
> *setup_git_directory_gently_1(int *nongit_ok)
>       * validation.
>       */
>      gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
> -    if (gitdirenv)
> -        return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
> +    if (gitdirenv) {
> +        gitdirenv = xstrdup(gitdirenv);
> +        ret = setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
> +        free(gitdirenv);
> +        return ret;
> +    }
>
>      if (env_ceiling_dirs) {
>          string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
> --
> 1.7.11.7
