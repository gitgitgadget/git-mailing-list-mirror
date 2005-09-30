From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 30 Sep 2005 03:02:57 -0700
Message-ID: <7v4q826ffy.fsf@assigned-by-dhcp.cox.net>
References: <433B3B10.5050407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 12:05:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELHjQ-0002Fo-AM
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 12:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVI3KDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 06:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVI3KC7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 06:02:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45296 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964917AbVI3KC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 06:02:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930100255.NMRJ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 06:02:55 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9551>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I have set up a git-on-Cygwin temporary tree at:
>
> http://www.kernel.org/pub/scm/git/git-cygwin.git

: siamese; git clone http://kernel.org/pub/scm/git/git-cygwin.git/ git-cygwin
defaulting to local storage area
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

Could you do update-server-info there, please?

hera$ cd /pub/scm/git/git-cygwin.git
hera$ GIT_DIR=. git-update-server-info



Knowing nothing about Cygwin environment, here are some
comments.

        +# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().

This part probably is applicable outside Cygwin.  At some point,
can we have it in the mainline please?

         # The ones that do not have to link with lcrypto nor lz.
         SIMPLE_PROGRAMS = \
        -	git-get-tar-commit-id git-mailinfo git-mailsplit git-stripspace \
        -	git-daemon git-var
        +	git-get-tar-commit-id$(X) git-mailinfo$(X) git-mailsplit$(X) \
        +	git-stripspace$(X) git-var$(X) git-daemon$(X)
 
I have seen these $(X) in other programs' ports and found them
quite distasteful.  Since I do not have immediate suggestions
for improvements, I do not have rights to complain, though.

Spelling it $X is a bit less distracting but not that much
better.  Maybe "SIMPLE_PROGRAM_NAMES = git-foo git-bar" and
"SIMPLE_PROGRAMS = $(patsubst %,%$X,$(SIMPLE_PROGRAM_NAMES))"...
but that would not help bits like this:

        -	PROGRAMS += git-http-fetch
        +	PROGRAMS += git-http-fetch$(X)

or this: 

        -git-%: %.o $(LIB_FILE)
        +git-%$(X): %.o $(LIB_FILE)

... so I'd shut up about this part.

        diff --git a/daemon.c b/daemon.c
        --- a/daemon.c
        +++ b/daemon.c
        @@ -1,9 +1,11 @@
         #include "cache.h"
         #include "pkt-line.h"
        +#include <alloca.h>

Why?  I do not see any use of alloca in the added code...

        +#include <sys/poll.h>

Is poll preferrable over select in general?  Some may have only
select available and others may have only poll available,
perhaps?  In any case, this is probably relevant to wider
audience than just Cygwin; please give it to mainline at some
point, perhaps conditionally allowing either/both.

        +	*socklist_p = malloc(sizeof(int));
        +	pfd = calloc(socknum, sizeof(struct pollfd));

Please use xmalloc and xcalloc just for consistency.

                test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
        +
        +	# In case we're running on Cygwin...
        +	test -x $path/git-$cmd.exe && exec $path/git-$cmd.exe "$@" ;;
         esac
 
Hmph, I think you forgot to drop double semicolon there.

The git.sh script is munged by Makefile so presumably we could
fix this part up there, like:

        git: git.sh Makefile
                rm -f $@+ $@
                sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' \
                    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
                    -e 's/@@X@@/$X/g' <$@.sh >$@+
                chmod +x $@+
                mv $@+ $@

And then (a patch on top of your "master"):

diff --git a/git.sh b/git.sh
--- a/git.sh
+++ b/git.sh
@@ -12,10 +12,14 @@ case "$#" in
 		exit 0 ;;
 	esac
 
-	test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
+	test -x $path/git-$cmd && exec $path/git-$cmd "$@"
 
-	# In case we're running on Cygwin...
-	test -x $path/git-$cmd.exe && exec $path/git-$cmd.exe "$@" ;;
+	case '@@X@@' in
+	'')
+		;;
+	*)
+		test -x $path/git-$cmd@@X@@ && exec $path/git-$cmd@@X@@ "$@" ;;
+	esac		
 esac
 
 echo "Usage: git COMMAND [OPTIONS] [TARGET]"
