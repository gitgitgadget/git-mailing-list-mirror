From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 22:50:19 -0800
Message-ID: <7vejc6761g.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	<7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801221913500.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 07:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIIP3-0008VC-AC
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 07:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYAYGuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 01:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYAYGue
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 01:50:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYAYGud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 01:50:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BC87623B;
	Fri, 25 Jan 2008 01:50:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C145A623A;
	Fri, 25 Jan 2008 01:50:28 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801221913500.1741@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 22 Jan 2008 19:19:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71684>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> +static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
> +{
> +	long per_entry;
> +
> +	per_entry = sizeof(struct cache_entry) - sizeof(struct ondisk_cache_entry);
> +
> +	/*
> +	 * Alignment can cause differences. This should be "alignof", but 
> +	 * since that's a gcc'ism, just use the size of a pointer.
> +	 */
> +	per_entry += sizeof(void *);
> +	return ondisk_size + entries*per_entry;
> +}
> +

I wonder if the issue Dave Miller addressed with
69ae517541ed5ab7d4fdcd8f82a9b8bd949df347 (fast-import: fix
unalinged allocation and access) applies here.

commit 69ae517541ed5ab7d4fdcd8f82a9b8bd949df347
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Dec 14 20:39:16 2007 -0800

    fast-import: fix unalinged allocation and access
    
    The specialized pool allocator fast-import uses aligned objects on the
    size of a pointer, which was not sufficient at least on Sparc.  Instead,
    make the alignment for objects of type unitmax_t.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
