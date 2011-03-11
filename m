From: Jeff King <peff@peff.net>
Subject: Re: git stash: status from current dir not top dir?
Date: Fri, 11 Mar 2011 17:32:32 -0500
Message-ID: <20110311223232.GA21410@sigill.intra.peff.net>
References: <4D7A8AC9.1030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 23:32:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyAsy-00085Q-2y
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 23:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab1CKWce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 17:32:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52565
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab1CKWcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 17:32:33 -0500
Received: (qmail 13245 invoked by uid 107); 11 Mar 2011 22:33:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 17:33:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 17:32:32 -0500
Content-Disposition: inline
In-Reply-To: <4D7A8AC9.1030506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168929>

On Fri, Mar 11, 2011 at 09:49:13PM +0100, Piotr Krukowiecki wrote:

> But "git stash apply" shows status from root of git repository.
> This is misleading because you can't copy and paste the paths.

Yeah, I am inclined to call it a bug. git-status will show the status of
the whole tree from wherever you are, and people who want full paths
will have status.relativePaths turned off, anyway. So I think your
proposed semantics are more natural.

> This patch tries to fix git-stash.sh to show status relative to 
> current directory. I can resend the patch with better commit message.

Yes, please. There is lots of nice discussion in your email but none of
it in the commit message. :)

> diff --git a/git-stash.sh b/git-stash.sh
> index 7561b37..586c12f 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -12,6 +12,7 @@ USAGE="list [<options>]
>  
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
> +START_DIR=`pwd`
>  . git-sh-setup
>  require_work_tree
>  cd_to_toplevel
> @@ -394,7 +395,7 @@ apply_stash () {
>  		then
>  			squelch='>/dev/null 2>&1'
>  		fi
> -		eval "git status $squelch" || :
> +		(cd "$START_DIR" && eval "git status $squelch") || :
>  	else
>  		# Merge conflict; keep the exit status from merge-recursive
>  		status=$?

This fix looks reasonable to me. The other option would be to avoid
cd_to_toplevel at the beginning (which I am not sure why we really need
in the first place, but presumably some code paths rely on it), but it's
probably not worth the risk of introducing new confusing bugs.

-Peff
