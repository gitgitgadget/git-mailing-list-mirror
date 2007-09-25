From: David Kastrup <dak@gnu.org>
Subject: Re: diffcore-rename performance mode
Date: Tue, 25 Sep 2007 21:32:31 +0200
Message-ID: <86641y4k34.fsf@lola.quinscape.zz>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net> <20070925163843.GA22987@coredump.intra.peff.net> <20070925190640.GA4613@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 21:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGEs-0007nY-Jo
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbXIYThj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXIYThj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:37:39 -0400
Received: from main.gmane.org ([80.91.229.2]:49565 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757210AbXIYThi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:37:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaGAy-0003un-TO
	for git@vger.kernel.org; Tue, 25 Sep 2007 19:34:32 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:34:32 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:34:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:CdmFejLDKmZNoFKoAP9bt4yRyjg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59159>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 25, 2007 at 12:38:43PM -0400, Jeff King wrote:
>
>>[...]
>>
>> What is most confusing is why the 'somefree' case performs so badly,
>> since we should just be using the cnt_data. I'll see if gprof can shed
>
> OK, I found the problem. estimate_similarity calls
> diff_populate_filespec each time, even if we already have the cnt_data,
> which leads to recomputing the blob contents from deltas. Oops.
>
> Fixing this, the correct numbers are:
>
>                  | stock | nofree | old somefree | fixed somefree
> -----------------|-----------------------------------------------
> user time (s)    | 76.78 | 16.96  | 46.26        | 16.99
> peak memory (Kb) | 52300 | 66796  | 59156        | 57328
>
> So now we're at a 4.5x speedup for about 10% extra memory usage. Patch
> will follow.

Sounds good except when we happen to just hit the "memory working set
exceeds physical memory" sweet spot.  But the odds are much better
than for "nofree".

-- 
David Kastrup
