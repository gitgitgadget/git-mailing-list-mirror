From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 17:27:17 -0800
Message-ID: <7vr78z3oy2.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<7v4q5v5536.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 02:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhGkk-00087r-Cy
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 02:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVK3B1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 20:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVK3B1T
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 20:27:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18581 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750768AbVK3B1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 20:27:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130012633.KSQN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 20:26:33 -0500
To: linux@horizon.com
In-Reply-To: <7v4q5v5536.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 Nov 2005 16:53:17 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12977>

Junio C Hamano <junkio@cox.net> writes:

> linux@horizon.com writes:
>
>> I'm wondering if this isn't a philosophical issue.
>
> I do not think so....
> ...
> This is the message from Linus that announced the current
> behaviour:
>
> 	http://marc.theaimsgroup.com/?l=git&m=111826424425624

Replying to myself.  In the message, Linus talks about being
able to do (diff-cache is an old name for diff-index):

	git-diff-files -p xyzzy ;# to compare with our version
        git-diff-cache -p MERGE_HEAD xyzzy ;# to compare with his

But because of the "index before merge has to match HEAD" rule,
the first one could have been written as:

	git-diff-index -p HEAD xyzzy ;# to compare with ours

So in that sense, I suspect it may not be too bad if we just
changed merge-one-file with the patch at the end.

However, git-diff-index HEAD without paths restriction would
show everything the merge brought in, not just the conflicting
path, so in that sense it may make things slightly harder for
the end user to use.

---

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index c3eca8b..df6dd67 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -79,11 +79,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	# We reset the index to the first branch, making
-	# git-diff-file useful
-	git-update-index --add --cacheinfo "$6" "$2" "$4"
-		git-checkout-index -u -f -- "$4" &&
-		merge "$4" "$orig" "$src2"
+	# Leave the conflicts in stages; failed merge result can be
+	# seen by "git-diff-index HEAD" or "git-diff-index MERGE_HEAD"
+	rm -fr "$4" &&
+	    git-cat-file blob "$2" >"$4" &&
+	    case "$6" in *?7??) chmod +x "$4" ;; esac &&
+	    merge "$4" "$orig" "$src2"
 	ret=$?
 	rm -f -- "$orig" "$src2"
 
