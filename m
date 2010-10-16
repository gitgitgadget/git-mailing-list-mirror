From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Sat, 16 Oct 2010 17:37:53 -0500
Message-ID: <AANLkTimSNTKFYnYgpha4MpyiC5CdZU5ay1B-848JQrzJ@mail.gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
	<AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
	<20101008195120.GA10810@sigill.intra.peff.net>
	<AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
	<20101008200657.GA10954@sigill.intra.peff.net>
	<AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
	<20101011030755.GB6523@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 17 00:38:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7FO8-00038x-05
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 00:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab0JPWh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 18:37:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47286 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab0JPWh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 18:37:56 -0400
Received: by vws2 with SMTP id 2so965363vws.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ARvp880V4PefkidxJrgv3YUQSkqMqRgsjt/zjNgnLhM=;
        b=vQVHO9N1QXGZmJBinltMITICoxc8S6ZOQcD3AAP3MqLDLqzJazzM58rhWyPheALj52
         vQgXB+GTxHA3E6q+cwqjzogQg5uNQ+PT6dTmL6w+/pa6GhkGmrXToX8bjyWds9ANd8IT
         JTHCFAVA+iEXCfddEsvDGtDMBYTUJHkEenvss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Y+P1svxdjozMU5ddErPL+yIutpQYuzEi+sgVfTSL1m5FtzlpwXwsCb2NYGFVqePIQF
         2AJvrpIwDw6rMe4qaJBN8agK+vltXTx/8JWLr4JTTV7FW2gRMnaYtO3iLfvW0qNKJZ2G
         CFxTbB64um4G75rmJ6TxuqVd9gkB6dgFd8ffo=
Received: by 10.220.186.130 with SMTP id cs2mr510100vcb.144.1287268673552;
 Sat, 16 Oct 2010 15:37:53 -0700 (PDT)
Received: by 10.220.202.7 with HTTP; Sat, 16 Oct 2010 15:37:53 -0700 (PDT)
In-Reply-To: <20101011030755.GB6523@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159179>

Thanks a lot everyone, and especially Jeff.

Running:

    git ls-tree -r HEAD

produces almost 100k lines of output, representing 100k total file +
directory count, which is a pretty big tree. I hope and expect to be
able to split out some branches in the future, but even with
everything included, the operation still only takes ~0.5s real (user +
sys).

So I think even with our relatively high user count and repository
traffic, that cost per commit should not completely break our
workflow.

Thus, I'm going to implement the hook to run the above command and
analyze the output per commit. Assumption is that with the script
overhead, we should be able to finish in less than a second, which is
reasonable latency.

I'll report back if there are any unexpected issues, or this doesn't
work as well as currently expected.

Thanks, D

On Sun, Oct 10, 2010 at 10:07 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 08, 2010 at 05:57:16PM -0500, Dun Peal wrote:
>
>> On Fri, Oct 8, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:
>> > Re-reading your original message, I have a few more thoughts.
>> >
>> > One is that you don't need to do this per-commit. You probably want to
>> > do it per-updated-ref, each of which may be pushing many commits. And
>> > then you either reject the new ref value or not.
>>
>> I think I do, actually, because let's say the developer pushes two
>> commits, 1<-2. Suppose commit 1 violates the rule, but commit 2
>> reverts the violation. One might think that we don't care, since the
>> head will now be on 2, which is a correct state. But in fact we do,
>> because this is Git, and anyone may branch of from 1 in the future,
>> and voila we have a head in an incorrect state.
>
> Yeah, though it is not an especially likely state to branch from, since
> you have to specify it manually. However, a much more likely scenario is
> checkout out a past commit for testing, especially in bisection. So yes,
> if you want to be thorough, you need to check every commit.
>
>> Yeah, that's a pretty good idea, if not for the many ls-tree calls.
>> With their overhead, I strongly suspect it may be slower than the
>> solution you seem to propose, which is:
>>
>> git ls-tree -r <commit>
>>
>> which should give the full list of all paths in a commit, upon which I
>> can decide to accept or reject.
>
> Yeah, that is what I am proposing.
>
> One other thing you could try is to "ls-tree -r" the known-good state of
> the current HEAD at the beginning of the push, and then run "git log
> -diff-filter=AD --name-status $old..$new". For each commit in the log
> output, look for new entries that are in case-insensitive conflict with
> the existing tree, and then update your tree state appropriately with
> added and removed files. You only invoke two git commands, which saves
> on invocation overhead, and you only ls-tree once per push, not per
> commit. Git's internal diff shouldn't look at parts of the tree that
> aren't relevant.
>
> The downside is that the tree state you are keeping internally is not
> entirely accurate. For example, when receiving a merge between two
> parallel lines of development, you would process them linearly, when in
> fact there are two simultaneous different states. So there is a case
> where branch X removes "foo.txt" and branch Y adds "FOO.TXT", and then
> they merge. It looks OK because linearly, they did not both exist at the
> same time. But pre-merge, the commit in branch Y is broken.
>
> So really the straightforward approach of checking the tree state for
> each commit is probably simplest. If it's really too slow, you could try
> jgit or linking against git itself, which would eliminate the external
> process overhead.
>
> -Peff
>
