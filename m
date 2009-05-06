From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 06 May 2009 13:14:07 -0500
Message-ID: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
References: <20090506055913.GA9701@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 20:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ldK-0004zX-Cw
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbZEFSOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbZEFSOJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:14:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58119 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZEFSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:14:09 -0400
Received: by mail.nrlssc.navy.mil id n46IE8SV023704; Wed, 6 May 2009 13:14:08 -0500
In-Reply-To: <20090506055913.GA9701@dektop>
X-OriginalArrivalTime: 06 May 2009 18:14:07.0526 (UTC) FILETIME=[72438460:01C9CE76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118363>

Nguyen Thai Ngoc Duy wrote:
> Hi,
> 
> I did "make test" on a SunOS 5.10 and it failed.

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index b68ab11..61ccdee 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
>  	test_must_fail git merge first
>  '
>  
> -sha1=$(sed -e 's/	.*//' .git/MERGE_RR)
> +sha1=$(cut -f 1 .git/MERGE_RR)

Are you using /bin/sed?  I think it has a problem with tabs.
/usr/xpg4/bin/sed works correctly, but it has a problem with
files that are not newline terminated.  So you will get other
errors.  I have a set of "ugly" patches that I will follow this
email with that allow me to compile on Solaris 10 while skipping
the following tests:

   GIT_SKIP_TESTS='
      t3900.2[23]
      t3901.[67]
      t6030.1[23]
      t8005.*
   '

The t3900 and t3901 are due to iconv failures.

The t6030 issues are due to a flaw in Sun's ksh, i.e. /usr/xpg4/bin/sh
which I use for testing.  This ksh seems to only call a trap that is
set within at most the next outer-layer function.  In other words, if
func1 sets a trap, and calls func2 which calls func3 which exits, then
the trap in func1 will _not_ be called. If instead, func2 exits, then
the trap will be called.  Bisect does such a thing.  You should not
have a problem with other ksh or bash.

I had assumed t8005 was failing because of iconv, but since you have
pointed out the extended RE in grep, some of these should pass.
Converting to egrep allows tests 1, 4 and 5 to pass for me. So my skip
expression can be changed to t8005.[23].

>  rr=.git/rr-cache/$sha1
>  test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"

Patches to follow.

-brandon
