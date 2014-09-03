From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Wed, 03 Sep 2014 16:14:34 -0700
Message-ID: <xmqq7g1kwb39.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
	<xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
	<xmqqegw08fft.fsf@gitster.dls.corp.google.com>
	<20140829234641.GG24834@peff.net>
	<xmqqwq9o2s6l.fsf@gitster.dls.corp.google.com>
	<20140903222937.GA30560@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPJlH-0001A3-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 01:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935521AbaICXOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 19:14:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65485 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933504AbaICXOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 19:14:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BB1D38448;
	Wed,  3 Sep 2014 19:14:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aRq/T7tS101D3yhTCYtucJ/JMJ8=; b=JZoSmc
	WLVfkfi/cHCj0E5R656fStAvaslwrYhOHK3VSAnuETI9lsK3D0nEsHZZDOajF9bZ
	mc5rME5AmSdSuZhMMb4sqD1S4/ihFIr5HGC/rnhGP/M2ptYUUvFy0hveu6RcMMAj
	jkSnjoCtiWQhWCVSx+Wc1VoPjNwepAPt5W3wA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5rI9+QsZq8ZnTMIAaLOP/+DBfSm7kIw
	Pufi4egrEzBAD+6z21Ya3JQtospatRL9fSBHH6bZRT49I+4zxfUHN40hCkJBSnCw
	vy00CROsUO3scFLzjF6tf6g4z/HdtnUeXTL3aJ/Agst/CAOyxijR9175ZPW16TCW
	pp/pyXASWDM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0251638447;
	Wed,  3 Sep 2014 19:14:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A8B738446;
	Wed,  3 Sep 2014 19:14:36 -0400 (EDT)
In-Reply-To: <20140903222937.GA30560@peff.net> (Jeff King's message of "Wed, 3
	Sep 2014 18:29:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1281AC0E-33C0-11E4-B8F8-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256429>

Jeff King <peff@peff.net> writes:

> This is a bit of an aside, but why do we have the "tag" line in the tag
> object in the first place?

http://thread.gmane.org/gmane.linux.kernel/297998/focus=1410

> It is part of the object contents, and therefore is part of the
> signature (which the refname is not). That's somewhat redundant with the
> tag message itself. E.g., the git v2.0.4 tag says:
>
>   object 32f56600bb6ac6fc57183e79d2c1515dfa56672f
>   type commit
>   tag v2.0.4
>   tagger Junio C Hamano <gitster@pobox.com> 1406755201 -0700
>
>   Git 2.0.4
>   -----BEGIN PGP SIGNATURE-----
>   ...

Yes, usually we write a moral equivalent in a human readable form as
the tag message, but the mapping "s/^v/Git /" between the tag name
and the message is purely by convention, and I suspect some old tags
I have may even have used "s/^v/Git v/" or "s/^v/git v/" or a
similar inconsistent mapping.

> The main advantage of the "tag" field is that it is machine-readable,
> and that your verification process can check that "git verify-tag
> v2.1.0" actually returns a tag that says "tag v2.1.0". But I do not
> think we do that verification at all. I wonder if that is something we
> should add support for.

Yes.  That essentially boils down to "refs/tags/$tag" must have "tag $tag"
line (the reverse may not have to be true if the hierarchy is
outside refs/tags/, though).
