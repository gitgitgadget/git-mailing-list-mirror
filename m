From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Mon, 23 Feb 2015 09:50:25 +0100
Message-ID: <54EAE9D1.3090504@drmicha.warpmail.net>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net> <xmqqa905wy43.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 09:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPoim-0005DO-1v
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 09:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbBWIu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 03:50:28 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38921 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172AbbBWIu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 03:50:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E7139208AB
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 03:50:25 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 23 Feb 2015 03:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=IPxZiI78So1yQy32/Onak8
	Ef5Ok=; b=JqPKqE+KIapEMfbguVOho44+LbYTWzlBe4W1d+bm4L5IWgiMUYi7C8
	qds/PGf8s+LoFyP+TeJLbFmjhDx2zbAUr+Soxmz/mxOM1lc58BPWL+aP4gxfIjVY
	lGbww5bVtJ10IT5DjzyLCK3RFx5ohJBt9JZCE6LXOZGihUTpxc5eI=
X-Sasl-enc: KgqnyeEnhtvEkngqmZHyUu9cVDZ9VBVFZ5/hnKhmdb9y 1424681426
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2004E6800C5;
	Mon, 23 Feb 2015 03:50:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqa905wy43.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264251>

Junio C Hamano venit, vidit, dixit 22.02.2015 20:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
>> ref depending on whether the detached HEAD has moved since. "git branch"
>> always uses "from", which can be confusing, because a status-aware user
>> would interpret this as moved detached HEAD.
>>
>> Make "git branch" use the same logic and wording.
> 
> Yeah, otherwise the user would wonder why sometimes the object name
> after that "from" matches "git rev-parse HEAD" and sometimes does
> not.
> 
> In order to make sure that it will be easy for us to maintain that
> these two commands will keep using the same logic and wording after
> this "fix" is applied, should this patch do a bit more?  Or is it
> worth doing that for such a small piece of code to be shared?

Yes, I guess I meant RFD when I meant RFC. If that consistency is deemed
worthwhile it should at least be guaranteed by the tests, which the test
amendments somehow do, but better by a shared code in wt-status.c.

That could possibly be reused by the decorate code - which is how I came
about this: In order to decide about consistent HEAD decorations I
checked what we have and got confused by status vs. branch.

> The following is a tangent and I do not think it is likely we would
> do anything about it, but I wonder what value we give the end users
> by showing the "from" information, both in "status" and "branch" in
> the first place.  When I am on a detached HEAD, I'd be doing one of
> these three things:
> 
>  (1) I am on some kind of sequencing machinery (e.g. "rebase -i",
>      "cherry-pick A..B", or "bisect").  It does not matter to me at
>      all if I am at the same commit at which I started the sequenced
>      operations or the sequencing machinery has moved me one or more
>      commits along its planned course of action, or where the
>      original point the sequencing machinery detached the HEAD at.
>      I suspect that I would not use "git status" or "git branch" in
>      this mode anyway.
> 
>  (2) I am sight-seeing, starting with e.g. "git checkout v2.0.0",
>      and moving around with "git checkout $some_other_commit".  I'd
>      always see that I am "at" the commit I last checked out, so the
>      distinctions would not be even shown to me.
> 
>  (3) I am experimenting to fix or enhance an existing thing that is
>      meant to eventually hit a concrete branch, but I do not know if
>      the experiment would pan out. "git checkout $topic~$n" would be
>      to start from near the tip of that $topic ($n may often be 0
>      but not always) and then I would "git commit" my experiments.
>      When I assess my progress, I'd be interested in what I have
>      that is not in $topic and vice versa since I started that
>      experiment, so
> 
>      $ git log ...$topic
>      $ git show-branch HEAD $topic
> 
>      would be a lot more useful than having to learn "where did I
>      detach" from either "status" or "branch" and then do something
>      about that the abbreviated object name (like feeding it to
>      "describe" or "log").
> 
> Of course, the decision to make the point the HEAD was originally
> detached at is not an issue this patch introduces, but it makes me
> wonder if that existing "at vs from" logic is an overall win or a
> loss.

Not for you nor anyone who routinely detaches heads :)

Despite HEAD reflog and delayed pruning and all that, "detached HEAD" is
a state the average user may feel slightly uncomfortable with, and may
not even have gotten into on purpose. "git checkout tag" and "git
checkout remotebranch" are very easy ways to get there, even "git
checkout HEAD^1" and such when mistaking "checkout" for "reset".
Therefore, I think about that "at/from" as information (or rather: quick
guesstimate) on two things:

- How did I get there? (For this it might be better to say 'at/from
HEAD^1' which was sha1" rather than resolving that to a sha1 only. I
dunno. Detached heads move so easily...)

- Has something (that could get lost) happened since?

We take a quick and overly cautious approach to answering the 2nd
question, of course.

Maybe a "git head" command would be really a better place for all that
information:

git head
 "master" or "HEAD" (on branch resp. detached state)
git head -v
 "master at..." or "HEAD at ..., detached from/at..."
git head -l
 list of sha1s of childless prunable commits from HEAD's reflog
git head -d|--detach
 alias for "git checkout -detach HEAD"

(just brainstorming)

Michael
