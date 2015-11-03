From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when accessing git file $X
Date: Tue, 03 Nov 2015 11:54:33 -0800
Message-ID: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
	<1446491306-13493-1-git-send-email-pclouds@gmail.com>
	<20151102203507.GB10722@sigill.intra.peff.net>
	<xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Csjgcv_L+TW9YPTs5V=T2XD+eqo1w1PO4jpfDoHLQKpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	rappazzo@gmail.com, kyle@kyleam.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:54:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZthfG-0002Cq-9v
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 20:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbbKCTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 14:54:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755916AbbKCTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 14:54:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C9AE29F20;
	Tue,  3 Nov 2015 14:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uIFab21lInVB6U/Bi9M49YtGI6I=; b=e2fTfr
	qw/or2lWS2IRwKgWekh2nqxTv80p0jtcmR5HxVnB7+SSTD52jqQZ/4RoMWPqKD7N
	UYC/zB5Z+fj0SdFOc/pfHgKOq8mqq9ci+8aQ1RRMzsXbGszozk4I2Ba4/VSFa5XF
	diFoW7EjC1rxA4s0SIY2ZDAMVG8oeqT/gb55o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDVblEGsFZLUbqv+zM6nNnx2j6Ho4HDl
	21Ig/MMafr+SR6mkGQRt2BFOM7GbMSdEEgGmh15TErIIjN58k1PG/C77ycAIX0cy
	a3F/TqbPW2IiTT4nltGX6Nj+RaNrskDLYiH8odtp69K768umXj7UgnXxOcebAjNP
	aHZiN7PJKlc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42D0729F1F;
	Tue,  3 Nov 2015 14:54:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3530529F1E;
	Tue,  3 Nov 2015 14:54:35 -0500 (EST)
In-Reply-To: <CACsJy8Csjgcv_L+TW9YPTs5V=T2XD+eqo1w1PO4jpfDoHLQKpQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 3 Nov 2015 06:48:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B53C1332-8264-11E5-B42A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280813>

Duy Nguyen <pclouds@gmail.com> writes:

> The whole prune strategy is a bit messy trying to cover all cases
> while still keeping out of the user's way. Perhaps if we implement
> "git worktree mv", or even "worktree fixup" so the user can do it
> manually (back when the prune strategy commit was implemented, there
> was no git-worktree), then we don't need this magic any more.
>
> So, which way to go?

I'd prefer to see "conservative and minimal first and carefully
build up" instead of "snapping something together quickly and having
to patch it up in rapid succession before people get hurt." and that
is not limited to the "worktree" topic.

I think "if you move, you are on your own, do not do it." would be a
good starting point.  The user education material would say: if you
create worktree B out of the primary A, and if you do not like the
location B, you "rm -fr B" and then create a new C out of the
primary A at a desired place, and do not reuse location B for any
other purpose.  The list of worktrees kept somewhere in A would then
name the old location B, and it is OK to notice the staleness and
remove it, but we do not have to.  At that point, the magic can and
should go.

After setting the user expectation that way, it is fine to design
how we would give "worktree rm" and "worktree mv".  As long as
users' initial expectation is set to "you do not mv, ever", these
can be introduced without hurting their established use pattern that
would involve no 'mv'.
