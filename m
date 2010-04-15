From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 09:49:51 -0700
Message-ID: <7vljcok6ds.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 18:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2SGZ-0005DA-6L
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 18:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0DOQt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 12:49:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0DOQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 12:49:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C09FAB684;
	Thu, 15 Apr 2010 12:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=66xpfMPzs38Q/2M7VMotmUoIVN4=; b=GZCxx5
	689XnMCjMuswnf3ZaDbEcr8L0PqHYka8wNzNIKn+XscyG3uhTaGcfgQKX10GMhvb
	C8YnVQqBKMhkR+GPK4VKUHxSUUSXDK3Y9muqb1goYNhzhi6haaGCuLO27T/q8z0y
	NqqxqpV48kr5cw8NAgTbx+alfn/Z+HDXqy55w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qseeZDuobA+SIIQCQwF7ZEDBd4apl/zM
	vovaqPfuMINg8A4CHazqFE+BqfNk5wUhdEMxKiLiUEHlUFBMk74hnO2HLzlpD07u
	zRo58hYRnE7MdZVDf3KkgtCWclZUQmRa9IdtVnIg34ldcS8Xojt6d2409dQjNwmv
	VyYj1u2DdxI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 424E4AB683;
	Thu, 15 Apr 2010 12:49:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78710AB682; Thu, 15 Apr
 2010 12:49:52 -0400 (EDT)
In-Reply-To: <4BC70D75.70801@viscovery.net> (Johannes Sixt's message of
 "Thu\, 15 Apr 2010 14\:58\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB3855AE-48AE-11DF-9287-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144999>

Johannes Sixt <j.sixt@viscovery.net> writes:

> But I don't see yet, why an entry pointing to a dead-end experiment is
> less important when it is an entry in a branch reflog than when it is an
> entry in the HEAD reflog. Care to explain?

You can set both expiry criteria to the same timestamp, unless you feel
"dead-end experiment is _more_ important", so I frankly don't see a strong
need to explain.  The two expiry setting came from the discussion in:

  http://thread.gmane.org/gmane.comp.version-control.git/34653/focus=34734

I can understand the "Oh, I made a commit that adds a huge garbage blob by
mistake---I want to get rid of it from my odb" use case.  It may go like
this:

    # starting from master
    git checkout maint ; did something
    git checkout next ; did something
    git checkout master
    git add huge-gunk ; git commit ; oops
    git reset --hard HEAD^

    git gc --expire-unreachable=now

In the current behaviour, HEAD reflog loses everything that is not
reachable from the current tip, just like the reflog for ordinary
branches.  You would lose the last pointer to the commit made by mistake
and the huge blob will immediately be kicked out from the odb.

But then I have to lose the record that I was working on 'next' before
coming to master, while I still have the record that says I was on
'maint'.  That is what "git checkout -" (and git log -g HEAD) will give us
after the above sequence.  I cannot explain how that could possibly be a
sane behaviour to the users.

It would be nicer to lose entries that talk about commits that do not
appear in history of any ref, and we can have the best of both worlds.
The patch does not do that, but it should be easy to implement.  Instead
of marking from the tip of the ref that the reflog we are expiring is for,
when expiring HEAD reflog, you would mark from the tips of _all_ the refs
(and you would need to clean up afterwards the same way).
