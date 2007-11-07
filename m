From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Wed, 07 Nov 2007 12:32:40 -0800
Message-ID: <7vr6j1bxuf.fsf@gitster.siamese.dyndns.org>
References: <20071107024118.GA11043@spearce.org>
	<7vsl3iefoj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpraH-0001PH-5I
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXKGUcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbXKGUcw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:32:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57390 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbXKGUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:32:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 064322EF;
	Wed,  7 Nov 2007 15:33:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E80E932FD;
	Wed,  7 Nov 2007 15:33:08 -0500 (EST)
In-Reply-To: <7vsl3iefoj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 06 Nov 2007 22:24:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63851>

Junio C Hamano <gitster@pobox.com> writes:

> Well spotted.  It would be a good idea to commit the big comment
> from contrib/examples/git-fetch.sh to fetch_local_nocopy()
> function, which would have made us realize that the patch does
> not refrain from applying this optimization even when shallow
> is in effect.  But I think that is actually a good change.

I take this back.  This regresses badly.

Why?

Because the optimization is useless when we are trying to deepen
the shallow history.  When you are trying to deepen a shallow
history and the tips of remotes haven't moved since you fetched
from there the last time, you have everything near the tip, and
becuse your history is shallow, your ancestry chain is
cauterized to make it appear that the history is complete.  The
rev-list reachability test would not fail as we expect.

The breakage can be seen with t5500.
