From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Tag refspecs (was Re: [PATCH] Remove restriction on notes ref
 base)
Date: Fri, 05 Nov 2010 11:11:34 -0400
Message-ID: <4CD41EA6.1090003@xiplink.com>
References: <1288657003-17802-1-git-send-email-kroot@google.com> <201011040149.47968.johan@herland.net> <4CD2C49A.8010309@xiplink.com> <201011050202.16931.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 05 16:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PENwE-0004yQ-30
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 16:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab0KEPKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 11:10:39 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:37356 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0KEPK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 11:10:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp38.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 89436348394;
	Fri,  5 Nov 2010 11:10:26 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp38.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0DE073483AF;
	Fri,  5 Nov 2010 11:10:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <201011050202.16931.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160816>

On 10-11-04 09:02 PM, Johan Herland wrote:
> On Thursday 04 November 2010, Marc Branchaud wrote:
>> On 10-11-03 08:49 PM, Johan Herland wrote:
>>> I'd probably suggest a more straightforward (and hopefully less
>>> confusing)
>>>
>>> setup like this:
>>>   Remote repo    ->   Local repo
>>>   ------------------------------------------------
>>>   refs/heads/*        refs/remotes/$remote/heads/*
>>>   refs/tags/*         refs/remotes/$remote/tags/*
>>>   refs/notes/*        refs/remotes/$remote/notes/*
>>>
>>> ...and these would all be set in the config, i.e. no implicit/magic
>>> refspecs.
>>
>> I'll second this proposal, at least as far as tags go.  I can offer two
>> reasons to support this.
>>
>>
>> First, I think the assumption that tags are immutable is too strong.  In
>> our repo, we try to keep our topic branches mergeable into both the
>> "master" and "maintenance-of-the-latest-release" branches.
>>
>> This means the topic branches need to be based at the point where the
>> maintenance and master branches diverged.  Making this rule easy to
>> follow is best accomplished with a tag, e.g. "topic-base", but that tag
>> will move when we create a new maintenance branch for a new release. 
>> With the current tag semantics, when that happens everyone has to delete
>> their local topic-base tags and get the new one from the common/shared
>> repo.  People who forget to do this end up basing their topics on
>> outdated code, with predictable results.
>>
>> It would be much easier to be able to just use an "origin/topic-base" tag
>> instead, one that that tracks the topic-base tag in the origin repo.
> 
> Actually, this is not a valid reason. To me, it sounds like your "topic-
> base" tag _really_ should be a "topic_base" _branch_. The branch is 
> initialized to the merge-base between "master" and "maintenance-of-the-
> latest-release" branches, and when you create a new maintenance branch, the 
> "topic-base" branch is fast-forwarded along the master branch until it 
> reaches the merge-base with the new maintenance branch. (Remember that 
> branches really are nothing but named pointers into the commit graph, and as 
> long as the "topic-base" branch stays within the history of the "master" 
> branch, it does not constitute a proper "branch", i.e. a fork in the commit 
> history.)

I understand how a branch can, with careful management, mechanically achieve
the behaviour I want.

But the problem with that approach is that it breaks as soon as someone
commits to the topic-base branch (an easy mistake to make, especially for
rookie users).  Then that person would base later topics on the wrong commit,
and worse, if they pushed their "topic-base" branch to our shared repo then
everyone would be affected.

A hook in the shared repo could prevent the pushing of the topic-base branch,
but that that's just a complicated, half-baked way of making a branch behave
like a tag.  A tag doesn't need the careful management that a branch would.


Anyway, regardless of whether or not the scenario I described is valid, I
still wonder if tag immutability makes sense when remote tags live in the
repo's namespace.  If a repo first sets tag "foo" to point to commit 'A' then
later changes "foo" to point to 'B', shouldn't my clone's "repo/foo" tag
update automatically to reflect that?  I see little point in keeping my
"repo/foo" tag pointing at commit 'A'.

		M.
