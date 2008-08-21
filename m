From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCHv3 1/2] Make xdi_diff_outf interface for running xdiff_outf diffs
Date: Wed, 20 Aug 2008 22:37:57 -0500
Message-ID: <20080821033756.GC31114@lavos.net>
References: <20080814053156.GE4396@lavos.net> <1218692211-26045-1-git-send-email-bdowning@lavos.net> <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 05:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW110-0003qn-Sv
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbYHUDiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbYHUDiK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:38:10 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:45226
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696AbYHUDiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 23:38:09 -0400
Received: from OMTA04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by QMTA10.westchester.pa.mail.comcast.net with comcast
	id 4fJZ1a0040ldTLk5Are15K; Thu, 21 Aug 2008 03:38:01 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA04.westchester.pa.mail.comcast.net with comcast
	id 4re01a00F4BqYqi3Qre0Tl; Thu, 21 Aug 2008 03:38:01 +0000
X-Authority-Analysis: v=1.0 c=1 a=YTq5XthBrPEA:10 a=9yyhHhZq3XEA:10
 a=szu5UreWqKJJ8qMwUbIA:9 a=QVjYIV-9i3zE-QzsRIQmwvQgOocA:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id F3376309F24; Wed, 20 Aug 2008 22:37:57 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93108>

On Wed, Aug 13, 2008 at 11:18:22PM -0700, Junio C Hamano wrote:
> Much nicer.  xdi_diff() is just a performance thing that only kicks in
> when you are running -U0 diff, so it is unsurprising that you did not see
> any test failures.

Interesting point here.  In playing with trying to cache the diff hashes
to speed up blame, I had to basically disable the xdi_diff tail trimming
when building the hash the first time, because it needed to see the
whole file.  In doing this, I discovered that just changing from
xdi_diff to xdl_diff /does/ change the blame -M -C -C --incremental
result for my test case.  (Unfortunately, my test case is proprietary
code...)

Is this expected, or some kind of serious bug with xdi_diff?

    :; diff proper-output other-output
    980c980
    < dee86dd25736e1778122cfde7d7455a3ef85e37d 173 173 2
    ---
    > dee86dd25736e1778122cfde7d7455a3ef85e37d 172 172 3
    982c982
    < dee86dd25736e1778122cfde7d7455a3ef85e37d 183 183 2
    ---
    > dee86dd25736e1778122cfde7d7455a3ef85e37d 184 184 1
    1509c1509
    < c6966941ebfaa1dc9b29489e53d6d7f41e52d357 287 384 1
    ---
    > c6966941ebfaa1dc9b29489e53d6d7f41e52d357 284 381 1
    1511c1511
    < c6966941ebfaa1dc9b29489e53d6d7f41e52d357 301 399 2
    ---
    > c6966941ebfaa1dc9b29489e53d6d7f41e52d357 286 383 2
    1513c1513
    < c6966941ebfaa1dc9b29489e53d6d7f41e52d357 304 402 1
    ---
    > c6966941ebfaa1dc9b29489e53d6d7f41e52d357 301 399 1
    1608c1608
    < ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 252 381 1
    ---
    > ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 252 385 1
    1610c1610
    < ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 255 383 1
    ---
    > ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 255 400 1
    1612c1612
    < ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 257 385 1
    ---
    > ecebfe8121dfd9c5836d47bbeb910fbb8f96f35c 257 402 1
    1945c1945
    < a325ab86914b15107bf0211550c7d0568fb0854c 138 172 1
    ---
    > a325ab86914b15107bf0211550c7d0568fb0854c 138 183 1

-bcd
