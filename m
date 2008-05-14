From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 09:23:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805140903560.30431@racer>
References: <482A7CA0.9060908@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Wed May 14 10:24:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwCHy-0005uB-7V
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 10:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225AbYENIXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 04:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758259AbYENIXv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 04:23:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:35986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758031AbYENIXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 04:23:49 -0400
Received: (qmail invoked by alias); 14 May 2008 08:23:48 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 14 May 2008 10:23:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Vzag9gxUV4ap0DPwJh0kV3AMZKLWh7iohVqv/4A
	V8BsK3GMejWTH8
X-X-Sender: gene099@racer
In-Reply-To: <482A7CA0.9060908@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82087>

Hi,

On Tue, 13 May 2008, David Reiss wrote:

> Make git recognize a new environment variable that prevents it from 
> chdir'ing up into specified directories when looking for a GIT_DIR. 
> Useful for avoiding slow network directories.
> 
> Signed-off-by: David Reiss <dreiss@facebook.com>
> ---
> Just a bit of context about the motivation for this.  I use git in an 
> environment where homedirs are automounted and "ls /home/nonexistent" 
> takes about 9 seconds.

I think this is a very strong argument in favor of your patch, so it 
belongs into the commit message.

> diff --git a/setup.c b/setup.c
> index c54f2b6..d7d986c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -359,10 +359,11 @@ const char *read_gitfile_gently(const char *path)
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> +	const char *env_ceiling_dirs = getenv(CEILING_DIRS_ENVIRONMENT);
>  	static char cwd[PATH_MAX+1];
>  	const char *gitdirenv;
>  	const char *gitfile_dir;
> -	int len, offset;
> +	int len, offset, min_offset = -1;

AFAIR we have min_offset in the mingw branch, too, but I think it is 
initialized to 0.

> @@ -414,6 +415,37 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	if (!getcwd(cwd, sizeof(cwd)-1))
>  		die("Unable to read current working directory");
>  
> +	// Compute min_offset based on GIT_CEILING_DIRS.

We do not like C99 style comments.  Remember, there are people who compile 
Git on something else than the super-latest Linux with cutting-edge GCC.

> +	if (env_ceiling_dirs) {
> +		char *ceils, *ceil, *colon;
> +		ceil = ceils = xstrdup(env_ceiling_dirs);

I think it is quite possible to do this without data copying.

Besides, I think that this whole block should be a function in path.c, if 
only to _document_ what it does: it is much easier to read for people who 
did not write the code.

Something like

	int longest_prefix(const char *path, const char *prefix_list)
	{
		int max_length = 0, length = 0, i;

		for (i = 0; *prefix_list; i++)
			if (prefix_list[i] == ':') {
				if (length > max_length)
					max_length = length;
				length = 0;
			}
			else if (length >= 0) {
				if (prefix_list[i] == path[length])
					length++;
				else {
					if (length > max_length)
						max_length = length;
					length = -1;
				}
			}

		return max_length;
	}

(Completely untested, though.)

> @@ -427,6 +459,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 */
>  	offset = len = strlen(cwd);
>  	for (;;) {
> +		// Check the current directory (.git first).

Again, C99 comments are a no-go.

> @@ -443,17 +476,29 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			check_repository_format_gently(nongit_ok);
>  			return NULL;
>  		}
> -		do {
> -			if (!offset) {
> -				if (nongit_ok) {
> -					if (chdir(cwd))
> -						die("Cannot come back to cwd");
> -					*nongit_ok = 1;
> -					return NULL;
> -				}
> -				die("Not a git repository");
> +
> +		// Did we just check the root dir?
> +		if (!offset) {
> +		not_a_repo:
> +			if (nongit_ok) {
> +				if (chdir(cwd))
> +					die("Cannot come back to cwd");
> +				*nongit_ok = 1;
> +				return NULL;
>  			}
> -		} while (cwd[--offset] != '/');
> +			die("Not a git repository");
> +		}
> +
> +		while (cwd[--offset] != '/') {
> +			assert(offset > 0);
> +		}
> +
> +		// Don't chdir into the ceiling.
> +		if (offset <= min_offset) {
> +			assert(offset == min_offset);
> +			goto not_a_repo;
> +		}
> +
>  		chdir("..");

Why this big, ugly change in the code?  I would have expected you to 
simply change the "if (!offset)" to "if (offset <= min_offset)" (together 
with the initialization to 0).

> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> new file mode 100755
> index 0000000..d4eaa13
> --- /dev/null
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -0,0 +1,104 @@
> +#!/bin/sh
> +
> +test_description='test GIT_CEILING_DIRS'
> +. ./test-lib.sh
> +
> +test_prefix() {
> +	test_expect_success "$1" \
> +	"test '$2' = \"\$(git rev-parse --show-prefix)\""
> +	shift
> +	[ $# -eq 0 ] && return
> +}
> +
> +test_fail() {
> +	test_expect_code 128 "$1: prefix" \
> +	"git rev-parse --show-prefix"
> +	shift
> +	[ $# -eq 0 ] && return
> +}

I think it would make more sense to write these out.  Besides, I think 
that the "&& return" is not necessary.

And your tests are, uhm,  quite extensive.

Ciao,
Dscho
