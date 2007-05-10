From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t5000: skip ZIP tets when unzip is absent
Date: Thu, 10 May 2007 13:49:11 -0700
Message-ID: <7vps58ieuw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705101246430.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 10 22:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmFZe-0005P8-DJ
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbXEJUtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXEJUtN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:49:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39511 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbXEJUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:49:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510204912.GAEA6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 16:49:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xYpB1W00K1kojtg0000000; Thu, 10 May 2007 16:49:12 -0400
In-Reply-To: <Pine.LNX.4.64.0705101246430.4167@racer.site> (Johannes
	Schindelin's message of "Thu, 10 May 2007 12:47:06 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46899>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
>  t/t5000-tar-tree.sh |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index e223c07..1580592 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -108,6 +108,13 @@ test_expect_success \
>      'git-archive --format=zip' \
>      'git-archive --format=zip HEAD >d.zip'
>  
> +unzip -v 2>/dev/null
> +if [ $? -ne 10 ]; then
> +	echo "Skipping ZIP tests, because unzip was not found"
> +	test_done
> +	exit
> +fi
> +

Are you sure about this?

        $ unzip -v 2>/dev/null; echo "**$?**"
        UnZip 5.52 of 28 February 2005, by Debian. Original by Info-ZIP.

        Latest sources and executables are at
        ftp://ftp.info-zip.org/pub/infozip/ ;
        see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other
        sites.

        Compiled with gcc 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)
        for Unix (Linux ELF) on Aug 30 2006.

        UnZip special compilation options:
                ACORN_FTYPE_NFS
                COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not
                supported)
                SET_DIR_ATTRIB
                TIMESTAMP
                USE_EF_UT_TIME
                USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method
                supported)
                USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
                VMS_TEXT_CONV
                WILD_STOP_AT_DIR
                [decryption, version 2.9 of 05 May 2000]

        UnZip and ZipInfo environment options:
                   UNZIP:  [none]
                UNZIPOPT:  [none]
                 ZIPINFO:  [none]
              ZIPINFOOPT:  [none]
        **0**
	$ unzil -v 2>/dev/null; echo "**$?**"
	**127**

So two points are...

 * 2>/dev/null alone would give unsightly output to stdout which
   does not need to be in the test when unzip is available;

 * at least one version of unzip does not exit with status 10
   upon successful -v invocation, so the test is wrong; "unzip
   is unavaiable" is typically signalled with exit 127 (POSIX
   tells shell to use this for "command not found"; if found but
   not executable is 126).
