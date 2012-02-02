From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] grep: cache userdiff_driver in grep_source
Date: Thu, 02 Feb 2012 10:34:07 -0800
Message-ID: <7v4nv9xexs.fsf@alter.siamese.dyndns.org>
References: <20120202081747.GA10271@sigill.intra.peff.net>
 <20120202082043.GF6786@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1U7-0001DB-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933236Ab2BBSeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:34:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695Ab2BBSeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:34:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6102C5C35;
	Thu,  2 Feb 2012 13:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Bl46szxWvZWfaS75kE3TsgkbNo=; b=k2WBlz
	ZnLuvD30Cm2GfjdRHQA3zo3X+iQuD5qbNZ/wL1aL8CpoPcjXGVX5gaGrnnKAdaNG
	uwpKN12Wse58sCndXCjSVEsk78638fzYfU5h6sPugTTFB66mZATbYNrsegWgnlwA
	j9WNgw3j3mmRZx2ipdrDlvKfUlDEQ45H6ARBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iQM8s5rPg/BCw+u1WIWXorlmQGC7/Ijr
	7kP12AAg0OvBxOVqWkJvWt6UYFuMQTq2wtv2KMftP3TifyfvchIw4E5Jq+yMlzcK
	E58vCCdRBPG6ikIVxFfSxUEPSMiRCgaxVpRbGEAWeWurgMBrroVs8lxvOTXBhTfq
	uiKuTfF/ics=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 533B75C34;
	Thu,  2 Feb 2012 13:34:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D423C5C32; Thu,  2 Feb 2012
 13:34:08 -0500 (EST)
In-Reply-To: <20120202082043.GF6786@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Feb 2012 03:20:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E800374-4DCC-11E1-9BAA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189663>

Jeff King <peff@peff.net> writes:

> -		grep_attr_lock();
> -		drv = userdiff_find_by_path(gs->name);
> -		grep_attr_unlock();
> -		if (drv && drv->funcname.pattern) {
> -			const struct userdiff_funcname *pe = &drv->funcname;
> +		grep_source_load_driver(gs);
> +		if (gs->driver->funcname.pattern) {
> +			const struct userdiff_funcname *pe = &gs->driver->funcname;

When we load driver, gs->driver gets at least "default" driver, so we no
longer need to check for drv != NULL as we used to?  Is that the reason
for the slight difference here?

> @@ -1237,6 +1234,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>  	gs->name = name ? xstrdup(name) : NULL;
>  	gs->buf = NULL;
>  	gs->size = 0;
> +	gs->driver = NULL;
>  
>  	switch (type) {
>  	case GREP_SOURCE_FILE:
