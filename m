From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 07 Dec 2007 11:29:10 -0800
Message-ID: <7vhciu1eyh.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<m3tzmuu57k.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0izf-00066x-MY
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbXLGTfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbXLGTfy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:35:54 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:33877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbXLGTft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:35:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 514E51A77;
	Fri,  7 Dec 2007 14:29:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B1681A75;
	Fri,  7 Dec 2007 14:29:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67444>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> [On hold]
>> 
>> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>>  - Move all dashed-form commands to libexecdir
>> 
>> I think this is a sane thing to do in the longer term.  Will be in
>> 'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
>> good thing as a transition measure.
>
> We would have to change the paragraph in INSTALL about git wrapper
> (which would be no longer optional, or at least no longer optional in
> the sense that you can just delete/not install this file), and its
> conflict with (old) GNU Interactive Tools (the other 'git').

Thanks for noticing.  Please send in a proposed patch to do so; then
we can park it near the tip of this topic, and nobody will forget.

>> [Stalled]
>> 
>> * ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
>>  - git-checkout --push/--pop
>> 
>> A reasonably cleanly written cute hack, and I do not see this breaking
>> the normal codepath, so I do not mind merging this as long as people
>> find it useful.
>
> That would be nice to have, although as somebody[*1*] said, you usualy
> know that you should have pushed branch into stack when you want to
> 'pop'. So it would be nice to have (if possible and easy to implement)
> also "git checkout --previous" or "git checkout -".
> ...

Perhaps.  There are a few issues, though.

 * When you were on 'master' and say "co -", you would want to come back
   to the 'master' branch, whose tip may have advanced since you
   switched away from (e.g. "git push . experiment:master"), and that is
   a desired behaviour.  When you switch away from a detached HEAD, what
   would we record?  The fact the head was detached and its commit, so
   next "co -" would come back to that exact commit in a detached state?
   Or "co -" is meant to say "I was distracted and was away but now
   let's go back to my normal working state" and should refrain from
   touching the previous branch information?  I tend to think it would
   be the latter.

 * There are a few commands that are not "git checkout" but still
   switches branches ("rebase that branch on this one" form of rebase
   and "bisect").  Personally, I think bisect should stop using the
   branch 'bisect' but instead work on detached HEAD in the longer run,
   but what would we do about "rebase"?

> [*1*] I'm sorry for no attribution

I think this was Matthieu Moy, <vpqir3de8t6.fsf@bauges.imag.fr>,
http://article.gmane.org/gmane.comp.version-control.git/67133

>> * jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
>>  . pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
>
> What is the status of this thingy, by the way?

As the topic group header says, it is [Stalled].
