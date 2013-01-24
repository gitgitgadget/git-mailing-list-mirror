From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Thu, 24 Jan 2013 08:51:33 -0800
Message-ID: <7vzjzycyne.fsf@alter.siamese.dyndns.org>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
 <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
 <1C90CE32-F559-4E76-915E-93642F614552@me.com>
 <7vfw1rfmw2.fsf@alter.siamese.dyndns.org>
 <20130124063259.GA610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathon Mah <jmah@me.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyQ1x-0005zZ-E2
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 17:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3AXQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 11:51:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab3AXQvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 11:51:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A06C446;
	Thu, 24 Jan 2013 11:51:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kiIyP+H+AJEzY+JNMGZK8Wr3qYA=; b=vmEkNQ
	rkG3Kw3E3lbSNNkYBIHO/e2Q3rIzQanXznDVrYFoLibVQY4BYCe23iSK33otcI/3
	bwvFAFTcoVNQBxy2fWE0tjCJvn/0sM518M9V5cw5pMbmwqWnnp4jhaHtYR56drNK
	R1cC9mGsPVm2JuJjJnrmrvG6BRWRcY4msSFCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmAOX2DSaD8BCE19wvhSRxPj3zc7vFI0
	iqG88WlmzfXK0zndpByY2e1UJRaTDkCwkEFvu9nbRBEtH2WLV+7a8RVBjhjl5Rfc
	9JOPwk6vmsW7HFibB47R36eah8Nu+grXJz0CE5qbY33pEvXAyp0n/+kzYEtD6O2/
	EN5+RzqWG+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F237CC444;
	Thu, 24 Jan 2013 11:51:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5568EC443; Thu, 24 Jan 2013
 11:51:35 -0500 (EST)
In-Reply-To: <20130124063259.GA610@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 01:33:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 502FA608-6646-11E2-B001-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214432>

Jeff King <peff@peff.net> writes:

> The ensure_commit_buffer function could look something like:
>
>   int ensure_commit_buffer(struct commit *item)
>   {
>           enum object_type type;
>           unsigned long size;
>
>           if (!item)
>                   return -1;
>           if (!item->object.parsed)
>                   return parse_commit(item);
>           if (item->buffer)
>                   return 0;
>
>           item->buffer = read_sha1_file(item->object.sha1, &type, &size);
>           if (!item->buffer)
>                   return error("Could not read %s",
>                                sha1_to_hex(item->object.sha1);
>           return 0;
>   }

The more important issue is when to release them.

Only the subcommands that know that what they are doing do not need
to access commit->buffer and they operate solely on parsed data are
suppposed to flip the save_commit_buffer bit off to reclaim the
memory early, so new callers that violate that assumption may want
to call ensure_*, but if they did so when somebody cares about the
memory pressure enough to turn the bit off need to free the buffer
themselves after they use it.  Otherwise the resulting program may
still be "correct" but we will end up keeping buffer that nobody
will use, just in case it is asked again.
