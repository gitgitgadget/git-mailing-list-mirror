From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix ranges with git-show
Date: Tue, 19 Jun 2012 14:31:10 -0700
Message-ID: <7vd34vyoo1.fsf@alter.siamese.dyndns.org>
References: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch> <a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch> <7vhau7ypk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:31:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh618-00027e-PV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2FSVbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:31:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab2FSVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:31:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63085811F;
	Tue, 19 Jun 2012 17:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRhyQY6cc0lQhh4nx5R2UeZ+xhg=; b=tH8mt1
	38ZE2lGQr+TbiJZmTi1SiK1Zereh/o0Q+hSL/a5ykwmYziDdNd4uivNhm9HeZWtC
	ngeww/xNL3Y1gv5u5mm6HkvpvVYFe9EUaCK2EMtzmxMFCtkKJ6SSXLkhxINpIkMp
	27axIXj+zGjRnW6ZRWM1J1eH89TaRB3Urhtj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qtgZ3DBVr1xj28N4U1F4G663EkC1gBRQ
	E5yG57+folzrbPccncgfoB/C+jRzWDHV/hzgBBWvUYpErnQ/PGfUAvh02ufcJIVm
	90ApJnzJXHfhFbDX29AU7mAlKcnuLPJrrSWK59yTHRGjQw8aHNVBh+NAaWAh0siU
	kCH5evgMa50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58F3A811E;
	Tue, 19 Jun 2012 17:31:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C51EE8118; Tue, 19 Jun 2012
 17:31:11 -0400 (EDT)
In-Reply-To: <7vhau7ypk6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Jun 2012 14:11:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17451A22-BA56-11E1-A063-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200247>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> As explained in the previous commit, git-show's DWIM walking mode
>> fails with ranges where propagating the UNINTERESTING marks is needed
>> for correctness.
>
> Finally ;-)
>
> Another bad thing about the Linus's walking hackery is it depends on
> the order of parameters (e.g "show maint master..next" and "show
> master..next maint" gives us vastly different results).

By the way, this reminds me of a totally separate topic we discussed
here recently.

Imagine you were on the maint-1.7.9 branch and gave this command.

	git cherry-pick maint master..topic

The range makes the command walk, and because of that, the above
does not result in transplanting a topic that depends on the commit
at the tip of maint to an older maint-1.7.9 branch.  You would
instead need to write something like:

	git cherry-pick maint $(git rev-list --reverse master..topic)

to prevent cherry-pick from walking.

But we could introduce a new "mode" to the revision machinery so
that a single token on the command line is parsed as a set of
commits, and causes the "walking" machinery not to walk the commits
in the union of the sets of commits specified from the command line,
e.g. (pardon my terrible option name)

    git cherry-pick --union-no-walk maint master..topic1 master..topic2

which would instruct the revision machinery that:

 (1) "maint" (the first token) yields a set that consists of a
     single commit at the tip of "maint";

 (2) "master..topic1" (another token) yields a separate set that
     consists of commits on the "topic1" branch since it forked from
     the "master" (similarly for "topic2");

 (3) the revision machinery is to compute these two sets
     _independently_ (meaning, object flags like UNINTERESTING are
     cleared after each run);

 (4) take union of the set, eliminating duplication (if "topic1" and
     "topic2" share some commits at their bottom, they are
     de-duped); and

 (5) the call to get_revision() will not walk, and instead return
     the elements of the resulting union one-by-one.

which would give us what most users of cherry-pick would naturally
expect.  For some commands (like cherry-pick and show), we might
even want default to --union-no-walk behaviour, but that is probably
a Git 2.0 topic after we gain enough confidence with experience.
