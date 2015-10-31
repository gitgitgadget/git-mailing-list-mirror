From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Sat, 31 Oct 2015 10:40:13 -0700
Message-ID: <xmqqfv0rhr7m.fsf@gitster.mtv.corp.google.com>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
	<20151031000837.GA25849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa8a-0006rG-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbbJaRkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:40:17 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752208AbbJaRkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:40:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0B15259C6;
	Sat, 31 Oct 2015 13:40:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bsZnDIw2PL7wwQrIq81dsYFDpqI=; b=o297Da
	9MyVJ3abSGer4hri4EuubBiCy/x7GtmTbo8AgPH3XZZl2HZfZooOZ/Lx/86t6TjI
	mhmmx4hSbL9a1CqaTT1KKEM6CoFSu0ZDDQvQK0U0qAURJVUKKP4uFH9lqvDmWQML
	G5DYh8yVoY097eCcXd1PfVGtM0ySoIFUMYyTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQvQUk0kwcNtbQVdCgX2ZUr0shVy+5Pz
	yLlvE04KR4znhf8cikTjJxJkEkPxGB2KKK1nTbydXHO1Pn9yjtQDzeAQ+CUGrEse
	eewL/xdU7mTjBFB5DA5hXICXwN+fr/SssSUuM15MnWvOpDiVHAZOWS/mvMcNbxpC
	2rojuk5pUPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8136259C3;
	Sat, 31 Oct 2015 13:40:14 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29C0F259C2;
	Sat, 31 Oct 2015 13:40:14 -0400 (EDT)
In-Reply-To: <20151031000837.GA25849@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 Oct 2015 20:08:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71286828-7FF6-11E5-BF7F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280593>

Jeff King <peff@peff.net> writes:

> We could even hide the whole thing away with something like:
>
>   void http_set_range(CURL *curl, long lo, long hi)
>   {
> 	char buf[128];
> 	int len = 0;
>
> 	if (lo >= 0)
> 		len += xsnprintf(buf + len, "%ld", lo);
> 	len += xsnprintf(buf + len, "-");
> 	if (hi >= 0)
> 		len += xsnprintf(buf + len, "%ld", hi);
>
> 	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
>   }
>
> That would also make it easier to replace if we do need to keep an
> #ifdef for older versions of curl. But maybe it is just
> over-engineering.

I personally do not think this is an over-engineered version.  This
is exactly what I had in mind when I alluded to a small helper ;-)
