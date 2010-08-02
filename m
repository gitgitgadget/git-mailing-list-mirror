From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep
 foo
Date: Mon, 02 Aug 2010 10:03:17 -0700
Message-ID: <7vvd7tlzfu.fsf@alter.siamese.dyndns.org>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 19:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfyQE-0006Ap-4j
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 19:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0HBRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 13:03:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0HBRDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 13:03:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5451CA5FF;
	Mon,  2 Aug 2010 13:03:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RDUmmtHHiDLoRUieWgFZ0D55+Q4=; b=r5G2y3
	6GlkF+c/uzQa9pi5hSpDDGiXFuooiiksTh4aRxIf1a6QpJf5VKY4GY0kDM8wDTf1
	jB9kfkV/a2T3okKLda+807dL8LGcqaxFtT1SQ8e8fJEzR2rzy78ImOcSZASWyV3o
	nakRQrb6+De4wVCB0UCzh74P7JaC8PjbAfw4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VP7YM7yT1/OWRH2sZKKNdXXwOugwclvM
	A6D1cHs87VmTyujCJz3dRbxfQuledYZ+B34sq0Nhf2VahfJPJnQSo/fDwJeplE6S
	RiWbuDWh+uNzdRfip4RWLGIjCqjTuUX6iYK5cnQ6XIFNhlQEIH7AvFxgHRVt+h+K
	hNMJLN/NzRI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95738CA5FB;
	Mon,  2 Aug 2010 13:03:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9FF0CA5FA; Mon,  2 Aug
 2010 13:03:18 -0400 (EDT)
In-Reply-To: <1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 30 Jul 2010 10\:31\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DADFC9AE-9E57-11DF-A723-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152425>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  revision.c     |   74 ++++++++++++++++++++++++++++++++++---------------------
>  t/t4202-log.sh |    7 +++++
>  2 files changed, 53 insertions(+), 28 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 7e82efd..359b1a1 100644
> --- a/revision.c
> +++ b/revision.c
> ...
> @@ -1295,6 +1305,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->pretty_given = 1;
>  		get_commit_format(arg+8, revs);
>  	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
> +		/*
> +		 * Detached form ("--pretty X" as opposed to "--pretty=X")
> +		 * not allowed, since the argument is optional.
> +		 */
>  		revs->verbose_header = 1;
>  		revs->pretty_given = 1;
>  		get_commit_format(arg+9, revs);

The patch overall looks good, and this comments illustrates the issue
rather well.  When the user wants to use "--longopt val" syntax, s/he
needs to know that "--longopt" will always take a value.  Arguably
majority of options that can take value will, but like "--stat X,Y" this
leaves things inconsistent.  Without "--longopt value" patch there won't
be such an inconsistency, but I think this patch series is lessor of two
evils.

Don't you by the way regret the naming of the parsing function by now?
There is nothing "diff" about it anymore.
