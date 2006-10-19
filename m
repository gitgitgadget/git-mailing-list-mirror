From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 20:16:02 +0200
Message-ID: <878xjckw7x.fsf@rho.meyering.net>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bug-diffutils@gnu.org,
	Paul Eggert <eggert@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Thu Oct 19 20:16:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GacR7-0005Sc-UE
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 20:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946304AbWJSSQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946306AbWJSSQG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 14:16:06 -0400
Received: from mx.meyering.net ([82.230.74.64]:57277 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1946304AbWJSSQE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 14:16:04 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id EB537825; Thu, 19 Oct 2006 20:16:02 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 19 Oct 2006 09:19:52 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29376>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> I noticed a case not handled in a recent patch.
>
> Thanks. Will apply.
>
> Curiously your patch was whitespace damaged.

I wondered what you meant, so compared what I sent
with the output of the command I ran:

  git-format-patch --stdout --signoff HEAD~1

There were two differences, both involving removed trailing blanks.
The first was a part of the diff: a line consisting of a single space
denoting an empty line in the context.  I understood that those types
of lines may safely be truncated (removing the trailing blank),
and in fact, GNU diff -u (cvs) now does this by default:

2006-09-05  Paul Eggert  <eggert@cs.ucla.edu>

        * NEWS: diff -u no longer outputs trailing white space unless the
        input data has it.  Suggested by Jim Meyering.
        * doc/diff.texi (Detailed Unified): Document this.
        * src/context.c (pr_unidiff_hunk): Implement this.

The only other difference was the removal of the trailing blank following
the "--" signature introducer.

I see that git-apply does not handle this new format:

  $ git-apply patch
  fatal: corrupt patch at line 47

That diagnostic comes from builtin-apply.c:

		if (len <= 0)
			die("corrupt patch at line %d", linenr);

It would be nice if git would accept such unified diff output,
since no other program we know of rejects them.  Paul Eggert has
even submitted revised wording to make POSIX allow this style
of output.

For reference, the GNU diff thread started here:
  http://lists.gnu.org/archive/html/bug-gnu-utils/2006-09/msg00005.html
