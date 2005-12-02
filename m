From: Junio C Hamano <junkio@cox.net>
Subject: Re: More merge questions (why doesn't this work?)
Date: Fri, 02 Dec 2005 12:31:35 -0800
Message-ID: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net>
References: <20051202113713.11618.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 21:35:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiHZE-0000Jg-3r
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 21:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVLBUbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVLBUbh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 15:31:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38048 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751057AbVLBUbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 15:31:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202203026.TPDR17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 15:30:26 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13123>

linux@horizon.com writes:

> Um, I'm looking at the one-side remove case, which t/t1000 calls
>
>      O       A       B         result      index requirements
> -------------------------------------------------------------------
>  10  exists  O==A    missing   remove      ditto
>  ------------------------------------------------------------------
>
> while trivial-merge.txt says is:
>
> case  ancest    head    remote    result
> ----------------------------------------
> 10    ancest^   ancest  (empty)   no merge
>
> I assumed the test case was probably more accurate, given that it's coupled
> to code which actually verifies the behaviour.

You are right.  And the test expects something different from
that table in t/t1000 test.  Relevant are the lines for ND (one
side No action the other Delete) in the "expected" file.  The
test expects the result to be unmerged.

Interesting is that it did so from the day one [*1*].  The very
original read-tree 3-way was quite conservative and left more
things unmerged for the policy script to handle, and it is not
surprising it started like this, but during the course of the
project I thought read-tree was made to collapse more cases in
index.  I am a bit surprised we did not loosen it ever since
[*2*].  Thanks for pointing out the discrepancy.

We earlier agreed that the table in t/t1000 test should go and
superseded by trivial-merge.txt, so what the table says right
now is a non-issue, but we _might_ want to revisit the issue of
what should happen in case #8 and #10 sometime in the future, as
the last three lines of trivial-merge.txt mentions.  I'd say we
should leave things as they are for now, though.

>  --reset::
> -
> -        Same as -m except that unmerged entries will be silently ignored.
> +        Same as -m except that unmerged entries will be silently overwritten
> +	(instead of failing).

Thanks.

> "Do something really complicated and then commit it to the repository"
> is a frightening concept.  "Do something really complicated and
> then stop and wait for you to see if it was what you expected" is
> a lot more comforting.

Fair enough.

>>> 7) The git-tag man page could use a little better description of -a.
>
>> Please.  It should have the same "OPTIONS" section as others do.
>
> I know NOTHING about asciidoc, and really wish I could fix its
> lack-of-line-break problem:

Thanks for pointing that one ont.  I think Josef recently did
similar linebreak on git-mv page.  I'll try and see if I can
mimic what he did [*3*].

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 95de436..7635b1e 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt

Thanks; applied.  

[Footnotes]

*1* A pickaxe example:

	$ git whatchanged -p -S'100644 1 ND
          100644 2 ND'

shows only two commits.  One is the first version of the test,
and the other is to adjust for the output format from 

*2* Further archaeology revealed that I did loosening primarily
for the 2-way side, and did not touch much about 3-way merge
other than what used to be marked with ALT.  There was no 10ALT
ever so it shows that my memory is simply faulty ;-).

*3* I did that, and it renders HTML side nicer, but it breaks
manpages X-<.  Inputs from asciidoc gurus are appreciated.
