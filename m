From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Wed, 26 Dec 2012 21:08:19 -0800
Message-ID: <7va9t0m69o.fsf@alter.siamese.dyndns.org>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
 <1356528674-2730-1-git-send-email-apelisse@gmail.com>
 <7vip7omd8c.fsf@alter.siamese.dyndns.org>
 <20121227034859.GA20817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 06:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To5lj-0006AR-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 06:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2L0FI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 00:08:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab2L0FI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 00:08:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2BDA854;
	Thu, 27 Dec 2012 00:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qpLLIf4TBXA4r1Z+SiXsht+UOlc=; b=O9XlZq
	gXgEJyqh2j9P4HHbhci51gWkcO3KQKymZdhNPPn360URFB2LgTC/UFldIars/5Wj
	CelDdKu+aypkFVYOKz6mQhhUNDojAhtYh3ApRWhqyeWNLaEuHc+Ga42MxIHg/St6
	QEz23xStUxnv8wpv+exQcXots3vnHBHkXnjko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TnOll8oWisQ6zVOLc9jM/zrhP11zDRw4
	y0dHrpSdMUGJ7GPqXSK3qVGS4rZLLOB1DSQMXZru2ulq2okUQQC0B75n+sof42JM
	W9eKAxtvPothJfjl4UcCiFfxlrMBRPN8ZcCHC+MzPc7zH9Cd55gO82bWlZuFl7xn
	MWhyzecZn00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C576A853;
	Thu, 27 Dec 2012 00:08:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9686A84F; Thu, 27 Dec 2012
 00:08:23 -0500 (EST)
In-Reply-To: <20121227034859.GA20817@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 26 Dec 2012 22:48:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 708CBEB4-4FE3-11E2-892E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212191>

Jeff King <peff@peff.net> writes:

> IOW, given:
>
>   git init
>   mkdir untracked ignored
>   >untracked/file
>   >ignored/file
>   echo ignored >.git/info/exclude
>
> I would expect:
>
>   $ git status --short --ignored --untracked=normal
>   ?? untracked/
>   !! ignored/

Sensible.

>   $ git status --short --ignored --untracked=all
>   ?? untracked/file
>   !! ignored/file

Again sensible; OK, --untracked=all is what I was missing.

> I do not know if anybody cares about the distinction, but optionally we
> could give --ignored its own selector, like:
>
>   $ git status --short --ignored=all --untracked=normal
>   ?? untracked/
>   !! ignored/file
>
> where obviously it would default to "none" (whereas untracked defaults
> to "normal").

We could just say the selector for the ignored implicitly follows
what is given for --untracked, if we don't care.

> But the behavior with Antoine's patch is:
>
>   $ git status --short --ignored --untracked=normal
>   ?? untracked/
>   !! ignored
>
>   $ git status --short --ignored --untracked=all
>   ?? untracked/file
>   !! ignored
>
> which seems wrong to me for two reasons:
>
>   1. It does not recurse for ignored but untracked entries. Neither does
>      the current code, but I think it should.
>
>   2. It loses the trailing slash from the ignored directory in both
>      cases (which is printed by the current code).

Nicely analysed.  Perhaps we would want new test pieces to define
the behaviour we want to see first?
