From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Add first whack at interpolated daemon paths.
Date: Sun, 04 Jun 2006 23:20:13 -0700
Message-ID: <7vac8s5dk2.fsf@assigned-by-dhcp.cox.net>
References: <E1Fn6B9-00017u-BV@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 08:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn8Rt-00089h-8v
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 08:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWFEGUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWFEGUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 02:20:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19840 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932425AbWFEGUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 02:20:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605062014.FBIJ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 02:20:14 -0400
To: Jon Loeliger <jdl@jdl.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21313>

Jon Loeliger <jdl@jdl.com> writes:

> This is really RFC-ish.  No canonicalization of hostname is done.

That's fine.  RFC-ish is what gets the ball rolling.

> diff --git a/Makefile b/Makefile
> index 004c216..6a02236 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -211,6 +211,7 @@ DIFF_OBJS = \
>  LIB_OBJS = \
>  	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
>  	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
> +	interpolate.o \
>  	object.o pack-check.o patch-delta.o path.o pkt-line.o \
>  	quote.o read-cache.o refs.o run-command.o dir.o \
>  	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \

A separate helper library is always a good idea.  Is it
"interpolate", I wonder, however?

> diff --git a/connect.c b/connect.c
> index 54f7bf7..9e7b276 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -374,7 +374,13 @@ static int git_tcp_connect(int fd[2], co
>  
>  	fd[0] = sockfd;
>  	fd[1] = sockfd;
> -	packet_write(sockfd, "%s %s\n", prog, path);
> +
> +	/*
> +	 * Separate original protocol components prog and path
> +	 * from extended components with a NUL byte.
> +	 */
> +	packet_write(sockfd, "%s %s%cHOST=%s\n", prog, path, 0, host);
> +

Since packet interface reader knows the length of the total
string, it might make sense to use NUL as the terminator
betweeen extended attributes (i.e. end the format with
"...HOST=%s%c" and append 0 as the last argument).  Some of our
later extended attributes might want to have LF in them for
whatever reason we do not foresee here.

>  	return 0;
>  }
>  
> @@ -443,7 +449,13 @@ static int git_tcp_connect(int fd[2], co
>  
>  	fd[0] = sockfd;
>  	fd[1] = sockfd;
> -	packet_write(sockfd, "%s %s\n", prog, path);
> +
> +	/*
> +	 * Separate original protocol components prog and path
> +	 * from extended components with a NUL byte.
> +	 */
> +	packet_write(sockfd, "%s %s%cHOST=%s\n", prog, path, 0, host);
> +
>  	return 0;
>  }

We probably would want to share this part between two
git_tcp_connect() implementations.  Rename two #ifdef'ed
implemenations of git_tcp_connect() to git_tcp_connect_sock(),
make its sole purpose to just open the connection and return the
sockfd.  Write a new git_tcp_connect() which is not #ifdef'ed,
call git_tcp_connect_sock() from there, and do the part after
"if (sockfd < 0)" in the new git_tcp_connect().

> +/* Flag indicating client sent extra args. */
> +int saw_extended_args = 0;
>  
>  /* If defined, ~user notation is allowed and the string is inserted
>   * after ~user/.  E.g. a request to git://host/~alice/frotz would
> @@ -41,6 +50,23 @@ static char *user_path = NULL;
>  static unsigned int timeout = 0;
>  static unsigned int init_timeout = 0;
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

As Linus mentioned, %H for full host and %h for the most
specific part may make sense.  I wonder if %D has a practical
value.  It lets you splice the client supplied directory path in
the middle of the final string, but would it be useful in
practice?  Otherwise, maybe dropping %D and always appending at
the tail of "interporated" path that is tailored for the virtual
host might be easier to code and explain.  

As to naming, "interp" sounds as if we are dealing with some
"interpreter" here...

> +#define N_INTERPS	(sizeof(interp_table) / sizeof(struct interp))

I would use ARRAY_SIZE() from git-compat-util.h where you would
use N_INTERPS and drop the #define altogether.

> +	else if (interpolated_path && saw_extended_args) {
> +		if (*dir != '/') {
> +			/* Allow only absolute */
> +			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
> +			return NULL;
> +		}
> +
> +		loginfo("Before interpolation '%s'", dir);
> +		loginfo("Interp slot 0 (%s,%s)",
> +			interp_table[0].name, interp_table[0].value);
> +		loginfo("Interp slot 1 (%s,%s)",
> +			interp_table[1].name, interp_table[1].value);
> +		interpolate(interp_path, PATH_MAX, interpolated_path,
> +			    interp_table, N_INTERPS);
> +		loginfo("After interpolation '%s'", interp_path);
> +		dir = interp_path;
> +	}

I suspect it would be easier to maintain the site if you let the
site administrator the default virtual host name, and for
requests from older clients use that name to interpolate %H, and
always use this codepath and nothing else (in other words, lose
"saw_extended_args" check) for both old and new clients.

With your patch, the administrator needs to configure the daemon
with --base_path=/mnt1/git.or.cz/git --interpolate=/mnt1/%H/git and
maintain them in sync.

> diff --git a/interpolate.c b/interpolate.c
>...
> +	if (p) {
> +	    /*
> +	     * Found a potential interpolation point.
> +	     */
> +	    for (i = 0; i < ninterps; i++) {
> +		name = interps[i].name;
> +		if (strncmp(p, name, strlen(name)) == 0)
> +		    break;
> +	    }
> +
> +	    value = interps[i].value;
> +	    valuelen = strlen(value);
> +	    printf("Interp: %s to %s\n", name, value);

Wouldn't a daemon misconfigured with --interpolate="/mnt/%X"
barf here by overstepping interps[] array?
