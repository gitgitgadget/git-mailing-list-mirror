From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 06 Jan 2014 15:22:20 -0800
Message-ID: <xmqq4n5ghf0z.fsf@gitster.dls.corp.google.com>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
	<20140106152742.GA26221@sigill.intra.peff.net>
	<xmqqbnzpkrvk.fsf@gitster.dls.corp.google.com>
	<20140106193625.GA27062@sigill.intra.peff.net>
	<xmqq61pwj25q.fsf@gitster.dls.corp.google.com>
	<20140106230348.GA7811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Burke <spraints@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:22:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0JVI-0004Qa-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbaAFXWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:22:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757309AbaAFXWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:22:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A1061105;
	Mon,  6 Jan 2014 18:22:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+g/DQk83wx1k1AnR/uXIkbzQNhc=; b=ZtUSTc
	lyvqy78HKaBaTiewTeJa4pYeDq/rfrSszOywDL77MtC3I3k+m8IBzaeKPD/0iZi2
	Zi2KHf0luKzwPMzW3u4zaQv5+Z8UjQGFNDNQx4zpBqEP0gd/H//kyic1cKDkXthn
	OB2c/xWdOJRJbZHzsZi9HZMp1loAWqrN9OUhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4mA5rrjxYLGnn+TZan2CXgQ4e0Bzu9w
	CK77ZcyFu94BCkQaK69QgUkTrGiwZmGNcus3OW7yqUrCvFOlnGzQjf/KGaP5N4Bl
	1iJWmRv6EmrblRS0kT7bX+woKwoIgeiRBxwh7Aq6Gu7wvxtLjqoikmoSTuH214NB
	ORll1jFrn9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A64A061104;
	Mon,  6 Jan 2014 18:22:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 018A5610FF;
	Mon,  6 Jan 2014 18:22:23 -0500 (EST)
In-Reply-To: <20140106230348.GA7811@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2014 18:03:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6603D7DE-7729-11E3-AE2D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240082>

Jeff King <peff@peff.net> writes:

> Then we ask fetch_refs_via_pack to get the actual objects for us. And
> it checks our refs again, with this call chain:
>
>   do_fetch
>     fetch_refs
>       transport_fetch_refs
>         fetch_refs_via_pack
>           fetch_pack
>             do_fetch_pack
>               everything_local
>                 filter_refs
>                   check_refname_format
>
> Here, the code looks like this:
>
>   if (!memcmp(ref->name, "refs/", 5) &&
>       check_refname_format(ref->name + 5, 0))
>     ; /* trash */

I think this should feed ref->name, not ref->name + 5; an obvious
alternative would be to use REFNAME_ALLOW_ONELEVEL; you are also
right that && is probably a misspelt ||; this is about protecting
ourselves from creating garbage in our ref namespace, so accepting
anything outside refs/ makes little sense.

> It's really not clear to me what the check in filter_refs was trying to
> do. It dates all the way back to 1baaae5 (Make maximal use of the remote
> refs, 2005-10-28), but there is not much explanation. I haven't dug into
> the list around that time to see if there's any discussion.

I think the "funny refs" the log message talks about is about
filtering "we know we can reach these objects via our alternates,
but these are not refs we actually have".
