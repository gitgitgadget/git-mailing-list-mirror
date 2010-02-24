From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [GIT GUI PATCH] git-gui: fix open explorer window on Windows 7
Date: Wed, 24 Feb 2010 01:14:11 +0100
Message-ID: <201002240114.11634.markus.heidelberg@web.de>
References: <20100223225243.GC11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4t6-00069l-EO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab0BXANs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 19:13:48 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56977 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab0BXANr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 19:13:47 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 238A613FB39F0;
	Wed, 24 Feb 2010 01:13:46 +0100 (CET)
Received: from [91.19.13.87] (helo=pluto.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Nk4sr-00051M-00; Wed, 24 Feb 2010 01:13:45 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <20100223225243.GC11271@book.hvoigt.net>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19BQVZDINKgy5DrLLa06hPrUzzPPeCGLMj2V3E9
	Ig2Z+NF8bnIrrR1h85Mp2Mn13LPJaMevaZkUh+Uzny6nbTV0CX
	ym/hJg+VSKzS0pqCgVNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140879>

Heiko Voigt, 2010-02-23 23:52:
> It seems that Windows 7's explorer is not capable to cope with paths
> that contain forward slashes as path seperator. We thus substitute slash
> with the platforms native backslash.
> 
> Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> ---
>  git-gui/git-gui.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 9a9525d..ae45a12 100644
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2112,15 +2112,17 @@ proc do_git_gui {} {
>  proc do_explore {} {
>  	global _gitworktree
>  	set explorer {}
> +	set path $_gitworktree
>  	if {[is_Cygwin] || [is_Windows]} {
>  		set explorer "explorer.exe"
> +		set path [list [string map {/ \\} $path]]

I remember having had the same problem, which I fixed with [file
nativename]. See commit 454efb47b (git-gui (Win): make "Explore Working
Copy" more robust). But that was on XP, shouldn't be Windows 7 specific.
So why does it fail now again, although I had fixed it? ...

>  	} elseif {[is_MacOSX]} {
>  		set explorer "open"
>  	} else {
>  		# freedesktop.org-conforming system is our best shot
>  		set explorer "xdg-open"
>  	}
> -	eval exec $explorer $_gitworktree &
> +	eval exec $explorer $path &

Ah, this doesn't look like what it looked like back then. Commit
21985a113 (git-gui: handle non-standard worktree locations) changed it,
removing the [file nativename]. I don't know if this was by accident,
but there is another place, where it was changed in a different manner:

Compare

-       eval exec $explorer [list [file nativename [file dirname [gitdir]]]] &
+       eval exec $explorer $_gitworktree &

with

-wm title . "[appname] ([reponame]) [file normalize [file dirname [gitdir]]]"
+wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"

Maybe _gitworktree should be normalized or nativenamified when it is set
and then will work everywhere it is used for every platform?

Markus
