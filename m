From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 12:48:22 -0800
Message-ID: <7vmyssvn55.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Sun Dec 02 21:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyvkA-0006FF-6f
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 21:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbXLBUsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbXLBUs3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 15:48:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46290 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbXLBUs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 15:48:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D275A2EF;
	Sun,  2 Dec 2007 15:48:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D3319C22A;
	Sun,  2 Dec 2007 15:48:45 -0500 (EST)
In-Reply-To: <20071202193918.GQ6212@lavos.net> (Brian Downing's message of
	"Sun, 2 Dec 2007 13:39:18 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66816>

bdowning@lavos.net (Brian Downing) writes:

> It looks like the "guilty" commit that allowed this behavior was:
>
> commit 13208572fbe8838fd8835548d7502202d1f7b21d
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Sun Nov 11 17:35:58 2007 +0000
>
>     builtin-commit: fix --signoff
>
>     The Signed-off-by: line contained a spurious timestamp.  The reason was
>     a call to git_committer_info(1), which automatically added the
>     timestamp.
>
>     Instead, fmt_ident() was taught to interpret an empty string for the
>     date (as opposed to NULL, which still triggers the default behavior)
>     as "do not bother with the timestamp", and builtin-commit.c uses it.
>
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> With the above, something like:
>
> echo msg | GIT_AUTHOR_DATE='' git commit-tree sha1
>
> will produce a broken commit without a timestamp, since fmt_ident is
> also used for the committer and author lines.
>
> Personally, I think if the date_str is not NULL, it should die() on
> anything that can't successfully be parsed as a date, rather than simply
> falling back to the current time.  But maybe that's a bit extreme.

Yeah, that change does look like a hack now we look at it again.  It
would have been much cleaner to make the caller accept the default
behaviour of fmt_ident() and strip out the part it does not want from
the result.  That way, the damage would have been much contained.

The next issue would be to find who could pass an empty GIT_AUTHOR_DATE
without noticing...
