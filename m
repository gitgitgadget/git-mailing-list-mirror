From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, final version] git-branch, git-checkout: autosetup for remote branch tracking
Date: Thu, 08 Mar 2007 01:47:18 -0800
Message-ID: <7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
References: <45EFB205.4000604@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:47:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFDk-0000NG-LT
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbXCHJrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbXCHJrV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:47:21 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48090 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030433AbXCHJrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:47:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308094719.BTXI3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 04:47:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Y9nJ1W00G1kojtg0000000; Thu, 08 Mar 2007 04:47:19 -0500
In-Reply-To: <45EFB205.4000604@lu.unisi.ch> (Paolo Bonzini's message of "Thu,
	08 Mar 2007 07:49:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41726>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> ...
> Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>

Beautifully done, with even a sign-off ;-).

> @@ -45,6 +46,16 @@ OPTIONS
>  	by gitlink:git-check-ref-format[1].  Some of these checks
>  	may restrict the characters allowed in a branch name.
>  
> +--track::
> +	When -b is given and a branch is created off a remote branch,
> +	setup so that git-pull will automatically retrieve data from
> +	the remote branch.
> +
> +--no-track::
> +	When -b is given and a branch is created off a remote branch,
> +	force that git-pull will automatically retrieve data from
> +	the remote branch independent of the configuration settings.
> +
>  -l::
>  	Create the new branch's ref log.  This activates recording of
>  	all changes to made the branch ref, enabling use of date

Earlier I said "checkout -b" vs "checkout -B", but deciding the
tracking default with congiguration mechanism and overriding
with an additional --track/--no-track as you did here is way
superiour.  Very nice.

> diff --git a/builtin-branch.c b/builtin-branch.c
> index d371849..34b1bbf 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -308,14 +313,102 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
> +static int get_remote_branch_name(const char* value)
> +{
> +	const char *colon;
> +	const char *end;
> +
> +	if (*value == '+')
> +		value++;
> +
> +	colon = strchr(value, ':');
> +	end = value + strlen(value);
> +
> +	/* Try an exact match first.  */
> +	if (!strcmp(colon + 1, start_ref)) {

Careful.  colon may be NULL here, in which case you would want
to return with 0 from this function before this strcmp.

You seem to declare variables with "const char *colon" but
function args with "const char* value".  Are they deliberately
done differently?  The existing code seems to favor asterisk
next to the variable name, not type name.

Other than that, I find this function and get_remote_config()
very nicely done.

> +static void set_branch_defaults(const char *name, const char *real_ref)
> +{
> +	char key[1024];
> +	const char *slash = strrchr(real_ref, '/');
> +
> +	if (!slash)
> +		return;
> +
> +	start_ref = real_ref;
> +	start_len = strlen(real_ref);
> +	base_len = slash - real_ref;
> +	git_config(get_remote_config);
> +
> +	/* Change to != 0 to enable this feature by default.  */
> +	if (config_repo && config_remote) {
> +		if (snprintf(key, sizeof(key), "branch.%s.remote", name)
> +		    > sizeof(key))
> +			die("what a long branch name you have!");
> +		git_config_set(key, config_remote);
> +
> +		snprintf(key, sizeof(key), "branch.%s.merge", name);
> +		git_config_set(key, config_repo);

This is nice, but you might want to have a comment that says why
you do not have to check the return value from the second
snprintf().  Otherwise, somebody less careful may update this
part of the code and swap the order of config_remote and
config_repo are set up without thinking in the future.

> diff --git a/trace.c b/trace.c
> index 27fef86..1d4179d 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -41,13 +41,11 @@ static int git_vasprintf(char **strp, const char *fmt, va_list ap)
>  	return len;
>  }
>  
> +int nfasprintf(char **str, const char *fmt, ...)
>  {
> +	va_list args;
> +	va_start(args, fmt);
> +	return nfvasprintf(str, fmt, args);
>  }
>  
>  /* Get a trace file descriptor from GIT_TRACE env variable. */

It might not matter on common architectures in practice, but
va_start() must be matched by a corresponding va_end() in the
same function.
