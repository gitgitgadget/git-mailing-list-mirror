From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What happens when the repository is bigger than gc.autopacklimit * pack.packSizeLimit?
Date: Wed, 27 Aug 2014 13:52:31 -0700
Message-ID: <xmqqa96pd59s.fsf@gitster.dls.corp.google.com>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed Aug 27 22:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMkD1-0008KU-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935653AbaH0Uwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 16:52:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53817 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159AbaH0Uwm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 16:52:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4540934CF4;
	Wed, 27 Aug 2014 16:52:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A5OwAd5BB6zVBDHyvLUG7ELpWgc=; b=ROK7t1
	XfmPwvQN2WnRxb3uioLOt0ypE2kCdt2SY4ibIGDv3ffSLJMZoPhKy0rU6EpuNfiK
	6HO22EnGDrx2TDWqClr1MrLHN87EcdDDmV05zP2xG8Spd6eRtDivbl3/QUAFutQR
	2oyyelGQ21NqED1zpeRxChsLM/ZsnQwjR1Ss0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QtsjNEJmGoSMdhhE22BZH8W3LCkP+cTW
	D2WLhr7hgLlG3ZHGSlhVHO6OywEEX5qUH2XJM+CTWWCj4x1j8WfWzaB6ev/jrhjl
	QyIaw5geq6W8BozGoxU/QtVWkc/1owy3wP8QeLUJHVbi+o8ROP2yy35zK6P1l3jZ
	Xm00kyGYID8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2979A34CF3;
	Wed, 27 Aug 2014 16:52:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3089434CE6;
	Wed, 27 Aug 2014 16:52:33 -0400 (EDT)
In-Reply-To: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com> (Dale
	R. Worley's message of "Wed, 27 Aug 2014 15:36:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11588436-2E2C-11E4-9BA3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256041>

worley@alum.mit.edu (Dale R. Worley) writes:

> builtin/gc.c:
> static int too_many_packs(void)
> {
> 	struct packed_git *p;
> 	int cnt;
>
> 	if (gc_auto_pack_limit <= 0)
> 		return 0;
>
> 	prepare_packed_git();
> 	for (cnt = 0, p = packed_git; p; p = p->next) {
> 		if (!p->pack_local)
> 			continue;
> 		if (p->pack_keep)
> 			continue;
> 		/*
> 		 * Perhaps check the size of the pack and count only
> 		 * very small ones here?
> 		 */
> 		cnt++;
> 	}
> 	return gc_auto_pack_limit <= cnt;
> }
>
> Yes, perhaps you *should* check the size of the pack!
>
> What is a good strategy for making this function behave as we want it to?

Whoever decides the details of "as we want it to" gets to decide
;-).

I think what we want is a mode where we repack only loose objects
and "small" packs by concatenating them into a single "large" one
(with deduping of base objects, the total would become smaller than
the sum), while leaving existing "large" ones alone.  Daily
repacking would just coalesce new objects into the "current" pack
that grows gradually and at some point it stops growing and join the
more longer term "large" ones, until a full gc is done to optimize
the overall history traversal, or something.

But if your definition of the boundary between "small" and "large"
is unreasonably low (and/or your definition of "too many" is
unreasonably small), you will always have the problem you found.
