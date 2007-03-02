From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from, when branching off a remote branch
Date: Fri, 02 Mar 2007 01:55:25 -0800
Message-ID: <7vmz2wezqq.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org>
	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	<45E68897.8000607@lu.unisi.ch>
	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	<45E68EDE.2090405@lu.unisi.ch>
	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	<45E69297.8070001@lu.unisi.ch>
	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	<45E69EEE.8070905@lu.unisi.ch>
	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	<7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
	<45E70041.1030705@lu.unisi.ch>
	<Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org>
	<7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4U6-0001yD-VU
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbXCBJz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422988AbXCBJz2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:55:28 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52941 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422983AbXCBJz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:55:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302095526.MPHL748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 04:55:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VlvR1W00N1kojtg0000000; Fri, 02 Mar 2007 04:55:26 -0500
In-Reply-To: <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Mar 2007 01:52:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41176>

Junio C Hamano <junkio@cox.net> writes:

> I have a feeling that "git checkout -b" and "git checkout -B"
> should be taught to explicitly use "git branch --no-track" and
> "git branch --track" to create a new branch (currently it does
> not even use "git branch" as far as I can tell).  With your
> patch, I suspect that you have to say "git branch topic
> origin/topic" and then "git checkout topic", which means you
> made the three-step process into two steps, but you could have
> made it into one step.  I'll send out an untested patch to
> git-checkout so that you can try it out in a separate message.

This does not add -B because I haven't applied your patch to my
tree yet, but it should be obvious where to add --track/--no-track.

Oh, as usual, I only have tested it once, so it may or may not
work.


diff --git a/git-checkout.sh b/git-checkout.sh
index 14835a4..bdf5cdf 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -33,7 +33,7 @@ while [ "$#" != "0" ]; do
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
 	"-l")
-		newbranch_log=1
+		newbranch_log=-l
 		;;
 	"-f")
 		force=1
@@ -235,11 +235,7 @@ fi
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		if [ "$newbranch_log" ]; then
-			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$newbranch")
-			touch "$GIT_DIR/logs/refs/heads/$newbranch"
-		fi
-		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
+		git branch $newbranch_log "$newbranch" "$new_name" || exit
 		branch="$newbranch"
 	fi
 	if test -n "$branch"
