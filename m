From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] [RESOLVED] merge-recursive call in git-am -3 chokes,
 autocrlf issue?
Date: Thu, 01 Apr 2010 10:27:50 -0700
Message-ID: <7vbpe3qe09.fsf@alter.siamese.dyndns.org>
References: <201003190149.03025.trast@student.ethz.ch>
 <hp2jkj$mu0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 19:28:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxOBh-0003Ub-0C
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab0DAR2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 13:28:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0DAR2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 13:28:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D379A7B69;
	Thu,  1 Apr 2010 13:27:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0DMx7KLuhd6sI6mRWsee0tsqIdg=; b=gR163+
	CXlPQmdjbXyeGhAWLxMi1AUIU1GMEWR0DRPGSayRKVM+uxzfBchy1SyiM5zFygDf
	6gEnaqonOlNV0djSjsON/4kcWQoJDeEVVrSsF9q5IqXf1UebXB4NwlJG0ls5LyoW
	Qmcji/MsV8MUii/vqWuzfAaTCIy+Z3cc/nZmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lVeV9jfpjWX8K6yB5OqySQaZzkepCehL
	ZVkkNobZ6jDCh3R2sQJUH5gFx1bp80BQTDh1tPpl0ojr5oC/IoYRBVMs4WM2gm6Y
	fIus5yo2w3gVLz/Af6e4pNYMu30pTwVShLac5aF6s0o1tUqlm90QKaWwl7HNakwV
	yW9LHB3hCJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DD8A7B67;
	Thu,  1 Apr 2010 13:27:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37FA9A7B64; Thu,  1 Apr
 2010 13:27:51 -0400 (EDT)
In-Reply-To: <hp2jkj$mu0$1@dough.gmane.org> (Scott R. Godin's message of
 "Thu\, 01 Apr 2010 13\:03\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8562CFE-3DB3-11DF-8865-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143736>

"Scott R. Godin" <scottg.wp-hackers@mhg2.com> writes:

> So my recommendation at this point is to patch the instructions within
> setgitperms.perl to add 'git update-index --refresh' to the end of the
> post-checkout hook.
>
> I've since reset git-am to use recursive again (instead of resolve)
> and done several rebases (both with and without -i) and all seems well
> and normal, and this has made my day.

Ahh.  If you muck with work tree files and the index in pre-commit,
post-merge, or post-checkout hook (especially if you make an up-to-date
work tree file stat-dirty), I can imagine that you would need to "refresh"
so that unchanged paths would appear unchanged in the index not to confuse
your caller.

I however think the patch probably "fixes" the issue at the worst point.
Wouldn't either of these alternatives be better?

 (1) Perhaps the caller of "pre-commit/post-merge/post-checkout" hook
     should instead refresh the index when the hook returns, _iff_ we
     expect that majority of these hooks are used to munge the work tree
     or the index; or

 (2) Because you already established that setgitperms script is the
     culprit that leaves the index unrefreshed, instead of forcing all the
     callers of the script, it should do the refresh for its callers
     before it exits.
