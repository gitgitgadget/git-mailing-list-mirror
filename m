From: Jeff King <peff@peff.net>
Subject: Re: Odd problems trying to build an orphaned branch
Date: Fri, 6 Nov 2015 14:00:17 -0500
Message-ID: <20151106190016.GA6830@sigill.intra.peff.net>
References: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
 <20151106001832.GB9963@sigill.intra.peff.net>
 <929fa95cedaa2d2588753864b77380e9.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: alan@clueserver.org
X-From: git-owner@vger.kernel.org Fri Nov 06 20:00:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZumFZ-00041T-IK
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 20:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbbKFTA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 14:00:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:54253 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756102AbbKFTAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 14:00:20 -0500
Received: (qmail 13155 invoked by uid 102); 6 Nov 2015 19:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Nov 2015 13:00:19 -0600
Received: (qmail 29310 invoked by uid 107); 6 Nov 2015 19:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Nov 2015 14:00:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Nov 2015 14:00:17 -0500
Content-Disposition: inline
In-Reply-To: <929fa95cedaa2d2588753864b77380e9.squirrel@clueserver.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280998>

On Fri, Nov 06, 2015 at 10:32:56AM -0800, alan@clueserver.org wrote:

> > Yes. There is no defined format for merge patches, so git-format-patch
> > cannot show them. What you're trying to do won't work.
> 
> This makes me worry about using git-format-patch. If it cannot handle
> merge commits correctly, then using it to send patches to customers is
> risky at best. (I work for a place that does not want to distribute the
> kernel, just patches on top of the kernel. The case of having a large
> number of merge commits in the tree seems to break that.)

If you do not know if the history contains merges and are blindly using
format-patch, you are right to be worried. It will not work well for
your case.

> > Was it a local clone? Depth is ignored for those (it _should_ print a
> > warning). If so, try --no-local to make it act like a "regular" clone.
> 
> I did not add any options for "local" vs "regular". What defines that?

If the clone is on the local filesystem (i.e., the source is a regular
path, not a URL or an ssh endpoint), git will optimize some of the
transfer. For example, it will hardlink objects, which makes computing a
shallow clone more expensive than simply providing all of the objects.

But it should warn in this case.

For example:

  $ git clone --depth=1 /home/peff/compile/linux clone-of-linux
  Cloning into 'clone-of-linux'...
  warning: --depth is ignored in local clones; use file:// instead.
  done.

You can disable these local optimizations by using a "file://" URL
instead of just a filename, or by using the "--no-local" flag.

> > Of course that leaves only the problem that filter-branch is
> > horrendously slow (for the kernel, most of the time goes to populating
> > the index for each commit; I think filter-branch could probably learn to
> > skip this step if there is no index or tree filter at work).
> 
> I have to only run this once, so I don't care. Running at all would be nice.

It may be sufficiently slow on the kernel that it will not count as
"running it all".  :)

The patch I posted earlier seemed to make it workable.

Yet another option (because you wanted more, right?) is to pipe
git-fast-export into git-fast-import. Something like:

  git fast-export \
    --no-data \
    --refspec refs/heads/master:refs/heads/filtered \
    v3.12-rc1..master |
  git fast-import

I don't know if there are any gotchas there, though.

-Peff
