From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v2] verify_filename: ask the caller to chose the kind
 of diagnosis
Date: Mon, 18 Jun 2012 15:25:04 -0700
Message-ID: <7vipeo2r7j.fsf@alter.siamese.dyndns.org>
References: <7vvcio4mbe.fsf@alter.siamese.dyndns.org>
 <1340043501-6170-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340043501-6170-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 19 00:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgkNp-0007xJ-04
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab2FRWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab2FRWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44A69D3B;
	Mon, 18 Jun 2012 18:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WDE6HICV6dsGUtecmAkGrrLvPGM=; b=Fc2An5
	wJ/u1q3wrZJQCsnvhB3jCyVxNHzc/4jYTWjBFogKY9JdkVT6d2ltn3DH5LgNMXOw
	k+WySnRpBkBlokW9VOauPSfX0exTInJuFAr8rGd1JreWRzXpGUZ29ZZ8efqCURIK
	1bBnDQWKIqE12m769dZd+77LebVGRy/5MJw1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EBcmx/YcJh3OvHMEeZhXbHGoUGePtse6
	zcRMW2glPorceo427cDi8sQLHgVWIQovDXvF5Ju1e8sJS0KPVOz8wEon+LVUweBi
	zE6id/8ZVuBp33u0UH6JeE3UnD6kvBkROpInLZMk+WC4JxzueaXK2PjpT/zFwG95
	jVgJDU3kMlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D25219D3A;
	Mon, 18 Jun 2012 18:25:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56F989D36; Mon, 18 Jun 2012
 18:25:06 -0400 (EDT)
In-Reply-To: <1340043501-6170-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 18 Jun 2012 20:18:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74CC4A8E-B994-11E1-9861-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200177>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> verify_filename can be called in two different contexts. Either we just
> tried to interpret a string as an object name, and it fails, so we try
> looking for a working tree file as a fallback, or we _know_ that we are
> looking for a filename, and shouldn't even try interpreting the string as
> an object name.
>
> For example, with this change, we get:
>
>   $ git log COPYING HEAD:inexistant
>   fatal: HEAD:inexistant: no such path in the working tree.
>   Use '-- <path>...' to specify paths that do not exist locally.
>   $ git log HEAD:inexistant
>   fatal: Path 'inexistant' does not exist in 'HEAD'
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Thanks; both patches look sensible (modulo minor nits below).

Will queue with a local fix-up.

> @@ -80,14 +86,28 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
>   * as true, because even if such a filename were to exist, we want
>   * it to be preceded by the "--" marker (or we want the user to
>   * use a format like "./-filename")
> + *
> + * The "diagnose_misspelt_rev" is used to provide a user-friendly
> + * diagnosis. If 0, the diagnosis will try to diagnose "name" as an
> + * invalid object name (e.g. HEAD:foo). If non-zero, the diagnosis
> + * will only complain about an inexisting file.

I have a feeling that "if 0/if non-zero" above are backwards.
