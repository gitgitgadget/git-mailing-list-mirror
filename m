From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Tue, 27 May 2014 09:55:02 -0700
Message-ID: <xmqqha4bgo0p.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537B30E7.5020505@opera.com>
	<xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
	<xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
	<CAEef6WyXGXAdm_DkzNsuLgeFFpQsxvTiuJbK3ypc8-Cz2qD_KQ@mail.gmail.com>
	<xmqq38g0l8we.fsf@gitster.dls.corp.google.com>
	<CAEef6Wxg2QkWDzjuogh5sjjE=HZ9NRUmiY9AhExSXK7H3pAcNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue May 27 18:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpKel-0002cj-EI
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 18:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbaE0QzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 12:55:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51030 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbaE0QzO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 12:55:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E21A189A1;
	Tue, 27 May 2014 12:55:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yye66Mr5uX3M
	NpFiuXga+9jM4jA=; b=JRnNknjOtXBrS7dumGlmWTLcRJf4xL+1nnr90QTnjQG3
	VZX1j95jLD4Y4v52X01y18jyAfRGpp4kFGEgLMn3KrpiSU0Q8bYHHmD3r/L84J8F
	RCbTi08YgPcDn8RqBVlZ4/WwAntMh6HdNWbxAnQo1SK99KrlJHzxe821x7rl0Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sedrVU
	aFebCvW5Uvv2GWkecdKuoJvtmIZXpvF1E3TtwK3w6uRJ+QueB52YCO9g66sMcCMA
	YPDMtLqhhHkbZrmDbPuyi59fvhIt6DYsgytJX7kqgLhPx12cFMbyd8FWbv6wQoQs
	2HMTZGxht1y+3TucpRo4mUQ6a1jUHm+m8vNYw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74800189A0;
	Tue, 27 May 2014 12:55:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1EBE71899A;
	Tue, 27 May 2014 12:55:04 -0400 (EDT)
In-Reply-To: <CAEef6Wxg2QkWDzjuogh5sjjE=HZ9NRUmiY9AhExSXK7H3pAcNA@mail.gmail.com>
	("Jens =?utf-8?Q?Lindstr=C3=B6m=22's?= message of "Sat, 24 May 2014
 09:54:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A636DD06-E5BF-11E3-B7AF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250176>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

>> Puzzled....
>
> There is one reason why one would want to call delete_ref() even if
> the ref itself was already fully deleted by repack_without_refs()
> (because it was only packed) and that is that delete_ref() also
> removes the ref log, if there is one.

Ahh, ok, no longer puzzled---I completely forgot about that part.

> We could refactor the deletion to
>
>   1) repack_without_refs() on all refs
>   2) delete_ref() on still existing (loose) refs
>   3) delete_ref_log() on all refs
>
> to let us only call delete_ref() on existing refs, and then keep the
> current value check.

I tend to agree that it is sufficient for the purpose of this topic
to be loose about the check; the refactoring can come later, as part
of the ref-transaction refactoring that is going on in a separate
thread.
