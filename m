From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] remote-helper: allow fetch to discover sha1 later
Date: Thu, 13 Sep 2012 23:10:26 -0700
Message-ID: <7vmx0t6sod.fsf@alter.siamese.dyndns.org>
References: <1347531013-10371-1-git-send-email-djpohly@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Devin J. Pohly" <djpohly@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 08:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCP6s-0002lW-Np
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 08:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab2INGKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 02:10:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab2INGK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 02:10:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B53906649;
	Fri, 14 Sep 2012 02:10:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4bc3Z/Yfo4H0PAkuuZU5fcJV6w=; b=SykdGW
	iUo5xgNj9r5oYUiTAxKp1fVA4t8OlW9lUY0HkyQ1b+eQyyQWtHzXgOrWP6eVj6Yx
	YIAeCePDDlUjaVMi/7RsnEofeFBLrGqdGeQgy8q4szv+0Z9aoFiv9iBGnQJALacV
	vW/6OYEQycg+D5KE4Kf0ISDIy7Ld2M2NCxMYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7MfUjD70gbpo1UjcoVwub/4rQzeSJC0
	J29DucV3hFdPzeqF9rBTNHBhIX6dLy9Ycbw9UF5kORCMg8smnxV/epC3LVfzFz9C
	S/jbn9Ns3l+Dpy8TAJpWc1EQ5ubY4lBcww87jkV9SkfVINDC4tXRDQ2FRhUwTHPx
	J7I7BjSaxYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17E06648;
	Fri, 14 Sep 2012 02:10:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E12176647; Fri, 14 Sep 2012
 02:10:27 -0400 (EDT)
In-Reply-To: <1347531013-10371-1-git-send-email-djpohly@gmail.com> (Devin J.
 Pohly's message of "Thu, 13 Sep 2012 06:10:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E148EF72-FE32-11E1-BBE2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205457>

"Devin J. Pohly" <djpohly@gmail.com> writes:

> From: "Devin J. Pohly" <djpohly@gmail.com>
>
> Allow a fetch-style remote helper to issue the notification
>   ref <sha1> <name>
> to specify a ref's value during the fetch operation.
>
> Currently, a remote helper with the "fetch" capability cannot fetch a
> ref unless its sha1 was known when the "list" command was executed.
> This limitation is arbitrary, as the helper may eventually be able to
> determine the correct sha1 as it fetches objects.

While I am not fundamentally against supporting a remote helper that
is not capable of saying what the object names of the tip of its
histories are before doing a lot of work, I do not think it is a
good idea to allow such a helper to claim that it supports "fetch"
capability, for at least two reasons:

 * Being able to "list" is essential for "fetch" based helpers, I
   think, far from "arbitrary".  When running a "git fetch" against
   such a remote, we can first issue "list" to see what it has and
   avoid asking for the refs that point at the histories we already
   have (or the refs that are the same as the last time we fetched
   from the remote).  I do not offhand know if we do this kind of
   optimization, but if we don't, we should.

 * Existing versions of "git" that can drive remote helpers that
   claim to have "fetch" capability are not prepared to accept an
   unknown "refs" protocol message from the helper, so a helper
   written for your new semantics of "fetch" capability will not
   work with them.  The point of capability mechanism is to prevent
   such a compatibility issue from breaking the system, and this
   patch goes against that spirit.

Such a remote helper should not advertise to support "fetch"
capability, because it does not support it.  It can advertise that
it supports "something else" and it is OK to make an updated Git
that knows how to drive a remote helper that lack "fetch" but
support that "something else" work with it.
