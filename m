From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] clean up some of the output from git push
 --porcelain
Date: Fri, 05 Feb 2010 13:07:09 -0800
Message-ID: <7vpr4j1jeq.fsf@alter.siamese.dyndns.org>
References: <cover.1265402797.git.larry@elder-gods.org>
 <ec0db70b8166ee4093a5a2400cd592e4263db20b.1265402797.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVOl-0001lz-Rj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606Ab0BEVHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:07:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933834Ab0BEVHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:07:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF9797FFA;
	Fri,  5 Feb 2010 16:07:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BRh2QECYH3DReLkd3UZH8WYV0Xk=; b=Mhlcfy
	xdOlUy3Q6eXB4iBEWrQFeRfcHGQJHkmdNSN2WPhXT6iQPmISRF9kBu4ox+6wbTQd
	YWd+mcqmLMEOXMcP8hRUH+8XpHrJg6RF3iTGDsmpuWcwKAUAUr770/cP8encHDt7
	XKr/JIRMysN7aaVO0DwacRtUV6Gc/GRuoBipI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFXqAZPMa4QGVXbcaFqqUGwzL11gJd0p
	+hkt8iQPX8jgICjbjcKpzDVxYx4hbdhHJvcqIyfxgl/EfRcl00GoF6PDDlU3suUG
	U8TMbwYmrM9kzRFlUvgr1bzO10KYZO/7iBwJAET1Z7ZILtNNPV0TW+4qd4M2Z6z2
	rkWKxpYjMfc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C5497FF9;
	Fri,  5 Feb 2010 16:07:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D34197FF8; Fri,  5 Feb
 2010 16:07:11 -0500 (EST)
In-Reply-To: <ec0db70b8166ee4093a5a2400cd592e4263db20b.1265402797.git.larry@elder-gods.org> (Larry D'Anna's message of "Fri\,  5 Feb 2010 15\:49\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EF5BCBA-129A-11DF-9357-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139091>

Larry D'Anna <larry@elder-gods.org> writes:

> diff --git a/builtin-push.c b/builtin-push.c
> index 0a27072..ff0b1c6 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -123,7 +123,7 @@ static int push_with_options(struct transport *transport, int flags)
>  	if (!err)
>  		return 0;
>  
> -	if (nonfastforward && advice_push_nonfastforward) {
> +	if (!(flags & TRANSPORT_PUSH_PORCELAIN) && nonfastforward && advice_push_nonfastforward) {

I suspect that it would be a much nicer solution if you turned advice_*
off in very early parts of the codepath after you read configuration and
command line options to see if --porcelain was asked for.  That way, we
don't have to add code check for PORCELAIN next time we add code for new
kinds of advice.  People who are adding new advice_* would grep for
existing one (e.g. "advice_push_nonfastforward") and will notice this
line, but if you had

	if (flags & TRANSPORT_PUSH_PORDCELAIN) {
        	advice_push_nonfastforward = 0;
	}

in early parts of the code, they will notice that as well, and then they
know where to add the corresponding change necessary.
