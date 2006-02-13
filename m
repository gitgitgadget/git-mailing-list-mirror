From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Fake linear history in a deterministic manner.
Date: Mon, 13 Feb 2006 18:58:40 +1300
Message-ID: <46a038f90602122158n51fc94a8h2ff2631c16cd28b5@mail.gmail.com>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
	 <7vk6bz3k7e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 06:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8WjV-0005z9-Gy
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 06:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWBMF6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 00:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBMF6n
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 00:58:43 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:36123 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750912AbWBMF6m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 00:58:42 -0500
Received: by wproxy.gmail.com with SMTP id 57so762895wri
        for <git@vger.kernel.org>; Sun, 12 Feb 2006 21:58:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oc/mt9aIq1IN4YFc0922tDh0uwqsYdzlopXjSQSl+CYELER15xGfOR83i4mFqZL9MqOQyFzbI8RS21MbApJFIDvn1FIauSDPqvqG4erzZlq9UApltLpqAQKeGXRkH7QAetCy1JBthZOKhVI68rErHvrGflv6eoxwhozejKjjmbA=
Received: by 10.54.79.4 with SMTP id c4mr1796451wrb;
        Sun, 12 Feb 2006 21:58:40 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Sun, 12 Feb 2006 21:58:40 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6bz3k7e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16048>

On 2/13/06, Junio C Hamano <junkio@cox.net> wrote:

Yep, I had roughly this exact scenario in my mind, thanks for the
graphs -- help make sense of what's happening.

> When somebody pushes a ref to your existing commit ancestry
> graph, you can easily identify which commits are the new ones
> you see for the first time.
>
>                 A
>            o---o
>           /
>      o---o---o---o---o B
>
> Suppose you started from two branch repo A and B.  Your sqlite
> database knows about all of these commits, and say you earlier
> have decided to treat A as a side branch, B as trunk.

Well, from the point of view of B being a head we know about, either A
is another head, and we don't care about it, or A is someone's repo
and we haven't seen it and thus cannot care about it either.

A bit of background... git-cvsserver at the moment has the following
semantics: what cvs considers a top-level "module" we use to identify
the head. So

    cvs -d :ext:me@server:/var/frob.git checkout  master

will get you frob.git#master. I thought long and hard about this, and
it is horribly hard to mimic CVS's idea of branches. So clients see a
strictly linear history. Any user in this scenario wanting to do
branching and merging is kindly invited to use real tools. There';s
only so much magic Perl can do ;-)

> Then somebody pushed a new B, making the ancestry graph like
> this:
>
>                 A
>            o---o-------*---*---* B-new
>           /           /
>      o---o---o---o---o B-old
>
> When the update-hook runs, as you read in receive-pack.c,
> your refs have not been updated yet, so you can identify the
> commits marked with * with:
>
>         git rev-list B-new $(git rev-parse --not --all)

That's a nifty trick, though I'm not sure I'll be able to use it.

Right now I'm doing something stupid-er just using `git-log
--parents`, skipping commits that don't move the ball forward on the
linear head I know about, and then processing those "other tracks"
when I see a merge commit. I'll probably find the merge base and see
what commits were brought in from the other side.

The problem is that the situation running from post update hook is
very different from the scenario of running the very same script on a
repo where you see all the history.

In any case, I'm undecided whether to use --topo-order or
--merge-order. Does it really matter?

(...)
> With CVS you cannot express a merge very well, so you now face a
> choice.  Which parent to drop from the leftmost * commit in the
> above picture?

Well, we've already lied about having B to clients that won't know
what to do if we tell them about parallel histories, so our pick is B.

(...)
> One approach would be to see the world with eyes of the person
> who did such a merge.  Both git and cogito place the current
> branch as the first parent,

Yes, I thought about that, but that order is ambiguous in the two most
interesting cases:

 - project maintainer pulls from mature feature branches from other
developers - her side is first, show the "pulled" stuff as merges
(flattened with a merge summary in the commit msg). Still, you can
argue the feature development is more interesting.

 - team-shared-git-repo user does cg-update and merges updates from
origin - her side is first, we don't know which side is the
interesting one. At all. Hmmm.

> But the thing is, there is no
> inherent trunk or branch in the distributed world, so the cvs
> clients of your server needs to live with it.

That's the mantra so far, and we'll talk to cvs clients about
perfectly linearized history. Anything else won't be useful as far as
I can tell -- or in any case,until this is going well for basic usage.
If someone's crazy enough to try I won't get in the way.

cheers.


martin
