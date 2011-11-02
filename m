From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 02 Nov 2011 14:26:30 -0700
Message-ID: <7vehxqi5bt.fsf@alter.siamese.dyndns.org>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de>
 <20111102203221.GB5628@sigill.intra.peff.net>
 <20111102203543.GC5628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mika Fischer <mika.fischer@zoopnet.de>, git@vger.kernel.org,
	gitster@pobox.com, daniel@haxx.se
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLiKU-0003oX-AC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 22:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1KBV0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 17:26:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab1KBV0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 17:26:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B8395660;
	Wed,  2 Nov 2011 17:26:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jv87s38g/KUm6G3zqIwShZviNKw=; b=HBEwD+
	z8VzCgfm41zdiYz3SwwDFlO0OfeS+nBB3vIUGbbPzzmgnNxAXgeymdXnIyQxr4vP
	uuUj2uxDrKsRrBGgQZLup0F9UPvBErXsEe6So1chrjW0S+yMViFZkiCapdVRb8S+
	0suxBTxYCCft63z3FBzKCyMof2FviAp/keUs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWezeqXWDpRrJFgCr9MdpgxaPhNkN06c
	xk6TsXQ+VUuzgXSaAdwcRAFOCxPNHih2EKhCuaTojiQ7KATTax4uRXRmVaNulcTS
	qYH/HhTrvHjUpwbR8J3OPuVPZ9W4YB9f1fvLudceb/LHKvKiNCjUJzgUUjreacdY
	2WhPPF+gjOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A30565F;
	Wed,  2 Nov 2011 17:26:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCB8D565D; Wed,  2 Nov 2011
 17:26:31 -0400 (EDT)
In-Reply-To: <20111102203543.GC5628@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Nov 2011 16:35:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5562E194-0599-11E1-BBE1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184671>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 02, 2011 at 04:32:21PM -0400, Jeff King wrote:
>
>> At least that's my reading. I am working on unrelated patches that clean
>> up the handling of data_received, but if it could go away altogether,
>> that would be even simpler.
>
> That patch, btw, looks like this:
>
> -- >8 --
> Subject: [PATCH] http: remove "local" member from slot struct
>
> The curl-multi http code does something like this:
>
>   while (!finished) {
> 	  try_to_read_from_slots();
> 	  if (!data_received)
> 		  wait_for_50_ms();
>   }
>
> ...
> Let's do the same thing for the write-to-file case as we do
> for the write-to-strbuf case: use a thin wrapper callback
> and increment the received flag. This makes both methods
> consistent with each other, and saves us from managing the
> "local" struct member at all, reducing the code size.

Looks very sensible.
