From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 06 Feb 2012 00:32:13 -0800
Message-ID: <7vk4408ir6.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJzq-0007g8-NO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab2BFIcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:32:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab2BFIcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:32:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0821D5410;
	Mon,  6 Feb 2012 03:32:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DCNNMVJJHOwt62mjRSxSHLX11Q=; b=fDHOeU
	ekSDkaDIH6PjkEwEJjwDANKh+hGA78wy2Snz9vmud19176izQoEyCS1B9/FekQhE
	nl2Ims8AnlsNdWuYKeQVz5K1EARpvU7Ec3LzQwzzsFsHrvq8TRkCxoAsOxSYw0Gc
	h7+sfl4BSUr2mN0/XJzqdInrxpAdFqFkkkVA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jO5yGFvNfPg0W3Yx9VPpSr/CmJMmfYon
	vw887+NJLWCZr6t2a6vwPWbrirghZpoW8LUXE11vu5N8C74sqhpRbY89KKGoDWDk
	ChhwtsWrEz3u7IwB6C4kX8snHNXDQFUVwLflv+PLk1RiZwUabIa7p6PNQBdIXkh1
	hQ6cqMjDGPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F19540F;
	Mon,  6 Feb 2012 03:32:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80824540A; Mon,  6 Feb 2012
 03:32:14 -0500 (EST)
In-Reply-To: <20120206081342.GB3966@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 03:13:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 125380D0-509D-11E1-BFAF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190045>

Jeff King <peff@peff.net> writes:

> The first case is an indication of a broken or corrupt repo,
> and we should notify the user of the error.
>
> The second case is OK to silently ignore; however, the
> existing code leaked the buffer returned by read_sha1_file.
> ...  
>  	buf = read_sha1_file(sha1, &type, &size);
> -	if (!buf || !size)
> +	if (!buf)
> +		die_errno("unable to read object %s", sha1_to_hex(sha1));
> +	if (!size) {
> +		free(buf);
>  		return;
> +	}
>  
>  	/* skip header */
>  	sp = strstr(buf, "\n\n");

Hmm, a pedant in me says a tag object cannot have zero length, so the
second case is also an indication of a corrupt repository, unless the tag
happens to be a lightweight one that refers directly to a blob object that
is empty.

For that matter, shouldn't we make sure that the type is OBJ_TAG? It might
make sense to allow OBJ_COMMIT (i.e. lightweight tag to a commit) as well,
because the definition of "first N lines" is compatible between tag and
commit for the purpose of the -n option.

For example, in the kernel repository, what would this do, I have to
wonder:

    $ git tag c2.6.12 v2.6.12^{commit}
    $ git tag t2.6.12 v2.6.12^{tree}
    $ git tag -l -n 12 c2.6.12 t2.6.12
