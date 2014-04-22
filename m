From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/13] refs.c: use a single exit path from transaction commit and handle onerr
Date: Tue, 22 Apr 2014 12:11:01 -0700
Message-ID: <xmqqbnvt5ge2.fsf@gitster.dls.corp.google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
	<1398120811-20284-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:11:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcg68-0006fc-1E
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaDVTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:11:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaDVTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:11:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 968617FE83;
	Tue, 22 Apr 2014 15:11:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9QDKTIpYu/0VWWNfFWXZxq3n7kc=; b=QpPPg6
	USm0u6BNtoMJ+2YOXYVS/nycJig6KAUSSYdZrx7HRFghwRc0007CdNyNGhOdSziZ
	0ljbaqkIQw48+cJ4GHmuWdL2deqiifm+mrteKFzniVIIo297Z2gn3gYfO/UiOfwO
	GT6AQG3Z5gETp+MyzCZ/cF42sb61CQLHatQjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKtgB1Hylh1PCblCBvJTs8qQ+WvTnI+C
	Nhno1QBJkbvajI6tLxoZrCjsPBiW48OD0+lwQN0OaB7PWcpwpPY9BOg001VAtJ2a
	xk8K9nTHnvdRUdBn05ozZvZEbW/He1fOtTkfa0qZyUNmGVoML1sNZzu5y67unMTE
	6WiYELzpCWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF567FE81;
	Tue, 22 Apr 2014 15:11:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38F367FE75;
	Tue, 22 Apr 2014 15:11:03 -0400 (EDT)
In-Reply-To: <1398120811-20284-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 21 Apr 2014 15:53:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8FBC19A-CA51-11E3-A73C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246771>

Ronnie Sahlberg <sahlberg@google.com> writes:

> diff --git a/refs.c b/refs.c
> index 138ab70..9daf89e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3414,12 +3414,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  			   const char *msg, enum action_on_err onerr)
> ...
> +	if (ret) {
> +		const char *str = "Cannot commit transaction.";
> +		switch (onerr) {
> +		case UPDATE_REFS_MSG_ON_ERR: error(str); break;
> +		case UPDATE_REFS_DIE_ON_ERR: die(str); break;
> +		case UPDATE_REFS_QUIET_ON_ERR: break;
> +		}
> +	}
>  	return ret;
>  }

I think this is a response to Michael's earlier review "do different
callers want to give different error messages more suitable for the
situation?".  I suspect that the ideal endgame may end up all
callers passing QUIET_ON_ERR and doing the error message themselves,
e.g. branch.c::craete_branch() may end something like this:

    ...
    if (!dont_change_ref)
        if (ref_transaction_commit(..., UPDATE_REFS_QUIET_ON_ERR))
                die_errno(_("Failed to write branch '%s'"),
                          skip_prefix(ref.buf, "refs/heads/));

And in the meantime until the callers are converted, we may end up
showing the fallback "Cannot commit transaction." but that would be
OK during the development and polishing of this series.
