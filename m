X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some advanced index playing
Date: Mon, 04 Dec 2006 02:41:49 -0800
Message-ID: <7vveksoscy.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031008360.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 10:42:03 +0000 (UTC)
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 3 Dec 2006 10:24:11 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33183>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrBGj-0000XD-UU for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758977AbWLDKlv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758983AbWLDKlv
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:41:51 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63114 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1758972AbWLDKlu
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:41:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204104150.EHXC4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 05:41:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uahF1V0011kojtg0000000; Mon, 04 Dec 2006
 05:41:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I think that is actually a misfeature. 
>
> This _should_ just work. It's the easy and logical way to do it, and it's 
> the one that matches all the other behaviours of "git commit" these days.
> ...
> So anyway, I would suggest that we just get rid of that partial commit 
> "safety check" in "git commit" for now. It still makes sense for when 
> you're in the middle of a _merge_, but the "verify that index matches" is 
> not worth it.

The codepath has a big "don't do this during a merge" check in
front.  I think this is a safe thing to do, so let's do this.

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..c829791 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -350,19 +350,9 @@ t,)
 			refuse_partial "Cannot do a partial commit during a merge."
 		fi
 		TMP_INDEX="$GIT_DIR/tmp-index$$"
-		if test -z "$initial_commit"
-		then
-			# make sure index is clean at the specified paths, or
-			# they are additions.
-			dirty_in_index=`git-diff-index --cached --name-status \
-				--diff-filter=DMTU HEAD -- "$@"`
-			test -z "$dirty_in_index" ||
-			refuse_partial "Different in index and the last commit:
-$dirty_in_index"
-		fi
 		commit_only=`git-ls-files --error-unmatch -- "$@"` || exit
 
-		# Build the temporary index and update the real index
+		# Build a temporary index and update the real index
 		# the same way.
 		if test -z "$initial_commit"
 		then
