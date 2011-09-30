From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 20:44:40 -0700
Message-ID: <7vwrcqpuc7.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
 <20110929221143.23806.25666.julian@quantumfyre.co.uk>
 <201109291913.34196.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 05:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9U1p-0003GN-Df
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 05:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab1I3Doo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 23:44:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682Ab1I3Don convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 23:44:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DDA45A07;
	Thu, 29 Sep 2011 23:44:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fgLoAiH+QG6O
	Bn1KKTV7rSj7U24=; b=nCCpgNOQCB5Ih7JgiJhHDioFyWU7eedeejH67iE3/9KA
	X0OGTqAT9JzUJtRUXBF9efuL+L7vPEpTDiD2LK3XIQ75UGiFnfE+ZVc02J7i+j0g
	jqj1XgC2w9B8sqMsFyJiCw7oHIJURkB3b6WhRWdZJSo7ggAmWt01eQgAHud1kzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w1Xo7V
	HVz661ry1AzbHg7KoySDXTziY41+fOOZYpBPNUGdsGKrgcPsTz+UA9efgCIMCvpB
	5tvhDH3BDg3g1ky5iUSokt08jkh8P1m1qej0xtQBibuxqgogyEPwWvp5lBpX9K4X
	vgcq6BjSjSYnf87URq9HWQ+WSTdVflbkRJ2b0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65A8E5A06;
	Thu, 29 Sep 2011 23:44:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE2995A05; Thu, 29 Sep 2011
 23:44:41 -0400 (EDT)
In-Reply-To: <201109291913.34196.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 29 Sep 2011 19:13:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87B79678-EB16-11E0-AAF0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182463>

Martin Fick <mfick@codeaurora.org> writes:

> This works for me, however unfortunately, I cannot find any=20
> scenarios where it improves anything over the previous fix=20
> by Ren=C3=A9.  :(

Nevertheless, I would appreciate it if you can try this _without_ Ren=C3=
=A9's
patch. This attempts to make resolve_ref() cheap for _any_ caller. Ren=C3=
=A9's
patch avoids calling it in one specific callchain.

They address different issues. Ren=C3=A9's patch is probably an indepen=
dently
good change (I haven't thought about the interactions with the topics i=
n
flight and its implications on the future direction), but would not hel=
p
other/new callers that make many calls to resolve_ref().
