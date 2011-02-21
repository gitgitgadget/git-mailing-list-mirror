From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] revlist.c: introduce --cherry for unsymmetric picking
Date: Mon, 21 Feb 2011 13:24:18 +0100
Message-ID: <4D625972.4090500@drmicha.warpmail.net>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net> <7vzkptnn7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrUrZ-0006KM-Ln
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab1BUM1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 07:27:32 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37161 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753865Ab1BUM1c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 07:27:32 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8366D20444;
	Mon, 21 Feb 2011 07:27:31 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 21 Feb 2011 07:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WuhEvXsMLeEcXuycQGbv6Beg7uA=; b=o7KTdZWDOS9HYjZmrACoxHxoR4uXOSZ/fApDG7o02Um6BHoQW+fDFY4Mcmkkqp12idXVJPLsw7PqeOdMoe559BibnRvBScx8emtP0tEY5dk4hV2SBmdbiqNXwEYyrl7MmWjriViO7xhnz4NeZawoWiVdbUPW208U2jwxstNF5IU=
X-Sasl-enc: MkQKDU4QQy/AJgRhvsMfeHppygqYdhLGls2qoZsdICt5 1298291251
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E035844A115;
	Mon, 21 Feb 2011 07:27:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vzkptnn7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167474>

Junio C Hamano venit, vidit, dixit 18.02.2011 20:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The existing "--cherry-pick" does not work with unsymmetric ranges
>> (A..B) for obvious reasons.
>>
>> Introduce "--cherry" which works more like "git-cherry", i.e.: Ignore
>> commits in B which are patch-equivalent to patches in A, i.e. list only
>> those which "git cherry B A" would list with a "-". This is especially
>> useful for things like
>>
>> git log --cherry @{u}..
>>
>> which is a much more descriptive than
>>
>> git cherry @{u}
>>
>> and potentially more useful than
>>
>> git log --cherry-pick @{u}...
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> A few comments.
> 
> As a Porcelain tool, "log --cherry @{u}.." may very well be useful; what
> do I have that I still need to send.  It is the moral equivalent of what
> format-patch does internally.
> 
> However I don't find it "works more like 'git-cherry'" at all.  The point
> of the command is to show _both_ what are still left to be sent, and what
> are already accepted.  So it is very much inherently a symmetric-range
> operation. 

Maybe I should have said "works more like I use git-cherry"... Whenever
I use it, I'm interested in one side only.

> At the plumbing level (which 'git-cherry' was designed to be),
> we should be able to ask for either (or both).  Adding a "we are only
> interested in the right hand side" as a rev-list option is somewhat
> distasteful and short-sighted.

I don't understand this remark - isn't that exactly what you suggest
below ("--right-only")? Then what is distasteful and short-sighted?

I don't propose changing any current functionality of "git cherry" not
"git rev-list --cherry-pick".

> I wonder if you can instead extend the revision walking machinery by just
> adding a filter that says "show me only the left/right hand side" [*1*]?
> I.e.
> 
>     git rev-list --right-only --oneline --cherry-pick @{u}...
> 

I think that is basically what I have done, just that I only implemented
the shortcut option you describe in the next paragraphs:

> If that is done, we could ask for "--left-only" when we wanted to.
> 
> As there are by definition more contributors than integrators, naturally
> we can expect that "--right-only" would be a lot more often used mode of
> operation than "--left-only", and I don't mind to have "--cherry" as a
> synonym to trigger "--cherry-pick --right-only" (and perhaps internally
> turn a two-dot automatically into three-dot), so that you can say
> 
>     git log --cherry @{u}..
> 
> from the command line to get the same effect.
> 
> By the way, when this feature is properly implemented internally at the
> revision traversal level, we should be able to lose quite a lot of code

Could you explain in what way the current implementation is not done
"properly"? I introduced a flag for the walker and act on the flag. I
don't see a way to cut down the walk further since we need the other
side for the patch-id comparisons.

> from builtin/log.c, as format-patch in it was the original implementation
> of the whole thing, and it was done outside the revision walking machinery
> to implement patch equivalence filtering of the traversal result.  We
> would essentially feed the symmetric upstream...HEAD range with the
> cherry-pick flag, ask it to give only the right hand side (i.e. what are
> left after the patch equivalence filter), and emit the result.
> 
> The get_patch_ids() function itself can go, and its caller and the
> codepaths that use has_commit_patch_id() would be vastly simplified, no?

I have not looked at format-patch at all. Also, I tend to forget
--ignore-if-in-upstream. In fact, git-format-patch(1) carefully avoids
any mentioning of "cherry" to the extent that it's difficult to
recognize as the same concept at all. I would suggest renaming it
"--cherry" or "--cherry-pick" in 1.8.0.

So I think the plan is:

- use a "right-only" flag rather than "cherry"
- make "--cherry" do "--cherry-pick --right-only" (with or without
".."->"...")
- simplify cmd_format_patch

Please stop me if I misunderstood you ;)

Michael
