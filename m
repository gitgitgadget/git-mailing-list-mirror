From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] send-email: Don't use FQDNs without a '.'
Date: Thu, 08 Apr 2010 22:36:11 -0700
Message-ID: <7v1vep427o.fsf@alter.siamese.dyndns.org>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
 <1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06tT-0004ML-5p
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0DIFgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:36:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0DIFgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:36:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC811A9F7B;
	Fri,  9 Apr 2010 01:36:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GwDvyQZtK6kY5RmcxOE52LGWwqs=; b=HYPz7N
	G9u4F0iCpPaS/XJ/oChoXX8J1B0LsSjGqx3LO+XB4whLp0N75k5YEzvOaSSuahsT
	dixCViUcTSgFx55yP/vkqM4+VGutvwHn8fNyaB4U27vTrSIn8CKjFpaCH+vKZa6Z
	gSISoKYEyyMMjhX8+zeh1J0wqUn3mKncTV8EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzE29C32c3/bwWpKCu/+D1oRg9cj30S0
	EK1x7cpH0ILVP8923cxuYfntp/U9IrkH9oqpwnc4n2+hsYjxfZM7wXLtIDVtRZnf
	QM7HZDT479eIthOmxTITdqRrSVlhIxSf6TPzysnSkNojbmTDpqXNpxoiWm8+WYQ5
	+mb3xds0zhE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B51A1A9F77;
	Fri,  9 Apr 2010 01:36:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00B71A9F73; Fri,  9 Apr
 2010 01:36:12 -0400 (EDT)
In-Reply-To: <1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Fri\,  9 Apr 2010 01\:11\:44 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D16D5C60-4399-11DF-A031-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144404>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

>  		$maildomain = $domain
> -			unless $^O eq 'darwin' && $domain =~ /\.local$/;
> +			unless $^O eq 'darwin' && $domain =~ /\.local$/
> +				or $domain !~ /\./;

It would become *much* easier to read if we stop using the statement
modifier, and write it in a more straightforward way:

	unless (($^O eq 'darwin' && $domain =~ /\.local$/)
        	|| $domain !~ /\./) {
                $maildomain = $domain;
	}

as the condition seems to have grown large enough to exceed "by the way
don't do this under this narrow condition", which is what statement
modifiers are designed to be used.  Also mixing && and or that have
different precedence taxes readers' brainpower unnecessarily.

I also think that this particular exception logic should probably be in a
separate helper function that is called from the two places.

Jari, you are the last person who touched code around this area.  What do
you think?
