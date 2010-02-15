From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git stash pop not reapplying deletions
Date: Mon, 15 Feb 2010 16:41:19 +0100
Message-ID: <201002151641.19694.trast@student.ethz.ch>
References: <loom.20100214T200110-615@post.gmane.org> <201002142308.01704.trast@student.ethz.ch> <loom.20100215T152932-38@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Nanako Shiraishi <nanako3@lavabit.com>
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 15 16:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh34y-0008I3-3D
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 16:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab0BOPl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 10:41:28 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:14621 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab0BOPl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 10:41:28 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 16:41:25 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 16:41:19 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <loom.20100215T152932-38@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140014>

Please don't remove the Cc list, it helps us (among other things) flag
the mail that is important.

On Monday 15 February 2010 15:32:44 Steve Folly wrote:
> Thomas Rast <trast <at> student.ethz.ch> writes:
> > Yes, [git stash without --index] does stage new files, but that is
> > only to help you: otherwise you could forget them before
> > committing.
> 
> But that's even more confusing - not using --index only 
> restores *some* of the index. To be honest, 
> that's not really helping - I still have to stage deletions 
> manually.
> 
> If not using --index isn't supposed to restore the index, 
> then surely it shouldn't be staging the new files?

Not sure.  I personally prefer the behaviour as it is now, as I have
status.showUntrackedFiles = no and would most likely forget about
them.  It has been that way since the introduction of git-stash, so
maybe Nanako (Cc'd) can enlighten us further.

That being said, it could probably be made configurable along the
lines of the patch below, or even with a config option.


diff --git i/git-stash.sh w/git-stash.sh
index 3a0685f..fc56e1b 100755
--- i/git-stash.sh
+++ w/git-stash.sh
@@ -222,12 +222,26 @@ show_stash () {
 
 apply_stash () {
 	unstash_index=
+	dont_touch_index=
 
 	while test $# != 0
 	do
 		case "$1" in
 		--index)
 			unstash_index=t
+			dont_touch_index=
+			;;
+		--index=apply)
+			unstash_index=t
+			dont_touch_index=
+			;;
+		--index=added-only)
+			unstash_index=
+			dont_touch_index=
+			;;
+		--index=none)
+			unstash_index=
+			dont_touch_index=t
 			;;
 		-q|--quiet)
 			GIT_QUIET=t
@@ -293,7 +307,7 @@ apply_stash () {
 			a="$TMP-added" &&
 			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
 			git read-tree --reset $c_tree &&
-			git update-index --add --stdin <"$a" ||
+			(test -n "$dont_touch_index" || git update-index --add --stdin <"$a") ||
 				die "Cannot unstage modified files"
 			rm -f "$a"
 		fi

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
