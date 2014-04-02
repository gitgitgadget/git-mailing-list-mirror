From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/22] try_merge_strategy(): remove redundant lock_file allocation
Date: Wed, 02 Apr 2014 09:53:19 -0700
Message-ID: <xmqqy4znwu4g.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-3-git-send-email-mhagger@alum.mit.edu>
	<20140401195615.GB21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:38:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeSO-0000xS-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbaDBQxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 12:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbaDBQxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 12:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6076E7793B;
	Wed,  2 Apr 2014 12:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x/FpxP6rNIbgRlj+yT/L6ci4NLQ=; b=EXSIYG
	qyzQkAnu0myQfon73YzqHjuhRwQ2gBMpQOygW7JsAmO4v7fJp64l0HeDk2hxxEnL
	L73HIneoRB43WV2W1rhAo0g5ArbnIUkO4bpQnf6V3gbJ16xtldC8zwCnMMj7Bq3w
	PBlSMVpceQFGt1DQELTg/nQlkCwIbPIh4Ihh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mXiYzFp5tq/OGWoUw8qBDUtVWdvRzJcj
	p2hOs4YmKf7nKPLq0Au+snAV7CjLvKZ03FIJfue29UvV+GE7b8XcJywbEiEcVQ7O
	7GqXiVGqQ7NkMXAn+8z8h8VQhLEMBLRQbNGf5doIs3ogEBX4G+kd5sntzTcOh4Ij
	WX+zGHz4bXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501067793A;
	Wed,  2 Apr 2014 12:53:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 517BE77939;
	Wed,  2 Apr 2014 12:53:21 -0400 (EDT)
In-Reply-To: <20140401195615.GB21715@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Apr 2014 15:56:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C3A03B8-BA87-11E3-9DF9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245689>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 01, 2014 at 05:58:10PM +0200, Michael Haggerty wrote:
>
>> By the time the "if" block is entered, the lock_file instance from the
>> main function block is no longer in use, so re-use that one instead of
>> allocating a second one.
>> 
>> Note that the "lock" variable in the "if" block used to shadow the
>> "lock" variable at function scope, so the only change needed is to
>> remove the inner definition.
>
> I wonder if this would also be simpler if "lock" were simply declared as
> a static variable, and we drop the allocation entirely. I suppose that
> does create more cognitive load, though, in that it is only correct if
> the function is not recursive. On the other hand, the current code makes
> a reader unfamiliar with "struct lock" wonder if there is a free(lock)
> missing.

Another thing that makes a reader wonder if this is a valid rewrite
is if it is safe to reuse a lock_file structure, especially because
the original gives a piece of memory _cleared_ with xcalloc().  The
second invocation of hold_locked_index() is now done on a dirty
piece of memory, and the reader needs to drill down the callchain to
see if that is safe (and if not, hold_locked_index() and probably
the underlying lock_file() needs to memset() it to NULs).
