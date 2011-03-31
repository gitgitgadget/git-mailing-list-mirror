From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch
 mirrors
Date: Wed, 30 Mar 2011 21:03:49 -0700
Message-ID: <7vfwq4kkbe.fsf@alter.siamese.dyndns.org>
References: <20110330195139.GA814@sigill.intra.peff.net>
 <20110330195318.GB30624@sigill.intra.peff.net>
 <7vhbakmj5k.fsf@alter.siamese.dyndns.org>
 <20110330205734.GA2940@sigill.intra.peff.net>
 <7v62r0meok.fsf@alter.siamese.dyndns.org>
 <loom.20110331T040801-714@post.gmane.org>
 <loom.20110331T044824-341@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 06:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q597D-0002xi-Gg
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 06:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab1CaEED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 00:04:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab1CaEEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 00:04:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CC995305;
	Thu, 31 Mar 2011 00:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aB2JquJmzBUvyW0DFGGizecfpYU=; b=j3sFdS
	C7KTmprTvLpf74hYRs4CTmKe8Y/qU7joyxrjnYhMbS+rH127FCYaIIGxVJKL3x4z
	/LEhE77sk+Bhtdo6Itbcqq2wRCibA2Q6LSqfypdBCvnrFRjsU4g+N+j2UT4g8Gwz
	GB6/PxmoDKBKNaehEoo0ADB55XyZ9sZk7TNTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSxruuE+lOWdC69dDw7ShN8RnysvOneS
	AmojPJsiAkst6h8M2mwD+jqb082LV+DmVIuMyj2BW7o9naBWaNy2/A1R/YHsWIsj
	GIk6J/O8Npy5ExXzc9VYGt3EyYoPsdnCgx7FAaxLdGENjyHYi5XpOYjWBJEozzI0
	YcaGyjolELY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 376685304;
	Thu, 31 Mar 2011 00:05:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 054375303; Thu, 31 Mar 2011
 00:05:40 -0400 (EDT)
In-Reply-To: <loom.20110331T044824-341@post.gmane.org> (chris's message of
 "Thu, 31 Mar 2011 02:50:01 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 266D0BAA-5B4C-11E0-BE14-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170454>

chris <jugg@hotmail.com> writes:

>> I use the mirror for synchronizing "local" work between my workstations 
>> (home/office).  So, I use the fact that I can fetch and pull from the mirror.
>
> That of course should say:
>
> So, I use the fact that I can fetch from and *push* to the mirror.

It is not quite clear what you meant by "mirror" above, but I am assuming
that you meant that you have a third repository that you use for the sole
purpose of synchronizing your work done in two repositories, one at home
and the other at office.

The synchronizing point should be a normal remote in such a case.  If you
mirror-push into the mirror from home, you may lose what you have pushed
from office that you forgot to pull back to home before starting to work
at home via the mirror.  If you mirror-fetch from the mirror from office,
you may lose what you worked locally on office and forgot to push out
before mirror-fetching for one thing, and for another, you will be
overwriting the tip of your current branch.

Using a pure mirror in such a three-repository situation _can_ be made to
work, but only if you are very careful: before you leave home, commit
everything and push to the mirror and then go to office; when you come to
the office, fetch from the mirror and "reset --hard" before doing anything
else; before leaving office, commit everything and push to the mirror;
when you come home, fetch from the mirror and "reset --hard" before doing
anything.  Ad infinitum...

Hopefully we are already forbidding mirror fetching into a non-bare
repository, so the system is foolproofed in that direction at least to
avoid such mistakes.  I offhand do not remember if we protect the branch
that is currently checked out from mirror pushing, though.  Hopefully,
receive.denycurrentbranch will protect it, but other branches may happily
get rewound when you do a mirror push.

A safer and more customary way to set up the synchronization between two
repositories is to arrange them to pull from each other (and if you can
initiate connections only in one direction, emulate one side of "git
fetch" with "git push").

In such an arrangement, a local branch "master" at home will correspond to
"refs/remotes/home/master" at the office, and a local branch "master" at
the office will correspond to "refs/remotes/office/master" at home.  There
is no mirror configuration involved.

Hopefully this will clear things up somewhat.
