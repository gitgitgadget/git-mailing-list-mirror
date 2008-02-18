From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 12:34:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181217580.30505@racer.site>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com> <1203331463-13857-2-git-send-email-hjemli@gmail.com> <1203331463-13857-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:35:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5DS-0004fy-Ot
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbYBRMeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbYBRMeu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:34:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:44988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752148AbYBRMet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:34:49 -0500
Received: (qmail invoked by alias); 18 Feb 2008 12:34:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 18 Feb 2008 13:34:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TZdFjsgsTVRlYxLjZiW9NpO3xuijPR+C6DRfIUk
	KWzbyxPUEtqodP
X-X-Sender: gene099@racer.site
In-Reply-To: <1203331463-13857-3-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74274>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> diff --git a/environment.c b/environment.c
> index 3527f16..8058e7b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -49,6 +49,8 @@ static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
>  	if (!git_dir)
> +		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> +	if (!git_dir)
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;

I still maintain that the code (maybe not the diff) is easier to read like 
this:

  	if (!git_dir) {
		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
		if (!git_dir)
  			git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
	}

> diff --git a/setup.c b/setup.c
> index 4509598..20502be 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -239,6 +239,44 @@ static int check_repository_format_gently(int *nongit_ok)
>  }
>  
>  /*
> + * Try to read the location of the git directory from the .git file,
> + * return path to git directory if found.
> + */
> +const char *read_gitfile_gently(const char *path)
> +{
> +	char *buf;
> +	struct stat st;
> +	int fd;
> +	size_t len;
> +
> +	if (stat(path, &st))
> +		return NULL;
> +	if (!S_ISREG(st.st_mode))
> +		return NULL;
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		die("Error opening %s: %s", path, strerror(errno));

Hmm.  Like I said, in the "gently" case, we might want to just print a 
warning and return NULL.

However, since you have 5 die()s in this function that would clutter the 
code tremendously.  I briefly considered (shut your eyes now if you do 
not like ugly code):

	int (*show_error)(const char *format, ...) = nongit_ok ?
		error : (int (*)(const char *format, ...))die;

but now I think a better method would be

static int show_error(int die_on_error, const char *format, ...)
{
        va_list params;

        va_start(params, err);
	if (die_on_error)
		die_routine(err, params);
	else
	        error_routine(err, params);
        va_end(params);
        return -1;
}

This would even be a candidate for a global function die_or_error().

Then you could use it like this:

	if (fd < 0 && die("Error opening %s: %s", path, strerror(errno))
		return NULL;

Hmm.  Seeing what I wrote, it does not really feel elegant.

So maybe we can just scratch all that, and I agree that an invalid .git 
file means "no repository" (as opposed to "no valid repository").

In that case, you might want to test for that, too...

Speaking about tests:

> +test_expect_success 'setup' '
> +       REAL="$(pwd)/.real" &&
> +       mv .git "$REAL" &&
> +       echo "gitdir: $REAL" >.git
> +'

Let's not do this.  It would clutter the t/ directory unnecessarily.  
Instead, do something like this:

test_expect_success setup '

	REAL="$(pwd)/.real" &&
	mkdir test &&
	cd test &&
	echo "gitdir: $REAL" > .git

'

Hmm?

Ciao,
Dscho "who likes to write 'Hmm' three times in a mail"
