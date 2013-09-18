From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] upload-pack: send symbolic ref information as capability
Date: Tue, 17 Sep 2013 21:36:17 -0700
Message-ID: <xmqq8uyuwxtq.fsf@gitster.dls.corp.google.com>
References: <20130906155608.GF12966@inner.h.apk.li>
	<1379471489-26280-1-git-send-email-gitster@pobox.com>
	<1379471489-26280-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 06:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM9V4-0000cV-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 06:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3IREgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 00:36:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab3IREgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 00:36:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B63B73A5F6;
	Wed, 18 Sep 2013 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xEMlkCnqeS5h850Q811mA8MDhEw=; b=lCK31C
	6extRR2t56XQq86qk6XxmlokMy7fEMMUjSUqYzA+0aSfmyLCOiy7VP+h7XCyTnus
	bZNaV39acKzvA8B4B3rpJXluVF7BtoY7ly+wqrC+h2P/juHGw4JywUClahRM2XQf
	OVVTozGtOQEQ+jKDefEEz3FdG/l9tncGLKl2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ooqDTot9hkKE1UznjI6s1UrUk7hdh/JC
	xP7e2+hRmaEdVctvlXchYf1pQo85ATqp2FZEC0lfygyXNz3P6F9cG4+5BTUK38pU
	iy7JjGtsAEy6Eqf2RRlGZRKyVM5eLYJj0LRtx09qLSfJzFpT61ml6tzTMA1SjDj/
	kOWHivPj6mo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A76D13A5F5;
	Wed, 18 Sep 2013 04:36:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BF553A5F3;
	Wed, 18 Sep 2013 04:36:20 +0000 (UTC)
In-Reply-To: <1379471489-26280-3-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Tue, 17 Sep 2013 19:31:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD5BDDE6-201B-11E3-8B10-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234949>

Junio C Hamano <gitster@pobox.com> writes:

>  static void upload_pack(void)
>  {
> +	struct string_list symref = STRING_LIST_INIT_DUP;
> +
> +	head_ref_namespaced(find_symref, &symref);
> +
>  	if (advertise_refs || !stateless_rpc) {
>  		reset_timeout();
> -		head_ref_namespaced(send_ref, NULL);
> +		head_ref_namespaced(send_ref, &symref);
>  		for_each_namespaced_ref(send_ref, NULL);

This one was trying to be too clever; HEAD may be pointing at an
unborn branch in which case head_ref_namespaced() will not emit
the capability bit, so the second line also needs to be

	for_each_namespaced_ref(send_ref, &symref);
