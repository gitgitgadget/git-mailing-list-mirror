From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pack v4 again..
Date: Sun, 15 Feb 2015 23:12:24 -0800
Message-ID: <xmqqlhjy72jr.fsf@gitster.dls.corp.google.com>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
	<alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
	<20150216064537.GF32381@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Pitre <nico@fluxnic.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:12:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNFr5-0003Ys-8h
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 08:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbbBPHM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 02:12:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752113AbbBPHM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 02:12:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C14242BC2C;
	Mon, 16 Feb 2015 02:12:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NgKkXmw/AUAlGgpiOcoAf9tfv4c=; b=jruEpK
	Y0bWaFhmyBswopQx7xSAwYBIIqAp2s19b9K8+iAMQr7gTwdt2R0SRkwANjcTM2cT
	t6lcMCpwWg9uBLYvBmjr8R3iUsExsQuIYDq2Y37Orj0KqBEC1Hj0BgPJqyrsA2K1
	iCXzy7HyuPet3sZACNsQAQjPiyBgdVF8Fj/R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ebOoxwNUtdaKvcTPuYD6qSZiJVt1w1eo
	xmY0WgIs9TyFupK/J8Q05QdknYo/crwz4vCnlTUc2ODpq/UzRWzaEWqzEJNj4owG
	P5GXvnj26X6/hrh734S3DLZDHFe1sTygiCa/JYiGlEu8UbMzql2pXVr0H+UBy6yo
	+g3gF6t5aLg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B75382BC2B;
	Mon, 16 Feb 2015 02:12:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D3242BC29;
	Mon, 16 Feb 2015 02:12:25 -0500 (EST)
In-Reply-To: <20150216064537.GF32381@peff.net> (Jeff King's message of "Mon,
	16 Feb 2015 01:45:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2891A360-B5AB-11E4-88F2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263885>

Jeff King <peff@peff.net> writes:

>   2. Calculating reachability for packing[1] spends a lot of time in
>      lookup_object, as we have to go through each tree saying "have we
>      seen object 1234abcd yet?". If we could instead just view the
>      differences, we would not have to make those hash lookups for
>      entries whose objects we know we have seen.

Hmm, that is an interesting idea.

> So in short, we may end up anywhere within a tree object and need to
> walk backwards to the start of the entry. But we cannot walk backwards
> looking for a NUL, because it may also be part of a sha1. You can only
> reliably parse a git tree by starting at the beginning of the stream and
> going forwards[3].

That in general is true for non deltified tree object (you cannot
take advantage of the fact that entries are sorted by pathname to
bisect to directly jump to an entry).

> If we knew that our deltas were always produced on entry-boundaries (a
> "character" in your description above), this would be much simpler.

;-)

> [2] One option, of course, is to generate byte-wise deltas, but with a
>     promise to always align them on entry boundaries. I'm tempted by
>     this, because the result would be readable by existing packv2
>     readers. We'd have to set a flag somewhere that indicates the pack
>     was written with this property, though.

Yes, that may work.
