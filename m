From: bdowning@lavos.net (Brian Downing)
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 13:39:18 -0600
Message-ID: <20071202193918.GQ6212@lavos.net>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyufF-0002va-Jj
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbXLBTjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 14:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXLBTjV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:39:21 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:57496 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbXLBTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:39:20 -0500
X-IronPort-AV: E=Sophos;i="4.23,241,1194238800"; 
   d="scan'208";a="135479516"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf04.insightbb.com with ESMTP; 02 Dec 2007 14:39:19 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAKOYUkdKhvkY/2dsb2JhbACBW49B
X-IronPort-AV: E=Sophos;i="4.23,241,1194238800"; 
   d="scan'208";a="168500452"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 02 Dec 2007 14:39:19 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 521F1309F21; Sun,  2 Dec 2007 13:39:18 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vir3hx70y.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66813>

On Sun, Dec 02, 2007 at 10:53:33AM -0800, Junio C Hamano wrote:
> Yeah, I was wondering what that commit that records the change older
> than git or myself come to life ;-)
> 
> I did rewrite the commit a few times, and it was some interaction
> between the built-in commit series, git-rebase -i and git-am, but I do
> not have the details, sorry.

It looks like the "guilty" commit that allowed this behavior was:

commit 13208572fbe8838fd8835548d7502202d1f7b21d
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Sun Nov 11 17:35:58 2007 +0000

    builtin-commit: fix --signoff

    The Signed-off-by: line contained a spurious timestamp.  The reason was
    a call to git_committer_info(1), which automatically added the
    timestamp.

    Instead, fmt_ident() was taught to interpret an empty string for the
    date (as opposed to NULL, which still triggers the default behavior)
    as "do not bother with the timestamp", and builtin-commit.c uses it.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

With the above, something like:

echo msg | GIT_AUTHOR_DATE='' git commit-tree sha1

will produce a broken commit without a timestamp, since fmt_ident is
also used for the committer and author lines.

Personally, I think if the date_str is not NULL, it should die() on
anything that can't successfully be parsed as a date, rather than simply
falling back to the current time.  But maybe that's a bit extreme.

-bcd
