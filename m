From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Tue, 02 Aug 2011 10:24:20 -0700
Message-ID: <7v4o1zg20r.fsf@alter.siamese.dyndns.org>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
 <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 02 19:24:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIhg-0001Do-NG
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 19:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab1HBRYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 13:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab1HBRYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 13:24:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27D53348;
	Tue,  2 Aug 2011 13:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V6e726CfBauaUHxG96AU6f3JR30=; b=b5/hZI
	uxXgSAzGrV/u45pBBPjOCpOW3V+VQSjpqFOE8JbYAzBdwf1YMiydYC3JNMF+Ea0n
	V/THXY3KgLs2ypykzrv3n97K6T2ijdTwpgZunagrzYmZ+qN/2Fn4jJ1hsXrQOV68
	p2srS38ooEpmVW2gpCvBtZYiyLfYa8pVnf1WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5cDvYuT/45Juw7tcS28xRyhnSMWsPIV
	J0fGZUawRSsU9l6K4cGpvIxCvDzbgDR5VWQhRpv27osOSn7ZEB0rGytaOzshxB5k
	nC3OpopdXccx9XEIDHnkpmB7JYTRcVkOtt2iLXekKRwRg0S4fmPz5uJLO5kiPiuV
	b9PXhht4bUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0773347;
	Tue,  2 Aug 2011 13:24:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CFED3346; Tue,  2 Aug 2011
 13:24:22 -0400 (EDT)
In-Reply-To: <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Thu, 28 Jul 2011 12:37:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 431251A6-BD2C-11E0-8343-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178488>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. I'm not sure whether it is correct to fix this problem at the level
>    of git-check-attr, or whether the fix belongs in the API layer.
>    What is the convention for API functions?  Do they typically take
>    path names relative to the CWD or relative to the working tree
>    root, or ...?

I think passing down "prefix" (i.e. where your $(cwd) was relative to the
root level of the working tree) and the user-supplied "pathspec" (which
typically is relative to that original $(cwd)) is the canonical approach.
The very original git worked only at the root level of the working tree,
with paths specified relative to the root level of the tree, so many code
do:

	- find out the root of the working tree;
        - note where the $(cwd) was in "prefix";
        - chdir to the root of the working tree;
	- prepend the "prefix" to user supplied pathspec;
        - forget all the complexity and work on the whole tree.

Then the "prefix" gets stripped away from the beginning of the paths when
reporting.

Your patch from a cursory look seems to follow that pattern, which is
good.
