From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sat, 19 Jan 2013 08:50:42 -0800
Message-ID: <20130119165042.GB12307@sigill.intra.peff.net>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 17:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwbdN-0002nQ-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 17:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3ASQus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 11:50:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38118 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3ASQus (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 11:50:48 -0500
Received: (qmail 5038 invoked by uid 107); 19 Jan 2013 16:52:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Jan 2013 11:52:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Jan 2013 08:50:42 -0800
Content-Disposition: inline
In-Reply-To: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213983>

On Fri, Jan 18, 2013 at 04:37:04PM -0800, Junio C Hamano wrote:

> This is an early preview of reducing the network cost while talking
> with a repository with tons of refs, most of which are of use by
> very narrow audiences (e.g. refs under Gerrit's refs/changes/ are
> useful only for people who are interested in the changes under
> review).  As long as these narrow audiences have a way to learn the
> names of refs or objects pointed at by the refs out-of-band, it is
> not necessary to advertise these refs.
> 
> On the server end, you tell upload-pack that some refs do not have
> to be advertised with the uploadPack.hiderefs multi-valued
> configuration variable:
> 
> 	[uploadPack]
> 		hiderefs = refs/changes

Would you want to do the same thing on receive-pack? It could benefit
from the same reduction in network cost (although it tends to be invoked
less frequently than upload-pack).

At GitHub, we have a similar patch (we even call it hiderefs), but we do
it only for receive-pack. In our case, it is not about network traffic,
but rather that we provide a set of read-only refs in the refs/pull
hierarchy. These are generated upstream by the creation of pull
requests, and we reject any updates to them via the git protocol using a
pre-receive hook.

However, if a client without these refs uses "git push --mirror", it
will attempt to delete them (which will fail). Meaning that a mirror
push will always report failure, because it will always fail to push the
refs/pull deletions.

I don't know much about Gerrit's inner workings. Are refs/changes also
read-only?

-Peff
