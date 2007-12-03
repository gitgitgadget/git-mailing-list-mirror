From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 02 Dec 2007 19:45:23 -0800
Message-ID: <7vr6i4qw4s.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
	<20071203021333.GC8322@coredump.intra.peff.net>
	<7vlk8csetl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 04:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz2Fj-0006cF-4u
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 04:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbXLCDpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 22:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbXLCDpb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 22:45:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55568 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXLCDpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 22:45:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B359B2F2;
	Sun,  2 Dec 2007 22:45:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FA809C2F9;
	Sun,  2 Dec 2007 22:45:47 -0500 (EST)
In-Reply-To: <7vlk8csetl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Dec 2007 18:16:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66854>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ..., but an
>> "ok, but btw I changed your commit" status from receive-pack seems like
>> it would be useful, for two reasons:
>>
>>   - it can be displayed differently, so the user is reminded to do a
>>     fetch afterwards
>>   - we can avoid updating the tracking ref, which makes it less likely
>>     to result in a non-fast forward fetch next time.  For example,
>>     consider:
>>
>>       1. The remote master and my origin/master are at A.
>>       2. I make a commit B on top of A.
>>       3. I push B to remote, who rewrites it to B' on top of A. At the
>>          same time, I move my origin/master to B.
>>       4. I fetch, and get non-ff going from B to B'.
>>
>>     If I had never written anything to my origin/master, it would be a
>>     fast forward. And obviously git handles it just fine, but it is more
>>     useful to the user during the next fetch to see A..B rather than
>>     B'...B.
>
> Sensible argument.  I stand corrected.

Having said that, I think the workflow that this "letting update hook
munge" patch supports has a bit more implications for the people who
interact with it.  The pusher will need to force fetch the result, but
after that he needs to discard his own commit and replace it with
whatever the hook did.  The question is how much to discard, and how to
reconstruct the changes since the last push that was made on top of the
commit that was pushed.

Maybe the push pushed out a string of five pearls and the hook may have
rewritten only the tip, or all of them.  You may have built a few
commits on top since then.  If what you pushed out contained merges and
the hook rewrote it, you would need to potentially replay such a merge
that was rewritten by the hook.

This is all the same with a workflow that deals with a branch that is
advertised to constantly rewound and rebased, and the common approach is
to use "fetch + rebase" (see recent discussion between Nico and Bruce).
So this patch is not creating a new problem (iow, I am not mentioning
this as the reason to reject this patch), but I thought I should bring
it up so that people know what they are doing.
