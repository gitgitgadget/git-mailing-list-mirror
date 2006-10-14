From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Sat, 14 Oct 2006 03:26:43 -0700
Message-ID: <7vwt739org.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 14 12:27:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYgjN-00027T-0M
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 12:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWJNK0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 06:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWJNK0p
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 06:26:45 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39642 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752131AbWJNK0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 06:26:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061014102644.EEOT22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 06:26:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aASm1V00X1kojtg0000000
	Sat, 14 Oct 2006 06:26:47 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Oct 2006 18:43:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28872>

Junio C Hamano <junkio@cox.net> writes:

> 4. Passing more blame.
>
> Instead of taking responsibility for the remainder, there are
> other ways to find other people to pass blame on.  That's what
> the "NEEDSWORK" comment in pass_blame() is about.

I've spent a few hours tonight to further work (eh, "have fun")
on this.  The version at the tip of "pu" implements detection of
a case like this:

> A typical example is a change that moves one static C function
> from lower part of the file to upper part of the same file,
> because you added a new caller in the middle.  The path in your
> parent and the path in you would look like this:
>
>         parent                          you
>
>         A                               static foo() {
>         B                               }
>         C                               A
>         D                               B
>         E                               C
>         F                               D
>         G                               ... call foo();
>         static foo() {                  E
>         }                               F
>         I                               G
>         J                               I
>
> With the common part finding code with diff, you will be able to
> pass blames for lines A B C D E F G I J to your parent.  You are
> truly guilty for introducing "... call foo();".  The problem
> here is that in addition, you will be blamed for the lines that
> implement "static foo() { ... }" at the beginning of your file.

You can use the pickaxe on its source itself, like this:

	git pickaxe -n master..pu builtin-pickaxe.c

If you compare this with output from:

	git log --pretty=short -p master..pu builtin-pickaxe.c

you will notice the line-movement detection in action.

During the course of development, I had to move quite a few
static functions around so that they are defined before their
first call site.  This is partly because I am very bad at
initial planning (who is?) and this still being in experimental
stage I did not bother declaring static functions upfront as
forward declarations.

For example, commit db3f0f2 introduces find_last_in_target()
function, but it was moved up by commit b5c0e4f (near the tip of
"pu").  pickaxe blames the implementation of it to db3f0f20, and
also notices that the bulk of its logic was actually copied from
the implementation of pass_blame_to_parent() function in commit
b14dc9ef (the initial commit that introduced builtin-pickaxe.c).

What _ought_ to come next is to detect line movement across
files, but I'll go to bed for now.
