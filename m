From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] git-core: Support retrieving passwords with
 GIT_ASKPASS
Date: Wed, 03 Mar 2010 11:56:20 -0800
Message-ID: <7vd3zlqivv.fsf@alter.siamese.dyndns.org>
References: <1267616208-3844-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 20:56:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmugM-0002HW-T4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 20:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab0CCT4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 14:56:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0CCT43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 14:56:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0F29E305;
	Wed,  3 Mar 2010 14:56:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xeKSeZk9UXJQ/kA05KS6tUCdl6Q=; b=OUzEHq
	bijaAS1uumQLFk/n01xwwtc5dCu6x1ns4Zh8iqg0YQrdEe2WpUFR2NqXMaOArBsk
	pAN5FqasbOOYGIVcnXqof5bQk26FQ2vuakBa5NnzJkK/+HoBaLupnvhoKf2jIZW2
	OQx1iT6YztYslUepO2CodN/Y5a4u99ZuDUe70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhWz94Pf65f/fAknA3L6uHaBoS8dUlT/
	WJcZ8UQsEcbyGsVet5NBNXMy2vmLdz1v2TuawRTK3RckzV1CSNkoobkZx7QlWCGB
	68Ii3heYCwI+eEaVKSjj94vDb8vKk02Ql4iuF5u5qcRmVIRZyrNGz5+rJnWztFXp
	LDcgLHKVxEw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D71159E303;
	Wed,  3 Mar 2010 14:56:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CF709E300; Wed,  3 Mar
 2010 14:56:21 -0500 (EST)
In-Reply-To: <1267616208-3844-1-git-send-email-lznuaa@gmail.com> (Frank Li's
 message of "Wed\,  3 Mar 2010 19\:36\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D996D860-26FE-11DF-9D14-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141464>

Frank Li <lznuaa@gmail.com> writes:

> imap-send and authority http connect reads passwords from an interactive
> terminal. This behavious cause GUIs to hang waiting for git complete.
>
> Fix this problem by allowing a password-retrieving command
> to be specified in GIT_ASKPASS
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---

It appears that between v3 and v4 you incorporated all the changes J6t
suggested.  I would have preferred to see you Cc him, so that he can
simply respond with "Acked-by:" (or another round of review cycle).

> +char *git_getpass(const char *prompt)
> +{
> ...
> +	memset(&pass, 0, sizeof(pass));
> +	pass.argv = args;
> +	pass.out = -1;
> +
> +	if (start_command(&pass))
> +		exit(1);

I understand that you exit silently here because start-command would have
given diagnostic messages already.

> +	if (strbuf_read(&buffer, pass.out, 20) < 0)
> +		exit(1);

What about this one?  Running out of memory inside strbuf_grow() may have
died with message but other error conditions that do give control back to
the caller seem pretty quiet to my cursory look...

> +	close(pass.out);
> +
> +	if (finish_command(&pass))
> +		exit(1);

This silent exit is correct, I think; wait_or_whine() called by
finish_command() would have reported errors.

> +	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
> +
> +	/*it maybe memory leak because getpass return a static buffer*/
> +	return strbuf_detach(&buffer, NULL);

Perhaps keep this value in a "static char *" in the function and free it
upon entry on the second call?
