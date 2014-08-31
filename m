From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sun, 31 Aug 2014 15:23:30 -0700
Message-ID: <xmqq38cc47tp.fsf@gitster.dls.corp.google.com>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net>
	<xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
	<20140829220818.GA24834@peff.net>
	<CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
	<20140830131649.GA26833@peff.net>
	<CAJo=hJu-DCMv=jepMJvcmR9EOedkynCyL0kD_hB+UGWxbErDfA@mail.gmail.com>
	<20140831152437.GB17449@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 00:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XODXN-0001l5-5M
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 00:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbaHaWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 18:23:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52597 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbaHaWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 18:23:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA53734335;
	Sun, 31 Aug 2014 18:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5Xj4Aq1FLiDBRt8L4jEhdx63kU=; b=C676R4
	csp557oryV6q9t5dGo4pDd4zA0loQU1PzPrymVuezH9dyOdF5p9HlVOoV0UtKqXn
	blUcwmVKLh8VyABRteHL03o77sgVJgV4elI5MdAGizz5G+y1XtHsGdzsvamsrIoS
	s4HEHx8iEARWClo9EYcz91T/FpC+npiUosvd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZV8Haf83siTX7pn0hcNuGkcxwp4gqNO
	mF5Kho5qWG1BjC0LYHuxBjn4UiqenVsmmCre2ZVnnAbjoyPIkxY+AYslE1rCBVJA
	5x/aaL8BmZ3vc4qe+kkM7k35gyNUt4Ovpv0YFiOktBi9U+VQOGu93d1s+tw21Xah
	woiLr6mtD4s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFE3B34334;
	Sun, 31 Aug 2014 18:23:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2002A34331;
	Sun, 31 Aug 2014 18:23:32 -0400 (EDT)
In-Reply-To: <20140831152437.GB17449@peff.net> (Jeff King's message of "Sun,
	31 Aug 2014 11:24:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70C18B28-315D-11E4-89BE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256301>

Jeff King <peff@peff.net> writes:

> Broken ident lines are annoying, but not _too_ fundamentally bad.
> Duplicate tree entries are a lot worse. Fsck even distinguishes between
> "error" and "warning", but "index-pack --strict" treats both as a reason
> to reject the object. We could perhaps loosen that, and make sure our
> error/warning categories are reasonable.

A pack stream that records the same object twice is not a breakage
that is buried deep in the history and cannot be corrected without a
wholesale history rewrite, unlike commit objects with broken ident
lines or tree objects with 0-filled file type designators.

As such, I think it is a reasonable thing to do the following:

 - "git repack" should be taught to dedup, as a way to recover from
   such a breakage, if not done already.

 - "git fsck" should complain, suggesting users to repack to
   recover.  It may even want to exit with non-zero status.

 - "git receive-pack" and "git fetch-pack" should warn, loudly,
   without failing.  They should ideally not keep such a corrupt
   pack stream on disk at all, de-duping the objects while
   streaming, but if that is not practical, at least they should
   give an easy way for the user to cause de-duping immediately (I
   do not mind if that is "we detected that the other side fed us a
   pack stream that is broken.  We automatically correct the
   breakage for you by repacking.  Be patient while we do so").

 - If the other side of "receive-pack/fetch-pack" implements the
   agent capability, upon detecting such a breakage, it may not be a
   bad idea to offer the user to send an e-mail reporting the
   version of the software to a wall-of-shame e-mail address ;-).

I agree that a tree that records the same path twice should be
outright rejected.  There is no sane recovery path.
