From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 23:19:37 -0800
Message-ID: <7vmx9sysqe.fsf@alter.siamese.dyndns.org>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
 <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
 <20120113015117.GA8245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 08:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbQP-0006zh-GF
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab2AMHTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 02:19:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2AMHTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:19:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF0776EC;
	Fri, 13 Jan 2012 02:19:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KwWKBlcr6JxpBiLZEHcbtajs4lE=; b=kHxzwc
	8EpHTbhhgHkjDj4z85s5pE9w9+h1sSomO/NPg0NiAmw13siKsadLzVhf6y6N3S8s
	pds1g0dY5gov8MhmsFx4pv4WHR0uaJFzkC/u3jUMEYdeUcaVwWVbQbMXeiihTkYB
	oBRdmoSrq7pfrVsr2RRg/ZP+vxWf7sjpbQFCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugYph56HSjVJUvyulCjthYLv4HEvHB8z
	levcfLR0Bpt1bCC6Hlptugs+cQkSer8aAKjLgMjKV6tLStzqBQBYeP/XT/xy+anO
	d64Z3znXHHT0FDn5iiUOtgNyk/qQFrcbxadZakYgw10ecQbZFi9F2X7gqcDmcDpD
	NzwVtTWwnpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2D6776EB;
	Fri, 13 Jan 2012 02:19:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79C8976EA; Fri, 13 Jan 2012
 02:19:38 -0500 (EST)
In-Reply-To: <20120113015117.GA8245@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Jan 2012 20:51:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F404572E-3DB6-11E1-AA42-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188496>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 12, 2012 at 05:31:42PM -0800, Junio C Hamano wrote:
>
>> From: Jeff King <peff@peff.net>
>> Subject: [PATCH] thin-pack: try harder to create delta against preferred base
>
> I just sat down to write a nicer commit message, and behold, it was done
> for me. Thanks.

Thank _you_ for a quick response and correction.

I wanted to make sure I understood the root cause of the issue and the
approach the patch takes to address it, instead of committing something
that smelled correct. And the only way I know to do so is to write it
down.

Especiallly, before coming up with the description, I was wondering if
this kind of symptom appears in non-thin cases, but after writing down the
justification for this patch, it became clear that we wouldn't have to
worry too much about that case. In a non-thin pack, we need to record one
object at least in a delta family in inflated base form, so we may as well
send that one near the tip that is already in that form for that, letting
the existing "avoid futile delta" heuristics to kick in. Other objects in
the same delta family will delta against it.
