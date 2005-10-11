From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 00:37:57 -0700
Message-ID: <7vy850v6zu.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 09:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPEj4-0006TS-DU
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 09:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVJKHh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVJKHh7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 03:37:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35829 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751405AbVJKHh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 03:37:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011073759.MMRX9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 03:37:59 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87mzlgh8xa.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of
	"Mon, 10 Oct 2005 23:20:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9959>

Paul Eggert <eggert@CS.UCLA.EDU> writes:

> The convention I had been thinking of adding is to have GNU diff
> use shell-quoting style, e.g.,
>
> 'three
> o'\''clock'
>
> to represent a file name with a newline and an apostrophe in it.
> This sort of file name can be cut and pasted into the shell.
> The quoting could be used with any file name containing a
> troublesome character.
>
> Perhaps another quoting style would be better.

A patch header (both "diff --git" line and ---/+++ lines) I've
been considering, and have in the proposed updates branch, looks
something like this:

    diff --git a/def\nghi/pqr b/dee/pqr
    similarity index 72%
    rename from def\nghi/pqr
    rename to dee/pqr
    index 9ee055c..243fbbc 100644
    --- a/def\nghi/pqr
    +++ b/dee/pqr
    @@ -1 +1,3 @@
     Fri Oct  7 23:19:04 PDT 2005
    +foo
    +foo

If we can keep things on one line, that would help parsing the
stuff very simple, but more importantly, it is easier to see
what's happening.  The pattern is the same whether you have
funny pathnames or not, and that helps the human consumer.

Adjusting the "git diff" output to the style the GNU diff with
your shell quoting style would produce something like this:

    diff --git 'a/def
    ghi/pqr' b/dee/pqr
    similarity index 72%
    rename from 'def
    ghi/pqr'
    rename to dee/pqr
    index 9ee055c..243fbbc 100644
    --- 'a/def
    ghi/pqr'
    +++ b/dee/pqr
    @@ -1 +1,3 @@
     Fri Oct  7 23:19:04 PDT 2005
    +foo
    +foo

Which, while it is possible to make tools parse them, is very
distracting for humans to read and review.  Yes, LF is quoted,
but it still breaks the line, disrupting the pattern we are used
to see.  If you are talking about a funny file, whose name is
"a\ndiff --git a/b/c", your diff would look like this:

    diff --git 'a/
    diff --git a/b/c' 'b/
    diff --git a/b/c'
    index 9ee055c..243fbbc 100644
    --- 'a/
    diff --git a/b/c'
    +++ 'b/
    diff --git a/b/c'
    @@ -1 +1,3 @@
     Fri Oct  7 23:19:04 PDT 2005
    +foo
    +foo

We are used to tell the "less" command to do "/^diff --git .*"
while reviewing patches.  The shell quoting, while I admit I
learned its beauty from you, is a disaster for human consumption.

For diff output quoting purposes, LF is the only thing that
matters, as you mentioned in another message to me.  Our parsing
side ("GNU patch" counterpart) checks two pathnames on "diff
--git" line and makes sure what follows a/ and b/ are consistent
(that is, they should be identical, or each are the same as
"rename from" and "rename to"), so there is no ambiguity.  But
again for human consumption purposes, we cannot easily tell SP
and TAB apart by just reading, and a TAB is so unusual character
to have in pathname (as opposed to SP which is not that
uncommon), we may be better off making them visible.

Quoting TAB incidentally has an added benefit, which you as GNU
diff/patch person would probably not care too much about.  Our
other tools sometimes need to show two paths in one record, and
TAB is used as the field separator between two paths (LF is the
record separator).  The tools do have '-z' mode to let us use
anything but NUL in the pathname, and carefully written scripts
tend to run them with '-z' flag and use Perl or Python to parse
paths out, but it would be nicer if we did not always have to.

For example, the 'git commit' command prepares the log editor
with the status information about changes being committed, and
needs to mention paths.  This is purely for human consumption,
and showing something like:

	# Type commit message to this file.  Lines that start
        # with '#' are ignored.
        #
        # Updated but not checked in:
        #   (will commit)
        #
        #	new file: ab\n\tc/mno
        #	modified: abc/mno
        #	renamed: def\nghi/pqr -> dee/pqr
        ...

is perfectly readable for human users, and can be done without
running the tool in '-z' mode, if the tool output is quoted with
'\n' and '\t' convention -- the parsing and formatting side can
just split the field with TAB and show them, without worrying
about an embedded LF making the rest of the pathname spilling
over to the next line.  And once we start teaching the user we
represent funny characters in their paths this way, it becomes
nicer to be consistent in the diff output as well.
