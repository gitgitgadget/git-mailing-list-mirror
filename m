From: Petr Baudis <pasky@suse.cz>
Subject: Re: User-relative paths (was: Server side programs)
Date: Sun, 23 Oct 2005 20:37:57 +0200
Message-ID: <20051023183757.GS30889@pasky.or.cz>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 20:40:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETkjp-0004DJ-SA
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 20:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVJWSiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 14:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVJWSiA
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 14:38:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17800 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750873AbVJWSh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 14:37:59 -0400
Received: (qmail 32454 invoked by uid 2001); 23 Oct 2005 20:37:57 +0200
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <435B5AE0.1060400@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10496>

Dear diary, on Sun, Oct 23, 2005 at 11:41:52AM CEST, I got a letter
where Andreas Ericsson <ae@op5.se> told me that...
> Anyways, the attached patch does this. I've tested all the various 
> syntaxes and they work as expected. rsync, http and local files take the 
> same syntax as before. I haven't added support for user-relative paths 
> to the git-daemon (can't see the point, really) although that can be 
> done easily enough.

It would be useful to add a [PATCH] tag to subject when you submit a
patch, so that we notice it better. ;-)

You don't update the documentation even though there seem to be some
syntactic changes. You should at least update

	Documentation/pull-fetch-param.txt

Also before Junio asks you, in the followup patches, you might want to
sign off the patch if you want it integrated.

> diff --git a/Makefile b/Makefile
> index 903c57c..87188ea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -359,6 +362,9 @@ git-cherry-pick: git-revert
>  %.o: %.S
>  	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
>  
> +$(SERVERSIDE_PROGRAMS) : git-%$X : %.o srvside-ssh.o $(LIB_FILE)
> +	$(CC) $(ALL_CFLAGS) -o $@ $(filter %o,$^) $(LIBS)
> +
>  git-%$X: %.o $(LIB_FILE)
>  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
>  

Why are you adding own compilation command, and why is it inconsistent
with the git-%$X's one?

> diff --git a/connect.c b/connect.c
> index b171c5d..0d78b3e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -436,33 +436,44 @@ static int git_tcp_connect(int fd[2], co
> +	/* leading colon marks relative path for ssh.
> +	 * Check for host == url and default to PROTO_SSH to allow
> +	 *   $ git fetch kernel.org:git
> +	 */
> +	if(ptr && (!path || ptr < path)) {
> +		if(host == url)
> +			protocol = PROTO_SSH;
> +
> +		if(protocol == PROTO_SSH) {
> +			*ptr = '\0';
> +			path = ptr + 1;
>  		}
>  	}

If I understand this right,

	ssh://foo.bar:baz/quux

will make foo.bar the host and baz/quux the path. Please, do NOT do
this! It is supposed to be a URL, dammit! And you know, URLs have
defined _syntax_, and that's important at least every time the URL gets
out of GIT's context. Or stop it calling URL altogether, to prevent any
confusion. But in URLs, the space between : and / is a port definition.
See also RFC3986 (aka STD066) and RFC2718.

Thanks.

> diff --git a/receive-pack.c b/receive-pack.c
> index 8f157bc..9a040ff 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -265,18 +267,9 @@ int main(int argc, char **argv)
>  	if (!dir)
>  		usage(receive_pack_usage);
>  
> -	/* chdir to the directory. If that fails, try appending ".git" */
> -	if (chdir(dir) < 0) {
> -		if (chdir(mkpath("%s.git", dir)) < 0)
> -			die("unable to cd to %s", dir);
> -	}
> -
> -	/* If we have a ".git" directory, chdir to it */
> -	chdir(".git");
> -	putenv("GIT_DIR=.");
> +	/* Find the right directory */
> +	srvside_chdir(dir, 0);
>  
> -	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
> -		die("%s doesn't appear to be a git directory", dir);
>  	write_head_info();
>  
>  	/* EOF */

No srvside_chdir() declaration?

> diff --git a/srvside-ssh.c b/srvside-ssh.c
> new file mode 100644
> index 0000000..0ed5d30
> --- /dev/null
> +++ b/srvside-ssh.c
> @@ -0,0 +1,63 @@
> +#include "cache.h"
> +#include <unistd.h>
> +#include <pwd.h>
> +
> +extern const char *__progname;

How portable is this? It appears that no standard really defines this,
and Google faintly hints at least some Cygwin-related problems...

> diff --git a/upload-pack.c b/upload-pack.c
> index accdba6..356c9b1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -5,6 +5,7 @@
>  #include "object.h"
>  
>  static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
> +extern void srvside_chdir(const char *path, int strict);
>  
>  #define MAX_HAS 256
>  #define MAX_NEEDS 256

What about a .h file?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
