From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Use ref transactions from most callers
Date: Tue, 22 Apr 2014 12:34:44 -0700
Message-ID: <xmqqzjjd40q3.fsf@gitster.dls.corp.google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcgSz-0002tk-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbaDVTet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:34:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaDVTes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:34:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCD957F9A9;
	Tue, 22 Apr 2014 15:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lSih/SxJpyoLArsXLRhmnxwcmlw=; b=GksRIG
	Brnj9OYe8+qLdNwRVQwUBGxtXNLoC61GikGmhOJN1xSRPVCFyFqQNU4cq9YJ/8DX
	LkRpIVcXNUo2OGJmJiNsr+F2kRXyVS9zXP2W7pWd13XbGA7D1zUDVDsvh/d81twK
	fhz0G+CrqJdD+TGWb+N/AUj8W1Qxyuo0RJIxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjAYIBbEFuu4rCrRCWe66Vsw6gd3yiAL
	DreRDYn7XxlWYl612B5brhCY2XKZXvQEe81JWlRROZo6ugrf2pedzAKOJFerw3fP
	xazZiGVILwUUiq2syERaPaPV7cwgC9Ps61pwHYcx5/PJ5OFVJkdhMuSXJJYXxfXu
	9Vnl3dPttkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C40AE7F9A8;
	Tue, 22 Apr 2014 15:34:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0EE7F9A6;
	Tue, 22 Apr 2014 15:34:46 -0400 (EDT)
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 21 Apr 2014 15:53:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29147C5A-CA55-11E3-81C8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246775>

Ronnie Sahlberg <sahlberg@google.com> writes:

> This patch series changes most of the places where the ref functions for
> locking and writing refs to instead use the new ref transaction API. There
> are still three more places where write_ref_sha1() is called from outside
> of refs.c but those all will require more complex work and review so those
> changes belong in a different patch series.
>
> Version 2:
>  - Add a patch to ref_transaction_commit to make it honor onerr even if the
>    error triggered in ref_Transaction_commit itself rather than in a call
>    to other functions (that already honor onerr).
>  - Add a patch to make the update_ref() helper function use transactions
>    internally.
>  - Change ref_transaction_update to die() instead of error() if we pass
>    if a NULL old_sha1 but have have_old == true.
>  - Change ref_transaction_create to die() instead of error() if new_sha1
>    is false but we pass it a null_sha1.
>  - Change ref_transaction_delete die() instead of error() if we pass
>    if a NULL old_sha1 but have have_old == true.
>  - Change several places to do  if(!transaction || ref_transaction_update()
>    || ref_Transaction_commit()) die(generic-message) instead of checking each
>    step separately and having a different message for each failure.
>    Most users are likely not interested in what step of the transaction
>    failed and only whether it failed or not.
>  - Change commit.c to only pass a pointer to ref_transaction_update
>    iff current_head is non-NULL.
>    The previous patch used to compute a garbage pointer for
>    current_head->object.sha1 and relied on the fact that ref_transaction_update
>    would not try to dereference this pointer if !!current_head was 0.
>  - Updated commit message for the walker_fetch change to try to justify why
>    the change in locking semantics should not be harmful.

Will queue, but when applied on top of mh/ref-transaction and tested
standalone, it appears to fail test #14 of t5550-http-fetch-dumb.sh
for me.

It seems that the culprit is that this step:

    git http-fetch -a -w heads/master-new $HEAD $(git config remote.origin.url) &&

creates ".git/heads/master-new" when what it was asked to create was
".git/refs/heads/master-new".  Perhaps there is something fishy in
the conversion in walker.c?  We used to do lock_ref_sha1() on
"heads/master-new", which prepended "refs/" prefix before calling
lock_ref_sha1_basic() that expects the full path from $GIT_DIR/, but
ref_transaction_update(), which wants to see the full path, is still
fed "heads/master-new" after this series.
