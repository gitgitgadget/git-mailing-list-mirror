From: Jeff King <peff@peff.net>
Subject: Re: [PATCH ] "git bisect visualize" results in an invalid error if
 "gitk" is not installed
Date: Mon, 21 Mar 2011 07:29:32 -0400
Message-ID: <20110321112932.GF16334@sigill.intra.peff.net>
References: <AANLkTi=HJjqrvv-PFO3VjhrHzBsLZmAbN0yU47WScWd_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Mon Mar 21 12:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1dIu-0006Qp-3o
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 12:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab1CUL3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 07:29:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab1CUL3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 07:29:38 -0400
Received: (qmail 12327 invoked by uid 107); 21 Mar 2011 11:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 07:30:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 07:29:32 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=HJjqrvv-PFO3VjhrHzBsLZmAbN0yU47WScWd_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169585>

On Sun, Mar 20, 2011 at 11:10:55PM +0200, Maxin john wrote:

> While using "git bisect visualize" on my PC running Ubuntu 10.10, I
> came across this error:
> 
> $ git bisect visualize
> eval: 1: gitk: not found
> git: 'bisect' is not a git command. See 'git --help'.
> 
> Did you mean this?
> 	bisect
> $

Yuck. Definitely non-optimal.

> diff --git a/git-bisect.sh b/git-bisect.sh
> index c21e33c..fefe212 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -290,7 +290,8 @@ bisect_visualize() {
>         then
>                 case
> "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}"
> in
>                 '')     set git log ;;
> -               set*)   set gitk ;;
> +               set*)   is_gitk_present
> +                       set gitk ;;
>                 esac

The point of this code is to use "gitk" if we can (i.e., if we have a
grahpical display of some sort), and "git log" otherwise. Shouldn't "we
are missing gitk" also cause us to fallback to using "git log"? IOW,
something like:

  if test -n "${DISPLAY+set}..." && is_gitk_present; then
    set gitk
  else
    set git log
  fi

> +is_gitk_present () {
> +       GIT_GITK=$(which gitk)
> +       test -n "$GIT_GITK" || {
> +               echo >&2 "Cannot find 'gitk' in the PATH"
> +               exit 1
> +       }
> +}

I don't think this is a portable use of which. In particular, I seem to
recall SunOS which printing some junk to stderr like "no foo in /bin
/usr/bin etc...". I think it even then returns a successful exit code,
just to make it totally useless.

I think we tend to use the shell's "type" builtin for this, which has a
usable exit code.

So the patch would look like:

diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..3b3156f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -288,10 +288,12 @@ bisect_visualize() {
 
 	if test $# = 0
 	then
-		case "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
-		'')	set git log ;;
-		set*)	set gitk ;;
-		esac
+		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
+		   type gitk >/dev/null 2>&1; then
+			set gitk
+		else
+			set git log
+		fi
 	else
 		case "$1" in
 		git*|tig) ;;

but I didn't test it at all.

-Peff
