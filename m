From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 10:22:35 +0200
Message-ID: <CABPQNSb7WACrr=7FsR8YVMC1-q3i0zRhQtXiV8VshfCJn3qgEA@mail.gmail.com>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net> <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
 <20111004071332.GA7308@sigill.intra.peff.net> <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
 <CABPQNSb7NYTac5uWSegK9rmYz1n0yt1GJWHKUtLg1k_OYHdDNg@mail.gmail.com> <20111004075608.GC7308@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 10:23:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB0Hb-0002Br-KS
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 10:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab1JDIXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 04:23:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39398 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab1JDIXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 04:23:16 -0400
Received: by gyg10 with SMTP id 10so217877gyg.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jtZqeO6IYK6zC+qRE3kfQoXvqCCrjjX2hVjLoxazShk=;
        b=QpnMx4XEKP759VSOieKQ1uV5grWIXovdsxj0cFCWZeaO+zUcpWAiq3OFtvn8dKjKZC
         BxSsxRP6KPeDrF/IgvTDx2m46jxPOxlD3Z6dkt6uERMT30PTlovqrGDV0zAVj4KCogne
         7IUuBxs9yUdU5T2YK+7oZ1mxnKPRNW3wvm0So=
Received: by 10.68.21.103 with SMTP id u7mr2908459pbe.129.1317716595049; Tue,
 04 Oct 2011 01:23:15 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Tue, 4 Oct 2011 01:22:35 -0700 (PDT)
In-Reply-To: <20111004075608.GC7308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182749>

On Tue, Oct 4, 2011 at 9:56 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2011 at 09:40:22AM +0200, Erik Faye-Lund wrote:
>> In fact, I'm not sure I understand why we simply do not always prune
>> by default.
>
> I think the original rationale was that we didn't want fetch to be
> "lossy". That is, if I were using upstream's "foo" branch as part of =
my
> work (to diff against, or whatever), then doing a "git fetch" to upda=
te
> should not suddenly make it hard to do my work. And not just hard as =
in
> "I notice that it's gone and I adapt my workflow". But that you no
> longer have _any_ record of where upstream's "foo" branch used to poi=
nt,
> so even doing something like:
>
> =A0git rebase --onto new-foo foo my-topic
>
> is impossible.
>

=46ollowing that logic, a user cannot _ever_ safely prune a remote if h=
e
wants to work on some of the branches. Doing something like "git
remote foo -n" to check if the branch would get pruned before doing a
proper prune is prone to a race-condition; the branch could be deleted
on the remote between the dry-run and the actual pruning.

Besides, the owner of the repo can just as easily have deleted the
branch and created a new one with the same name, causing the contents
of the branch to be lost. This happens all the time with
"for-upstream"-kind of branches, no?

> These days we have reflogs, so you would hope to do something like:
>
> =A0git rebase --onto new-foo foo@{1} my-topic
>
> But ref deletion also deletes the reflog completely, so that doesn't
> work.
>

=2E..and this just makes the problem I pointed out above a lot worse.

So surely, the only sane thing is to make a local branch of what
you're interested in to be safe?

> The right solution, IMHO, is that ref deletion should actually keep t=
he
> reflog around in a graveyard of some sort. Entries would expire
> naturally over time, as they do in regular reflogs. And then it becom=
es
> a lot safer to prune on every fetch, because you still have 90 days l=
ook
> at the reflog.
>

=46ixing the reflog to expire for ref deletion rather than completely
deleting it sounds like a good move, indeed.

>> If a user wants to keep another user's branch, surely the most sane
>> thing would be to make a local branch of it?
>
> Unfortunately there are some management problems there. How do I keep=
 my
> local branch up to date with what I fetch? I have to keep checking ou=
t
> and merging on every fetch (or use some plumbing), which is a pain. B=
ut
> if I don't, then when the upstream branch goes away, I still have no
> clue where its tip was right before it got pruned.

Hmm, good point. I tend to just do the dirty work every now and then
myself. But I only tend to track upstream and stale
development-branches that I intend to pick up, so I'm probably not the
best user-example.

While we're on the subject, an additional argument to change "git
fetch" to always prune is that it's much much easier for user to grok
"last known state of <remote>'s branches" than "the union of all the
branches that were ever pulled from <remote>, unless --prune was
specified". But that's not a technical one, and surely there's issues
to resolve with the proposal before going in that direction.
