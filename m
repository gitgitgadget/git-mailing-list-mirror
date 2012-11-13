From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Tue, 13 Nov 2012 13:20:18 -0800
Message-ID: <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNuO-00024A-5P
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 22:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab2KMVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 16:20:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab2KMVUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 16:20:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14448A427;
	Tue, 13 Nov 2012 16:20:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ps8vU2f4O/4DCr41KXSWXSFRf24=; b=LaWS3CO71OnqAlHWVqTp
	Bg8IuzD33mXbb5yj68TImv/vbqRhE93L03vfrImWfStHKrLaLU1WOUCK0H0UrWUq
	6o12mHShB1il/zAuHmV/5TsT9pH3DGJwl8jYMM/EJ9wf9YrDbMljcU6MrEErRgVl
	M4z/UNhx6PlTnw8jzW3CPew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eD2OpGV/vzGt51DLNVA2Z8Ry4FKOqYarFdFGOdD2Bngd//
	AML69eYl6jQU5tHn7l6o6dkixJMzbganNuWUGlQSxOPagRDnaMMl9s/o6rpO4eSa
	wNCbkpn45v6dZRH1sOUcN4VjQpRAK3wxn1vVbYi5AXVNXvadFQQ2nAmkPs+6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40C1A426;
	Tue, 13 Nov 2012 16:20:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47F06A425; Tue, 13 Nov 2012
 16:20:20 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDAD879E-2DD7-11E2-8CF4-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209675>

Chris Rorvick <chris@rorvick.com> writes:

> Minor changes since from v2 set.  Reposting primarily because I mucked
> up the Cc: list (again) and hoping to route feedback to the appropriate
> audience.
>
> This patch set can be divided into two sets:
>
>   1. Provide useful advice for rejected tag references.
>
>      push: return reject reasons via a mask
>      push: add advice for rejected tag reference
>
>      Recommending a merge to resolve a rejected tag update seems
>      nonsensical since the tag does not come along for the ride.  These
>      patches change the advice for rejected tags to suggest using
>      "push -f".

Below, I take that you mean by "tag reference" everything under
refs/tags/ (not limited to "annotated tag objects", but also
lightweight tags).

Given that the second point below is to strongly discourage updating
of existing any tag, it might be even better to advise *not* to push
tags in the first place, instead of destructive "push -f", no?

>   2. Require force when updating tag references, even on a fast-forward.
>
>      push: flag updates
>      push: flag updates that require force
>      push: update remote tags only with force
>
>      An email thread initiated by Angelo Borsotti did not come to a
>      consensus on how push should behave with regard to tag references.

I think the original motivation of allowing fast-forward updates to
tags was for people who wanted to have "today's recommended version"
tag that can float from day to day. I tend to think that was a
misguided notion and it is better implemented with a tip of a
branch (iow, I personally am OK with the change to forbid tag
updates altogether, without --force).

>      I think a key point is that you currently cannot be sure your push
>      will not clobber a tag (lightweight or not) in the remote.

"Do not update, only add new" may be a good feature, but at the same
time I have this suspicion that its usefulness may not necessarily
be limited to refs/tags/* hierarchy.

I dunno.
