From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/13] introduce credentials API
Date: Mon, 28 Nov 2011 13:46:35 -0800
Message-ID: <7v4nxnvs1w.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110105.GA8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 22:46:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV92C-0002fa-S6
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 22:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab1K1Vqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 16:46:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab1K1Vqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 16:46:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E89164E4;
	Mon, 28 Nov 2011 16:46:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0kuNO3Zfi3gc+pEDBsBwZd6e8hE=; b=SryAz/
	YvCM3e2QxBeFNaIHgEDfR87n/Ve2hnK6zQ5zuBHKapKX5HrPRNibf4EZat7EhRoC
	eGP1/IAFNXwSsStFJinu7MgF89JO1W2HSl0bG58Ih2lInA3djyGHNq8f0DzDWSDb
	O5QjW7kU5f2S3Cz/Iq0kz5HlogFi5/48bhzKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYSWwh+pYUYyiMsUXTG0FdDe+LcSH9iM
	843HfoNQ0263Msc0Pn9ls6nItKuOxpUNW9CjON7BLedCfjlJBugOp8ut60k1nqU7
	ww8UEnZfsJqUe2yYziW/dviCTBdrnX8bSVCuCnu+4UKZh8KAh8bs+SLOMD5q/xi4
	DFMdmBS2lBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14BBF64E3;
	Mon, 28 Nov 2011 16:46:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41CE564E2; Mon, 28 Nov 2011
 16:46:37 -0500 (EST)
In-Reply-To: <20111124110105.GA8417@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Nov 2011 06:01:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 729E5862-1A0A-11E1-93DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186035>

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> new file mode 100644
> index 0000000..3061077
> --- /dev/null
> +++ b/Documentation/technical/api-credentials.txt
> @@ -0,0 +1,148 @@
> + ...
> +`credential_fill`::
> +
> +	Attempt to fill the username and password fields of the passed
> +	credential struct, first consulting storage helpers, then asking
> +	the user. Guarantees that the username and password fields will
> +	be filled afterwards (or die() will be called).
> +
> +`credential_reject`::
> +
> +	Inform the credential subsystem that the provided credentials
> +	have been rejected. This will notify any storage helpers of the
> +	rejection (which allows them to, for example, purge the invalid
> +	credentials from storage), and then clear the username and
> +	password fields in `struct credential`. It can then be
> +	`credential_fill`-ed again.
> +
> +`credential_approve`::
> +
> +	Inform the credential subsystem that the provided credentials
> +	were successfully used for authentication. This will notify any
> +	storage helpers of the approval, so that they can store the
> +	result to be used again.

It's a bit hard to read and understand which part of the system calls
these and which other part of the system is responsible for implementing
them, and how "helper" fits into the picture (perhaps calling some of
these interfaces will result in "helper" getting called?).

> +Credential Storage Helpers
> +--------------------------
> +
> +Credential storage helpers are programs executed by git to fetch or save
> +credentials from and to long-term storage (where "long-term" is simply
> +longer than a single git process; e.g., credentials may be stored
> +in-memory for a few minutes, or indefinitely on disk).
> +
> +Helper scripts should generally be found in the PATH, and have names of
> +the form "git-credential-$HELPER".

Is this normal PATH or can a helper be moved away into $GIT_EXEC_PATH?

I briefly wondered if they want to be git-credential--$HELPER; I do not
deeply care either way, though.

> When the helper string "$HELPER" is
> +passed to credential functions, they will run "git-credential-$HELPER"
> +via the shell. If the first word of $HELPER contains non-alphanumeric
> +characters, then $HELPER is executed as a shell command. This makes it
> +possible to specify individual scripts by their full path (e.g.,
> +`/path/to/helper`) or even shell snippets (`f() { do_whatever; }; f`).

The definition of "the first word" above is not specified but it seems to
be "space separated". In other words, 'f() { do_whatever; }; f' would be
OK but 'f () { do_whatever; }; f' would not be. Am I reading and guessing
your intention correctly?

Funnily enough, 'f<TAB>() { do_whatever; }; f' would qualify as the first
word having a non alphanumeric.

> +The details of the credential will be provided on the helper's stdin
> +stream. The credential is split into a set of named attributes.
> +Attributes are provided to the helper, one per line. Each attribute is
> +specified by a key-value pair, separated by an `=` (equals) sign,
> +followed by a newline. The key may contain any bytes except `=` or
> +newline. The value may contain any bytes except a newline.  In both
> +cases, all bytes are treated as-is (i.e., there is no quoting, and one
> +cannot transmit a value with newline in it).

Can k or v contain a NUL? The literal reading of the above implies they
could, but I do not think you meant to.

> +int credential_read(struct credential *c, FILE *fp)
> +{
> ...
> +			c->host = xstrdup(value);
> +		}
> +		else if (!strcmp(key, "path")) {
> ...
> +		/* ignore other lines; we don't know what they mean, but
> +		 * this future-proofs us when later versions of git do
> +		 * learn new lines, and the helpers are updated to match */

Two style nits.
