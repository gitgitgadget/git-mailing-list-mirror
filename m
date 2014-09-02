From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] t5309: mark delta-cycle failover tests as passing
Date: Tue, 02 Sep 2014 10:19:37 -0700
Message-ID: <xmqqoauy2b4m.fsf@gitster.dls.corp.google.com>
References: <53F868F8.9080000@web.de> <20140823105640.GA6881@peff.net>
	<20140823110459.GA13087@peff.net> <20140823111804.GA17335@peff.net>
	<53FB66D1.709@web.de> <20140828220821.GA31545@peff.net>
	<20140828222227.GA30879@peff.net>
	<xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
	<20140829205538.GD29456@peff.net> <20140830132311.GA14709@peff.net>
	<20140831151550.GA16499@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOrkK-0002cT-9T
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbaIBRTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 13:19:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63245 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbaIBRTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 13:19:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58A2F35AB5;
	Tue,  2 Sep 2014 13:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OWEg2276Rq5EhR3hYUIttYY7Fgk=; b=gYjun0
	i4xU3uTJzEIVNWIh7TPYfyjlJVTlOyc+K4+pZQo7Y8kCSOZmF+XGxgLT6DbEB/Se
	Jq+ANVchXd4/agAhG8eWq2dNCzYae6fQ9PO8iPlAxPuYZEdm12oB2Js2JzCOwurt
	eySYMICFzg4vb1TKx9uWYV1IQ73Jj2JiORW/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7Tw8vvKjq30Mym8GDIfCpLrLRhNw4zJ
	ej1y9oL6PChnxCzpw1b4YMXFd7ZQLl/KoXz0bQi7pBzT5QuaCofX1USDtPM7ZAbi
	OiFWQW1ITUpUqvoi9JV4VYmBrSYWEpsUS8ddD4gqGarb980+OS2xEkYNL5vo8QLs
	unUczhnAQ98=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DEBF35AB2;
	Tue,  2 Sep 2014 13:19:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95E0635A9E;
	Tue,  2 Sep 2014 13:19:39 -0400 (EDT)
In-Reply-To: <20140831151550.GA16499@peff.net> (Jeff King's message of "Sun,
	31 Aug 2014 11:15:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 522847B0-32C5-11E4-88AC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256325>

Jeff King <peff@peff.net> writes:

> We used to do that because the only way to correctly resolve them was by
> introducing a duplicate base object, and we did not allow that. Patch 2
> from my series loosened this, which makes index-pack work, but not
> necessarily the rest of git. And since index-pack is the gatekeeper on
> receiving objects from remotes, it needs to be the _most_ picky. So my
> series is definitely a regression as-is.

Yeah, at first, allowing the delta resolution so that we can
resurrect data from such a corrupt pack looked a no-brainer
improvement, but I think that is probably a right conclusion.
Thanks for digging this one through.

>      I wonder if index-pack is really the right place for such a "please
>      help me get the data out of this broken pack" operation in the
>      first place. If it is a broken pack, we are probably much better
>      off to explode it into loose objects than try to index a broken
>      pack. That's way less efficient, but this should be a last-resort.

Most objects in such a broken pack do not have to get unpacked, no?
I wonder if we can excise duplicate objects from the pack stream,
which would involve adjusting the delta offset for any ofs-delta
representations that appear after the part we cut out of the stream
to remove such cruft.
