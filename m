From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 21:51:04 -0800
Message-ID: <7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 06:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhKsH-0001vO-H0
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 06:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVK3FvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 00:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVK3FvH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 00:51:07 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37504 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750984AbVK3FvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 00:51:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130054931.CYJ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 00:49:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 29 Nov 2005 21:06:10 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12986>

Linus Torvalds <torvalds@osdl.org> writes:

> Whaddaya think? I really like it.

Yes.  Maybe split this into 3 pieces.  I do not want to waste
your time with that, so will take the liberty to do so myself,
with appropriate commit log messages, if you do not mind.

 1. give diff-files -[012] flags.
 2. merge-one-file leaves unmerged index entries.
 3. always use -M -p in git-diff.

I do not have any issue against #1.

Regarding #2, in an earlier message you said something about
"patch to do that was just broken" which I did not understand; I
think your patch I am replying to is doing the right thing.  That
case arm is dealing with a path that exists in "our" branch and
the working tree blob should be the same as recorded in the
HEAD, so I did not have to do the unpack-cat-chmod like I did in
mine.  Am I simply confused?

About #3, I am not quite sure.  I often use --name-status and I
do _not_ want -p to kick in when I do so.  How about something
like this?

---

diff --git a/git-diff.sh b/git-diff.sh
index b3ec84b..8e0fe34 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -7,8 +7,6 @@ rev=$(git-rev-parse --revs-only --no-fla
 flags=$(git-rev-parse --no-revs --flags --sq "$@")
 files=$(git-rev-parse --no-revs --no-flags --sq "$@")
 
-: ${flags:="'-M' '-p'"}
-
 # I often say 'git diff --cached -p' and get scolded by git-diff-files, but
 # obviously I mean 'git diff --cached -p HEAD' in that case.
 case "$rev" in
@@ -20,6 +18,21 @@ case "$rev" in
 	esac
 esac
 
+# If we do not have --name-status, --name-only nor -r, default to -p.
+# If we do not have -B nor -C, default to -M.
+case " $flags " in
+*" '--name-status' "* | *" '--name-only' "* | *" '-r' "* )
+	;;
+*)
+	flags="$flags '-p'" ;;
+esac
+case " $flags " in
+*" '-"[BCM]* | *" '--find-copies-harder' "*)
+	;; # something like -M50.
+*)
+	flags="$flags '-M'" ;;
+esac
+
 case "$rev" in
 ?*' '?*' '?*)
 	echo >&2 "I don't understand"
