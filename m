From: Jeff King <peff@peff.net>
Subject: Re: error: git checkout-index: unable to write file
Date: Thu, 4 Nov 2010 15:22:39 -0400
Message-ID: <20101104192238.GA2381@sigill.intra.peff.net>
References: <20101104190007.GA17101@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 20:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE5Nu-00083Y-PU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 20:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab0KDTWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 15:22:01 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41094 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab0KDTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 15:22:00 -0400
Received: (qmail 2509 invoked by uid 111); 4 Nov 2010 19:21:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 19:21:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 15:22:39 -0400
Content-Disposition: inline
In-Reply-To: <20101104190007.GA17101@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160751>

On Thu, Nov 04, 2010 at 02:00:07PM -0500, Jonathan Nieder wrote:

> Maybe we can do better?  It seems non-ideal in a few ways:
> 
>  1) it is not checkout-index but read-tree -m that prints the message

I would prefer that it print out "clone" if anything. But those "git
checkout-index" bits appear to be hard-coded in entry.c, probably from
some long-ago cut and paste. Yuck.

Probably it should just be:

   ("error: unable to write %s: %s", file, strerror(errno))

>  2) errno is forgotten

Yup, that is poor.

>  3) I would prefer if "git clone" errored out quickly for ENOSPC instead
>     of continuing to fill in the cracks with what small files it can
>     find.  Though I suppose the current behavior is better for errors
>     like EPERM and ENAMETOOLONG, so I can't complain much.

I'm not sure that the "try to get whatever files you can out" is ever
particularly useful, since the result is a broken repository. But if we
do subscribe to the theory that such a thing may be useful, I think it
can also be useful with ENOSPC. Consider a repository with a bunch of
small files and one giant file. If the giant file fails, you might want
to still be able to read the other stuff.

Again, that is assuming such a partial checkout is even useful. You can
always still pick things manually out of the index or the object db if
you really want to see them.

-Peff
