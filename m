From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fixing the git-repack replacement gap?
Date: Tue, 18 Jun 2013 10:17:24 -0700
Message-ID: <7v8v275oez.fsf@alter.siamese.dyndns.org>
References: <201306181052.50490.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <sop@google.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozXA-0004ZP-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933191Ab3FRRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:17:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab3FRRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:17:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB07C28D2C;
	Tue, 18 Jun 2013 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLCUKH/fQj7gXeETIxBduHsgMKM=; b=O4bDfz
	tSXpVluvWbHb5Jvs9w2ghWjADDLDZPgg7CoNU9TCrSPYqWZgGj2w0X+vzbvudYUT
	cdp4fq4tn+fkqQWXsUha1UvEnfcvkP2sWpj9WsQNVsCO99OoqP3Fz7Jn9LvxLdhj
	E4HYmIgDS9z238dDEe1T/2jP6O4As3KKNj07U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1GkW9v1PWgn+98p/sBN6+saIRJuOpX9
	KntTzbhc8FGsrvMLXE61n0rhVvWsfxuPNP2wRcgUSG07H954vRACL2bKrzYginE1
	2cUp7gpm7I5Z6kBIRytDFfyRafi4hQe+SE0eImxlayzb7+8rHZP2L8AA85V9ziE6
	Z1UOYPPRwZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0FA228D2B;
	Tue, 18 Jun 2013 17:17:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 122E928D28;
	Tue, 18 Jun 2013 17:17:25 +0000 (UTC)
In-Reply-To: <201306181052.50490.mfick@codeaurora.org> (Martin Fick's message
	of "Tue, 18 Jun 2013 10:52:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2637BF0-D83A-11E2-8D01-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228284>

Martin Fick <mfick@codeaurora.org> writes:

> ... So, what 
> if we could simply add a dummy object to the file to cause 
> it to deserve a name change?
>
> So the idea would be, have git-repack detect the conflict in 
> filenames and have it repack the new file with an additional 
> dummy (unused) object in it, and then deliver the new file 
> which no longer conflicts.  Would this be possible?

Sounds like a fun exercise.  I do not think it breaks anything, and
because we have the list of objects to be placed in the resulting
pack fairly early in the process, this sequence would be possible:

    (1) enumerate the objects;
    (2) compute the resulting packname;
    (3) notice it is the same as an existing one;
    (4) add another dummy object and go back to (2);
    (5) do the heavy-lifting of delitify;
    (6) write out the resulting pack.

inside pack-objects.

I do not know if the loop between (2) and (4) is the only necessary
thing to completely avoid the race you are worrying about, though.
