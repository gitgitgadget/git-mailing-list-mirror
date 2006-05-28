From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] new environment variable GIT_TEMPLATE_DIR to override default template
Date: Sun, 28 May 2006 10:33:44 -0700
Message-ID: <7v4pzadpfr.fsf@assigned-by-dhcp.cox.net>
References: <20060527132554.GC10488@pasky.or.cz>
	<E1Fk3yR-0006Gd-36@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 19:33:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkP9B-0006KJ-8K
	for gcvg-git@gmane.org; Sun, 28 May 2006 19:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWE1Rdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWE1Rdq
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 13:33:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52874 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750817AbWE1Rdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 13:33:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060528173345.MTLP27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 13:33:45 -0400
To: Matthias Lederhofer <matled@gmx.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20882>

Matthias Lederhofer <matled@gmx.net> writes:

> directory and --template=<template_directory> option for to git-clone
>
> ---
>> Please document such changes, in the spirit of
>
> That's right, here are both patches in one because the second patch
> would also change the documentation of the first one.

Thanks.

 * Please don't put the beginning of one sentence on Subject
   line and start the body of the message with the rest of that
   sentence.  Instead, come up with a short (meaning "fits on
   the Subject line without wrapping with 80-column terminal")
   title that describes what the patch does -- it is a good
   sanity check to make sure your patch is doing one thing and
   one thing only, instead of mixing unrelated mess together.

 * Please sign-off your patch.

 * Please test your patch for existing usage, not just for the
   new usage you added, to avoid regressions.

I like the part to let git-clone pass --template down to git-init-db,
but once it is in place I doubt you would still need GIT_TEMPLATE_DIR.
I'd rather not to introduce new environment variables if we can
avoid them.

> diff --git a/git-clone.sh b/git-clone.sh
> index d96894d..1c7ae12 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -102,6 +102,7 @@ quiet=
>  local=no
>  use_local=no
>  local_shared=no
> +template=
>  no_checkout=
>  upload_pack=
>  bare=
> @@ -120,6 +121,8 @@ while
>  	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
>          *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
>            local_shared=yes; use_local=yes ;;
> +	*,--template=*)
> +	  template="$1" ;;
>  	*,-q|*,--quiet) quiet=-q ;;
>  	*,--use-separate-remote)
>  		use_separate_remote=t ;;

Here, $template is either empty string "", or "--template=dir"
after argument parsing.  But then it does this:

> @@ -203,7 +206,7 @@ trap 'err=$?; cd ..; rm -r "$D"; exit $e
>  case "$bare" in
>  yes) GIT_DIR="$D" ;;
>  *) GIT_DIR="$D/.git" ;;
> -esac && export GIT_DIR && git-init-db || usage
> +esac && export GIT_DIR && git-init-db "$template" || usage

which I suspect would make git-init-db barf if you did not pass
any --template=foo option to git-clone.  Did you test your patch?

So I'd do it like this instead.

-- >8 --
[PATCH] Let git-clone to pass --template=dir option to git-init-db.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-clone.txt |    9 +++++++--
 git-clone.sh                |   10 ++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b333f51..94d9393 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,8 +9,8 @@ git-clone - Clones a repository
 SYNOPSIS
 --------
 [verse]
-'git-clone' [-l [-s]] [-q] [-n] [--bare] [-o <name>] [-u <upload-pack>]
-	  [--reference <repository>]
+'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
+	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
 	  <repository> [<directory>]
 
 DESCRIPTION
@@ -89,6 +89,11 @@ OPTIONS
 	the command to specify non-default path for the command
 	run on the other end.
 
+--template=<template_directory>::
+	Specify the directory from which templates will be used;
+	if unset the templates are taken from the installation
+	defined default, typically `/usr/share/git-core/templates`.
+
 <repository>::
 	The (possibly remote) repository to clone from.  It can
 	be any URL git-fetch supports.
diff --git a/git-clone.sh b/git-clone.sh
index d96894d..de59904 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@ # See git-sh-setup why.
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -102,6 +102,7 @@ quiet=
 local=no
 use_local=no
 local_shared=no
+unset template
 no_checkout=
 upload_pack=
 bare=
@@ -120,6 +121,11 @@ while
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
+	1,--template) usage ;;
+	*,--template)
+		shift; template="--template=$1" ;;
+	*,--template=*)
+	  template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote)
 		use_separate_remote=t ;;
@@ -203,7 +209,7 @@ trap 'err=$?; cd ..; rm -r "$D"; exit $e
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init-db || usage
+esac && export GIT_DIR && git-init-db ${template+"$template"} || usage
 case "$bare" in
 yes)
 	GIT_DIR="$D" ;;
-- 
1.3.3.g2a0a
