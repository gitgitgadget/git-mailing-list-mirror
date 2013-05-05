From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Sun, 5 May 2013 11:59:46 +0200
Message-ID: <CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 05 12:00:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYvjs-0003tf-B1
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 12:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3EEJ7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 05:59:54 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:57300 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3EEJ7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 05:59:52 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYvjS-000NJJ-L8
	for git@vger.kernel.org; Sun, 05 May 2013 11:59:50 +0200
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYvjS-000PDg-6G
	for git@vger.kernel.org; Sun, 05 May 2013 11:59:50 +0200
Received: by mail-ob0-f176.google.com with SMTP id er7so2373915obc.7
        for <git@vger.kernel.org>; Sun, 05 May 2013 02:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yi1ucpw1+CoWIF3xr4cJpTwWMPJIqhKWFUVuXDGaouE=;
        b=cGmVeUgxO/29Vgmolu4/6Vf1whTEpWkUv2u2cIk4n3zveK3IqUvSG2bjVsuT9nCNCx
         kx1tMxgnSK6raDFK+oTNPp1qy8CR3KIVB1w6a3dy6uwTsrX28+Yw1rs88ZnJyuchEKwD
         j8rRh7Ezj7jIuYxPHHVMqNM3nYvLf8SQ8DAfu5xg5l/HR0D4bkMPPH/RtNHFWmhhXomf
         3J9cZnIvnlAgSpMc4GCkIgyDYkQC0IyAy3d9sE+NL/Ev/NWAau95/tS8uUgZ05TmD9D5
         1IkfWDwvG990EiheQ5SVtEe75XVmok+7NJxvRVWlj9IjEioUbwUgQWWMtgbhvz7fXeBk
         kihA==
X-Received: by 10.182.204.5 with SMTP id ku5mr4499301obc.22.1367747986614;
 Sun, 05 May 2013 02:59:46 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Sun, 5 May 2013 02:59:46 -0700 (PDT)
In-Reply-To: <7vr4hmuk20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223397>

On Sun, May 5, 2013 at 6:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> The "$remote/$branch" syntax can be interpreted in two subtly different
>> ways:
>>
>>  1. A shorthand name for the remote-tracking branch corresponding to a
>>     specific $branch from a specific $remote.
>>
>>  2. A refname fragment, which - when appended to "refs/remotes/" -
>>     yields the remote-tracking branch corresponding to a specific
>>     $branch from a specific $remote.
>
> I think both of the above are somewhat distorted views and they go
> against all the documentation we have so far.  The real definition
> is:
>
>    3. $string (which may happen to have one or more slashes) is used
>       by prepending a few common prefixes to see if the result forms
>       a full refname, and refs/remotes/ is one of the prefixes.
>       origin/master ends up referring refs/remotes/origin/master
>       because of this.

True, but from the POV of remote-tracking branches (which is what this
series is concerned about, more on that below), #2 and #3 are equivalent.

