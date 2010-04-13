From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] pretty: Initialize notes if %N is used
Date: Tue, 13 Apr 2010 13:01:31 -0700
Message-ID: <7vzl17t944.fsf@alter.siamese.dyndns.org>
References: <20100413110723.GA2910@coredump.intra.peff.net>
 <1271157981-9767-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 13 22:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1mIx-00031h-Ls
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 22:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0DMUBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 16:01:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab0DMUBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 16:01:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF50AAE03;
	Tue, 13 Apr 2010 16:01:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ht9fs5QoJyH7+SeoTzrUeGFedN4=; b=j8PjO1FDYszn8ueIL7a8HLI
	ABUQO2VKbiRfmZbf2M4XrYXfW0poiM8nlIBNMDlYJ/fCxejvDOHB4p8mRVHB3CY2
	ZBKWbqENVCnpkiKIq/8yp5licSMLS4M4xzEtmsQpyNey6UUKBtXRmce2bJ1sLTwB
	3LrVdrm8pW7Nq60fm1Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QRzsypMffFahNOt+1gPgwFDd1ivIOEQdtQg1/WidiE01qiogQ
	EyG7xmsnvIw0Bdwnhs8wtpymgG1kv9Ju/nuHjwJHnR2TOEx14WoBeULqjhr6RUYl
	09Zo4J/IL7IGWYcY5faJFODl43WXVDErbgiyiHFZF8h0VM31EbhUM6VQDA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E54DAAAE02;
	Tue, 13 Apr 2010 16:01:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F63EAADF2; Tue, 13 Apr
 2010 16:01:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EDB38BA-4737-11DF-90EC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144829>

Johannes Gilger <heipei@hackvalue.de> writes:

> +void userformat_find_requirements(const char *fmt, struct userformat_want *w)
> +{
> +	struct strbuf dummy = STRBUF_INIT;
> +
> +	memset(w, 0, sizeof(*w));
> +	if (!fmt) {
> +		if (!user_format)
> +			return;
> +		fmt = user_format;
> +	}
> +	strbuf_expand(&dummy, user_format, userformat_want_item, w);
> +	strbuf_release(&dummy);
> +}

It does not matter for the current set of callers, but it might make sense
to make it the responsibility of the caller to clear *w instead of
unconditionally clearing what have been accumulated in there by previous
calls to this function.  It is not entirely implausible for a new caller
to have more than one user formats, it uses one or more on the same commit
depending on the context, and wants to find all the requirements by
feeding the possible formats upfront to this function to fill a single *w
structure.
