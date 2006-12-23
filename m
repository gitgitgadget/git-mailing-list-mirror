From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 01:51:03 -0800
Message-ID: <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061223051210.GA29814@segfault.peff.net>
	<7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 10:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy3XA-0006qJ-Co
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 10:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWLWJvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 04:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLWJvI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 04:51:08 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47755 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbWLWJvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 04:51:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223095104.BXCC3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 04:51:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 29qM1W00B1kojtg0000000; Sat, 23 Dec 2006 04:50:22 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 22 Dec 2006 22:15:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35309>

Junio C Hamano <junkio@cox.net> writes:

> Jeff King <peff@peff.net> writes:
>
>> BTW, is there some explanation why branch.*.merge specifies a _remote_
>> head? The following would make much more sense to me:
>>
>> [branch "master"]
>> remote = origin
>> merge = refs/remotes/origin/master
>
> Only *if* you store it in that tracking branch.  The name the
> other party gives _do_ matter to you anyway, because you have to
> _know_ it to fetch.  What it does NOT matter is if you use a
> tracking branch, or if you do, which local tracking branch you
> use to track it.

Having said that, I think we _could_ do this.

If you (or other people) use branch.*.merge, with its value set
to remote name _and_ local name, and actually verify that either
form works without confusion, please report back and I'll apply.

My scar is still fresh from the "not having branch.*.merge is an
error" mistake, where the thing stayed on 'next' for the better
part of last week without anybody complaining, and immediately
broken peoples' workflows when it was pushed out to 'master'.

I really do not want to repeat that.

-- >8 --

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index aaef861..b45af5c 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -146,8 +146,13 @@ canon_refs_list_for_fetch () {
 		else
 			for merge_branch in $merge_branches
 			do
-			    [ "$remote" = "$merge_branch" ] &&
-			    dot_prefix= && break
+			    if	test "$remote" = "$merge_branch" ||
+				test "z$local" != z &&
+			    	test "$local" = "$merge_branch"
+			    then
+				    dot_prefix=
+				    break
+			    fi
 			done
 		fi
 		case "$remote" in
