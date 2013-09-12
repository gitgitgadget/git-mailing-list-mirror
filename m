From: Jeff King <peff@peff.net>
Subject: Re: Re-Transmission of blobs?
Date: Thu, 12 Sep 2013 15:44:53 -0400
Message-ID: <20130912194453.GD32069@sigill.intra.peff.net>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCpD-0005aY-JF
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3ILTo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:44:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:57473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756012Ab3ILTo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:44:56 -0400
Received: (qmail 6763 invoked by uid 102); 12 Sep 2013 19:44:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 14:44:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 15:44:53 -0400
Content-Disposition: inline
In-Reply-To: <20130912103531.GD14259@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234681>

On Thu, Sep 12, 2013 at 12:35:32PM +0200, Josef Wolf wrote:

> I'm not sure I understand correctly. I see that bitmaps can be used to
> implement set operations. But how comes that walking the graph requires a lot
> of CPU? Isn't it O(n)?

Yes and no. Your "n" there is the entirety of history. Whereas a simple
"git push" generally only has to look at the recent history. So even
though you are looking at each commit and tree only once, it's still a
large number of them (and each one needs to be pulled off of the disk,
decompressed, and reconstructed from deltas).

Secondly, the graph traversal ends up seeing the same sha1s over and
over again in tree entries (because most entries in the tree don't
change from commit to commit). We spend a non-trivial amount of time
looking those up in a hash table.

Just try "git rev-list --objects --all" in your favorite repository to
get a sense. It takes something like 30 seconds in the kernel repo. You
would probably not want to add 30 seconds of CPU time to a trivial push.

> Those bitmaps would be stored in the git metadata? Is it worth it? Storing a
> bitmap for every commit just to be used once-in-a-while seems to be a pretty
> big overhead to me. Not to mention the interoperability problems you mentioned
> below.

There are tricks to make them smaller (run-length compression,
bitmapping a subset of commits and traversing to the nearest one,
storing bitmaps as deltas against nearby bitmaps). And how often it is
used depends on your git workload. For a repository serving git clones
and fetches, it speeds up every operation.

Try starting a clone of:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

versus

  git://github.com/torvalds/linux.git

and see which one starts sending you data more quickly.

> Sounds like you're already almost done and don't really need help
> anymore. Just out of curiosity, I'd be interested in a pointer anyway
> ;-)

Shawn gave a talk on JGit here:

  http://www.eclipsecon.org/2013/sites/eclipsecon.org.2013/files/Scaling%20Up%20JGit%20-%20EclipseCon%202013.pdf

and the scrapped patches for git are here:

  http://article.gmane.org/gmane.comp.version-control.git/228918

-Peff
