From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] interpret_branch_name bug potpourri
Date: Wed, 15 Jan 2014 03:25:28 -0500
Message-ID: <20140115082528.GA18974@sigill.intra.peff.net>
References: <52D5C296.7050906@lge.com>
 <xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
 <20140115050003.GA27237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:25:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Ln4-0006xD-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbaAOIZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:25:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:60903 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbaAOIZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:25:30 -0500
Received: (qmail 8746 invoked by uid 102); 15 Jan 2014 08:25:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:25:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:25:28 -0500
Content-Disposition: inline
In-Reply-To: <20140115050003.GA27237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240437>

On Wed, Jan 15, 2014 at 12:00:03AM -0500, Jeff King wrote:

>   $ git rev-parse --symbolic-full-name HEAD@{u}
>   refs/remotes/origin/master
>   $ git rev-parse --symbolic-full-name @mybranch@{u}
>   @mybranch@{u}
>   fatal: ambiguous argument '@mybranch@{u}': unknown revision or path
>   not in the working tree.
> 
> So I do think there is a bug. The interpret_branch_name parser somehow
> gets confused by the "@" in the name.

The "somehow" is because we only look for the first "@", and never
consider any possible marks after that. The series below fixes it, along
with two other bugs I found while looking at this code. Ugh. Remind me
never to look at our object name parser ever again.

I feel pretty good that this is fixing real bugs and not regressing
anything else. I would not be surprised if there are other weird things
lurking, though. See the discussion in patch 4.

  [1/5]: interpret_branch_name: factor out upstream handling
  [2/5]: interpret_branch_name: rename "cp" variable to "at"
  [3/5]: interpret_branch_name: always respect "namelen" parameter
  [4/5]: interpret_branch_name: avoid @{upstream} past colon
  [5/5]: interpret_branch_name: find all possible @-marks

-Peff
