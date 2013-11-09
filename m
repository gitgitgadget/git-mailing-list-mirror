From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: most of the time we have good leading directories
Date: Sat, 09 Nov 2013 12:09:05 -0800
Message-ID: <xmqqsiv5mj6m.fsf@gitster.dls.corp.google.com>
References: <xmqqy54zohux.fsf@gitster.dls.corp.google.com>
	<87iow1ps9t.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Nov 09 21:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfEqZ-0000tK-1l
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 21:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab3KIUJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 15:09:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750Ab3KIUJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 15:09:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF124D960;
	Sat,  9 Nov 2013 15:09:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gSAJ98hnfFMGMgtJMWqzffPUCsU=; b=X3rldi
	9Y9vheIPcoVaMhaXm5hBlV5S17M+BXeJoStRt1Icpw9rExlc+9b6yfG5nWDzJdMH
	9a5eyMPXkqpPYX/ZLReZdma5utWDZqCq3rtUB4EMgRFAYddS/sPCAaZG6o0kjuhv
	0VT76TfJleepNRm21MzrLPt5xWiKdSqoR09Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H5akBd1imL5LrueEqdHt6J2XMQrsib2S
	GYYWS2D2Vh7KLUAmHtsbXxqGuF9LfsWStILUswmDrFwxX6GzdVi+8xnLlCQA7MSO
	YIWWv0l2JoMKP/Ezmzr5I0EYd3q4wCPSYQifgWk9pevb58iV/nPug5FVzJ+jc8ok
	joFaXmVT3T0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C8E84D95F;
	Sat,  9 Nov 2013 15:09:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4E1C4D95C;
	Sat,  9 Nov 2013 15:09:08 -0500 (EST)
In-Reply-To: <87iow1ps9t.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 09 Nov 2013 15:24:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CAC7A88A-497A-11E3-A4BE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237580>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When "git checkout" wants to create a path, e.g. a/b/c/d/e, after
>> seeing if the entire thing already exists (in which case we check if
>> that is up-to-date and do not bother to check it out, or we unlink
>> and recreate it), we validate that the leading directory path is
>> without funny symlinks by seeing a/, a/b/, a/b/c/ and then a/b/c/d/
>> are all without funny symlinks, by calling has_dirs_only_path() in
>> this order.
>>
>> When we are checking out many files (imagine: initial checkout),
>> however, it is likely that an earlier checkout would have already
>> made sure that the leading directory a/b/c/d/ is in good order; by
>> first checking the whole path a/b/c/d/ first, we can often bypass
>> calls to has_dirs_only_path() for leading part.
>
> Naively one would think that this is just as much work -- to correctly
> verify that the path consist only of actual directories (not symlinks)
> we have to lstat() every component regardless.  It seems the reason this
> is an optimization is that has_dirs_only_path() caches its results, so
> that we can get 'a/b/c/d/ is okay in every component' from the cache.
>
> Is this analysis correct?  If so, can you spell that out in the commit
> message?

It was done without analysis ;-) but I think you are correct.

If you are checking out a/b/c/d/{m,a,n,y}, after you checked out
a/b/c/d/m, the has_dirs_only_path cache knows a/b/c/d/ is in good
order so when you check out a/b/c/d/{a,n,y}, we can just ask for
a/b/c/d/ and get an OK immediately.  There is no point asking from
a/, a/b/, a/b/c/ and then a/b/c/d/, in the original pessimistic
order.  A change done _right_ to properly optimize this might even
want to change the main loop that the patch bypassed.

I do not think the patch (or the "change done right" for that
matter) will make much difference on a platform with good filesystem
metadata caching. It may be very interesting to see if that simple
patch makes any difference on Windows, though. If it does, then we
may want to look into cleaning up the code further.

Thanks for a comment.
