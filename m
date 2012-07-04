From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Tue, 03 Jul 2012 23:31:43 -0700
Message-ID: <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
References: <20120703221900.GA28897@sigill.intra.peff.net>
 <7vipe4tqns.fsf@alter.siamese.dyndns.org>
 <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 08:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJ85-0000N5-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 08:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933375Ab2GDGbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 02:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933342Ab2GDGbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 02:31:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05EF43FA3;
	Wed,  4 Jul 2012 02:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7iqtwzKM9rDpoxH067RFmZTdQG8=; b=FNXwFy
	LITGTlmk6MpiIA7/XKR0cDYa/Tz808EunHVHCJfgt7RpS0LHrnnD0BWysuTnN+yd
	OwhChzBhhARTeOcUQKqqgYd/Vy8REtYBVQl0HmYCU5FxHT3gFLY59i5T6ukDWtk8
	pvF+EsI0/RY+Un1VgewdHVl0drm9APBNNgNgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxvSE10qMRKNAfxVoarXc00KzgYVo19C
	mN2AUNPhgFx6MT4hNhY9f0+z/dMy2awx6SRT5COv0VRbi3t5mUh0HTDQD+Fc5VBO
	R5WUmqWyrojP+ErqNM/U4iHtPagFbbuXPrXQZdP9gSb8HaESFjvnDeRC3tDjjqZ1
	1hzrQ+K8EWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF54C3FA2;
	Wed,  4 Jul 2012 02:31:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5653F3F9D; Wed,  4 Jul 2012
 02:31:45 -0400 (EDT)
In-Reply-To: <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 4 Jul 2012 12:35:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECF43B84-C5A1-11E1-8AE3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200984>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> By the way I searched the commit that introduces that check with "git
> log --follow -p builtin/index-pack.c" but I could not find it. What
> did I do wrong?

Your commit 8a2e163cc shows changes to the file at ll.535-540; these
come from 776ea370 builtin-index-pack.c ll.383-388.

  $ git show 776ea370:builtin-index-pack.c

The get_data_from_pack() function in that commit gives sufficient
buffer to output side (avail_out starts out as obj->size), and feeds
the data from the packfile in chunks.  With the arrangement this
commit makes to call git_inflate(), it should never get stuck
because it ran out of output buffer.  In each iteration of the loop,
when the function returns, status should read Z_OK and the function
should have consumed all input.

But the version that uses consume() function does not give
sufficient output buffer to ensure that the input will always be
inflated fully (avoiding to use large output buffer is the whole
point of your patch after all), so with your patch, that no longer
holds true.
