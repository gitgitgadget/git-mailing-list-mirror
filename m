From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] threeway_merge: if file will not be touched, leave it
 alone
Date: Mon, 23 Oct 2006 02:48:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610230228340.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
 <45391F1C.80100@utoronto.ca> <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
 <4539318D.9040004@utoronto.ca> <Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
 <Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610222301080.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkn80wv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 02:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbnzI-00027U-N3
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 02:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWJWAsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 20:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWJWAsR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 20:48:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:57800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750984AbWJWAsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 20:48:16 -0400
Received: (qmail invoked by alias); 23 Oct 2006 00:48:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 23 Oct 2006 02:48:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkn80wv2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29809>

Hi,

On Sun, 22 Oct 2006, Junio C Hamano wrote:

> Complaining when no_anc_exists means that threeway_merge() is deciding 
> that the merge result should have the path in this case.

Two points:

- you are correct for at least the case of choosing the merge strategy 
"theirs". (Which does not exist yet.)

- in merge-recursive.c:process_entry() (which is called on _all_ unmerged 
entries after threeway merge), "Case A" reads "deleted in one branch". 
Reading the code again, I believe there is a bug, which should be fixed by

diff --git a/merge-recursive.c b/merge-recursive.c
index 2ba43ae..9f6538a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1005,9 +1005,10 @@ static int process_entry(const char *pat
 		    (!a_sha && sha_eq(b_sha, o_sha))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
-			if (a_sha)
+			if (!a_sha) {
 				output("Removing %s", path);
-			remove_file(1, path);
+				remove_file(1, path);
+			}
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;

Note that not only it groups the call to output() and remove_file(), which 
matches the expectation, but also changes the condition to "!a_sha", 
meaning that the file is deleted in branch "a", but existed in the merge 
base, where it is identical to what is in branch "b".

Of course, this assumes that even in the recursive case, branch "a" is to 
be preferred over branch "b". (If I still remember correctly, then branch 
"a" is either the current head, or the temporary recursive merge, so this 
would make sense to me.)

So, after applying this patchlet, merge-recursive (more precisely: the 
function process_entry()) should behave correctly with the change to 
unpack-trees.c you have in pu, i.e. the change that drops that 
verify_absent() call to the floor.

However, I could use some additional optical lobes here.

Ciao,
Dscho

P.S.: Maybe I was wrong on my earlier assessment, that merge-recursive 
does not optimize the "subtrees have identical SHA1s" case. This should be 
handled pretty well by the call to unpack_trees() with threeway merge.
