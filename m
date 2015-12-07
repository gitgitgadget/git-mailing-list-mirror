From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Mon, 07 Dec 2015 13:27:51 -0800
Message-ID: <xmqqa8pmlzjc.fsf@gitster.mtv.corp.google.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
	<CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
	<20151204215158.GA27987@sigill.intra.peff.net>
	<xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
	<xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
	<20151206063718.GA549@sigill.intra.peff.net>
	<20151206070144.GA17902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63Ku-0000pF-9r
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbbLGV2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:28:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933226AbbLGV1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:27:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F98631543;
	Mon,  7 Dec 2015 16:27:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zsl5iYM3gPq+jsulRCRFIT/MDrc=; b=tmSJaD
	jHen62mMLSJ27iy5NFAVkqSbRPNJObjxkXlYz6GFwnFBhe3sHcYozY8CCt4Czv45
	6zVLnbLAD/NPuJh76E4g8w26Ef2Z4a6WpTXq8o9hKG3+G/WJWnZQ1MwCGKS+AgEh
	WNx4TNb1hsFL59PJ4LmmJj0DYVX0CMGI0IqDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NMlLowRQQDK3xo+QyHgtTrPWVuOIfJ18
	U2jwDulnFW4YkuCWIdrz+a5SWTTIHxqc233LR/lBPDJyiXOINgWVhNNM5+yy3f4E
	O9A34rh+OqI0aj5grVFl/RGkO9sMEOow0sFPLTt409M7UUE8lOYQO4DY8TgFi+Am
	52+nkgFLKYI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9765031542;
	Mon,  7 Dec 2015 16:27:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DB6E3153C;
	Mon,  7 Dec 2015 16:27:53 -0500 (EST)
In-Reply-To: <20151206070144.GA17902@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 6 Dec 2015 02:01:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FD02714-9D29-11E5-A572-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282128>

Jeff King <peff@peff.net> writes:

> I think one thing I was missing is that we need to just grab the
> _object_, but we need to realize that the ref needs updating[1]. So we
> cannot skip backfill of any tag that we do not already have, even if we
> already have the tag object.
> ...
> [1] I'm still puzzled why find_non_local_tags uses has_sha1_file() on
>     the tag object at all, then.

The designed semantics of auto-following tags (not necessarily as
implemented or documented, i.e. there may be implementation or
documentation bugs), I think, is to arrive at the same state as
doing a fetch (or a push) without the auto-following and then doing
a separate fetch (or a push) of tags that point at the objects that
are reachable from the tips of refs after finishing the first
(i.e. without auto-follow) fetch (or a push).  In a scenario where
we already have a commit reachable from existing remote-tracking
branch and the current transfer (be it a fetch or a push, with or
without auto-follow) does not update any remote-tracking branch
(because the source side did not have any changes), if the source
side added a tag that refers to that commit that the receiving end
lacks, that tag needs to be transferred and then stored.

So has_sha1_file() is not the right test---if anything, it needs to
be checking if the object being checked is reachable from a tip of
some ref.

But of course, that test is rather expensive, so perhaps the
implementation cheated and uses has_sha1_file() instead?  The only
case it would misidentify would be after an aborted fetch (or push)
left unconnected island of objects and some of these objects that
are not reachable are pointed at by tags the receiving end does not
have.





 
