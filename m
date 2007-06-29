From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag: Fix the main while loop exit condition.
Date: Thu, 28 Jun 2007 17:01:48 -0700
Message-ID: <7vy7i3mxw3.fsf@assigned-by-dhcp.pobox.com>
References: <11830498172717-git-send-email-alexandre@peadrop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Vassalotti <alexandre@peadrop.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 02:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I43w8-0001LJ-28
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 02:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764201AbXF2ABv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759461AbXF2ABv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 20:01:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65016 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390AbXF2ABu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 20:01:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629000149.WUQA1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 20:01:49 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HC1o1X00r1kojtg0000000; Thu, 28 Jun 2007 20:01:49 -0400
In-Reply-To: <11830498172717-git-send-email-alexandre@peadrop.com> (Alexandre
	Vassalotti's message of "Thu, 28 Jun 2007 12:56:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51138>

Thanks.

I think you would need something like this on top if you want to
really fix it, though.

I also suspect that we should error out on:

	$ git tag -l foo bar

but that will be left as an exercise to the readers ;-)

diff --git a/git-tag.sh b/git-tag.sh
index bc0d735..48b54a1 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -14,7 +14,8 @@ username=
 list=
 verify=
 LINES=0
-while [ $# -ne 0 ]; do
+while case "$#" in 0) break ;; esac
+do
     case "$1" in
     -a)
 	annotate=1
@@ -30,8 +31,9 @@ while [ $# -ne 0 ]; do
 	shift
 	;;
     -n)
-        case $2 in
-	-*)	LINES=1 	# no argument
+        case "$#,$2" in
+	1,* | *,-*)
+		LINES=1 	# no argument
 		;;
 	*)	shift
 		LINES=$(expr "$1" : '\([0-9]*\)')
@@ -43,7 +45,14 @@ while [ $# -ne 0 ]; do
     -l)
 	list=1
 	shift
-	PATTERN="$1"	# select tags by shell pattern, not re
+	case $# in
+	0)	PATTERN=
+		;;
+	*)
+		PATTERN="$1"	# select tags by shell pattern, not re
+		shift
+		;;
+	esac
 	git rev-parse --symbolic --tags | sort |
 	    while read TAG
 	    do
