From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] implement submodule config cache for lookup of submodule names
Date: Thu, 12 Jun 2014 14:58:20 -0700
Message-ID: <xmqq38f96b9f.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
	<20140605060750.GC23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvD0x-0007jU-JW
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 23:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbaFLV61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 17:58:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbaFLV61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 17:58:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66A281FE86;
	Thu, 12 Jun 2014 17:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bc8GfOJg+2WArE9YfzDCWP6HJNk=; b=ZELz+B
	wIkMGnC8b+dABgh2j8oWnvYhrgk1hbgXA/gH69QfDyqIcoytjze29IRISJZXZ/G7
	CknqZx0y2nyhlXmh/XgdTYwi2DDaGRFCrny+cqVkFgHFcZt5Kn7EJIHb1HIlKIX/
	BqhJ/1br0YWH2KT3qcnSX9b13AklWQYKGRCTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BesRrEb6A3tqXFjFt5igzyOQTesYsZQI
	QNnbMM0Xha7lRqd8he0jOPfAtWYtH1pWcAub6eN/Nm0v6NE+7bhZ0aCqGp+loUg4
	gFEvWs/JnAmxDde93drSvY6gqwSnxaNdbom1ptY5actd5RIuPVuHtNasVt2tAZwa
	MiPBdcQcc7k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B1BA1FE85;
	Thu, 12 Jun 2014 17:58:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5400C1FE7C;
	Thu, 12 Jun 2014 17:58:22 -0400 (EDT)
In-Reply-To: <20140605060750.GC23874@sandbox-ub> (Heiko Voigt's message of
	"Thu, 5 Jun 2014 08:07:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ABCE8EFC-F27C-11E3-A60E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251498>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> ...
> +static int is_cache_init = 0;

Please don't initialise variables in the .bss to zero by hand.

> + ...
> +	warning("%s:.gitmodules, multiple configurations found for "
> +			"submodule.%s.%s. Skipping second one!",
> +			commit_string, name, option);
> +}
> + ...
> +		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
> +		    strcmp(value, "all") && strcmp(value, "none")) {
> +			warning("Invalid parameter \"%s\" for config option "
> +					"\"submodule.%s.ignore\"", value, var);
> +			goto release_return;
> +		}

These two look inconsistent in different ways.  I think we typically
quote the names like so:

	warning("I have trouble with variable '%s' somehow", var);
