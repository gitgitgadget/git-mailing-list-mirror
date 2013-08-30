From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] has_sha1_file: re-check pack directory before giving up
Date: Thu, 29 Aug 2013 21:17:57 -0700
Message-ID: <xmqqioyn24ne.fsf@gitster.dls.corp.google.com>
References: <20130830011052.GA21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 30 06:18:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFG9u-0007Sq-8K
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 06:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab3H3ESB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 00:18:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab3H3ESA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 00:18:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D978A36C74;
	Fri, 30 Aug 2013 04:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9o+8Nj+6tuCQ3oivcUQVXSdRR4=; b=ZkCDVT
	na6vHDrrUS6kxPUs+09xzVYnaohQNdtIss2hIKKGjb8bdTVqMW/+LT0ZyVbjOW9M
	0iG21pTYa0cMJwcV0w/Qz6vCyFX/4VsizH/51vAV6dg5Ez07Wtw9aAQVRsNoiw5k
	aVTrW6HmxYEohMV4wYsn4cdHIc/wLABHo7OhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5nPL0frUoGf9Rm2LpO3JozRQvRT6EYd
	IRW9lOkT6f8bqSQf4jiEOISks+MtNNXksrwwQynTVPMMY2BrvNyH8lA7xyLlzdIs
	tE+yRqp2aGSsl4J716yJyJWryDDq/6mHL+p2FuZd4CgBmYywbh9F4+1HrYzkuNa0
	+cdhn1XPHFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB19A36C72;
	Fri, 30 Aug 2013 04:17:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2663836C6D;
	Fri, 30 Aug 2013 04:17:59 +0000 (UTC)
In-Reply-To: <20130830011052.GA21895@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2013 21:10:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2749FD34-112B-11E3-9184-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233389>

Jeff King <peff@peff.net> writes:

> When we read a sha1 file, we first look for a packed
> version, then a loose version, and then re-check the pack
> directory again before concluding that we cannot find it.
> This lets us handle a process that is writing to the
> repository simultaneously (e.g., receive-pack writing a new
> pack followed by a ref update, or git-repack packing
> existing loose objects into a new pack).
>
> However, we do not do the same trick with has_sha1_file; we
> only check the packed objects once, followed by loose
> objects. This means that we might incorrectly report that we
> do not have an object, even though we could find it if we
> simply re-checked the pack directory.

Hmm, would the same reasoning apply to sha1_object_info(), or do
existing critical code happen not to have a problematic calling
sequence like you noticed for repack?
