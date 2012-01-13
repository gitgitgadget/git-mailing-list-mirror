From: Jeff King <peff@peff.net>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 20:59:20 -0500
Message-ID: <20120113015920.GB8245@sigill.intra.peff.net>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
 <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
 <20120113015117.GA8245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 02:59:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlWQR-000808-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 02:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969Ab2AMB7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 20:59:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36421
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799Ab2AMB7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 20:59:22 -0500
Received: (qmail 6011 invoked by uid 107); 13 Jan 2012 02:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 21:06:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 20:59:20 -0500
Content-Disposition: inline
In-Reply-To: <20120113015117.GA8245@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188492>

On Thu, Jan 12, 2012 at 08:51:17PM -0500, Jeff King wrote:

> > Tweak the recomputation avoidance logic, so that we do not punt on
> > computing delta against a preferred base object.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Other than that, it looks good to me.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Actually, Nicolas asked for the numbers to go into the
commit message (and gave his acked-by).  So maybe append:

The effect of this patch can be seen on two simulated
upload-pack workloads. The first is based on 44 reflog
entries from my git.git origin/master reflog, and represents
the packs that kernel.org produced to send me git updates
for the past month or two. The second workload represents
much larger fetches, going from git's v1.0.0 tag to v1.1.0,
then v1.1.0 to v1.2.0, and so on.

The table below shows the average generated pack size and
the average CPU time consumed for each dataset, both before
and after the patch:

                  dataset
            | reflog | tags
---------------------------------
     before | 53358  | 2750977
size  after | 32398  | 2668479
     change |   -39% |      -3%
---------------------------------
     before |  0.18  | 1.12
CPU   after |  0.18  | 1.15
     change |    +0% |      +3%

This patch makes a much bigger difference for packs with a
shorter slice of history (since its effect is seen at the
boundaries of the pack) though it has some benefit even for
larger packs.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
