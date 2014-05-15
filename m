From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/6] build argv_array into run-command
Date: Thu, 15 May 2014 09:48:42 -0700
Message-ID: <xmqqiop7gf85.fsf@gitster.dls.corp.google.com>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 15 18:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkyqx-00078P-N6
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaEOQtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:49:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63950 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbaEOQtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:49:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15A3815DDD;
	Thu, 15 May 2014 12:49:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHrImuUUwxV6P0RHv85eL9o5+zM=; b=G/XbSm
	fwLvo16+DfWErVObK1wm31KEJloJIRktg5PhdcGTJNinVegjQTLX2Fz0FCjnhj3C
	U9x6nxLPCvHuLT7Sug+jckVjF6CszGQ6V94AQ3YBPep63j8u6rMfdF/GSjK0svbb
	kWND/l4ECVoGWAlNJEJ+UvJpkbd2bI23knWcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0BuIgTqiksn5iwfzwHEONEYYNlSZn5f
	FgPKg+YgHQyKKYuzZhvBQhBcq5EbAAXMWJ9NM6KaNcYQ35kJjz2fZusbrNdIkoRP
	VC/cDBXgTJ/bwp0ZfZNzqQWte8Ah0yFg1Idc55GaxqFHwTw8ps+xk/HklsEm0vF3
	MWOzApljA9A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B24815DDB;
	Thu, 15 May 2014 12:49:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39A9515CC0;
	Thu, 15 May 2014 12:48:44 -0400 (EDT)
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 15 May 2014 04:29:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6D30706-DC50-11E3-AD30-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249113>

Jeff King <peff@peff.net> writes:

> The memory ownership of the "argv" array of a "struct child_process" can
> be tricky. The child_process does not own the memory, but it must remain
> valid until finish_command runs. That's easy for cases where we call
> start_command and finish_command in the same function: you can use a
> local array variable, or use an argv_array and cleanup afterwards.
>
> But it's easy to screw up in cases where you want to start a command in
> one function and finish it in another, either by pointing to invalid
> storage during finish_command, or by leaking dynamically allocated
> memory.
>
> This series sticks an argv_array inside the "struct child_process",
> which we clean up automatically.  Because some callers might not want to
> use it, it's optional. If you provide "argv", we use that, and
> otherwise fall back to the internal array.
>
> The first commit below does that. The second fixes an uninitialized
> memory access. 3, 4, and 5 plug memory leaks. 6 is just a cleanup for
> consistency with the changes in 4 and 5.
>
> And in 2, 3, and 5 we are introducing argv_array into new spots, which
> simplifies the code and gets rid of magic numbers.

Nicely done.