>> However, when configuring non-default refspecs
>> (such as the +refs/heads/*:refs/remotes/origin/heads/*), it becomes
>> obvious that the current code follows the latter interpretation: The
>> "$remote/$branch" shorthand will no longer work, and you are forced to
>> use "$remote/heads/$branch" instead.
>
> While I do _not_ think it is _wrong_ to use remotes/origin/heads/*
> as a namespace for branches you copy from the 'origin' remote, my
> gut feeling is that it is myopic to redefine that origin/master
> resolves to refs/remotes/origin/heads/master [*1*].

I guess my point is to "raise" the origin/master notation to a higher
level of abstraction. Instead of it being purely a string that is
appended to some common prefixes to yielf a (hopefully unambiguous) match,
I want Git to support the idea that it refers to the "master" shorthand
from the "origin" remote. In other words, just as you can write
"$something" to refer to a ref in the local repo, you can also write
"$remote/$something" to refer to a remote-tracking ref from another repo.

> Step back a bit.
>
> There must be a reason why somebody wants remotes/origin/heads/*
> instead of the traditional remotes/origin/* to keep the copies of
> branches taken from the origin.
>
> It is because she wants to use the parts of remotes/origin/ that are
> outside remote/origin/heads/ to store other things taken from that
> remote, no?  They may be "changes", "pull-requests", "notes", etc.

Indeed.

> If origin/master were to map to refs/remotes/origin/heads/master and
> origin/jh/rtrack were to map to refs/remotes/origin/heads/jh/rtrack,
> [*2*] what short-hands hierarchies in refs/remotes/origin/ other
> than "heads/" would have?

The same. Today, you can use "eggs" to refer to either "refs/heads/eggs"
or "refs/tags/eggs", depending on which exists in your repo. (Having both
exist is also possible, but then you must express more explicitly which of
them you mean). In the same way, I want "origin/eggs" to refer to either
"refs/remotes/origin/heads/eggs" or "refs/remotes/origin/tags/eggs",
depending on which is available (with the same behavior when both exist).

This series only gets us halfway there, the other half consists of making
Git work properly with "remote tags" (i.e. teaching Git to handle
"refs/remotes/$remote/tags/*" as an extension of "refs/tags/*").

Part of that would surely be to add another rule that maps "$remote/$tag"
through $remote's fetch refspec for tags to yield the corresponding
remote-tracking tag (e.g. "refs/remotes/$remote/tags/$tag" if you're
using namespaced remote refs). This rule would should cause problems for
current users since it would map to _nothing_ if you're using the default
refspec, alternatively "refs/tags/$tag" if you have explicitly set up
mirroring of tags from the remote (refs/tags/*:refs/tags/*).

> If you do not special case "heads/",
>
>     $ git merge origin/pull-requests/4
>
> is very straightforward to understand and explain when you use the
> definition #3 above.  But if you do, then the above may refer to
> origin/heads/pull-requests/4, or perhaps there is no pull-requests/4
> branch in the origin and the resolution may have to error out.

Let's say that in the origin repo there may be either refs/pull-requests/4
or refs/heads/pull-requests/4, and they are fetched into our repo, and
placed at either refs/remotes/origin/pull-requests/4 or
refs/remotes/origin/heads/pull-requests/4, respectively. (If both are
present, and fetched, we will get both in our local repo).

When doing your

    $ git merge origin/pull-requests/4

we would either expand to refs/remotes/origin/pull-requests/4 (with the
existing "refs/remotes/%.*s" rule) if that exists, or alternatively expand
to refs/remotes/origin/heads/pull-requests/4 (with the new refspec-mapping
rule from this series) if that exists. (If both exist, you would have to
be more explicit to resolve the ambiguity - the same ambiguity that would
have to be resolved if you did "git merge pull-requests/4" in the origin
repo.

The rules that expand shorthand names into full refnames, are all about
balancing convenience against ambiguity. We want users to be able use as
short names as possible, as long as they are unambiguous. As part of that
we have determined that "foo" can be auto-completed into any of

  foo
  refs/foo
  refs/tags/foo
  refs/heads/foo

without causing ambiguity in the common case (obviously all of these could
exist, and the user would have to be more explicit, but in most repos, at
most one of these exist, so we are fine).

I want to extend the same reasoning to remote-tracking refs, i.e.
"$remote/$name" could be auto-completed into any of

  refs/remotes/$remote/$name
  refs/remotes/$remote/tags/$name
  refs/remotes/$remote/heads/$name

without causing ambiguity in the common case. When there is ambiguity, we
would resolve that in the same manner as for local refs.

> While I do not reject refs/remotes/origin/heads/* layout as a
> possibility, I am somewhat skeptical that any "solution" that starts
> from the "two interpretations" above (both of which are flawed, that
> only consider what happens to the branches) will yield a generally
> useful result.

The current series only concerns itself with the branches, but the larger
intention is to make it work for tags and other refs as well.

> If the final end result you are shooting for is to introduce an
> extra level between the remote name and the branch names, i.e.
> "heads/", any solution needs to at least have a plan (not necessarily
> a detailed design or implementation) for the other hierarchies.  The
> possibility to have these other hierarchies per remote is the true
> progress that the "heads/" at that level can give us; there is not
> much point to have heads/ after refs/remotes/origin/, if heads/ is
> the only thing that can come there.

I fully agree. This series was meant as the first step in that direction
(sorry for not describing my intentions more clearly).

I believe "the plan" that you request might have been largely described in
the large "[1.8.0] Provide proper remote ref namespaces" thread, but this
thread is now more than 2 years old, and although I re-read some of it to
prepare for this series, it was stupid of me to assume that it would still
be fresh in the minds of everyone else... I hope my answers above have
clarified the plan somewhat.

> [Footnotes]
>
> *1* Unlike the usual cautions from me, this does not have anything
>     to do with backward compatibility; it is more about forward
>     thinking.
>
> *2* Wait.
>     Does origin/jh/rtrack map to refs/remotes/origin/jh/heads/rtrack
>     which is rtrack branch taken from the origin/jh remote?

There is an inherent ambiguity when interpreting "foo/bar/baz" as
"$remote/$ref", whether to do

  $remote = foo/bar and $ref = baz

or

  $remote = foo and $ref = bar/baz

My opinion on this is:

 1. Having both remotes "foo" and "foo/bar" in the same repo is _insane_,
    and this scenario would cause problems for current Git as well.

 2. Remote ref namespaces marginally improves the situation by forcing the
    middle fragment ("bar" in the above example) to be one of "heads",
    "tags", etc.; otherwise the refs won't clobber eachother.

 3. Currently, this series does not explicitly handle this insanity.
    The code in patch 7/7 (refs.c:ref_expand_refspec()) stops at the
    first remote that matches a prefix of the given shorthand, so both
    alternatives won't be tested. This could be fixed by moving the ref
    verification (does the refname actually exist/resolve?) into the
    expansion, but I'm not sure it's worth it.

 4. The proper way to deal with this is probably to detect when a new
    remote name is a prefix of another remote name (or vice versa) in
    "git remote add" and "git remote rename", and warn or error out.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
