From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 14:40:24 -0800
Message-ID: <xmqqwpqcxk87.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<20160210214945.GA5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:40:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTdR1-00014k-R8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 23:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbcBJWk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 17:40:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbcBJWk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 17:40:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43A4A441C8;
	Wed, 10 Feb 2016 17:40:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MnXpieQa8MgPvCoLbOJobkodpOg=; b=OJqfkk
	ijIFzs1Clkpk5aU4JHRYByGmnJKukBSnqWftDeW9r5tSj/gupALo+CfY95Cf4Dge
	t6DYYIaB+T+8KTA2xmeetQTeEIQ76EW0E22djIHe93Ycp27l69wzGeAzERRmOGpo
	ebeL+g7sgxp+qrnsq9YObDVNfDwtcDg8/J8Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sUy2T5lTtgq/mSlU+mDWzdsC/ZpECW4u
	XoUULG720dMWh2RJUuGV/+gs3La2yfnxhQK99FLOqcEz+i1mTjZQnE8EXlVaMtOT
	1HEb4ZAm702jfn/diCpRJ+mm1o/C8VvI9e36SNCXg4aejAj3oUEwN8PxlprmR+m/
	dT7Q9gLq4ik=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AFEA441C7;
	Wed, 10 Feb 2016 17:40:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B37D7441C6;
	Wed, 10 Feb 2016 17:40:25 -0500 (EST)
In-Reply-To: <20160210214945.GA5853@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Feb 2016 16:49:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47059FB0-D047-11E5-BE0C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285939>

Jeff King <peff@peff.net> writes:

> Clients do not have to _just_ fetch a packfile. They could get a bundle
> file that contains the roots along with the packfile. I know that one of
> your goals is not duplicating the storage of the packfile on the server,
> but it would not be hard for the server to store the packfile and the
> bundle header separately, and concatenate them on the fly.

Yeah, I was wondering about that.  Just storing them as separate
two-file pair on the server side and serving it as if it is a single
file to the client does not sound like a rocket science, and a
reasonable webserver should be able to serve even a byte-range
request out of such a thing.

Of course, updating the clients to understand such a two-file pair
as a valid bundle is a good thing to do, and I like that step 0. you
outlined below.

>   0. During gc, server generates pack-1234abcd.pack. It writes matching
>      tips into pack-1234abcd.info, which is essentially a bundle file
>      whose final line says "pack-1234abcd.pack".
>
>   1. Client contacts server via any git protocol. Server says
>      "resumable=<url>". Let's says that <url> is
>      https://example.com/repo/clones/1234abcd.bundle.
>
>   2. Client goes to <url>. They see that they are fetching a bundle,
>      and know not to do the usual smart-http or dumb-http protocols.
>      They can fetch the bundle header resumably (though it's tiny, so it
>      doesn't really matter).
> ...
