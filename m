From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 13:43:17 -0800
Message-ID: <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
References: <ih1449$ul6$1@dough.gmane.org>
 <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Kelly <steveire@gmail.com>,
	KDE PIM <kde-pim@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg2I6-0000ZU-6r
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab1ATVnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 16:43:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab1ATVna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 16:43:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CA35404D;
	Thu, 20 Jan 2011 16:44:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TdpteezE9eywFW2/ZmaW3VNBdN0=; b=svbKS5
	odiQ9yB7uu6M+72opG/mmWfHDVGeOtYduUegwfKZUd2vLK32RKOKt7N+qg/J7TgG
	aK/iqo1Qy2dGEgfFM1jY2psaR5JKCyNzl7e52feitqzy3o95G+nQC37OvD55rd8Y
	iCvw9D8TPsb2/FAgZFb90Y/RtSIyq/9BcKA20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUGFFnZ1aTgdiLhfT6KZtqrC+X40+NT8
	e2jBn4y8DBvDbOPF/r4myvqfOVT0mVpQ8xLlmUPCQqC+Wodmj8kQYEx1sLe3+1EQ
	SaJn/Hg+kQz9HenXpQzWNyc7kbUjwzBtp4ZTx0DABt8llryHAaw56e++34cW2J26
	NYI16wQlY9U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCAFA404A;
	Thu, 20 Jan 2011 16:44:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FF734049; Thu, 20 Jan 2011
 16:44:05 -0500 (EST)
In-Reply-To: <20110120203840.GA11468@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 20 Jan 2011 15\:38\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B0ECAA4-24DE-11E0-971A-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165341>

Jeff King <peff@peff.net> writes:

> Hmm. It seems like the symbolic ref is the culprit, not just HEAD. The
> HEAD thing is the most likely, of course, but I could do something like:
>
>   git symbolic-ref refs/remotes/origin/convenient-alias \
>                    refs/remotes/origin/some-name-you-dont-like

Isn't it already wrong to do the above locally, in the sense that it is
equally wrong to do this?

    git update-ref refs/remotes/origin/no-such-thing-exists-over-there 
    	refs/heads/master

I agree that the symbolic ref is the real source of confusion in Stephen's
case (I admit that I was scratching my head chasing a non-existent bug in
transport_update_tracking_ref() before I realized what was happening), but
the usual (and the only) way for refs/remotes hierarchy to get a symbolic
ref is via a normal clone, and HEAD is the only name that can cause this
conflict.  Creating a branch called HEAD (or FETCH_HEAD for that matter)
is infinitely more likely to be a mistake than being clever, I think.

> ... Maybe we should not follow symbolic
> refs during fetch. So if we are fetching the refspec "foo:bar", and the
> RHS "bar" is a symref, we should _not_ follow it, but instead just
> overwrite the symref with a regular ref.
> 
> For pushing, one rule could be to allow pushing from a named symref, but
> not allow the matching rules to use a symref as a source....

I personally like this line of thought, especially as a thought experiment
to see what corner cases we could find, but I doubt I will be able to say
we covered all the corner cases with confidence without thinking long and
very hard.  For now, I do not find this issue worth spending that kind of
deep thinking, especially when a lot simpler and easier to explain
workaround is available, but others may disagree and perfect your idea.
