From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 10:28:11 +0200
Message-ID: <4A029B9B.7090706@viscovery.net>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 10:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1yyN-0008Cx-1I
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508AbZEGI20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbZEGI2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:28:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32470 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbZEGI2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:28:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1yxh-0007zP-3F; Thu, 07 May 2009 10:28:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 08EF354D; Thu,  7 May 2009 10:28:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118441>

Matthias Andree schrieb:
> Problem: when git is installed into /usr/local/bin, running 'sudo make
> install' won't find git in $PATH (because sudo strips PATH, for instance
> on openSUSE 11.1, and doesn't include /usr/local/whatever).
> 
> This causes GIT-VERSION-FILE to not find git for git describe, and fall
> back to DEF_VER.
> 
> This in turn causes rebuilds of major parts of the system.
> 
> This patch passes GIT through to the shell script, and additionally
> looks for the current version and in ${prefix}/bin.
> 
> Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
> ---
>  GIT-VERSION-GEN |    7 ++++---
>  Makefile        |    6 +++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 39cde78..66c171e 100755
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
> +	VN=$(${GIT} describe --abbrev=4 HEAD 2>/dev/null) &&

+	VN=$(${GIT} describe --abbrev=4 HEAD 2>/dev/null) &&
>  	case "$VN" in
>  	*$LF*) (exit 1) ;;
>  	v[0-9]*)
> -		git update-index -q --refresh
> -		test -z "$(git diff-index --name-only HEAD --)" ||
> +		${GIT} update-index -q --refresh
> +		test -z "$(${GIT} diff-index --name-only HEAD --)" ||
>  		VN="$VN-dirty" ;;
>  	esac
>  then
> diff --git a/Makefile b/Makefile
> index 6e21643..8e34877 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -177,7 +177,11 @@ all::
>  # away (some NTFS drivers seem to zero the contents in that scenario).
>  
>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> -	@$(SHELL_PATH) ./GIT-VERSION-GEN
> +	@{ GIT=./git$X ; type $$GIT >/dev/null 2>&1 ; } \
> +	    || { GIT=$(prefix)/bin/git$X ; type $$GIT >/dev/null 2>&1 ; }\
> +	    || GIT=git ; \
> +	    export GIT ; \
> +	    $(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
>  
>  uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')


-- 
DI Johannes Sixt
Leiter Softwareentwicklung
Viscovery Software GmbH
Landstrasse 11
A-4020 Linz, Austria

T: +43-1-532 0570-51
M: +43-676-8494 9571
F: +43-1-532 0570-33
j.sixt@viscovery.net
www.viscovery.net

t u r n   y o u r   d a t a   i n t o   r e a l   v a l u e !
