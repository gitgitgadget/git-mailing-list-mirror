From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] git-push: make git push --dry-run --porcelain
 exit with status 0 even if updates will be rejected
Date: Tue, 09 Feb 2010 14:25:11 -0800
Message-ID: <7vtytqyrlk.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:25:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeyWM-0005Dd-Nx
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab0BIWZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:25:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab0BIWZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:25:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BB498E56;
	Tue,  9 Feb 2010 17:25:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOisfjxalx4ZQv45lSRz6gjME5s=; b=SwI1sM
	v7y8iTMApmeFTq6/J8NmoZQyyMKVJcYV81fDOpDkaTdgZdNBS6z7UlKIPGA1nyZd
	LuiNzHNeL8RZIPDSyrB3SJ487yV72Ni4rptpQTxRsvE7LnlJv/o8WrV1isPHIL9s
	bJ/XSUlzTVCjlfl9OebPF2YyhtEQAkvpOWxJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dIEpNQy6lH7tsNYI339IyYg2/RXJ6oHg
	ZW7+J2QA5JWnZ0pFWyFIvnlNnGQQvE4eEtaL/Vt9ifIUZRWt5D75WE8bEan64dtr
	i5NRNaG0w6uTLP/9s210O79FzsWboZvzsKp8B0f4TQv3F/LQ1YIOFm1Lcjpn4NOg
	8fRFuiQWx48=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4CAD98E55;
	Tue,  9 Feb 2010 17:25:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38EF598E54; Tue,  9 Feb
 2010 17:25:13 -0500 (EST)
In-Reply-To: <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org> (Larry D'Anna's message of "Mon\,  8 Feb 2010 15\:31\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF3A4B38-15C9-11DF-A2DF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139450>

Larry D'Anna <larry@elder-gods.org> writes:

> @@ -1052,7 +1053,7 @@ int transport_push(struct transport *transport,
>  			flags & TRANSPORT_PUSH_FORCE);
>  
>  		ret = transport->push_refs(transport, remote_refs, flags);
> -		err = push_had_errors(remote_refs);
> +		err = (pretend && porcelain) ? 0 : push_had_errors(remote_refs);

Hmph, you are doing (rewritten in an easier to follow format)

	if (--dry-run && --porcelain)
		err = 0;
	else
		err = push_add_errors(remote_refs);

here, which I think changes the semantics of what follows immediately
after this hunk, namely:

	if (!quiet || err)
		print_push_status(transport->url, remote_refs,
				verbose | porcelain, porcelain,
				nonfastforward);

Earlier, the logic said "even if you asked for --quiet, we would report if
there is an error" but now you are changing the rule to "under --dry-run
and --porcelain, --quiet means don't ever report the status, even when
there are errors".

I don't necessarily think it is a bad change, but in any case the semantic
change is worth documenting.
