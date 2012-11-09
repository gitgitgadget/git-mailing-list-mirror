From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git commit/push can fail silently when clone omits ".git"
Date: Fri, 9 Nov 2012 19:42:27 +0100
Message-ID: <20121109184225.GA1190@book.hvoigt.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com> <20121108185643.GN15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Issues <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:51:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtg3-00064r-O3
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab2KISv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:51:26 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:44334 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KISvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:51:25 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TWtXA-0007k6-1q; Fri, 09 Nov 2012 19:42:28 +0100
Content-Disposition: inline
In-Reply-To: <20121108185643.GN15560@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209236>

Hi,

On Thu, Nov 08, 2012 at 01:56:43PM -0500, Jeff King wrote:
> Unfortunately, the patch below which does that seems to make t7407 very
> unhappy. It looks like the submodule test uses "git clone ." and
> "git-submodule add" expects the "/." to still be at the end of the
> configured URL when processing relative submodule paths. I'm not sure if
> that is important, or an unnecessary brittleness in the submodule code.
> 
> Jens, Heiko?

After some analysis it seems to me that the test deviates from the
expected behavior. For relative urls we have documented that if we have
a remote in the superproject a relative submodule path is relative to that
remotes url.

In the test super has been cloned from ".". So the tests root directory
should be the directory the submodule path is relative to. That would
be ./submodule (since submodule is also in the root directory) and not
../submodule.

Before your patch a "/." was added to the origin of super and "/." is
currently counted as a path component.

So we have another corner case here: When your superproject was cloned
from "." the urls you currently have to specify with submodule add are
wrong (one ".." to much).

Since this is a change in behaviour I would like to further think about
the implications this brings if we fix this. Not sure how many people
clone from ".". The correct behavior (as documented) is the one you
introduce with your patch. If we decide to fix this we should also correct
the path calculation in git-submodule.sh.

Cheers Heiko
