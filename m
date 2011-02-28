From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] index-pack: --verify
Date: Mon, 28 Feb 2011 10:54:20 -0800
Message-ID: <7v7hckhtwj.fsf@alter.siamese.dyndns.org>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <1298886583-30965-4-git-send-email-gitster@pobox.com>
 <20110228174857.GB17278@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:54:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu8Er-0005Gf-Mx
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab1B1Sy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:54:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1B1Sy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:54:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C36A31D8;
	Mon, 28 Feb 2011 13:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mNFnQq1efncW3XxnoN2d8FvDTiI=; b=YHIG76
	kFujeagqY6GNMMNFVgjn2FdahmW1cg4ClVDy6lERTmTzBSakEBsSE/EOLtWmQrK6
	1Pu/U58NgrsTSiN8BwVldSGHsum/1XOifu/MtPmmjnBHTJq5fCbBNn/Rhp771ZNF
	c72/gNXRRMnQPnHr+7rv8/E6p9Sf5tnT8/8L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1hAQGBnEfNaEX6XH06CjHNJNCzAmAFc
	S9VERvzL3n1pR2PTvrooUYJbRPwWI9MEd/mv/p03peLMwx372wZv6ywuFCJgzDaV
	JpduvHesVPxyxP4TiuAcsEn0VDMjqPL/u9TGsmFCU87P3wuczyYscIYnmG3uvEl5
	43VqahAwqkA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 167C931D6;
	Mon, 28 Feb 2011 13:55:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F235131CE; Mon, 28 Feb 2011
 13:55:40 -0500 (EST)
In-Reply-To: <20110228174857.GB17278@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 28 Feb 2011 09\:48\:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 586332C6-436C-11E0-A032-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168133>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Skim reading the code it mostly looked OK, though the NEEDSWORK
> stuff has to be cleaned up.

Yeah, the part that needs working is about thinking if such a clean-up
(i.e. extracting small piece of code from free-pack-by-name to make an
official API function to free storage for a packed_git while closing the
pack_index and its associated resource) is necessary.  There are other
remaining tasks such as integrating this into verify_pack() function,
which in turn requires to teach index-pack to produce the delta-chain
histograms (i.e. "verify-pack --verbose").  Also the codepath needs to be
taught about the plan for narrow clones---there are places that assume
everything referred to from objects need to exist.  These have higher
priority than this NEEDSWORK comment.

> ... And I wonder if the series cannot be
> flipped around a bit to put the 4/5 earlier and try to avoid a
> stage where `index-pack --verify` doesn't do the right thing on
> the hand-rolled lower 32 bit index limit.

Oh, I fully agree that 4/5 should be squashed into this in the final
round.  I preserved the progression of thought in this WIP as it
illustrated pitfalls to avoid rather nicely (iow, hoping to show others a
BCP of building a series by example).  The separation would also hopefully
have made the series easier to review.

> In this patch I'm not happy about csum-file having this check_fd
> part of its contents. But its probably the shortest way to inject
> validation into index-pack without butchering a large part of its
> index generation function.

Yeah, I am only 70% happy about the approach myself.  Patches and
improvements are welcome, of course.
