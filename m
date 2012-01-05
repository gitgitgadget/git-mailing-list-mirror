From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: try internal cache before reading object
 db
Date: Thu, 05 Jan 2012 13:35:50 -0800
Message-ID: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
References: <20120105210001.GA30549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 22:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Riuyd-0004kE-TH
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab2AEVfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 16:35:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289Ab2AEVfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 16:35:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAAFD65B0;
	Thu,  5 Jan 2012 16:35:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9Wktj1fiIH8zKdD3ecysuskIAE=; b=edihW/
	OGW/j7TIvwpdUXa/Uhs2vLlYJYl3HSijkQzAFhY2Pgmk/kkiuaLahubpXJFk7Ve3
	uKZkxxMpPEeEl33RXHUANuVxGBuFs0fl0cEVDQEaeTU6RbK4PApVc3+9o0CfRJWn
	DiL7sIkvAzlHkLbswDL6E6jt+pSqKiLwsl3pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FagYXOh1RQGdbQwhXucc8fvCSfGyanj/
	dlsQuGeYDg2w6APp+OfZEnJ27LdS0MAyOD5JLHKnhAD1KaYgLN+1w93pMMRgfO0B
	phv8IlSGHtxDG3M2zgiBFVEIpQ4j/Gxlcowh5EaEmk1uoqYWulVxw3UtTQzsDjZ6
	SOp1KfWoaX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B222A65AF;
	Thu,  5 Jan 2012 16:35:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3090365AE; Thu,  5 Jan 2012
 16:35:52 -0500 (EST)
In-Reply-To: <20120105210001.GA30549@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 5 Jan 2012 16:00:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DD2FDF6-37E5-11E1-B1C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187996>

Jeff King <peff@peff.net> writes:

> This might seem circular, since step 2a uses the type
> information determined in step 1 to call the appropriate
> lookup function. However, we can notice that all of the
> lookup_* functions are backed by lookup_object. In other
> words, all of the objects are kept in a master hash table,
> and we don't actually need the type to do the "do we have
> it" part of the lookup,...

The only case that might matter is where you read one object, you have
written another object of a different type but that happens to hash to the
same SHA-1 value. The other existing optimizations do not take that into
account, so I do not think there is any new issue here.

> For example, GitHub's alternates repository for git.git has
> ~120,000 refs, of which only ~3200 are unique. The time for
> upload-pack to print its list of advertised refs dropped
> from 3.4s to 0.76s.

Nice. I am more impressed by 120k/3.4 than 3.2k/0.76, though ;-)

Thanks.
