From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 10:41:35 -0800
Message-ID: <7vd3cpl1cw.fsf@alter.siamese.dyndns.org>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
 <20111118103355.GA4854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 19:41:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRTNf-0007Ab-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 19:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab1KRSlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 13:41:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab1KRSli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 13:41:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D133263CF;
	Fri, 18 Nov 2011 13:41:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GANEKK/AkgO7DKc60i9I1UclHFI=; b=EJZoVc
	vSuIgRPvEqkVSi63rLOeMAy+ScAFFGzOTXN4v3G73DioUOUXAYlAENL6oGdYagiT
	WiqmSkP/6wt5bd6mc0vqx03oCk+fLpOiur5OeQPol1oiMDpEr/lEYor2oC9Mk0S4
	npg+1weu7Afn+vVtSc37uTBkSDcXmFouSDYbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSGM1KTL0YgtkpdaUL1IMXNLbDc22iW7
	K3mu5E+wpCi3uVSizELqtdRi0GWzaFLtTcMSd/B7fvh1VNal+NKkUDrtEf3ifYnm
	SSJ1a1/39zXB0C0m3UF5qmEN4OWEogKk7s2fuQYgdRqfcfMtktotosBVVEuLbapi
	G9jJkT7x9t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8E2C63CE;
	Fri, 18 Nov 2011 13:41:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4535A63CD; Fri, 18 Nov 2011
 13:41:37 -0500 (EST)
In-Reply-To: <20111118103355.GA4854@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 18 Nov 2011 05:33:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2617636-1214-11E1-B389-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185672>

Jeff King <peff@peff.net> writes:

> If we are fixing a thin pack (which should be the case most of the
> time), we are rewriting the packfile anyway. Shouldn't we just omit
> the duplicate?

Excising unwanted objects from the middle of an existing packfile would
mean you would need an equivalent of memmove() in the file, which amounts
to really rewriting the packfile, but the thing is, we are _not_ rewriting
in that sense in "index-pack --fix-thin"; it only appends and adjust the
fixed-size header.
