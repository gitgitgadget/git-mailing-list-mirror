From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems installing as root
Date: Sat, 24 Feb 2007 22:40:35 -0800
Message-ID: <7vabz2wxi4.fsf@assigned-by-dhcp.cox.net>
References: <erpljl$ln9$1@sea.gmane.org> <20070225061258.GA1415@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 25 07:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLD3o-0002Fv-6p
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 07:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbXBYGkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 01:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbXBYGkh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 01:40:37 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51569 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932989AbXBYGkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 01:40:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225064037.YXEQ3767.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 01:40:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tigb1W0081kojtg0000000; Sun, 25 Feb 2007 01:40:36 -0500
In-Reply-To: <20070225061258.GA1415@spearce.org> (Shawn O. Pearce's message of
	"Sun, 25 Feb 2007 01:12:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40538>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Which files, specifically?  I'm sure that the following would be
> built as root during 'make install':
>
>   GIT-CFLAGS
>   GIT-VERSION-FILE
>   git-gui/GIT-VERSION-FILE
>   git-gui/CREDITS-FILE
>
> as these are rebuilt automatically everytime the Makefile runs,
> as they are embedding version data from HEAD.

We should strive to make sure that "find -type f -newer .stamp"
after "make all; date >.stamp; sleep 2; make all" reports
nothing.  Otherwise we would break:

	$ make all
        $ su
        # make install

How about doing something like this (you would need -p2 to apply
to your tree)?

diff --git a/git-gui/CREDITS-GEN b/git-gui/CREDITS-GEN
index da2c076..d1b0f86 100755
--- a/git-gui/CREDITS-GEN
+++ b/git-gui/CREDITS-GEN
@@ -20,8 +20,8 @@ tree_search ()
 generate_credits ()
 {
 	tip=$1 &&
-	rm -f $CF &&
-	git shortlog -n -s $tip | sed 's/: .*$//' >$CF || exit
+	rm -f "$2" &&
+	git shortlog -n -s $tip | sed 's/: .*$//' >"$2" || exit
 }
 
 # Always use the tarball credits file if found, just
@@ -36,10 +36,14 @@ generate_credits ()
 # that fact.
 #
 
+credits_tmp=/var/tmp/gitgui-credits-$$
+trap 'rm -f "$credits_tmp"' 0
+
+orig="$credits_tmp"
+
 if test -f credits
 then
-	rm -f $CF &&
-	cp credits $CF || exit
+	orig=credits
 elif prefix="$(git rev-parse --show-prefix 2>/dev/null)" &&
    test -n "$prefix" &&
    head=$(git rev-list --max-count=1 HEAD -- . 2>/dev/null) &&
@@ -47,12 +51,21 @@ elif prefix="$(git rev-parse --show-prefix 2>/dev/null)" &&
    tip=$(tree_search $head $tree) &&
    test -n "$tip"
 then
-	generate_credits $tip || exit
+	generate_credits $tip "$orig" || exit
 elif tip="$(git rev-parse --verify HEAD 2>/dev/null)" &&
    test -n "$tip"
 then
-	generate_credits $tip || exit
+	generate_credits $tip "$orig" || exit
 else
 	echo "error: Cannot locate authorship information." >&2
 	exit 1
 fi
+
+if test -f "$orig" && cmp -s "$orig" "$CF"
+then
+	: noop
+else
+	rm -f "$CF" &&
+	cat "$orig" >"$CF"
+fi
+
