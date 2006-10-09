From: Junio C Hamano <junkio@cox.net>
Subject: Obituary for git-annotate
Date: Mon, 09 Oct 2006 15:33:43 -0700
Message-ID: <7v3b9xazlk.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
	<20061005064817.21552.qmail@web31804.mail.mud.yahoo.com>
	<7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
	<20061009103710.GX1558@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Oct 10 00:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX3hG-0000r4-HV
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWJIWdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWJIWdp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:33:45 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54269 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751297AbWJIWdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 18:33:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009223344.CRZU16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 18:33:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YNZm1V00l1kojtg0000000
	Mon, 09 Oct 2006 18:33:47 -0400
To: git@vger.kernel.org
In-Reply-To: <20061009103710.GX1558@h4x0r5.com> (Ryan Anderson's message of
	"Mon, 9 Oct 2006 03:37:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28580>

Ryan Anderson <ryan@michonline.com> writes:

> On Thu, Oct 05, 2006 at 01:13:15AM -0700, Junio C Hamano wrote:
>> It's been a while since we lost git_blame from %actions list.  I
>> am wondering maybe it's time to remove it, after 1.4.3 happens.
>
> I certainly have no objection.  In fact, I sent a patch a moment ago.
> (I didn't keep the cc: on it, I figured there was too high a chance of
> mishap when pasting the cc: list.)

So it's finally settled between annotate and blame.  It is kind
of sad to see one of them had to go while these stem from
slightly different algorithm sketches [*1*].  But for 8 months
of its existence, it served us well as the git-cvsserver
backend.  May it rest in peace.

Having said that, there are a few things in git-blame that
interested people may want to further look into.

Annotation by git-blame is done by "passing the blame to
parents" principle.  You start from the final form of the blob,
and compare it with its counterpart in the parent version
(rename detection is used to pick which file in the parent
version to compare against).  The lines the commit inherited
from its parent are not responsibility of the child so the
algorithm passes blame on them to the parent.  The lines the
commit changed from the parent are blamed on the child.  

When this is done, the parent "temporarily" takes responsibility
for those lines that child did not change -- it just becomes
"suspect" for those lines when we compare parent and child.  And
then the algorithm goes further down the ancestry to give the
parent the chance to exonerate itself by passing blames for the
lines it is suspect for, by passing the blame to its parent.

When sifting the lines into "inherited" and "our
responsibility", internally git-blame runs "diff", which
expresses the changes as "these lines are deleted and these are
inserted by the child".  Lines outside are clearly inherited
from the parent.

This has an interesting effect on blame output.  

Suppose the original file had two groups of lines; group A
followed by group B.  A commit changes the file so that it has
group B followed by group A.  What git-blame sees as diff
between the two is either:

    -A
     B
    +A 

or

    +B
     A
    -B    

In either case, it would end up giving blame to the child for
one group (the first diff blames the child for A lines) and pass
the blame for the other one to the parent.

If we used something other than "diff" (Delete Insert File vs
File ;-)), that expresses changes as "these are moved from
there, these are inserted anew" (call that "miff"), then we
should be able to assign blame more accurately.  The above
example case would be expressed as "group A came from the top
part of the parent, group B came from the bottom part of the
parent".  Passing of the blame based on that expression would
blame the child for neither group of lines.

Further, if we use "ciff" that expresses changes as "these are
copied from there, these are inserted anew", we can do a lot
more interesting thing.  We can track code movement across
files, and that is not limited to renames.

For example, suppose that the parent had files F1 and F2 and the
child moved a function and copy-and-pasted a comment block from
F1 to F2, and we are annotating lines in F2.

The current git-blame sees that the function and comment block
appeared from nowhere into F2 and blames the child for them.
However, when annotating F2, we could:

 - use concatenation of all files in the parent that was
   modified between parent and child (or just "all files in the
   parent" -- the difference is exactly like plain -C vs -C
   --find-copies-harder) as the source image;

 - use lines of F2 in the child as the destination image;

 - run "ciff" algorithm to see where each line of F2 in the
   child came from (either copied from existing file somewhere
   in the parent, or inserted anew by the child).

This would find that the function and the comment block were
copied from F1 in the parent.

An interesting property of this is that when the parent passes
down the blame for the function the child moved in the above
example further to its parent, we do not necessarily have to run
"ciff" algorithm on file F1 as the whole.  We only need to give
the function (i.e. the lines the parent is still suspect for)
[*2*].  So this makes destination image fed to "ciff" smaller as
more lines are blamed on children while digging deeper, which
may compensate for the need to feed not just that file but other
files for copy detection on the source image side.


[*1*]

I think annotate follows this sketch
http://thread.gmane.org/gmane.comp.version-control.git/14819/focus=14867

while blame follows this sketch
http://thread.gmane.org/gmane.comp.version-control.git/5453/focus=5483


[*2*]

we may need to use a handful surrounding context lines for
better identification of copy source by the "ciff" algorithm but
that is a minor implementation detail.
