From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: add systemd support
Date: Sun, 17 May 2015 11:12:01 -0700
Message-ID: <xmqq4mnbdqfi.fsf@gitster.dls.corp.google.com>
References: <1431830650-111684-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Sun May 17 20:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yu32r-0001uZ-2P
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 20:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbbEQSMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 14:12:08 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33357 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbEQSMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 14:12:05 -0400
Received: by iebgx4 with SMTP id gx4so155449533ieb.0
        for <git@vger.kernel.org>; Sun, 17 May 2015 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ATj1vyQ34+LDwIGlkLGpIog/5An/iAvvR1kaNu/tEiE=;
        b=mWsXvkqbGbBjcJbMeQncOMU0WP+EuG99sd4sK1rsHLAHDuCruOSEUuDP8Fpapw8tAs
         I2ReazPf1l2O0kkU6vDKmRXi3b9T+gCZ/RoWrR+0kr2uCJYcofCINQRFNN0DOb+zoS3m
         6G0kW6pFMfIITap0c/UI/klyvAIPRirqd/FAOlnFoj0tyh+fILPF0VNGmZnUL36trgzr
         8ss45AM2FYONyyPNpLB95djjuoG6pS4sPJ3q8Ix7iOJQQ7swJgvumf/LAG7RPYMYSKWU
         3w/vIB6sk5cj5K20wgmH5CPz/6KZTInuIeqEA4hpmxyfN17gUysLYJb/VNHqNupR0/Jo
         BNdg==
X-Received: by 10.50.80.19 with SMTP id n19mr10031797igx.30.1431886323708;
        Sun, 17 May 2015 11:12:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id e69sm6004569ioe.11.2015.05.17.11.12.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 11:12:02 -0700 (PDT)
In-Reply-To: <1431830650-111684-1-git-send-email-shawn@churchofgit.com> (Shawn
	Landden's message of "Sat, 16 May 2015 19:44:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269219>

Shawn Landden <shawn@churchofgit.com> writes:

> git-daemon's --systemd mode allows git-daemon to be connect-activated
> on one or more addresses or ports. Unlike --inetd[1], git-daemon is
> not spawned for every connection.
>
> [1]which systemd is compatible with using its Accept=yes mode

I can barely parse but cannot comprehend this footnote and the body
text the footnote is attached to.

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index a69b361..0eab51b 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -19,7 +19,8 @@ SYNOPSIS
>  	     [--access-hook=<path>] [--[no-]informative-errors]
>  	     [--inetd |
>  	      [--listen=<host_or_ipaddr>] [--port=<n>]
> -	      [--user=<user> [--group=<group>]]]
> +	      [--systemd |
> +	       [--user=<user> [--group=<group>]]]
>  	     [<directory>...]
>  DESCRIPTION
> @@ -81,8 +82,8 @@ OPTIONS
>  
>  --inetd::
>  	Have the server run as an inetd service. Implies --syslog.
> -	Incompatible with --detach, --port, --listen, --user and --group
> -	options.
> +	Incompatible with --systemd, --detach, --port, --listen, --user and
> +	--group options.

When adding to a new thing to an existing list, we usually add to
the end (same comment applies to the addition to SYNOPSIS above).
You did that correctly to the other part (like the next hunk and
also the example), so let's be consistent.

> @@ -146,8 +147,8 @@ OPTIONS
>  	the option are given to `getpwnam(3)` and `getgrnam(3)`
>  	and numeric IDs are not supported.
>  +
> -Giving these options is an error when used with `--inetd`; use
> -the facility of inet daemon to achieve the same before spawning
> +Giving these options is an error when used with `--inetd` or `--systemd`; use
> +the facility of systemd or the inet daemon to achieve the same before spawning
>  'git daemon' if needed.
>  +
>  Like many programs that switch user id, the daemon does not reset

> diff --git a/Makefile b/Makefile
> index 36655d5..54986a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -42,6 +42,9 @@ all::
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports (dumb).
>  #
> +# Define NO_SYSTEMD to prevent systemd socket activation support from being
> +# built into git-daemon.
> +#

Hmmm, instead of doing negative, make this an opt-in "USE_SYSTEMD"?

> @@ -997,6 +1000,13 @@ ifeq ($(uname_S),Darwin)
>  	PTHREAD_LIBS =
>  endif
>  
> +ifndef NO_SYSTEMD
> +	ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null 2>/dev/null && echo y),y)
> +		BASIC_CFLAGS += -DHAVE_SYSTEMD
> +		EXTLIBS += -lsystemd
> +	endif

This is bad, if we expect headers and libraries can be installed
outside the usual search paths.  Perhaps imitate what we do for
libpcre library where we enable with $USE_LIBPCRE and allow the
location specified with $LIBPCREDIR, or something like that?

