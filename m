From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 15:27:03 -0700
Message-ID: <7vmz28g98o.fsf@assigned-by-dhcp.cox.net>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
	<45FED31B.8070307@midwinter.com>
	<slrnevtqaq.1df.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:27:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQJs-0008TD-5d
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 23:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbXCSW1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXCSW1H
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 18:27:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52484 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbXCSW1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 18:27:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319222704.LDDH1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 18:27:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cmT31W00n1kojtg0000000; Mon, 19 Mar 2007 18:27:04 -0400
In-Reply-To: <slrnevtqaq.1df.jgoerzen@katherina.lan.complete.org> (John
	Goerzen's message of "Mon, 19 Mar 2007 14:49:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42675>

John Goerzen <jgoerzen@complete.org> writes:

> But if most of my work is hacking directly on the code, I am going to
> know better than the VCS what is being renamed, and would like to record
> that.  Sometimes the filenames are part of the code.
>
> I want the option.

This depends on what you want to do with that recorded rename.

Let's say you renamed foo.py to bar.py, but the content changed
so much while you renamed the file that it is no longer similar
enough for the default similarity threshold to consider them a
renamed pair.

Then you run:

	$ git log bar.py

and against your expectation, it says "the history of that name
ends here --- you created this file at this point from zero".

Now, what would you do at this point, of course after an
obligatory "f*ck, stupid tool" cussing?

You would do "$ git show -M" and you would not see the rename,
because we are assuming that the similarity is smaller than the
default threashold.

But it's your project and you know better than the tool.  You
know that bar.py used to be called foo.py.  So you can do:

	$ git diff $commit^:foo.py $commit:bar.py

if you cared what huge change you did while renaming, and then
continue digging from that point, perhaps with:

	$ git log $commit^ -- foo.py

Earlier, I said "you know better than the tool", but that is a
slight lie.  You probably knew better than the tool back when
you made that commit, but you cannot be better than any tool to
remember that 10 years (or 6 months) after making that commit.

That's why you need to record somewhere you renamed foo.py to
bar.py in this commit.

We happen to have a perfect place to record such a rename and it
is called the commit log message.  If a rename matters *so* much
to your project, you not only would want to record the fact that
you renamed it, but you would want to record *WHY*, and the
commit log message is the perfect place to do both.

A single path being renamed is a special case of content
movement across file boundaries.  Pairwise diff that "git log
-p" gives cannot express one file being split into two or two
file merged into one, and that is independent of explicitly
recorded rename or inferred one.  We already have a better
solution for that general problem and it is called git-blame.

By the way, blame is not perfect.  One thing I sometimes find
lacking from it is that it only shows the final assignment of
the blame.  Often, a development goes like (1) code evolves in
two or more different files, (2) at one point somebody goes in
and cleans things up to move the duplicated code from these
files and consolidate into one file, (3) and the refactored
results gets polished further, drastically changing.  Many
times, step (2), especially when done by a competent person, is
done carefully not to change the logic of the code to avoid
regression, and lines from that revision does not appear in the
end result of the blame.

This is good when the reason why you are reading the blame
output is to figure out *why* a block of lines in the current
code is written that way (you do not care about the
restructuring history, but care more about the origin of the
code and the reasoning behind why it is that way), but when
doing archaeology sometimes I wish what happened in step (2) can
also be shown a bit more prominently in the final output.
