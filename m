From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 13:49:45 +0200
Message-ID: <4A02CAD9.9080808@drmicha.warpmail.net>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 13:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M228D-0000WB-DV
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 13:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZEGLtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZEGLty
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 07:49:54 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44687 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981AbZEGLty (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 07:49:54 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 07:49:53 EDT
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 80B4E341482;
	Thu,  7 May 2009 07:49:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 07 May 2009 07:49:54 -0400
X-Sasl-enc: oHqvJydf1fmdwwKHGMDqgI6wtqI5A/IMSXbrUidlO0He 1241696994
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 69B5E13155;
	Thu,  7 May 2009 07:49:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118462>

Matthias Andree venit, vidit, dixit 07.05.2009 11:22:
> Situation: sudo make install rebuilds the whole package even if you've just
> built it before. For instance:
> 
> make configure
> ./configure    # defaults to --prefix=/usr/local
> make all doc
> sudo make install install-doc install-html # REBUILDS HAPPEN HERE
> 
> This causes the "sudo make install" to rebuild everything because it believes
> the version had changed.
> sudo strips $PATH for security reasons.
> 
> The underlying problem flow is:
> 
> 1 - Makefile has "include GIT-VERSION-FILE", thus gmake builds
>     GIT-VERSION-FILE early.
> 
> 2 - GIT-VERSION-FILE depends on a .PHONY target (.FORCE-GIT-VERSION-FILE)
> 3 - Thus, GNU make *always* executes GIT-VERSION-GEN
> 4 - GIT-VERSION-GEN now, under the stripped $PATH, cannot find "git" and
>     sees a different version number.
> 5 - GIT-VERSION-GEN notes the difference in versions and regenerates
>     GIT-VERSION-FILE, with up-to-date timestamp.
> 6 - GNU make rebuilds everything because GIT-VERSION-FILE is new.
> 
> The patch makes GIT-VERSION-GEN look for the current built git$X executable,
> and in $(prefix)/bin/git, before falling back to plain "git" and thus to the
> default version in GIT-VERSION-GEN.

Thanks for the detailed analysis, now I g[oi]t it!
According to the analysis, the problem would also appear with a standard
make run (without configure) as long as git is not in the sudoer's $PATH
($prefix isn't, no distro git in /usr).

> Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
> ---
>  GIT-VERSION-GEN |    9 ++++-----
>  Makefile        |    6 +++++-
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 39cde78..d0dfef3 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -2,6 +2,7 @@
>  
>  GVF=GIT-VERSION-FILE
>  DEF_VER=v1.6.3.GIT
> +test -x "$GIT" || GIT=git
>  
>  LF='
>  '
> @@ -12,12 +13,12 @@ if test -f version
>  then
>  	VN=$(cat version) || VN="$DEF_VER"
>  elif test -d .git -o -f .git &&
> -	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
> +	VN=$($GIT describe --abbrev=4 HEAD 2>/dev/null) &&
>  	case "$VN" in
>  	*$LF*) (exit 1) ;;
>  	v[0-9]*)
> -		git update-index -q --refresh
> -		test -z "$(git diff-index --name-only HEAD --)" ||
> +		$GIT update-index -q --refresh
> +		test -z "$($GIT diff-index --name-only HEAD --)" ||
>  		VN="$VN-dirty" ;;
>  	esac
>  then
> @@ -38,5 +39,3 @@ test "$VN" = "$VC" || {
>  	echo >&2 "GIT_VERSION = $VN"
>  	echo "GIT_VERSION = $VN" >$GVF
>  }
> -
> -
> diff --git a/Makefile b/Makefile
> index 6e21643..d6be483 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -177,7 +177,11 @@ all::
>  # away (some NTFS drivers seem to zero the contents in that scenario).
>  
>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> -	@$(SHELL_PATH) ./GIT-VERSION-GEN
> +	@{ GIT=./git$X ; test -x "$$GIT" ; } \
> +	    || { GIT=$(prefix)/bin/git$X ; test -x "$$GIT" ; }\
> +	    || GIT=git ; \
> +	    export GIT ; \
> +	    $(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
>  
>  uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

Looks good to me. So, untested but reviewed by me.

Michael
