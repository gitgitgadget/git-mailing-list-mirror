From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v4 1/3] Add test to describe expectation of blame
 --reverse with branched history
Date: Tue, 27 Oct 2015 06:40:50 +0200
Message-ID: <20151027044049.GA18120@wheezy.local>
References: <1445837217-4252-1-git-send-email-max@max630.net>
 <1445837217-4252-3-git-send-email-max@max630.net>
 <xmqqeggijga3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 05:41:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqw4I-0006JT-G3
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 05:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbbJ0ElA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 00:41:00 -0400
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:34859
	"EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbbJ0Ek7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 00:40:59 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-04.prod.phx3.secureserver.net with 
	id a4gp1r00E5B68XE014gxC4; Mon, 26 Oct 2015 21:40:59 -0700
Content-Disposition: inline
In-Reply-To: <xmqqeggijga3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280244>

On Sun, Oct 25, 2015 at 11:27:32PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> If history contains merges from feature branches, `blame --reverse`
>> reports not the commit when the line was actually edited, but head of
>> the last merged branch which was created before the edit.
>>
>> As a workaround, `blame --reverse --first-parent` could be used to find
>> the merge of branch containing the edit, but it was disabled in
>> 95a4fb0eac, because incorrectly specified range could produce in
>> unexpected and meaningless result.
>>
>> Add tests which describe ideal functionality with and without
>> `--first-parent`.
>>
>> Signed-off-by: Max Kirillov <max@max630.net>
>
> I _think_ I know why it would be useful to allow "--first-parent" to
> the command; it is useful the same way why "git log --first-parent
> $path" would be a good way to get an overview.
> 
> But I am puzzled by your complaints (I'd characterise the statement
> as such, given your second paragraph calls the combination a
> "workaround") in the first paragraph.  I honestly do not understand
> where it comes from at all.
> 
> The reverse blame begins from an old state and shows the most recent
> child in the history that each line survived to, and it does not
> show what commit removed the line from the original state.  And that
> does not have anything to do with the presence of any merges or
> forks in the history.  The command will always report "not the
> commit that edited the line."  There is nothing special about "If
> the history contains merges".
> 
> If you have this history, for example:
> 
>     D---E---F
>    /         \*
>   O           X---Y
>    \         /
>     A---B---C
> 
> where O had the original file, which was not touched by any commits
> on the branch on the upper side, and commit B rewrote all lines of
> the file, running blame in reverse may show A as the last point
> where all lines survived up to, if the "reversed" history happened
> to consider A as the earlier "parent" (in reality it is a child but
> blame is about assigning blame for each line from child to parents
> so in the reversed history, real children becomes parents).  Or it
> may show F as the last point where all lines survived up to, if D
> was picked as the earlier "parent".  Because there is no inherent
> ordering between A and D, both of which are children of O, your
> result is not necessarily "head of the last merged branch".
> 
> But I do not see how "first-parent" would be a workaround for that.
> The option would be useful to force the assignment of blame (in
> reverse) along the first-parent chain O---D---E---F---X---Y so that
> you can get a bird's-eye view of the history, i.e. squashing all
> that happened in A---B---C as if that happened at X.
> 
> The explanation of the first paragraph needs to be rewritten to make
> it understandable, but I am not sure what relevance it has with this
> change.

I understand how the blame works and why does it produce the
result which it used to produce. In one of my letter I
called it "technically correct, but absolutely useless", and
let me explain why I think so.

In a big project which uses the nowadays conventional topic
branches aka pull-requests aka however it's named workflow,
the history is a straigh first-parent chain with
short-living branches, which are forked from it, exists for
several days, then merged back and closed. When there are
many people working on a project, there can be tens of
merges during day, and average pull-request exists for
several days. So the history looks rather like (the
interesting line is removed in B1, line removal is
practically more interesting case because edits can be found
with normal forward blame):


 a0--a1-----*a2-*a3-a4...-*a100
 |\         /   /         /
 | b0-B1..bN   /         /
 |\           /         /
 | c0..   ..cN         /
 \                    /
  z0..            ..zN


...where many of the c-z branches started before a1 and
contain the older version of line. And, what I usually need
is the change b0->B1, because I expect to find there the
person who did it and explanation why that was done.

Now the git blame --reverse a0..a100 may return me zN, and in
practice it often does return some quite late commit wN
which was merged to some a90. Then, I continue search with
range a0..a89, and so on. So, to find the commit B1 I might
have to perform many blames. 

(I realize that this behavior is correct, and it's even not
obvious how to formally specify the b0 commit as something
different than zM commit, so we could discuss the
implementation of its search. But it does not make me want
being able to find it less)

In contrast, git blame --reverse --first-parent gives me a1,
and then I need only one more step:
git blame --reverse --first-parent a0..bN (--first-parent
for case there are synchronizing merges from master). And,
moreover, in the commit message of a2 I can often find the
information which I expect to find in B1, because it
summarizes what was done in the merged branch and often
contains a link to other resources, like number of ticket.

So "blame --reverse --first-parent" it not like "log
--first-parent", which just decreases number of information
but still pproduces a list which I should look through. It
is really a difference between getting answer and not
getting it.

-- 
Max
