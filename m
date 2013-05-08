From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] shallow clones over http
Date: Wed, 08 May 2013 12:12:16 -0700
Message-ID: <7v38txffqn.fsf@alter.siamese.dyndns.org>
References: <20130403040352.GA8284@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 08 21:12:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua9ms-00049G-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 21:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab3EHTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 15:12:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3EHTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 15:12:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD29E1C4E7;
	Wed,  8 May 2013 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GF1m3Av3LRo8RDJvdM/Bmgp4mrU=; b=I+Zw2W
	Dd0pnmuymgWwe2lJ6nNbOD3nSM5gu5xj4TFE4i9axvyWIHmnlYTEjDBDHnHyg+WQ
	vL03cD4ymlDZaeI363quDHejtu2co1rMiYqw7XRvLTDgUAGiqEkLTON0RZK2EMBD
	Be6BOfzXhnghcQZk/ENq37D81BUJAGye5uapg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AaJ3Tvc4675z1n6e1tkqmjGeghcxgg9n
	ekGklK1ZBz44sGlEdz/TwX3b5vLmAQYO7McPsP9DGv9gtJ+6BgkFCCz8Z97Mkuum
	6TdDWxvbGyCTZKedvdPlr1rJkwy5eht4uB/RbabPyWKtAWj+mSQ9UY2iAKJ86Pk7
	emWvAdIig0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3FC81C4E6;
	Wed,  8 May 2013 19:12:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E0961C4E5;
	Wed,  8 May 2013 19:12:18 +0000 (UTC)
In-Reply-To: <20130403040352.GA8284@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 3 Apr 2013 00:03:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 336E7F5C-B813-11E2-8DC0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223682>

Jeff King <peff@peff.net> writes:

> I'm trying to track down a protocol bug that happens with shallow clones
> over smart-http. As far as I can tell, the bug has existed in all
> versions.
>
> You can reproduce it using the attached repository, which is a shallow
> clone of https://github.com/mileszs/ack.vim.git, like:
>
>   $ tar xzf repo.tar.gz
>   $ cd repo.git
>   $ git fetch --depth=10
>   fatal: git fetch-pack: expected shallow list
>
> In that test my fetch actually hit github.com as the upstream full repo,
> but you can also clone it down locally and demonstrate it with purely
> local copies of git (but it's more of a pain, because you have to set up
> a smart http server).
>
> The last part of the conversation looks like this:
>
>   packet:   fetch-pack< 0000
>   packet:   fetch-pack< ACK f183a345a0c10caed7684d07dabae33e007c7590 common
>   packet:   fetch-pack> have f183a345a0c10caed7684d07dabae33e007c7590
>   packet:   fetch-pack< ACK 33312d4db4e91468957b1b41dd039c5d88e85fda common
>   packet:   fetch-pack< ACK 34d0b2fbc182b31d926632d170bc07d6a6fc3f9b common
>   packet:   fetch-pack< ACK 45c802e07c60686986474b6b05b2c7048330b6b5 common
>   packet:   fetch-pack< ACK e93f693fd2a9940d6421bf9e4ddd1f535994eaa5 common
>   packet:   fetch-pack< ACK 132ee41e8e2c8c545b3aed120171e1596c9211a4 common
>   packet:   fetch-pack< ACK 973deb3145a99992638b2301cfd654721cf35d68 common
>   packet:   fetch-pack< ACK e53a88a4e72d84562493313e8911ada4def787da common
>   packet:   fetch-pack< ACK 90be0bf3eee6f7a0cb9c2377a50610f4ce738da3 common
>   packet:   fetch-pack< ACK aeab88ccf41bf216fde37983bd403d9b913391e7 common
>   packet:   fetch-pack< ACK 5f480935d3ce431c393657c3000337bcbdbd5535 common
>   packet:   fetch-pack< ACK db81e01b433501b159983ea38690aeb01eea1e6b common
>   packet:   fetch-pack< ACK 06c44b8cab93e780a29ff7f7b5b1dd41dba4b2d5 common
>   packet:   fetch-pack< ACK 65f3966becdb2d931d5afbdcc6a28008d154668a common
>   packet:   fetch-pack< ACK 10e8caef9f2ed308231ce1abc326c512e86a5d4c common
>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2 common
>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2 ready
>   packet:   fetch-pack< NAK
>   packet:   fetch-pack< ACK 6b55dd91f2e7fc64c23eea57e85171cb958f9cd2
>   fatal: git fetch-pack: expected shallow list
>
> So we see that upload-pack sends a bunch of detailed ACKs, followed by a
> NAK, and then it sends another ACK.
>
> Fetch-pack is inside find_common, reading these acks. At the beginning
> of each stateless-rpc response, it expects to consume any
> shallow/unshallow lines up to a flush packet (the call to
> consume_shallow_list). And then it reads the acks in a loop. After it
> sees the NAK, it assumes that the server is done sending the packet, and
> loops again, expecting another set of shallow/unshallow lines. But we
> get the next ACK instead, and die.
>
> So who is wrong? Is upload-pack wrong to send an ACK after the NAK?

3e63b21aced1 (upload-pack: Implement no-done capability, 2011-03-14)
claims that the above sequence of acks and naks is what upload-pack
wants to show.

What happens when you disable no-done extension handling on the
server end, I wonder?
