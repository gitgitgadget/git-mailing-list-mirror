From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Sat, 01 Oct 2011 13:41:45 -0700
Message-ID: <7vwrcola0m.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <201109301041.13848.mfick@codeaurora.org>
 <201109301502.30617.mfick@codeaurora.org>
 <201109301606.31748.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 22:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA6Nd-0002a0-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 22:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab1JAUlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 16:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab1JAUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 16:41:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A98665FC;
	Sat,  1 Oct 2011 16:41:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=scgFeS3mtYr8edRMjIYX+6yrtF8=; b=o4M4/W
	EtvdILs4venNGty0bCj+OrRNNYk0gn47DZmBUyZ/coiTE2rv4QoJwfpqhXUKwNYG
	LpHrFn87p06CvbRp1522aiaREioT67d5tiqqkLTRFyy12+VtTnss6ccG8S2e1x4s
	BFhqEqdlCtsxsyJEMMmjwnzv3zt8wc1ZLPbDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bgvllw1FRqo94d34AZCRBLWsny87GSRw
	aGII1WQ1MtnRmTZKGzMEutxjiPeuLZq098F/z3Re4koyNo7iiBDJetGBO2tC2UYd
	7ycnciXxJEdIvuzGTw9a1XkZF5TeYyjBT2h4jl5Jabu4Bzw4/+jG4ema2hB2gIm2
	QRMcFinMGJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A4765FB;
	Sat,  1 Oct 2011 16:41:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C545265FA; Sat,  1 Oct 2011
 16:41:46 -0400 (EDT)
In-Reply-To: <201109301606.31748.mfick@codeaurora.org> (Martin Fick's message
 of "Fri, 30 Sep 2011 16:06:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7C834F4-EC6D-11E0-A338-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182575>

Martin Fick <mfick@codeaurora.org> writes:

> I guess this makes sense, we invalidate the cache and have 
> to rebuild it after every new ref is added?  Perhaps a 
> simple fix would be to move the invalidation right after all 
> the refs are updated?  Maybe write_ref_sha1 could take in a 
> flag to tell it to not invalidate the cache so that during 
> iterative updates it could be disabled and then run manually 
> after the update?

It might make sense, on top of Julian's patch, to add a bit that says "the
contents of this ref-array is current but the array is not sorted", and
whenever somebody runs add_ref(), append it also to the ref-array (so that
the contents do not have to be re-read from the filesystem) but flip the
"unsorted" bit on. Then update look-up and iteration to sort the array
when "unsorted" bit is on without re-reading the contents from the
filesystem.
