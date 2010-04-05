From: Jeff King <peff@peff.net>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Mon, 5 Apr 2010 02:26:21 -0400
Message-ID: <20100405062621.GA30934@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 08:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyflk-0003GV-Ju
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 08:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab0DEG0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 02:26:38 -0400
Received: from peff.net ([208.65.91.99]:48564 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab0DEG0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 02:26:37 -0400
Received: (qmail 18508 invoked by uid 107); 5 Apr 2010 06:27:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Apr 2010 02:27:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Apr 2010 02:26:21 -0400
Content-Disposition: inline
In-Reply-To: <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143972>

On Sun, Apr 04, 2010 at 11:22:18AM -0700, Junio C Hamano wrote:

> Thanks for the analysis, but expire_reflog() that is run for each ref
> already does that, I think.  It first runs mark_reachable(), then walks
> each reflog entry for the ref to call expire_reflog_ent(), which in turn
> calls unreachable() that first checks if mark_reachable() has marked the
> commit, and if so we don't run in_merge_bases().

Hmm. It looks like mark_reachable() stops traversing when it hits a
commit older than expire_total. I imagine that's to avoid going all the
way to the roots. But if we hit any unreachable entry, in_merge_bases()
is going to have to go all the way to the roots, anyway.

If we just marked everything, couldn't we then trust the REACHABLE
value and not have to do the in_merge_bases double-check? It has worse
best-case cost (since we always go to the root), but better worst-case
(since we can potentially go to the roots for each unreachable reflog
entry).

For example:

> +	/*
> +	 * Unless there was a clock skew, younger ones that are
> +	 * reachable should have been marked by mark_reachable().
> +	 */
> +	if (cb->cmd->expire_total < commit->date)
> +		return 1;
> +
>  	if (in_merge_bases(commit, &cb->ref_commit, 1))
>  		return 0;

If we haven't done a "reflog expire" in a while, won't we have a bunch
of old commits that will still need double-checked, and produce the same
slow behavior? Or is that what your "clock skew" is meant to mean? That
we would have removed those old ones already assuming the commit date
and the reflog entry for them match up? That's not necessarily true if
you move to an older commit, which freshens its reflog entry compared to
the commit date.

I wonder if, in addition to your patch, we should remove the
double-check in_merge_bases and simply report those old ones as
reachable. We may be wrong, but we are erring on the side of keeping
entries, and they will eventually expire in the regular cycle (i.e., 90
days instead of 30).

All of that being said, your patch does drop Frans' case down to about
1s of CPU time, so perhaps it is not worth worrying about beyond that.

-Peff
