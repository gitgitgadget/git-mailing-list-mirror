From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call to
 callers
Date: Mon, 30 Apr 2012 14:11:38 -0700
Message-ID: <7vsjfkexh1.fsf@alter.siamese.dyndns.org>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
 <20120429115831.GC24254@sigill.intra.peff.net>
 <4F9EBB6D.3090900@alum.mit.edu> <7vd36pgn0e.fsf@alter.siamese.dyndns.org>
 <4F9EF60D.8030301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:11:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxso-0003Rb-S6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab2D3VLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 17:11:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756581Ab2D3VLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:11:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA22C6EFE;
	Mon, 30 Apr 2012 17:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oiZDqT5eVPQ/iCARBoKMYCeGjDg=; b=p68zKU
	fy1OcFMR/JoQAgGDR7SlwuQbDT4ccyDYRhvj9yexzVbnhASP6hLYsDMZ9G5EtkZ/
	LpGhiuywXEc7XCDhrNk9J8tE0Vw6xc2uxCm3oVN5IdSlyVbJfZ2+Mzc+G31rP3Jm
	U/2RV8/v+075AOUzTMZTcVh2i3WIH/WIh8JWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olVF/kKc1XVky++R5ToovXcAPMeFKkiR
	X3Q769enlK8Bj10xCGiDIe4ATi4kq+UUbJ3TibEyivE6eHq8rLKFlgtYK8JXc6D8
	GciAEczgxRgS/ZMnTnwAh4j1i2KBGMlb7t8KQ8WV/fYdnFTRcWjNj+PYodMIs9Rj
	+SqSRCMraqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8216EFD;
	Mon, 30 Apr 2012 17:11:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71C3F6EFA; Mon, 30 Apr 2012
 17:11:40 -0400 (EDT)
In-Reply-To: <4F9EF60D.8030301@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 30 Apr 2012 22:29:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1470F5B0-9309-11E1-91F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196611>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For example, have all of the following code paths been audited to make
> sure that they cannot introduce class (3) refnames into a repository
> (including via symbolic refs with class (3) targets) even in the face
> of a malicious remote?  Can we (and do we want to) rely on this level
> of vigilance being sustained in the future?

Auditing is one thing, but perhaps the right solution to that issue is to
refactor the existing code so that we have only a handful (preferrably
one) API entry point that is used to create a new ref (not to be confused
with create_ref_entry(), which is not necessarily about creating a ref)?

The UI layer may place additional restrictions to the source data used to
eventually lead to a ref creation (e.g. your updated "git branch" may
forbid you to create a branch with the name of an existing tag, perhaps),
but after passing its check, the API to create a new ref will do mandatory
"check-ref-format" check.
