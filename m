From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] remote: don't prune when detecting overlapping refspecs
Date: Fri, 21 Jun 2013 11:53:25 -0700
Message-ID: <7v4ncrmh22.fsf@alter.siamese.dyndns.org>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	<1371809051-29988-4-git-send-email-dennis@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6Si-0006Iv-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423668Ab3FUSx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:53:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423590Ab3FUSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:53:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CD8A2A397;
	Fri, 21 Jun 2013 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHbTBgM38hp6owfM50Bqi/5Xq+4=; b=bxWiI2
	lnKSgORRs2uZJU7sKU0fa15JTdt30g9GEvN+ME+doyClbPbVa3F31RVMCSKH/M7p
	PPgFiW3+h1KVZtpnmdgpXISlvrpGbuPPRt64Oc6C9GSLLms6Ngcr+zND3wMjmMnx
	H9nCx+uCOaDyBBCerVAjThrp7V7iG+n1ODkqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vb7XnpEbLQmsVtmJ9ii5mOA7v80N/8sq
	CEv7TOsUJNiGSSOtye+YKZsmp1E69fJcZg06ouENWZ/OctNAA9XNbsQ8EbDeEpKj
	u9sSBZovQXCGOffQ3tz3O25E+eojYm6I9tStqjHFd2yvK1HpAPd+r37Y8qyW6xjJ
	CW4hxmCfgdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32CFE2A396;
	Fri, 21 Jun 2013 18:53:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A915E2A393;
	Fri, 21 Jun 2013 18:53:26 +0000 (UTC)
In-Reply-To: <1371809051-29988-4-git-send-email-dennis@kaarsemaker.net>
	(Dennis Kaarsemaker's message of "Fri, 21 Jun 2013 12:04:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB3906AA-DAA3-11E2-96D5-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228652>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> +static int check_overlapping_remotes(struct remote *first, void *priv) {
> +	struct remote *second = priv;
> +	int i, j;
> +	if(!second)
> +		return for_each_remote(check_overlapping_remotes, first);
> +	if(first == second)
> +		return 0;
> +	for (i = 0; i < first->fetch_refspec_nr; i++) {
> +		for (j = 0; j < second->fetch_refspec_nr; j++) {
> +			if(strcmp(first->fetch[i].dst, second->fetch[j].dst) &&
> +			   (!fnmatch(first->fetch[i].dst, second->fetch[j].dst, 0) ||
> +			    !fnmatch(second->fetch[j].dst, first->fetch[i].dst, 0))) {
> +				warning(_("Overlapping refspecs detected: '%s' and '%s', not pruning."),
> +					first->fetch[i].dst, second->fetch[j].dst);
> +				return 1;
> +			}
> +		}
> +	}
> +	return 0;
> +}

This codepath essentially needs the same logic as 1/3, no?  Instead
of open code the inner loop here, can't you call the "check RHS of a
single fetch refspec for overlap with refspecs from a remote" helper
you introduced in 1/3?

The logic in the inner loop shares the same issue as the code in
1/3; it needs to be extended to cover non-wildcard respecs and
non-storing refspecs.
