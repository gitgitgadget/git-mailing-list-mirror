From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Mon, 15 Mar 2010 13:46:17 -0500
Message-ID: <32541b131003151146qeb6b15bqa9317c6d56443e8e@mail.gmail.com>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:46:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrFJM-0000a4-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721Ab0COSqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:46:38 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:42566 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739Ab0COSqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:46:37 -0400
Received: by pxi36 with SMTP id 36so2190110pxi.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ycGogpLknN+8xym3i2t06moEQjhI3jyZrhVwp9QTI+U=;
        b=sJbfDWxPp9fplspvYj2FnIPiMbz+/PW6RVWZN9ZoBYr30HiiQNSk4P0ab1jWFtYtA8
         8qHkQP1sn2XOgNa1e6EAos+zBLzKNntHBa3LpQNjDphAwLIeKSqO0hW6jc5hLTFP6pIr
         VqKB0CAuG6dS81C+hQ7Tf7ccEFXLjSCSIYKdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NlQaF4Q750pA6zXQsCABZiNyGp9vFlutgtYrUGLAK7RtpOOa6AB5Q0NDCWVbf3bqzC
         8eDqM66pxR3b9UZiOIGo4yThcxBkStz484JySzgYKeHHzqwnRn5pcD6jX4MGF1iDk9Vc
         undXWXnrDHQoXeVGrclhWKB9DuYSLg/u4A3ko=
Received: by 10.140.180.5 with SMTP id c5mr6251287rvf.270.1268678797300; Mon, 
	15 Mar 2010 11:46:37 -0700 (PDT)
In-Reply-To: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142243>

On Sun, Mar 14, 2010 at 11:17 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> The question is how to best integrate the fixes on upstream-a into
> local-master, w/o causing a headache when upstream cuts the next
> tentative release branch, at which point upstrea-master will again
> need to be merged into local-master (and that will also have other
> local development). Here are two options I've considered:

You forgot option 0: tell upstream not to do that.

0a) Have them do their bugfixes directly in the upstream-a branch,
then merge sometimes from upstream-a to upstream-master.  Then when
they cut upstream-b from upstream-master, it should be an easy merge
for you (since they've already resolved any conflicts between
upstream-a and upstream-master as they arose over time).

0b) If they really need to do their bugfixes on upstream-master and
then cherry-pick them back to upstream-a, have them merge upstream-a
into upstream-master sometimes *anyway*, resolving any (probably
trivial) conflicts as they arise.  I say the conflicts should be
trivial because they're just cherry-picks anyway, so git will mostly
notice they're identical and ignore them.  This is easy to do a little
at a time, but gets more complicated if you wait a long time between
merges.

0c) Like 0b), only use 'git merge -s ours' to merge from upstream-a
into upstream-master.  This assumes that upstream-a *never* has a fix
other than one that is already in upstream-master, so that all
conflicts necessarily resolve to exactly what's already in
upstream-master.  This makes it easier for downstream people to merge
but doesn't actually cost any extra effort.

As for your original suggestions:

> 1) Create a local-a integration branch, merged from upstream-a and
> local-master. Keep this branch up-to-date by periodically merging
> local-master and upstream-a:

This will be inconvenient since local-master won't actually be useful;
if upstream-a contains a critical patch, you won't be able to test
your changes in local-master until you merge them into local-a.  Thus
the history of local-master, while "clean", will actually be
meaningless.

> 2) Periodically merge upstream-a into local-master:
> [...]
> Then when it is next time to merge upstream-master into local-master either:
>
> (a) Backout the upstream-a merges to local-master by reverting the
> merge commits which introduced them to local-master, then merge
> upstream-master.

Don't try to revert merge commits; that generally ends in disaster,
both in terms of your tree's correctness and your ability to
accurately retrace the history of your branch.  Possibly you can make
it work, but I don't know anybody who has.  Even if you can, you'll
still hate yourself in the morning.

> (b) Just merge upstream-master and carefully deal with all the
> conflicts. I think this will necessarily be an evil merge.

This is probably not as hard as it sounds, particularly if upstream-a
is *purely* a subset (in terms of cherry-picks, not in terms of
history) of upstream-master.  I'd recommend something like this (just
once when it's time to move to a new release branch):

       git checkout -b mergey upstream-master
       # take the history of upstream-a but not the content:
       git merge -s ours upstream-a
       # assuming local-master is your branch based on upstream-a:
       git checkout -b local-b local-master
       # merge the changes from upstream-a to upstream-master into local-b:
       git merge mergey

> (c) Create a new branch at point Ma and cherry-pick only the local
> commits from local-master past point Ma. This essentially gives me the
> clean local-master I would've had if I'd been doing (1) all along.

This will work, but the short form for exactly the same operation is:

        git checkout -b local-b local-master
        git rebase --onto upstream-master upstream-a

It will result in a cleaner history, and importantly, one that
upstream would probably be willing to merge someday.  You won't have
any extra cherry-picked commits confusingly merged into your history
with the original commits.

The disadvantage is that each of your branches will have a disjoint
history: there will be no branch showing how you got from local-a to
local-b, since they're actually two totally different things.  In git,
the ideal case is that if you look at the history of HEAD, you can see
the *entire* evolution of the product, and using a different
merge-base for each branch gets in the way of that.

The best option above, IMHO, is my proposed option 0.  But any of the
others will work.

Have fun,

Avery
