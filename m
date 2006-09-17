From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add virtualization support to git-daemon
Date: Sun, 17 Sep 2006 03:07:29 -0700
Message-ID: <7vvenm4xi6.fsf@assigned-by-dhcp.cox.net>
References: <E1GOint-00048W-2A@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 12:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtYk-0002UT-Vd
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 12:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWIQKHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 06:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIQKHc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 06:07:32 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8936 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964887AbWIQKHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 06:07:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917100730.XRMO18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 06:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PN7J1V0021kojtg0000000
	Sun, 17 Sep 2006 06:07:18 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1GOint-00048W-2A@jdl.com> (Jon Loeliger's message of "Sat, 16
	Sep 2006 17:38:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27180>

I have a few stylistic comments but the contents look quite sane
and fine.

> I use an inetd invocation like this example:
>
>     git  stream  tcp  nowait  nobody  /usr/bin/git-daemon git-daemon --inetd
>         --verbose --syslog
>         --export-all --interpolated-path=/pub/%H/%D
> 	/pub/software /software
> 	/pub/www.example.com/software
> 	/pub/www.example.org/software
> 	/pub

This would be nice to have as an example in the documentation.

> @@ -45,6 +51,23 @@ static const char *user_path;
>  static unsigned int timeout;
>  static unsigned int init_timeout;
>  
> +/*
> + * Static table for now.  Ugh.
> + * Feel free to make dynamic as needed.
> + */
> +#define INTERP_SLOT_HOST	(0)
> +#define INTERP_SLOT_DIR		(1)
> +#define INTERP_SLOT_PERCENT	(2)
> +
> +struct interp interp_table[] = {
> +	{ "%H", 0},
> +	{ "%D", 0},
> +	{ "%%", "%"},
> +};
> +
> +#define N_INTERPS	(sizeof(interp_table) / sizeof(struct interp))

Shouldn't this variable static to the file?

We seem to use ARRAY_SIZE() macro, which is not particularly my
favorite but other places already use it so probably we would
want to keep consistency.

> +		loginfo("Before interpolation '%s'", dir);
> +		loginfo("Interp slot 0 (%s,%s)",
> +			interp_table[0].name, interp_table[0].value);
> +		loginfo("Interp slot 1 (%s,%s)",
> +			interp_table[1].name, interp_table[1].value);
> +		interpolate(interp_path, PATH_MAX, interpolated_path,
> +			    interp_table, N_INTERPS);
> +		loginfo("After interpolation '%s'", interp_path);
> +		dir = interp_path;

Do we really want to see each step of interpolation in the log?
Sounds more like logdebug than loginfo to me.

> +		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
> +		loginfo("dir was %s", dir);
> +		loginfo("base_path is %s", base_path);
> +		loginfo("rpath now %s", rpath);
> +		dir = rpath;

Likewise.

> @@ -351,6 +398,29 @@ static void make_service_overridable(con
>  	die("No such service %s", name);
>  }
>  
> +void parse_extra_args(char *extra_args, int buflen)

static?

> @@ -391,13 +461,19 @@ #endif
>  	if (len && line[len-1] == '\n')
>  		line[--len] = 0;
>  
> +	if (len != pktlen) {
> +	    parse_extra_args(line + len + 1, pktlen - len - 1);
> +	}
> +

No { } around single statement.

> +int
> +interpolate(char *result, int reslen,
> +	    char *orig,
> +	    struct interp *interps, int ninterps)
> +{

"int interpolate(..."; the return type and function name on the
same line (again, not my preference but just doing as Romans do).

> +	bzero(result, reslen);

	memset(result, 0, reslen);

> diff --git a/interpolate.h b/interpolate.h
> new file mode 100644
> index 0000000..241af7c
> --- /dev/null
> +++ b/interpolate.h
> @@ -0,0 +1,13 @@

        #ifndef INTERPOLATE_H
        #define INTERPOLATE_H
        ...
        #endif

> +/*
> + * Copyright 2006 Jon Loeliger
> + */

> +
> +struct interp {
> +	char *name;
> +	char *value;
> +};
> +
> +extern int interpolate(char *result, int reslen,
> +		       char *orig,
> +		       struct interp *interps, int ninterps);
> +
