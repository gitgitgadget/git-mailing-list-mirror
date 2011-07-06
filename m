From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Date: Wed, 6 Jul 2011 21:06:21 +0200
Message-ID: <20110706190621.GA3937@toss>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <20110706065452.GB927@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 21:38:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeXvJ-0000Tm-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 21:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab1GFTiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 15:38:04 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:40627 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754329Ab1GFTiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 15:38:03 -0400
X-Greylist: delayed 1896 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jul 2011 15:38:03 EDT
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id CDDADCE00A
	for <git@vger.kernel.org>; Wed,  6 Jul 2011 21:06:31 +0200 (CEST)
Received: from localhost (p5B22D353.dip.t-dialin.net [91.34.211.83])
	by bsmtp.bon.at (Postfix) with ESMTP id A2061A7EBB;
	Wed,  6 Jul 2011 21:06:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110706065452.GB927@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176727>

On Wed, Jul 06, 2011 at 02:54:52AM -0400, Jeff King wrote:
>
> From what we've seen, it seems like skewing into the past is more
> common. It seems to come from importing old commits and using their
> timestamps as the commit timestamps. It would be nice to find a more
> accurate set (I _think_ with future skew like the second example above,
> the patch below will not give wrong answers; it will just be overly
> pessimal and traverse more commits than it needs to).

Yes, and that was indeed my only concern. Since we cannot tell with
certainty if we have skew into the past or into the future, it's
not wrong to always assume skew into the past. It just does not
always produce the shortest run of skewed commits, as you said. And
if skews into the future are rare, then that should not be an
issue.

But considering the complexity behind the timestamp based approach,
which you have demonstrated in your analysis, the generation number
concept looks very attractive to me.

It even has potential for the push/pull transport protocol.
(Unreliable) commit timestamps are currently used while searching
for common commits. And there is still the problem of searching
down the wrong branch, which can be especially bad for repos with
multiple disjoint histories. For example, we shouldn't send any
HAVEs for commits with generation numbers greater than the
generation number of the wanted ref. Or smaller than half that (in
which case downloading the complete pack would probably be faster).

Thomas, IIRC you were working on this. Do you think this could
help?

Clemens
