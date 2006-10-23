From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] threeway_merge: if file will not be touched, leave it alone
Date: Sun, 22 Oct 2006 21:17:37 -0700
Message-ID: <7vejszzmvy.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	<200610202047.11291.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
	<45391F1C.80100@utoronto.ca>
	<Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
	<4539318D.9040004@utoronto.ca>
	<Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
	<Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610222301080.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkn80wv2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610230228340.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 06:17:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbrFu-0003nN-T5
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 06:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWJWERj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 00:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWJWERj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 00:17:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5312 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751461AbWJWERi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 00:17:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061023041738.CJEU16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Oct 2006 00:17:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dgHN1V0071kojtg0000000
	Mon, 23 Oct 2006 00:17:22 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610230228340.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 23 Oct 2006 02:48:14 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29815>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2ba43ae..9f6538a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1005,9 +1005,10 @@ static int process_entry(const char *pat
>  		    (!a_sha && sha_eq(b_sha, o_sha))) {
>  			/* Deleted in both or deleted in one and
>  			 * unchanged in the other */
> -			if (a_sha)
> +			if (!a_sha) {
>  				output("Removing %s", path);
> -			remove_file(1, path);
> +				remove_file(1, path);
> +			}
>  		} else {
>  			/* Deleted in one and changed in the other */
>  			clean_merge = 0;
>
> Note that not only it groups the call to output() and remove_file(), which 
> matches the expectation, but also changes the condition to "!a_sha", 
> meaning that the file is deleted in branch "a", but existed in the merge 
> base, where it is identical to what is in branch "b".

I think the conditional "output" is to mimic the first case in
git-merge-one-file; there we conditionally give that message
only when ours had that path.  If we lost the path while they
have it the same way as the common ancestor, then we do not have
the path to begin with when we start the merge.  It is not
correct to say "Removing" in such a case.

So the output() call being tied to if (a_sha) _is_ correct in
your code.

What we would want to prevent is to remove the path from the
working tree when we did not have the path at the beginning of
the merge and the merge result says we do not want that path.
In such a case, the file in the working tree is an untracked
file that is not touched by the merge.

E.g gitweb/gitweb.cgi is not tracked in the current "master",
but used to be around v1.4.0 time.  If you try to merge a
branch forked from v1.4.0 because you are interested in a work
on other part of the system (i.e. the branch did not touch
gitweb/ at all), we want to successfully merge that branch into
our "master" even after "make" created gitweb/gitweb.cgi.

Such a merge would start with your HEAD and index missing
gitweb/gitweb.cgi but the path still in your working tree.  The
common ancestor and their tree has the path tracked, so you
would end up with identical stage #1 and #3 with missing stage
#2.

The merge machinery should say the merge result does not have
the path, so it should remove it from the index.  However, it
should _not_ touch the untracked (from the beginning of the time
the merge started) working tree file.  So remove_file() call you
touch in your patch needs to be told not to update working
directory in such a case.

Under "aggressive" rule, threeway_merge() is requested to make
the merge policy decision, so it should also loosen this check
itself.  The change by commit 0b35995 needs to be updated with
this patch:

diff --git a/unpack-trees.c b/unpack-trees.c
index b1d78b8..7cfd628 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -642,7 +642,7 @@ int threeway_merge(struct cache_entry **
 		    (remote_deleted && head && head_match)) {
 			if (index)
 				return deleted_entry(index, index, o);
-			else if (path)
+			else if (path && !head_deleted)
 				verify_absent(path, "removed", o);
 			return 0;
 		}
