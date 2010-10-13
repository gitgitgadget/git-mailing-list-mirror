From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: handle %x00 NUL in user format
Date: Wed, 13 Oct 2010 14:58:40 -0700
Message-ID: <7vtykpiwkv.fsf@alter.siamese.dyndns.org>
References: <20101007182542.GA20165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:59:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69Lp-0000ce-Hx
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0JMV6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:58:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0JMV6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:58:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 570AFDEAD5;
	Wed, 13 Oct 2010 17:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UFTeowm6fuPtiyNYHwdI7S9v61M=; b=p8e8e9VWgpk6zIbSgIcVEWE
	CfSJl72hJ0DxDD8gKbR5/YcWUGAMPfvN4PkWelC2A2NxrSSDgyVFyWLimQXSsqOE
	iTZUfr6R6nUAwd8sz7YmQcj8BjmJAjCVcJf0ndpdrEjhNjGqnWWQvt4SGM7MxseG
	qhiSrjzTwE6CiCPd4pVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kkr3crSUMoUmP8jVlaHU98kPrRD0SpBHQid3oM6yE/zRHg3dP
	6dZXGjIA50Ocoyoo9XccbWL9db76z+6GZU5BAEvw/fYyfGCKKFN3pgzbhRV1DFxa
	/+noy38GQEsMRxuhWI9h+JqNy8cEdzqOi52Aqnu2r4ng7P2lqNgg97Krqs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02059DEAD3;
	Wed, 13 Oct 2010 17:58:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB8FBDEAD2; Wed, 13 Oct
 2010 17:58:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E5F0E7A-D715-11DF-9639-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158986>

Jeff King <peff@peff.net> writes:

> Erik mentioned a potential problem with fwrite() and the way we handle
> ANSI emulation for Windows. I think if there is a problem, then the same
> problem exists in the --graph code, and we should do this, and then fix
> both on top.

I am quite sure that --graph codepath is used a lot less often than this
codepath, and most users do not hit the problem you are fixing---that is
why it took so long to get noticed.  I think this printf() has been there
from the beginning, even though the possibility of placing a NUL in
buf.buf may have come much later, like when %x00 was introduced).

Use of fwrite() here will affect all Windows users who use color (probably
most of them), no?  It may be a deliberate regression, but it has a real
cost associated with it; it will break more usual uses on Windows to help
an obscure use case on POSIX.

As to emulating fwrite(3) on Windows, even though there are a lot of
callers of fwrite(3) that do not want the payload colored, it is probably
sufficient to check isatty(fileno(stream)) upfront like all the other
winansi_fEMULATED() functions do, and to make ansi_emulate() call the
system fwrite(3) directly.

I'll queue this patch on a side branch and I may even feel like merging it
to 'next', but we would need to hear from Windows folks how they want to
proceed soon.
