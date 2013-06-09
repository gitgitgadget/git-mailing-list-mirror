From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] sort-in-topological-order: use commit-queue
Date: Sun, 09 Jun 2013 16:37:27 -0700
Message-ID: <7vehcan9e0.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlpB0-0001mK-4m
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3FIXha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:37:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab3FIXh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:37:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FA12644D;
	Sun,  9 Jun 2013 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGcDMt5R9VqwFGuzvydVeUzxtu4=; b=f8yYDV
	Oy87PfEhq55CUQqvOQ19o4yBLVVtpq9kkumqQwHPF8/3zgqy3vquv33grLt29c7c
	HYTYMXt0if3I33F8ES4oek0RZjXxmYsp8dutK093n0UzVH1ZdxqeFzk4ZRNMtmG4
	Ut026AFP8Ny8tErkPWfxZM4pxWabqtcN+dOl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiYciJ0OERsxCzr2Wz2EpHziFoMJGLHn
	nYlcN0RmAx0AJNxrVgTL7yBBnodDUmdFavJWpLIRV0+keH7UOJfORjESRKHSC3/Y
	SZvOWGkJc+O4h3/e7hs3Tb3RDx4sM2f0Bss81qKFHIvalOR6tVstQN3dO2jfQ2YC
	ssFbODdPtpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9A82644A;
	Sun,  9 Jun 2013 23:37:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDC6826446;
	Sun,  9 Jun 2013 23:37:28 +0000 (UTC)
In-Reply-To: <1370820277-30158-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sun, 9 Jun 2013 16:24:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C23ACB8-D15D-11E2-8A0D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227215>

Junio C Hamano <gitster@pobox.com> writes:

> Use the commit-queue data structure to implement a priority queue
> of commits sorted by committer date, when handling --date-order.
> The commit-queue structure can also be used as a simple LIFO stack,
> which is a good match for --topo-order processing.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  commit-queue.c | 13 +++++++++++
>  commit-queue.h |  3 +++
>  commit.c       | 74 ++++++++++++++++++++++++++++++++++------------------------
>  3 files changed, 59 insertions(+), 31 deletions(-)

Peff, I think you were the one who did a priority queue previously,
primarily for performance.  The primary reason for this round was so
that I didn't have to touch the revision.c and struct commit in
order to sort by keys in commit-info-slabs and I was not aiming for
performance but a quick and rough benchmarking seems to indicate
that

 - for a small repository like git.git, there is not much difference
   in runtime;

 - but it does seem to cut down the memory pressure (less minor
   faults).

Representative runs of "rev-list --date-order v0.99..v1.8.3" on my
box with 'master' and with these patches spend 0.47user/0.04system
with 0.50elapsed (no time change), with 13450 vs 13108 minor faults
(smaller memory use).
