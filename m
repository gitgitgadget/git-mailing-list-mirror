From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 14/26] Add stateless RPC options to upload-pack,
 receive-pack
Date: Wed, 28 Oct 2009 20:42:31 -0700
Message-ID: <7vd446dfx4.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-15-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 04:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Luh-0001US-8w
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 04:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZJ2Dmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 23:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZJ2Dmw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 23:42:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZJ2Dmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 23:42:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4810C6BA70;
	Wed, 28 Oct 2009 23:42:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iDyJsX3VnCL1KBimrHWEyVQVD/8=; b=wDEbQp
	96jK3gaE688SpfmAGwZkOqpM1NYH8RxjTQx09xwaNw+zxCFqBib0uKUU8XXBpCjl
	c2aD+j1rxOMrnfr5kuAFHT2sYrD+ZSkvlon0+H3VITnp5dsAzd5Q3xuHN7QCq4Qc
	+BjoPRYD7sQDHKEZOuR38ed5U5H1yx7iV/uBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LI8LC0UiTTLsRyr0AGhC0jZZrK5guzUq
	lgLCP1Eew2rB00csF9pdCLwXieVKUs1dTuS9MtL7NprWD4470Chv2lEu83kdRRPC
	oFI3nwo5VAK9rp52bBXuRL+CtjBDJg/MlwEYlYHoQnMClsQ8m63/YPN1iiVtwgBF
	nMgxZye2D/4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5A36BA6D;
	Wed, 28 Oct 2009 23:42:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9586B6BA66; Wed, 28 Oct
 2009 23:42:42 -0400 (EDT)
In-Reply-To: <1256774448-7625-15-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Wed\, 28 Oct 2009 17\:00\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 233A6704-C43D-11DE-A800-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131553>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> When --stateless-rpc is passed as a command line parameter to
> upload-pack or receive-pack the programs now assume they may
> perform only a single read-write cycle with stdin and stdout.
> This fits with the HTTP POST request processing model where a
> program may read the request, write a response, and must exit.
>
> When --advertise-refs is passed as a command line parameter only
> the initial ref advertisement is output, and the program exits
> immediately.  This fits with the HTTP GET request model, where
> no request content is received but a response must be produced.

Is the idea to first run with --advertise-refs to get the set of refs, and
then doing another, separate run with --stateless-rpc, assuming that the
refs the other end advertised does not change in the meantime, to conclude
the business?

I suspect that two separate invocations on a (supposedly) single
repository made back-to-back can produce an inconsistent response in
verious situations (e.g. somebody pushing in the middle, or the same
hostname served by more than one mirrors) and the other end can get
confused.

I do not think there is any way to avoid it, short of adding to the second
request some "cookie" that allows the second requestee to verify that the
request is based on what he would give to the requester if this request
were the first step of the request made to him, iow, his state did not
change in the middle since the first request was made (either to him or to
the equivalent mirror sitting next to himm).

I wouldn't worry too much about this if the only negative effect could be
that the requestor's second request may result in an error, but I am
wondering if this can be used to attack the requestee.
