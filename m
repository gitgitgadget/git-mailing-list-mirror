From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 14:52:15 -0700
Message-ID: <7vwre9133k.fsf@alter.siamese.dyndns.org>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
 <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
 <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 23:52:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuWzI-0005X8-2h
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 23:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042Ab1HSVwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 17:52:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab1HSVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 17:52:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6C3423C;
	Fri, 19 Aug 2011 17:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CNywMFAZUvvPOP6X6SSILdRMjLQ=; b=f2hRCF
	jJX7T1/sF9pzpVlrO+h7MC2q67PEw2NqIM0svFGB65nDGqC22c3GFo1dphQnXJgO
	peMHkDMrUDvFM/yYy4RC51IZ7vAsmLcgJWCEr7XB81LRJdZXZgZE/RqxMB7HX0aL
	NE+txYvQpNTtemeObT5tV5LtlYQuMRDyY3KBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mFiPkg+xfA5bN1N+EQmfAkQ5A+5fh+s+
	Qd4Lxot6mGp1ao9PRfVkj01Q1egIKt+nHWdsiC12QJYEmOPx6WEIB2vJEqZRnb1n
	7fUC+5JfuYQJiW5l58ff/Ow0V14oRXqH304JTEKoEIQiC03H7+4lL4pUxP/uhkky
	eNUpZAzAOiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D9B423B;
	Fri, 19 Aug 2011 17:52:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44EB04239; Fri, 19 Aug 2011
 17:52:17 -0400 (EDT)
In-Reply-To: <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com> (Conrad
 Irwin's message of "Fri, 19 Aug 2011 11:14:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 818F6E80-CAAD-11E0-BFA3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179730>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> In the process of changing things around to do this, I noticed that
>
> git branch -M <foo> <current-branch>
>
> surprisingly works, and does confusing things, in that you will get a:
>
> $ git rev-parse HEAD@{1}
> warning: Log .git/logs/HEAD has gap after Fri, 19 Aug 2011 02:00:09 -0700
>
> Presumably this is the reason that git branch -f forbids you from
> changing the current branch?

[jc: edited typo in the original command exhibition]

I also suspect that "git status" will become nonsense at that point, as
the working tree and the index were still the original state while the
commit pointed by HEAD have changed underneath you.

And you are correct to point out that it is why "git branch -f" shouldn't
touch the current branch. We should notice the situation and error out.

Patches welcome.

I initially thought that such a patch can optionally as a bonus suggest an
alternative way to confuse yourself, e.g. "git reset --soft <foo>", which
is what is happening, but I do not think it makes sense, especially with
"--soft", either.

The user is saying "I know the <current-branch> exists already, and I want
it to match the tip of <foo> branch", without saying what should happen to
what is in the working tree, so depending on what s/he wants, either "git
reset --hard <foo>" or "git reset --keep <foo>" followed by "git branch -d
foo" would be the right thing to do, and I would imagine that one could
even argue that "git branch -M <foo> <current-branch>" should do exactly
that under the hood, but the <current-branch> may be a typo and the user
may have meant to affect some other branch, so in order to play it safe,
just an error message without any advice based on a vague second-guess of
the user's intention, would be the most appropriate, I would think.

Thanks.
