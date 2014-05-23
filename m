From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Fri, 23 May 2014 10:09:05 -0700
Message-ID: <xmqq38g0l8we.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537B30E7.5020505@opera.com>
	<xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
	<xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
	<CAEef6WyXGXAdm_DkzNsuLgeFFpQsxvTiuJbK3ypc8-Cz2qD_KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri May 23 19:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnsyB-0004z2-4k
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaEWRJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 13:09:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62789 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbaEWRJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 13:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77CFF186D1;
	Fri, 23 May 2014 13:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=djAV6wylH77O
	hw9aPALMn0UHCw8=; b=DL+35sQK6TQ/QRNborMxekRvO9f3gxpPnJe8BXG5jUNq
	tUXhiSAg/tvtSp9GDq2Q25HR0oAm3WeNhHcUiAPt0DxtnleUP4Vg5G7mDGmk4AZR
	tOM3YUCvPo4fWTrexEmNENgAATh1119oTY3f1XMHmN9t9V9yFRlNIfE0efDDbgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wt0uTs
	gI8V22lcleHfI9kDLZ150Ew4czNIEgeNkO2eBja32pPLN8150ePrC38sRI9tc+CJ
	SEs5kDau8sK13UOnMuXz6iQdQaf7ilWYurTpkjEhORMcb4UN6/85/MPThvcwrR9y
	ELYM+FrnZydVwTe8d+SjxGnH5jfKFV850zc08=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66D77186D0;
	Fri, 23 May 2014 13:09:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5228F186C2;
	Fri, 23 May 2014 13:09:07 -0400 (EDT)
In-Reply-To: <CAEef6WyXGXAdm_DkzNsuLgeFFpQsxvTiuJbK3ypc8-Cz2qD_KQ@mail.gmail.com>
	("Jens =?utf-8?Q?Lindstr=C3=B6m=22's?= message of "Fri, 23 May 2014
 12:03:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3278A14-E29C-11E3-86E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250001>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> Removing the remote configuration (I assume you mean the
> "remote.<name>" section from .git/config) last in 'remote rm' would b=
e
> a bit better I think.  Especially ...

Yes, that is exactly why I suggested it ;-)

> Doing the repacking first and then run through and delete loose refs
> and ref logs leads to a smaller and nicer patch as well ...

Hmph, that would be a bonus, then.  I suggested it primarily as a
correctness thing against an interrupted operation.

> One additional change was required in
> builtin/remote.c:remove_branches().  It used to pass in the expected
> SHA-1 of the ref to delete_ref(), which only works if the ref exists.
> If repack_without_refs() is called first, most refs won't exist,...

Why?  A ref, before you start pruning or removing a remote, could be
in one of these three states.

 (a) only loose refs/remotes/them/frotz exists
 (b) both loose and packed refs/remotes/them/nitfol exist
 (c) only packed refs/remotes/them/xyzzy exists

And then you repack packed-refs file without these three refs.  When
you do so, you know that you would need to remove frotz and nitfol,
and also you know you do not want to call delete_ref for xyzzy, no?

In other words, the problem you are describing in remove_branches(),
that it wants to make sure that the ref-to-be-removed still points
at the expected object, does not sound like it is doing anything
inherently wrong---rather, it sounds like you didn't make necessary
changes to the caller to make sure that you do not call delete_ref()
on something you know you removed already.

Puzzled....
