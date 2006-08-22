From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Tue, 22 Aug 2006 16:40:26 -0700
Message-ID: <7virkkl4ph.fsf@assigned-by-dhcp.cox.net>
References: <7vhd05s2b5.fsf@assigned-by-dhcp.cox.net>
	<1156268432.16120@hammerfest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 01:40:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFfrD-0003xJ-JP
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 01:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWHVXk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWHVXk2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 19:40:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12215 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932266AbWHVXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 19:40:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822234027.ZCRB18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 19:40:27 -0400
To: Tilman Sauerbeck <tilman@code-monkey.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25883>

Tilman Sauerbeck <tilman@code-monkey.de> writes:

> @@ -93,6 +94,21 @@ OPTIONS
>  --pid-file=file::
>  	Save the process id in 'file'.
>  
> +--user=user::
> +--group=group::

Probably

	--user=user, --group=group::

Also check for asciidoc formatting please; it's rather picky.

> +	These two options may be used to make `git-daemon` change its uid and
> +	gid	before entering the server loop.
> +	The uid that's used is the one of 'user'. If `group` is specified,
> +	the gid is set to the one of 'group', otherwise, the default gid
> +	of 'user' is used.

Funny whitespaces all over the place...

What is the pw_gid stored in struct passwd for the user?
getgroups(2) gives supplementary group IDs, so perhaps it is
called primary group ID?

> +	Both `group` and `user` need to be passed as the name of the resp of
> +	the group, ie you'll get unexpected results if you pass an uid/a gid.

Gaah, but that is probably OK.  I'd explicitly say they are
always interpreted as name and never numeric.  An alternative
would be to be nice and when getpwnam() and/or getgrnam()
returns NULL try to interpret them as numeric, which might help
a small dedicated server installation that does not have any
/etc/passwd or /etc/group file ;-) but I do not think that would
be worth the confusion.

> +	Note that you probably don't want to use these options if you run
> +	git-daemon in inetd mode, since inetd can do the privilege dropping
> +	for you.

Gaah again.  These options do not have any effect (other than
sanity checking) on the inetd_mode codepath, so instead of
saying this in the documentation I would suggest specifying
these options an error under --inetd.

Something like this on top of your patch perhaps.

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 8f850fa..17619a3 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -94,20 +94,16 @@ OPTIONS
 --pid-file=file::
 	Save the process id in 'file'.
 
---user=user::
---group=group::
-	These two options may be used to make `git-daemon` change its uid and
-	gid	before entering the server loop.
-	The uid that's used is the one of 'user'. If `group` is specified,
-	the gid is set to the one of 'group', otherwise, the default gid
-	of 'user' is used.
-
-	Both `group` and `user` need to be passed as the name of the resp of
-	the group, ie you'll get unexpected results if you pass an uid/a gid.
-
-	Note that you probably don't want to use these options if you run
-	git-daemon in inetd mode, since inetd can do the privilege dropping
-	for you.
+--user=user, --group=group::
+	Change daemon's uid and gid before entering the service loop.
+	When only `--user` is given without `--group`, the
+	primary group ID for the user is used.  The values of
+	the option are given to `getpwnam(3)` and `getgrnam(3)`
+	and numeric IDs are not supported.
++
+Giving these options is an error when used with `--inetd`; use
+the facility of inet daemon to achieve the same before spawning
+`git-daemon` if needed.
 
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
diff --git a/daemon.c b/daemon.c
index 4e94210..dd3915a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -821,6 +821,9 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	if (inetd_mode && (group_name || user_name))
+		die("--user and --group are incompatible with --inetd");
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
