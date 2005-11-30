From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 12:05:12 -0800
Message-ID: <7vsltdsxzb.fsf@assigned-by-dhcp.cox.net>
References: <20051128234256.1508.qmail@science.horizon.com>
	<7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301235390.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 21:13:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhYCo-0006kd-1V
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 21:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVK3UFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVK3UFS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 15:05:18 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19184 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750707AbVK3UFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 15:05:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130200401.VPMF26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 15:04:01 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511301235390.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 30 Nov 2005 12:46:00 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13014>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 28 Nov 2005, Junio C Hamano wrote:
>
>> *1* It is a shame that the most comprehensive definition of
>> 3-way read-tree semantics is in t/t1000-read-tree-m-3way.sh test
>> script.
>
> Isn't Documentation/technical/trivial-merge.txt more comprehensive?

It describes the multi-base extention while the old one was done
before the multi-base, so content-wise it may be more up to date.

One thing I have most trouble with is that it is not obvious if
the table is covering all the cases.  You have to read from top
to bottom and consider the first match as its fate [*1*].  I was
about to write "with no match resulting in no merge", but it is
not even obvious if there are cases that would fall off at the
end from the table by just looking at it.  Even worse, if we add
"no match results in no merge" at the end, by definition it
covers all the cases, but it is not obvious what those fall-off
cases are (IOW, what kinds of conflict they are and why they are
not handled).

Another thing, perhaps more important, is taht it does not seem
to talk about index and up-to-dateness requirements much; it
says something about what happens when "no merge" result is
taken, but it is not clear about other cases.  The table in
t1000 test marks the case with "must match X" when index and
tree X must agree at the path, and with "must match X and be
up-to-date" when in addition the file in the working tree must
match what is recorded in the index at the path (i.e. the former
can have local modification in the working tree as long as index
entry and tree match).

This is vital in making sure that read-tree 3-way merge does not
lose information from the working tree.  I am sure your updated
*code* is doing the right thing, but the documentation is not
clear about it.  E.g. case 3ALT in the table says "take our
branch if the path does not exist in one or more of common
ancestors and the other branch does not have it" without saying
anything about index nor up-to-dateness requirements.  In this
case, the index must match HEAD but the working tree file is
allowed to have local modification (t1000 table says "must match
A").  If somebody wants to audit if the current read-tree.c does
the right thing for this case, he needs the documentation to
tell him what should happen.  There may be thinko in the design
(IOW, the index requirements the documentation places may not
make sense) that can be found during such an audit.  There may
be implementation error that the code does not match what the
documentation says should happen.  Not having that information
in the case table makes these verification difficult.

> Probably the tables in various other places should be replaced with 
> references to this document.

I agree 100% that having them scattered all over is bad and the
trivial-merge.txt is the logical place to consolidate them, but
I do not think simply removing others and pointing at
trivial-merge.txt without updating it is good enough.

[Footnote]

*1* That is OK from an implementation point of view (i.e. we can
look at the table, and then go to C implementation and follow
its if-elif chain to see if the same checks are done in the same
order as specified in the document), but for somebody who wants
to understand the semantics, i.e. what the thing it does means,
by looking at the documentation it is harder to read.
