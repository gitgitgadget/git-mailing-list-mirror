From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Tue, 06 Jan 2009 17:52:43 -0800
Message-ID: <7v4p0bevbo.fsf@gitster.siamese.dyndns.org>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
 <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
 <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
 <7v1vvj1lvx.fsf@gitster.siamese.dyndns.org>
 <70318cbf0901061637l29837d14nfaa8a3106652b7e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>, git@vger.kernel.org
To: "Christopher Li" <sparse@chrisli.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKNcj-0002Nv-An
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 02:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbZAGBwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 20:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbZAGBwx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 20:52:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbZAGBww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 20:52:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CAB58C220;
	Tue,  6 Jan 2009 20:52:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC5548C21F; Tue,
  6 Jan 2009 20:52:45 -0500 (EST)
In-Reply-To: <70318cbf0901061637l29837d14nfaa8a3106652b7e5@mail.gmail.com>
 (Christopher Li's message of "Tue, 6 Jan 2009 16:37:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3CE8D4C-DC5D-11DD-9FD0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104745>

"Christopher Li" <sparse@chrisli.org> writes:

> So here is my understanding of what you described. The 'pu' branch is
> for highly experiment changes. The 'pu' branch can rewind and rewrite
> the history. Once the patch merge to 'next', the history will not change
> any more.  All update will stay as incremental changes.
>
> One question, does user suffer from conflict when then pull from the 'pu'
> branch?

[jc: I think this is going to the tangent for "sparse" list;
 redirecting to git@vger.kernel.org] 

I think they will, if they "pull", but:

 (1) They are upfront strongly discouraged from doing so by the way 'pu'
     is advertised.  "It is a collection of not yet even testable series,
     and any patch in it can be dropped and replaced".

 (2) They can instead 'fetch + rebase' the changes they made on top of
     previous round of 'pu', instead of 'pull' (= 'fetch + merge') to
     mitigate the pain.

Suppose I have two un-ready topics A and B in pu, and you base your work
X, Y, and Z on what was done by A (in other words, you are not interested
in topic B at all).  Then suppose one of A or B is replaced by wildly
different versions, and 'pu' is rebuilt:

                    X---Y---Z (private changes)
                   /
             A----B pu (old)
            /
           /              A'---B' pu (new)
          /              /  
     ----o----o----o----o

        Fig. 1

If you pull, even if A was not the one that was replaced, the merge will
have severe conflicts from the changes involved in the other series
(i.e. B).

But if A and A' did not change drastically in the meantime, rebasing X, Y,
Z on top of the updated pu (i.e. B') would not conflict:


                    X---Y---Z (private changes)
                   /
             A----B pu (old)     X'--Y'--Z' (private changes rebased)
            /                   / 
           /              A'---B' pu (new)
          /              /  
     ----o----o----o----o

        Fig. 2

In either case, if A (i.e. the work X, Y, Z were made on top of) was
rewritten drastically to become A', neither rebase nor merge will be of
help anyway, and it would not help if the new A' were recorded as an
incremental change from A without rebasing/rewinding 'pu' itself, either.

But at least 'fetch + rebase' would avoid the issue when it is only the
other topics in 'pu' that you are not interested in that were replaced or
rewritten drastically.

By the way, I drew A and B as if they are single patches made _directly_
on pu, only for simplicity's sake.  In reality, all topics fork from more
stable branches (maint or master), and the only commits you see on 'next'
or 'pu' are merges.

Which means, even if we assume that you never rewind 'pu':

> Here is an idea, I am just thinking it out loud.
>
> Given 'pu' branch like this, (each [ ] is a commit, A1 is a follow up
> change for A0).
>
> 'pu' branch: [A0] - [B0] - [A1] - [C0] -[B1] -[A2]

... the history of 'pu' won't look like this.

It would be more like this:

           .-----[B0]----[B1]  ...  topic branch for B
          /         \       \
         /  ...--*---*---*---* ...  pu
        /       /       /
       /       [A0]---[A1]     ...  topic branch for A
      /       /
     o-------o----o master

        Fig. 3

    Side note: my 'next' never rewinds except for once every major
    release, so the above "repeated merge from topics into the branch"
    depicts how 'next' works pretty closely.

Or, if you rebuild 'pu' every day, it would be more like
this one day, and;

           .-----[B0]          ...  topic branch for B
          /         \        
         /  ...--*---*         ...  pu
        /       /        
       /       [A0]            ...  topic branch for A
      /       /
     o-------o----o master

        Fig. 4

the next day it would look like this:

           .-----[B0]----[B1]  ...  topic branch for B
          /                 \
         /          ...--*---* ...  pu
        /               /
       /       [A0]---[A1]     ...  topic branch for A
      /       /
     o-------o----o master

        Fig. 5

In either case, unless a topic began with too many early issues and
mistakes that requires a wholesale replacement, you can expect the
accumulation of A0,A1,...,An to end up in a good shape eventually and then
you have a good incremental history you would want to preserve.

At that point, you can merge the tip of the branch (i.e. An) to master and
declare victory.  'pu' or 'next' may have a messy history that would make
anybody who looks at gitk output barf, but that is Ok.

> We can have a temporary clean up branch fork from 'pu' looks like this:
>
> 'tmp_clean' branch: [A0 + A1 + A2] - [B0 + B1] - [C0]
>
>  'tmp_clean' and 'pu' will generate exactly the same tree. The
> only different is the history path it take to get there.
>
> Then we can have 'pu' merge from 'tmp_clean', with zero text
> changes. The only change is the change log and we tell git
> that the merge is for history clean up. So when we launch
> "git log", by default it will follow the "tmp_clean" path rather
> than the original "pu" path.
>
> So it just provide "alternative" view of the history without introduce
> real changes. When user pull from 'pu', it can automatically get the
> cleanup version of the history without introduce conflicts.
>
> It seems it can have the best of both worlds. I am not sure weather
> it is doable or worth while to do though.

I do not think it is worth it, for two reasons:

 (1) That won't help the case where others based on their work on un-ready
     changes in 'pu', as I described earlier, anyway.

 (2) If you do not have any work on top of the un-ready 'pu', in other
     words, if you are just following along, then "git checkout origin/pu"
     won't care if yesterday's pu and today's pu are not fast-forward
     anyway.

If you rebuild 'pu' from scratch every day, without keeping many repeated
merges so far, it will give a pleasant read in "gitk master..pu" than
'next' that never rewinds whose "gitk master..next" output is a disaster
;-).


There is one trick my experienced users use, knowing how 'pu' is managed.

If today's 'pu' looked like Fig. 4 above, and you are interested in the
topic A, you can find the tip of that topic by looking at:

        git log --first-parent master..pu

It is what was merged to the merge that is at the second from the tip of
'pu' branch, i.e. "pu^^2 == A0".

And you fork your own enhancement to that topic by forking from A0,
creating "my-A" branch.  Your own commits go to that branch.

Next day you will find a history that is depicted in Fig. 5 and find the
tip of topic A the same way.  It is at A1.

Then you rebase "my-A" on top of A1 (or merge A1 to "my-A" branch).  You
really do not care about other uncooked garbage in 'pu', and you can
ignore them this way.

If you are working on more than one such "topics started by others", you
will have many my-A, my-B, ... branches.  You treat your 'master' branch
as if it is my 'next', i.e. fork from the last major release, merging all
of my-X branches, and employ the aggregated result for your own use.
