From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 13 Oct 2010 12:31:10 -0700
Message-ID: <7vvd55lwjl.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
 <20100929214107.GA4485@capella.cs.uchicago.edu>
 <7v4ocpncli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Kaseorg <andersk@ksplice.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:31:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P672s-0005hu-Lz
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab0JMTbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:31:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab0JMTbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:31:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB1FDE7D6;
	Wed, 13 Oct 2010 15:31:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sSj/DNb9xak2GEVuFTv65WC2c0Q=; b=chsyUS
	mLYnBU0JIOTkqLQGmlVma8qkLzfpBFzuQ2Ps4ujlgs79cOK8ulPaHvAa8XeTsLJd
	UqChXZGg2nhrRS3/rPF9mvNnXghxkdLz+ZHhDvTLJHg19n3smgNag5g2ftgiSJ97
	m1+O70sHKJwaqMisznZ6NpJkM9cYppuNLiz9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuLDWdx/UzOWvf2E9sQJvZty8eTf1GKW
	FnlajFdI1hektBn/epbZXysa/m2t0yBixqkbmdhQfy8dwaHhtFjE102bzvIipurY
	cGjszR7QIcAkw4PuYYMSSn/QdWkgkw+YbPwZ114Ze+HYssPt3048AZCW0M6rKYZb
	qTkAT/SC2o0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6691DE7D5;
	Wed, 13 Oct 2010 15:31:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD8FCDE7D4; Wed, 13 Oct
 2010 15:31:11 -0400 (EDT)
In-Reply-To: <7v4ocpncli.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 13 Oct 2010 11\:59\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 729B2032-D700-11DF-87C0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158964>

Junio C Hamano <gitster@pobox.com> writes:

> Neither the patch nor your suggestion makes much sense to me.  With the
> patch, the regexp is now
>
>     ^(1969-12-31|1970-01-01) <time>(\.0+)? ([-+][0-2][0-9]):?([0-5][0-9])
>
> so $3 is always 3 letters long (i.e. hour with sign), no?  IOW, zoneoffset
> is never divided by 100 by the original patch.
>
> What am I missing?

Well, I was missing that without ':' strtol() goes through to parse $3$4
as a single integer, and the division was done to discard the minute part
and parse it again.

Calling strtol() twice only because some unusual input may have ':' there
feels ugly, but now I understand why the patch is written that way, at
least.
