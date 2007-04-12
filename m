From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase, please help
Date: Thu, 12 Apr 2007 13:37:34 -0700
Message-ID: <7v7ishjpm9.fsf@assigned-by-dhcp.cox.net>
References: <200704110852.00540.litvinov2004@gmail.com>
	<7v8xczqs1q.fsf@assigned-by-dhcp.cox.net>
	<200704111110.18461.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexander Litvinov <litvinov2004@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc632-00086p-Uw
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 22:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXDLUhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbXDLUhh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 16:37:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55967 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbXDLUhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 16:37:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412203735.GMGE1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 16:37:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mLda1W00S1kojtg0000000; Thu, 12 Apr 2007 16:37:35 -0400
In-Reply-To: <200704111110.18461.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 11 Apr 2007 11:10:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44351>

Andy Parkins <andyparkins@gmail.com> writes:

> This is interesting and brings to mind a difficult I've had.
> I had problems with rebase when rebasing chains with a file
> that was self-similar.  Indulge me for a while with this
> example (forgive the C++, but that's where I had this
> problem):
>
> class A : public C
> {
>    // ...
>
>    int someVirtualOverride(n) { return ArrayA[n]; }
>
>    // ...
> }
>
> class B : public C
> {
>    // ...
>
>    int someVirtualOverride(n) { return ArrayB[n]; }
>
>    // ...
> }
>
> One patch changed "ArrayX[n]" to "Array.at(n)" and another inserted more 
> similar classes around these two.
>
> When I was rebasing, some strange things happened (without any conflict 
> warnings):
>
> class D : public C
> {
>    int someVirtualOverride(n) { return ArrayA.at(n); }
> }
>
> class A : public C
> {
>    int someVirtualOverride(n) { return ArrayB.at(n); }
> }
>
> class B : public C
> {
>    int someVirtualOverride(n) { return ArrayB[n]; }
> }
>
> Notice that the arrays don't match up with the classes.  By
> some crazy coincidence and the strong similarity between
> localities within the file, the patch successfully applied in
> the wrong place.

A patch that can ambiguously apply to multiple places is indeed
a problem, and in such situations merge based rebase is probably
safer as it can take advantage of the whole file as the context.

But it brings up another interesting point.  The ambiguous patch
is a problem even more so outside the context of rebasing, for
another reason.  When rebasing, you are dealing with your own
changes and you know what and how you want each of them to
change the tree state, as opposed to applying somebody else's
patch outside the context of rebasing.

When we only have the patch text (i.e. applymbox), there is no
"merge to use the whole file as the context" fallback.  I wonder
if this is a common enough problem that we would want to make it
safer somehow...

[jc: Since I happen to know somebody who applies more patches in
     one week than anybody else would ever apply in the lifetime
     ;-), I am CC'ing that person]

I can see two possible improvements.

 - On the diff generation side, we could notice that the hunk
   we are going to output can be applied to more than one
   location, and automatically widen the context for it.

   This is only a half-solution, as many patches do not even
   come from git.

 - Inside git-apply, apply_one_fragment(), ask find_offset() if
   the hunk can match more than one location, and exit with an
   error status (still writing out the patch results if it
   otherwise applies cleanly) so that the user can manually
   inspect and confirm.
