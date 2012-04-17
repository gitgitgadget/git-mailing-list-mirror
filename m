From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Tue, 17 Apr 2012 13:48:27 -0700
Message-ID: <7vvckym6ec.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
 <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vzkaambre.fsf@alter.siamese.dyndns.org>
 <CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKFKI-0000o1-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab2DQUsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 16:48:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab2DQUs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 16:48:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA566668;
	Tue, 17 Apr 2012 16:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PJNMtAtOgOqk
	obIFy3x1LAVVD4I=; b=gPPFI6Nxm+6jMoCeyFSKyL4QiDApLfEwVAJtdh3SCQzH
	zBJpbfBX8LrdJWwb1YT+vvUxjWkH0UzPeNR8R2JX7FeIIeuneNIoQUalNV9rFKJ4
	j5NTpoxG53VGGJSS++7xCQpjTwqw4cVIAOtICZ7Ls0Yn5pKAiuBcgizo2xWCGaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=myLIg2
	zksOMpEhnMtPA6oLbTP5/wQlVStwsmOl640GRo+omkC5x4y6fgBy/YUocK+5uCky
	EvQGW8YNUE9r5wAX4QT2nq4flSyGdMGSs2OKnioKdJVGk2HLjaAvFFDAiLlt8Cr+
	cYFCoCUN1/fN3y+t1kM59Tit4b8NjMG6j8QDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 427556667;
	Tue, 17 Apr 2012 16:48:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C58666666; Tue, 17 Apr 2012
 16:48:28 -0400 (EDT)
In-Reply-To: <CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 17 Apr 2012 13:09:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF945914-88CE-11E1-85C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195804>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> 2012/4/17 Junio C Hamano <gitster@pobox.com>:
>>
>> If your current HEAD is an ancestor of one of the commit on that lis=
t, the
>> above does not omit it from the parent list of the resulting merge c=
ommit,
>> but if you performed the same merge while on one of the commit being
>> merged, your current HEAD will be excluded with reduce_heads(), whic=
h
>> would mean that you will end up recording a different history even t=
hough
>> a merge is supposed to be symmetrical.
>>
>> In other words, isn't any solution that calls reduce_heads() only on
>> remoteheads fundamentally wrong and merely papering over the problem=
?
>
> I think Micha=C5=82's patch, together with my original one (but not t=
he
> fixups later) is actually the right thing to do.
>
> Micha=C5=82's patch fixes the "log shown multiple times" problem. It =
also
> turns a certain class of octopus merges into trivial common merges,
> which is good.
>
> So I'd suggest:
>  - undo the two top commits from lt/octopus-simplify
>  - apply Micha=C5=82's patch on top of the remaining one commit
>
> It's not perfect, and I really think we could simplify things a bit
> more here, but I think the two commits together fix the problems in
> practice.
>
> Hmm?

I was cooking a fix on-and-off since yesterday evening, and sent it out=
 a
few minutes ago. I think the spirit is almost the same as Micha=C5=82's=
 updated
patch, but it reduces the heads even earlier to catch cases where Micha=
=C5=82's
updated patch may misdiagnose arity of the resulting merge due to its u=
se
of remoteheads->next before the list is reduced (namely, the choice of =
the
default strategy based on how many we are merging).
