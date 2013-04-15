From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/33] refs: change the internal reference-iteration API
Date: Mon, 15 Apr 2013 10:38:51 -0700
Message-ID: <7vvc7nvglw.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-16-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnN0-0004hC-2o
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab3DORjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:39:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3DORjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:39:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B5A15C48;
	Mon, 15 Apr 2013 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PCFQGDQntzkj0WfVGr6ziRmig0w=; b=bU//NW3Xhgh15fWhfxX0
	gdwGm49H6UvN5w5QifqE+X9ia0DiAybFlL+AgYySLsWcgK9EITnRGqHIXE/krGXR
	6Lyg/mqftXqGUJ5PDSwFq/ABGxkKQNSvj6Kgv9tnDNHjBD3VqwpXnn2RmEAr8pbK
	Vksh2E5qJnCq3ywWjBmLdTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xP8aWUD1dTkqRv8qEO6fSkfjUljZOsJUxa0mNlhv8+vSos
	538XBp714Bm5tNDlJkZEh3u0q/D7edOVj6/GWyoxsapgDT2R/vDW4mx5vEBZQsno
	fHUhM0bFga+cgK2WWJkQXsgQBaV7ENyckeVjwV7tPwNQYbl0J5GBlVi88+A50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A8B415C46;
	Mon, 15 Apr 2013 17:39:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9670715C42; Mon, 15 Apr
 2013 17:38:52 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56CA2A6E-A5F3-11E2-84AF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221263>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Establish an internal API for iterating over references, which gives
> the callback functions direct access to the ref_entry structure
> describing the reference.  (Do not change the iteration API that is
> exposed outside of the module.)
>
> Define a new internal callback signature
>
>    int each_ref_entry_fn(struct ref_entry *entry, void *cb_data)
>
> Change do_for_each_ref_in_dir() and do_for_each_ref_in_dirs() to
> accept each_ref_entry_fn callbacks, and rename them to
> do_for_each_entry_in_dir() and do_for_each_entry_in_dirs(),
> respectively.  Adapt their callers accordingly.
>
> Add a new function do_for_each_entry() analogous to do_for_each_ref()
> but using the new callback style.

Nicely done.

>
> Change do_one_ref() into an each_ref_entry_fn that does some
> bookkeeping and then calls a wrapped each_ref_fn.
>
> Reimplement do_for_each_ref() in terms of do_for_each_entry(), using
> do_one_ref() as an adapter.
>
> Please note that the responsibility for setting current_ref remains in
> do_one_ref(), which means that current_ref is *not* set when iterating
> over references via the new internal API.  This is not a disadvantage,
> because current_ref is not needed by callers of the internal API (they
> receive a pointer to the current ref_entry anyway).  But more
> importantly, this change prevents peel_ref() from returning invalid
> results in the following scenario:
>
> When iterating via the external API, the iteration always includes
> both packed and loose references, and in particular never presents a
> packed ref if there is a loose ref with the same name.  The internal
> API, on the other hand, gives the option to iterate over only the
> packed references.  During such an iteration, there is no check
> whether the packed ref might be hidden by a loose ref of the same
> name.  But until now the packed ref was recorded in current_ref during
> the iteration.  So if peel_ref() were called with the reference name
> corresponding to current ref, it would return the peeled version of
> the packed ref even though there might be a loose ref that peels to a
> different value.  This scenario doesn't currently occur in the code,
> but fix it to prevent things from breaking in a very confusing way in
> the future.

Hopefully that means "in later patches in this series" ;-)
