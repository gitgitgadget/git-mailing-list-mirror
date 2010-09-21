From: Jeff King <peff@peff.net>
Subject: Re: Enforcing clone/fetch to use references.
Date: Tue, 21 Sep 2010 17:31:35 -0400
Message-ID: <20100921213135.GB1255@sigill.intra.peff.net>
References: <20100921204456.GA24357@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 23:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyARI-0003sf-JP
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 23:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab0IUVbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 17:31:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364Ab0IUVbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 17:31:42 -0400
Received: (qmail 12716 invoked by uid 111); 21 Sep 2010 21:31:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 21:31:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 17:31:35 -0400
Content-Disposition: inline
In-Reply-To: <20100921204456.GA24357@huya.qualcomm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156764>

On Tue, Sep 21, 2010 at 01:44:56PM -0700, David Brown wrote:

> Suppose I want to publish some changes to a tree.  I have a server
> available where I can run a git daemon, but for one reason or another
> I want to force people to use the another git repo as a reference.
> The reason could be one of bandwidth, or someone who isn't comfortable
> making all of the other source available.  Ideally, someone who
> already has the other git repo cloned, and just adds mine as a remote
> wouldn't notice the difference.

I think the gentoo people were talking about doing something like this.
They wanted you to use some faster and/or restartable protocol to clone
initially, and so they wanted to reject initial clones. I'm not sure if
they are doing that, and how (from the thread below, I suspect they run
a patched git).

The simplest thing would be a pre-upload-pack hook. There was some
discussion of that in this thread:

  http://article.gmane.org/gmane.comp.version-control.git/137007

but there are some security implications. For a remote site, where the
user running upload-pack trusts the hook, it should be fine.

Once you have that hook, then you basically need to just check whether
they are requesting objects in your "you should have this in your
reference repository" set (probably by using merge-base to see if it is
contained in some "everything our alternate has" ref), and then just

  echo >&2 Sorry, here's how to clone properly...
  exit 1

which should go to the user over the sideband.

And that would cover both the "clone --reference" and "git remote add"
cases, as it is not looking at what the user invoked, but which objects
they're requesting.

-Peff
