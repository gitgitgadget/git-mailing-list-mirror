From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 14:53:12 -0800
Message-ID: <7v7ihsmeg7.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
	<20080129222007.GA3985@coredump.intra.peff.net>
	<7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzL6-0005Xo-K0
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbYA2Wx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYA2Wx0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:53:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183AbYA2WxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:53:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 479493DAA;
	Tue, 29 Jan 2008 17:53:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F193DA9;
	Tue, 29 Jan 2008 17:53:19 -0500 (EST)
In-Reply-To: <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 29 Jan 2008 14:36:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72012>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Hrm, setting diff.renamelimit to 0 lets me reproduce (I thought I tried
>> it before, but clearly not...).
>
> Hmph.  But I wonder why this part does not trigger, even when
> you have renamelimit set to 0.
>
> 	/*
> 	 * This basically does a test for the rename matrix not
> 	 * growing larger than a "rename_limit" square matrix, ie:
> 	 *
> 	 *    rename_dst_nr * rename_src_nr > rename_limit * rename_limit
> 	 *
> 	 * but handles the potential overflow case specially (and we
> 	 * assume at least 32-bit integers)
> 	 */
> 	if (rename_limit <= 0 || rename_limit > 32767)
> 		rename_limit = 32767;
> 	if (rename_dst_nr > rename_limit && rename_src_nr > rename_limit)
> 		goto cleanup;
> 	if (rename_dst_nr * rename_src_nr > rename_limit * rename_limit)
> 		goto cleanup;
>
> I wonder if the second one for the overflow avoidance should be
> using || instead of &&, though.

Reverting d19fbe8a7 means coming up with a 3-way merge between
d19fbe8a7^ and master as if d19fbe8a7 is their common ancestor.

"git diff --name-status d19fbe8a7 d19fbe8a7^" shows only two
paths changed.

"git diff --name-status d19fbe8a7 master" shows 8558 new paths
and 3756 deleted paths, which makes 32m paths pairs, that is
still lower than 32767 squared.

If your int is 64-bit, struct diff_score which is 4-int is
16-byte long.  32m * 16 = 501,801,600.  That seems to match your
450MB observation well.
