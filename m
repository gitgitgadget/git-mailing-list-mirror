From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of
 commit  header in $GIT_EDITOR
Date: Mon, 12 Jul 2010 22:06:40 -0700
Message-ID: <7vzkxw3r8f.fsf@alter.siamese.dyndns.org>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
 <1278764821-32647-2-git-send-email-ayiehere@gmail.com>
 <7vbpadfd4r.fsf@alter.siamese.dyndns.org>
 <AANLkTin9vUliwD5Ufa1vMTC2RZ7TSiyNaPmnDNtz1FQd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 07:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYXhp-0008W6-3k
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 07:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab0GMFGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 01:06:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0GMFGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 01:06:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C263BC4929;
	Tue, 13 Jul 2010 01:06:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ERIUGcjPR+goJVlhJuJ521pHpdA=; b=mpjOTyZiblJbqe6eoYKFGFn
	3dt0FcJULGjM953OOxfzZOe8u6rLNYW0jpbO8kvfjOYbFzjEnle32TjUbUJDpKRE
	F4k476LMo5bK2vI4DVy5DStni617J4osOw3K6H7+3FRBolFBs22QNhItqN8/lZpv
	NF558wQVqgfKRU3zFsHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xfhBlAtprWSVp3aT8wVRQ1pG6dd0svojQN2fh1STIlKxK2j5c
	jvLxvVpYwIV1Q5vnhTAH6eeQn9JmTQ3Js09aJ/y8bgGFaBYVI/jQ/mZxTrpF2kYC
	c87qOisBNuL4ItIT2W1FoekHbgXLOya2aT+mN8HPeZRDEbC2IaQ/h9SW8k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EAB9C4928;
	Tue, 13 Jul 2010 01:06:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88F62C4927; Tue, 13 Jul
 2010 01:06:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F93F132-8E3C-11DF-B3E2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150872>

Nazri Ramliy <ayiehere@gmail.com> writes:

> I guess it boils down to your answer to this:
>
> When you want to reword the badly formatted commit header, would you
> prefer the see the output like the one shown in exhibit 1 over that of
> exhibit 2 in your $GIT_EDITOR?

What I was getting at was if you want to add a special case _only_ for
commits that have indented subject line, and do not care about ones that
are missing the subject line, excess whitespace in the middle or at the
end, or no commit log message.  That is why I asked the "What happens"
questions.  For example, if neither the current nor the updated code
removes excess whitespace in the middle or at the end, then that becomes a
non-issue.

I just checked.  You can create "funny commits" of various shape by
misusing hash-object (and presumably importing from foreign SCMs with
custom importers).  Since the topic here is about _fixing_ such mistakes,
seeing how we handle commits that have different but similar breakages is
very relevant before going forward.

 - We do keep excess whitespaces in the middle, so they are easy to spot.

 - A commit without any message is shown without _any_ message in the
   list, so presumably we can identify them (if there are many, you would
   want to fix them all anyway).

 - We drop trailing whitespaces, so it is impossible to spot a commit with
   such a subject line.  The user who wants to fix these breakages in the
   commit log messages presumably is intelligent enough to check with "git
   cat-file commit $that_commit | cat -e" to find such a commit, make a
   mental note of what the log message of the broken commit said, and then
   identify the one with the same message when editing the instruction
   sheet for the rebase-i, so it is not the end of the world, though.

 - A commit with an extra blank line is not shown any differently, so it
   is impossible to identify.  The "remember the message to identify"
   trick would work very well, though.

 - A commit with a space at the begining gets that excess space stripped,
   so it is impossible to identify.  Again, the "remember the message to
   identify" trick would work very well.

So the bigger picture laid out here shows that there are five cases,
including your "SP at the beginning" which is the last one.

Among these five, two are non-issues, and the remaining three share the
same "impossible to spot if you _only_ look at the insn sheet, but it is
easy to remember which ones to edit" characteristics.  Is the change that
only keeps the excess whitespaces at the beginning such an improvement
worth the code churn?

To put it differently, if we really do perceive this "impossible to spot
if you _only_ look at the insn sheet, but it is easy to remember which
ones to edit" as an issue, shouldn't the patch at least mention that it
attempts to solve only one and punts on the other two that are still to be
fixed later (so that other people can come back to help)?
