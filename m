From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 17:05:36 -0700
Message-ID: <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 02:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Daz-0007zv-3A
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZEHAFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbZEHAFh
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:05:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62605 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZEHAFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:05:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508000536.MQYL20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 May 2009 20:05:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oo5c1b00A4aMwMQ03o5cde; Thu, 07 May 2009 20:05:36 -0400
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=l3pLm0oRiFCvfTRvEQEA:9 a=0rJmuIOeASm6U9hGj8sA:7
 a=B5rfbVsxJI0jOEJutc4jCr9fUaEA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118547>

Matthias Andree <matthias.andree@gmx.de> writes:

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

Interesting.  I wonder if you need the change to the Makefile.

As long as GIT-VERSION-GEN notices that you have a freshly built git
available (test -x) and uses it, falling back to whatever on the PATH, it
would not have to touch GIT-VERSION-FILE, no?

IOW, instead of this:

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 39cde78..d0dfef3 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -2,6 +2,7 @@
>  
>  GVF=GIT-VERSION-FILE
>  DEF_VER=v1.6.3.GIT
> +test -x "$GIT" || GIT=git

wouldn't it make more sense to do

	if test -x "git"
        then
        	GIT=./git
	elif test -x "git.exe"
        then
        	GIT=./git.exe
	else
        	GIT=git
	fi

and use the rest of the patch to GIT-VERSION-GEN, without touching
Makefile at all?
