From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Possible bug] diff-tree --stat info does not count copies
Date: Thu, 17 Aug 2006 21:09:13 -0700
Message-ID: <7v8xlmelcm.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550608170219q12fcb34ewf93a195eabe0b94a@mail.gmail.com>
	<7vveorsnt3.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550608170354i45104458h3b7e2ec8c668fb9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfj-0002KC-3b
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWHREJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWHREJR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40432 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030236AbWHREJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040914.YNJY23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:14 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25625>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 8/17/06, Junio C Hamano <junkio@cox.net> wrote:
>
>> Interesting.  That's really a matter of taste and interpretation.
>>...
>
> If it was a rename we had something like:
>
> diff-lib.c                  | 1795 -----------------------------------------
> diff.c                        | 1795 ++++++++++++++++++++++++++++++++++++++++
>
> and, with -C
>
> diff-lib.c => diff.c          |    0
>
> and _this_ is correct. But with copy  diff-lib.c => diff.c  should not
> stay at zero lines changed because diff.c is not the same of
> diff-lib.c, but it's a _new_ file created with the same content of
> diff-lib.c and _then_ the original and only diff-lib.c file is further
> modified on his own (in our case changing 1862 lines).
>
> Please tell me where I get wrong.

That's why I said this is a matter of taste and interpretation.
Our differences lie in what we expect from these numbers.  I do
not think your interpretation is wrong.  It is just different
from mine, and I happen to think my interpretation is more
useful for my purposes.

The numbers currently shown give "how big a patch do I have to
go through if I were to review this change in a patch form,
assuming I am reasonably familiar with the current, pre-image,
code?"  So straight copy does not count -- if the patch tells me
that new file diff.c has the same contents as old diff-lib.c,
then I know what the resulting diff.c would contain without
looking at the patch text to judge what its implications are
(including things like 'if file A.c is moved to sub/B.c, I know
A.c includes "C.h" and it needs to be adjusted to include
"../C.h").  In "copy plus edit" case, the change shown in the
diff text plus the fact that the file was copied from something
I know makes the patch part the only thing that needs to be
reviewed.  The same logic applies to rename with or without
editing.

What you expect seems to be different.  If I understand you
correctly, you are asking for the number of lines that need to
be touched (inserted and removed) in order to make the original
into the patched, when the source tree is taken as a whole.  I
do not think it is wrong to want to know that number, which is
pretty much the same number the command gives without -M/-C
[*1*].

To make this topic even more interesting, we can compare these
three commands:

    $ paths='diff-lib.c diff.c'
    $ git diff-tree -r --stat --summary 6973dca -- $paths
    $ git diff-tree -r --stat --summary -C 6973dca -- $paths
    $ git diff-tree -r --stat --summary -B -C 6973dca -- $paths

The last one says:

6973dcaee76ef7b7bfcabd2f26e76205aae07858
 diff-lib.c           | 1928 +++-----------------------------------------------
 diff-lib.c => diff.c |    0 
 2 files changed, 133 insertions(+), 1795 deletions(-)
 rewrite diff-lib.c (99%)
 rename diff-lib.c => diff.c (100%)

which, personally, I think tells the story closest to what
really happened for this change.  What was known to be
diff-lib.c was renamed to diff.c without any change, while
diff-lib.c was replaced by completely new contents, losing all
1795 lines that were there and acquiring 133 brand new lines.

In this case, I do not _need_ to look at the 1795 lines that
were lost from diff-lib.c to review the new implementation of
diff-lib.c, assuming that I am familiar with the pre-image code
(so what I said earlier about the number of lines I have to
review is not quite true, but is close enough).

[Footnote]

*1* But if that is the number you are after, then you should
count rename and copy the same way by saying rename removes N
lines and adds N lines (that happen to be the same) elsewhere,
so you would not say 0 is the right answer.
