From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Wed, 30 Nov 2011 10:05:24 -0800
Message-ID: <7vzkfdqye3.fsf@alter.siamese.dyndns.org>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
 <20111129205905.GA1793@sigill.intra.peff.net>
 <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Bill Zaumen <bill.zaumen+git@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 19:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVoXW-0004Du-0w
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab1K3SF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 13:05:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab1K3SF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 13:05:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CD26E20;
	Wed, 30 Nov 2011 13:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Df1Tksh+5oopEzVqnQVdbczFZJ0=; b=B8gTic
	ZeQpyCjCHCFDHy7R7vUTfTeP5EDn7u6i+SX+mn5VpW1yHj2X/NXuCDlKozB3vHYK
	Y0wTYCLvkto9UhW52ygClz55eXK+jbbWRW7G1ALjqmDXdQAkgZH4QeRPBL+tmJyn
	jumBB/SNo1siE2AJVLGdl6cny4+h1ljzYLIT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLNB7LekUWr3eIPghS1CDtNZUiYbGrHc
	Bmcq3s0z11HAW6z8YrXkM4RkYDbimMQKQ848C7EbuPeocYLif8fpBznQ8xAJ2cZA
	61TEZ+ERwQYfBa1dzAcfIEKqUUJNeJnnN7/qB9wRyxBNEqNgaUKtnBrXWc4ns1GY
	om88o3uHgqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AADB86E1F;
	Wed, 30 Nov 2011 13:05:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3496C6E1D; Wed, 30 Nov 2011
 13:05:26 -0500 (EST)
In-Reply-To: <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 30 Nov 2011 20:35:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E14CF7F4-1B7D-11E1-9A39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186131>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> What I'm thinking is whether it's possible to decouple two sha-1 roles
> in git, as object identifier and digest, separately.

Why it would be a good thing? If you have a collided identifier, somebody
has to choose which blob a particular tree wants to have at the path, and
because the tree would not record anything but the identifier, you cannot.

> ...
> The day sha-1 is broken, a project can generate new digests from its
> old good repo and enforce developers to use new digests for
> verification instead of sha-1. sha-1 is still used by git as
> identifier after that day.

And an old blob that is identified with a SHA-1 now has a new blob that
has different contents but happens to have the same SHA-1. How does Git
decide which blob to use when a particular object is named by the SHA-1?
