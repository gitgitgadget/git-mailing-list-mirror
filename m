From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: avoid sending duplicate "have" lines
Date: Fri, 06 Nov 2015 15:38:00 -0800
Message-ID: <xmqq8u6a3dif.fsf@gitster.mtv.corp.google.com>
References: <1446851773-32390-1-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:38:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuqaY-0002zI-Ij
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 00:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbbKFXiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 18:38:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751839AbbKFXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 18:38:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C50F629C83;
	Fri,  6 Nov 2015 18:38:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jTpXyjL14iHWxNKHQwvioEgxzCM=; b=iOQ+dL
	3DGWSLh4pyb8C9ouMzqHLftlRXnjuqqpELVqMB7sv5pg5lrRqajyNSmgb5iMKriZ
	z0mhGxvRQVeoLm13aHKu8XGVlDzzagNamdx+hgx/M/VAEhGsjZ83JI6qdDSgIpw1
	hQTOSZyEV25fm1E5y8pSRhKE6lugmILVc5OkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SGBU+85PNNLP9XvIAjcz1EiXnG8ixbaL
	ho/KPGKbs1OFsguKmZbWfzQDqfqYST2PEJFzQ/sZvOOM74XjFQIFk6FpS74qtkeL
	bi8rqKhImOEGxcu3EF+OQZBkrTMg1nFG7z2f6x4nFWeswc2u6ImgSWa1OPNXvIYQ
	CuQLhui5GQc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB56929C82;
	Fri,  6 Nov 2015 18:38:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42EEA29C81;
	Fri,  6 Nov 2015 18:38:11 -0500 (EST)
In-Reply-To: <1446851773-32390-1-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Sat, 7 Nov 2015 00:16:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70FD294A-84DF-11E5-966D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281006>

Lukas Fleischer <lfleischer@lfos.de> writes:

> @@ -254,9 +255,9 @@ static void write_head_info(void)
>  	struct sha1_array sa = SHA1_ARRAY_INIT;
>  
>  	for_each_alternate_ref(collect_one_alternate_ref, &sa);
> +	for_each_ref(show_ref_cb, &sa);
>  	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);

Heh, I didn't realize that we already have half a support for this
deduping.  Good find.

We used to show ".have" from alternates first and then our own, but
now we show the refs that matter and then ".have"s from alternates
and ".have"s for our repository outside the current namespace.  That
shouldn't cause problems and the result would probably make more
sense from aesthetics point of view ;-)

I suspect that many of these that turn into ".have"s point the same
object as those sit at the tip of our refs (e.g. tags in alternates
we borrow from, which are the folks of the same project that copy
the same tags from the same upstream).  I wonder if it easy to filter
them out?  After all, if we say object X sits at refs/tags/v1.0
there is no point showing ".have" for that same object X.

>  	sha1_array_clear(&sa);
> -	for_each_ref(show_ref_cb, NULL);
>  	if (!sent_capabilities)
>  		show_ref("capabilities^{}", null_sha1);
