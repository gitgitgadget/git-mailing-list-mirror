From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] full featured formating function of the --{base,user}_path arguments,
Date: Sun, 27 Aug 2006 22:35:42 -0700
Message-ID: <7vd5altob5.fsf@assigned-by-dhcp.cox.net>
References: <11566787581030-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 07:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHZmF-0004Kl-TA
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 07:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWH1FfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 01:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWH1FfL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 01:35:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32463 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750778AbWH1FfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 01:35:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828053508.PSJW6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 01:35:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FHb51V00X4Noztg0000000
	Mon, 28 Aug 2006 01:35:06 -0400
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <11566787581030-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Sun, 27 Aug 2006 13:39:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26142>

Pierre Habouzit <madcoder@debian.org> writes:

> +static struct {
> +	const char *path;
> +	int use_as_fmt;
> +} base_path;
>  
>  /* If defined, ~user notation is allowed and the string is inserted
>   * after ~user/.  E.g. a request to git://host/~alice/frotz would
>   * go to /home/alice/pub_git/frotz with --user-path=pub_git.
>   */
> -static const char *user_path;
> +static struct {
> +	const char *path;
> +	int use_as_fmt;
> +} user_path;

Maybe it does not matter much, but I wonder if we want to keep
two structs the same type, like:

        static struct {
                const char *path;
                int use_as_fmt;
        } base_path, user_path;

I also wondered if we can just extend the semantics of base_path
and user_path to autodetect the fmt-ness of them, but that means
we would break existing setups that uses per-cent in the
pathname.  Arguably that would not be so common and we may not
need to worry about such an installation, though.  What do you
think?

> @@ -174,24 +285,45 @@ static char *path_ok(char *dir)
>  				slash = dir + restlen;
>  			namlen = slash - dir;
>  			restlen -= namlen;
> +
> +			if (user_path.use_as_fmt) {
> +				loginfo("host <%s>, "
> +					"userpathfmt <%s>, request <%s>, "
> +					"namlen %d, restlen %d, slash <%s>",
> +					vhost,
> +					user_path.path, dir,
> +					namlen, restlen, slash);
> +				dir = git_path_fmt(rpath, user_path.path, vhost,
> +						   slash, dir + 1, namlen - 1);

When vhost is NULL you would feed it to "%s", which I think
glibc works around with (null) fine but other C libraries would
not like it.  git_path_fmt()'s logging does not have this
problem, though.

> +	else if (base_path.path) {
>  		if (*dir != '/') {
>  			/* Allow only absolute */
>  			logerror("'%s': Non-absolute path denied (base-path active)", dir);
>  			return NULL;
>  		}
> +
> +		if (base_path.use_as_fmt) {
> +			dir = git_base_path_fmt(rpath, base_path.path, vhost, dir);
> +		} else {
> +			snprintf(rpath, PATH_MAX, "%s%s", base_path.path, dir);

The level of logging in this branch and in user_path.use_as_fmt
branch are inconsistent.  Maybe the more detailed one above I
commented about vhost==NULL case was primarily meant for
debugging and you forgot to remove it?

> @@ -274,6 +406,7 @@ static int execute(struct sockaddr *addr
> @@ -303,15 +436,30 @@ #endif
>  	alarm(0);
>  
>  	len = strlen(line);
> +
> +	if (pktlen != len) {
> +		int arg_pos = len + 1;
> +
>  		loginfo("Extended attributes (%d bytes) exist <%.*s>",
>  			(int) pktlen - len,
> +			(int) pktlen - len, line + arg_pos);
> +
> +		while (arg_pos < pktlen) {
> +			int arg_len = strlen(line + arg_pos);
> +
> +			if (!strncmp("host=", line + arg_pos, 5)) {
> +				vhost = line + arg_pos + 5;
> +			}
> +
> +			arg_pos += arg_len + 1;
> +		}
> +	}
> +

I think it is easier to do:

	if (!vhost)
        	vhost = default_host;

and have git_base_path_fmt() barf if the format calls for %h and
vhost passed to it is NULL.  Lack of "host=" in the request is
logged here already.
