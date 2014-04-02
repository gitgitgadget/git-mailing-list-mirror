From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/22] lock_file(): always add lock_file object to lock_file_list
Date: Wed, 02 Apr 2014 10:01:59 -0700
Message-ID: <xmqqppkzwtq0.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-8-git-send-email-mhagger@alum.mit.edu>
	<20140401201659.GE21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:55:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeSZ-0000xS-KR
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbaDBRCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:02:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413AbaDBRCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:02:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D54A877C28;
	Wed,  2 Apr 2014 13:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pVtCjNXntftaY51atA3d8+xbROE=; b=nMTGlG
	M8g8DbrNBN0pdgkdL0aOVA6QnyNvuASLkSuxTGBC+1/wqNltzl6Omr/3nYSr9b8x
	ai3ewytd03zppGQRU2GaSSlD8vjcL5i0e1rA4f4HQzZvTDBv2QyVatPZv8na9oLh
	DOzyIAC/61oWSxWrCnG0B/1tyx4h5PE2bKfTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vz7ZKoYGhIB0d3sisyEm0hdCcJaKghfI
	IDqPf4twHeMb2bFkKFKVcwglKCvuYKE9a9Op13FW2p3aLNzHIZLZjumHCn/+Uy1h
	Qexry+zgG4Tq6MBZjAxW0X9R/UIsEwfPITTf226rjUUX5NvY1IoowREgmXnarqJc
	v83GWrA5I0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B033C77C27;
	Wed,  2 Apr 2014 13:02:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB38877C22;
	Wed,  2 Apr 2014 13:02:04 -0400 (EDT)
In-Reply-To: <20140401201659.GE21715@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Apr 2014 16:16:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8441B4C6-BA88-11E3-8E63-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245700>

Jeff King <peff@peff.net> writes:

> So for a moment, lk->filename contains the name of the valuable file we
> are locking.  If we get a signal at that moment, do we accidentally
> delete it in remove_lock_file?
>
> I think the answer is "no", because we check lk->owner before deleting,
> which will not match our pid (it should generally be zero due to xcalloc
> or static initialization, though perhaps we should clear it here).

That "generally be zero" no longer holds since 2/22, no?

> But that makes me wonder about the case of a reused lock. It will have
> lk->owner set from a previous invocation, and would potentially suffer
> from this problem. In other words, I think the change you are
> introducing does not have the problem, but the existing code does. :-/

Yes, I tend to agree.

> I didn't reproduce it experimentally, though.  We should be able to just
>
>     lk->owner = 0;
>
> before the initial strcpy to fix it, I would think.
>
> -Peff
