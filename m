From: Jeff King <peff@peff.net>
Subject: Re: [Bug] data loss with cyclic alternates
Date: Sat, 12 Jul 2014 01:57:03 -0400
Message-ID: <20140712055703.GA9655@sigill.intra.peff.net>
References: <53BFB055.206@gmail.com>
 <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
 <1405101705.22963.27.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"dr.khong@gmail.com" <dr.khong@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 07:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5qJU-0000pl-P2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 07:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbaGLF5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 01:57:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:60645 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751211AbaGLF5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 01:57:05 -0400
Received: (qmail 25927 invoked by uid 102); 12 Jul 2014 05:57:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Jul 2014 00:57:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 01:57:03 -0400
Content-Disposition: inline
In-Reply-To: <1405101705.22963.27.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253383>

On Fri, Jul 11, 2014 at 06:01:46PM +0000, Keller, Jacob E wrote:

> > Yeah, don't do that.  A thinks "eh, the other guy must have it" and
> > B thinks the same.  In general, do not prune or gc a repository
> > other repositories borrow from, even if there is no cycle, because
> > the borrowee does not know anythning about objects that it itself no
> > longer needs but are still needed by its borrowers.
> > 
> 
> Doesn't gc get run automatically at some points? Is the automatic gc run
> setup to avoid this problem?

No, the automatic gc doesn't avoid this. It can't in the general case,
as the parent repository does not know how many or which children are
pointed to it as an alternate. And the borrowing repository does not
even need to have write permission to the parent, so it cannot write a
backpointer.

If people are using alternates, they should probably turn off gc.auto in
the borrowee (it doesn't seem unreasonable to me to do so automatically
via "clone -s" in cases where we can write to the alternates repo, and
to issue a warning otherwise).

-Peff
