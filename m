From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug: build from tarball uses git-describe
Date: Wed, 14 Feb 2007 11:26:15 -0800
Message-ID: <7vlkj0o814.fsf@assigned-by-dhcp.cox.net>
References: <eqtfso$7mo$1@sea.gmane.org>
	<Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd54dwnvb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702140206550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPll-0003K6-Dx
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbXBNT0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbXBNT0R
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:26:17 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51344 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476AbXBNT0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:26:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214192616.IWEN21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:26:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PXSF1W00m1kojtg0000000; Wed, 14 Feb 2007 14:26:16 -0500
In-Reply-To: <Pine.LNX.4.63.0702140206550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 02:10:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39727>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It checks if the file "version" exists, and takes the contents of that as 
> version, otherwise $DEF_VER.
>
>> After all fresh tarball is how we build rpm packages and we do
>> not have .git in that build environment, so I am quite puzzled.
>
> Yes, the idea was: if there is no .git, do not even bother checking the 
> output of git-describe (it might find a .git directory in a parent 
> directory, after all).

Ok, then let's do this.  Our tarballs do have version file, and
if the upperlevel Makefile wants to set a different version it
can drop 'version' file before descending into us. 

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index febacd2..6abde8d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,18 +6,19 @@ DEF_VER=v1.5.0.GIT
 LF='
 '
 
-# First try git-describe, then see if there is a version file
-# (included in release tarballs), then default
-if VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
-   case "$VN" in
-   *$LF*) (exit 1) ;;
-   v[0-9]*) : happy ;;
-   esac
-then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
-elif test -f version
+# First see if there is a version file (included in release tarballs),
+# then try git-describe, then default.
+if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
+elif test -d .git &&
+	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	case "$VN" in
+	*$LF*) (exit 1) ;;
+	v[0-9]*) : happy ;;
+	esac
+then
+	VN=$(echo "$VN" | sed -e 's/-/./g');
 else
 	VN="$DEF_VER"
 fi
