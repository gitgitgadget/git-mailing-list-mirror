From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] read-cache: free cache entry in add_to_index in case of early return
Date: Fri, 20 Mar 2015 20:31:53 -0700
Message-ID: <xmqq1tkjc9g6.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZA8o-0007JD-FG
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbbCUDb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:31:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751481AbbCUDb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:31:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B929B4280C;
	Fri, 20 Mar 2015 23:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0fgUL/kbsak3/PfjHI5hA68yGo=; b=B0Mhg5
	ZG57LGtzLe4Cm63prQkT8IeKOptAa17B8/YOTMtnVosaZQYyL3gDaryHENX8jnJB
	lRm9coGxus85s/K3x/e/zihxZwqOQhWm+8/I1Imzy0FDPBhD6syRVWBhFsFoI2Qp
	Kx5evAfQEM37dVJYSMSGpKjhpbgcxTMeCj21w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZXcq7P3nDqStw1ENMLw2tJUhRBX9dN5
	tzC9mXOV0TZ2epdcd3c91bmv4f7l2lHfaS+PwAvWECIixPTSqx0X/G/ij/1F/CeF
	qz5RiV4PWByWVk0Sk/USFI9Smiu1T8sMNBXpgafgX7gH9Ol5k7wMmW6iy/JCKxX1
	RhrDcWOF/Vs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFF994280B;
	Fri, 20 Mar 2015 23:31:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2037D4280A;
	Fri, 20 Mar 2015 23:31:55 -0400 (EDT)
In-Reply-To: <1426897692-18322-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D26FEC46-CF7A-11E4-9ECD-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266001>

Stefan Beller <sbeller@google.com> writes:

> This frees `ce` would be leaking in the error path.

At this point ce is not yet added to the index, so it is clear it is
safe to free it---otherwise we will leak it.  Good.

> Additionally a free is moved towards the return.

I am on the fence on this one between two schools and do not have a
strong preference.  One school is to free as soon as you know you do
not need it, which is a valid stance to take.  Another is, as you
did, not to care about the minimum necessary lifetime of the storage
and free them all at the end, which is also valid.  Technically, the
former could be more performant while the latter is easier on the
eyes.
