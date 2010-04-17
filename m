From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: use 64-bit integers for diffstat calculations
Date: Sat, 17 Apr 2010 10:00:44 -0700
Message-ID: <7vvdbq2ev7.fsf@alter.siamese.dyndns.org>
References: <20100416135948.GA26918@zakalwe.fi>
 <4BC87BE9.9040704@dbservice.com>
 <20100417102543.GB23110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>,
	Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BO9-0007AX-Ci
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0DQRA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:00:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0DQRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:00:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F725AAFA4;
	Sat, 17 Apr 2010 13:00:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+5i822iifuZ08j5RQ6rmDNhMx+8=; b=OumnCs
	0qXxa9t0dnW2sJi1HFPfBT+88iLnxym6RnbggnfYBoSUJlIayqJUq6YDJeVi9m9L
	rCW/zphDpMNodAFxMQDFW1dJN4Ds0r6OirlxhiIBdUua3I3aqpBj3koDfv4K0NRX
	dpoZJHEKqDJ7wLXuxIW4dT9t7qY5C1WPh51e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U8Y9FFbTa+MKPFQcWqrXByHEg7exwThT
	a7behdzRZpna3RAkZ0ULMCWF6dgRQBXDvnMLbrlY0ihR1Ojd1+SYEQ0bTx2ZK/Fi
	ThxpJMTC9TlSw6e92PyhfiQXKRSqmGADZS64V5f8LY/UZKXksxo667Zo4DMBBl/T
	BHRB/HIZfCU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 245EBAAFA3;
	Sat, 17 Apr 2010 13:00:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A8FEAAF9F; Sat, 17 Apr
 2010 13:00:46 -0400 (EDT)
In-Reply-To: <20100417102543.GB23110@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 17 Apr 2010 06\:25\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6FC098E-4A42-11DF-85B3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145158>

Jeff King <peff@peff.net> writes:

> Yuck, we use "unsigned int" for the actual storage, and then convert to
> a regular "int" in some other places. I think we should just do this:
>
> -- >8 --
> Subject: [PATCH] diff: use 64-bit integers for diffstat calculations
>
> The diffstat "added" and "changed" fields generally store
> line counts; however, for binary files, they store file
> sizes. Since we store and print these values as ints, a
> diffstat on a file larger than 2G can show a negative size.
> Instead, let's explicitly use 64-bit integers.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Yes, but we would probably be better off using using uintmax_t for things
like this if the quantity a variable represents is not closely tied to
external file format (e.g. the offset field of pack idx file), nor the
code is only for a particular platform (e.g. compat/win32mmap.c), don't
you think?

That is the impression I am getting on the discipline expressed in the
current codebase, from browsing the output from "git grep uint64_t".