> +endif
> +
>  ifndef CC_LD_DYNPATH
>  	ifdef NO_R_TO_GCC_LINKER
>  		# Some gcc does not accept and pass -R to the linker to specify
> diff --git a/daemon.c b/daemon.c
> index d3d3e43..42e1441 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,3 +1,7 @@
> +#ifdef HAVE_SYSTEMD
> +#  include <systemd/sd-daemon.h>
> +#endif
> +
>  #include "cache.h"

Never include system headers to our code before "git-compat-util.h"
is included (either directly or via "cache.h" and friends).

>  #include "pkt-line.h"
>  #include "exec_cmd.h"
> @@ -28,7 +32,11 @@ static const char daemon_usage[] =
>  "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
>  "           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
> +#ifdef HAVE_SYSTEMD
> +"                      [--systemd | [--detach] [--user=<user> [--group=<group>]]]\n" /* exactly 80 characters */

An overlong source line.

I am not sure if we want to hide the "--systemd" option from this
list with #ifdef ugliness.  "git daemon --systemd" can error out with
a build without USE_SYSTEMD with "fatal: systemd not supported".

> +#else
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
> +#endif
>  "           [<directory>...]";
>  
>  /* List of acceptable pathname prefixes */
> @@ -1166,12 +1174,40 @@ static struct credentials *prepare_credentials(const char *user_name,
>  }
>  #endif
>  
> +#ifdef HAVE_SYSTEMD
> +static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
> +{
> +	if (systemd_mode) {
> +		int i, n;
> +
> +		n = sd_listen_fds(0);
> +		if (n <= 0)
> +			die("--systemd mode specified and no file descriptors recieved");

"received"

> +		ALLOC_GROW(socklist->list, socklist->nr + n, socklist->alloc);
> +		for (i = 0; i < n; i++)
> +			socklist->list[socklist->nr++] = SD_LISTEN_FDS_START + i;
> +	}
> +
> +	if (listen_addr->nr > 0 || !systemd_mode)
> +		socksetup(listen_addr, listen_port, socklist);
> +
> +	return 0;
> +}
> +#else
> +static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
> +{
> +	socksetup(listen_addr, listen_port, socklist);
> +
> +	return 0;
> +}
> +#endif
> +
>  static int serve(struct string_list *listen_addr, int listen_port,
> -    struct credentials *cred)
> +    struct credentials *cred, int systemd_mode)

A full int for "systemd_mode" feels a poor taste that invites more
ugliness in the future---the next person will be tempted to add yet
another variable to add foobar_mode.  How about adding "unsigned flags"
and check

	#define SYSTEMD_MODE 1

	if (flags & SYSTEMD_MODE)
        	... do the systemd thing ...
	else
        	... do other thing ...

Actually, I think we should do without this systemd_mode (or flags
for that matter) passed to this function via a parameter.

Can't we consolidate inetd_mode and serve_mode into a single "enum
service_mode { SERVE, INETD, SYSTEMD }" variable as a preparatory
step?  I think it is perfectly fine to make it a global variable
without passing it via a parameter, as the choice among serve, inetd
and systemd is done once for the process and will not change
throughout the life of it.

With those suggested changes, there would be fewer conditionally-
compiled stuff and I suspect the result would be cleaner.

Also, I wonder if we may even want do the attached patch for the
"enumerate" stuff (of course, "if (systemd)" would further be
changed to "if (sevice_mode == SYSTEMD)" etc.).

Thanks.


 daemon.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/daemon.c b/daemon.c
index 42e1441..c8d529b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,7 +1,3 @@
-#ifdef HAVE_SYSTEMD
-#  include <systemd/sd-daemon.h>
-#endif
-
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
@@ -9,6 +5,13 @@
 #include "strbuf.h"
 #include "string-list.h"
 
+#ifdef HAVE_SYSTEMD
+#  include <systemd/sd-daemon.h>
+#else
+#define SD_LISTEN_FDS_START 0 /* not used */
+#define sd_listen_fds(n) (n) /* not used */
+#endif
+
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
@@ -1174,15 +1177,16 @@ static struct credentials *prepare_credentials(const char *user_name,
 }
 #endif
 
-#ifdef HAVE_SYSTEMD
-static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
+static int enumerate_sockets(struct socketlist *socklist,
+			     struct string_list *listen_addr,
+			     int listen_port, int systemd_mode)
 {
 	if (systemd_mode) {
 		int i, n;
 
 		n = sd_listen_fds(0);
 		if (n <= 0)
-			die("--systemd mode specified and no file descriptors recieved");
+			die("--systemd mode specified and no file descriptors received");
 		ALLOC_GROW(socklist->list, socklist->nr + n, socklist->alloc);
 		for (i = 0; i < n; i++)
 			socklist->list[socklist->nr++] = SD_LISTEN_FDS_START + i;
@@ -1193,14 +1197,6 @@ static int enumerate_sockets(struct socketlist *socklist, struct string_list *li
 
 	return 0;
 }
-#else
-static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
-{
-	socksetup(listen_addr, listen_port, socklist);
-
-	return 0;
-}
-#endif
 
 static int serve(struct string_list *listen_addr, int listen_port,
     struct credentials *cred, int systemd_mode)
