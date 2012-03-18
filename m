From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 15:07:00 -0400
Message-ID: <20120318190659.GA24829@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 20:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9LRf-00010p-0Y
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 20:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab2CRTHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 15:07:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51755
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464Ab2CRTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 15:07:03 -0400
Received: (qmail 22167 invoked by uid 107); 18 Mar 2012 19:07:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Mar 2012 15:07:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2012 15:07:00 -0400
Content-Disposition: inline
In-Reply-To: <m3fwd550j3.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193390>

On Sun, Mar 18, 2012 at 09:36:24AM -0700, Jakub Narebski wrote:

> > The solution is conceptually simple: if the list of refs results in a too long 
> > command line, split the refs in batches and call fetch-pack multiple times such 
> > that each call is under the cmdline limit:
> > 
> > git fetch-pack --stateless-rpc --lock-pack ...<first batch of refs>...
> > git fetch-pack --stateless-rpc --lock-pack ...<second batch of refs>...
> > ...
> > git fetch-pack --stateless-rpc --lock-pack ...<last batch of refs>...
> 
> That, or implement --stdin / --revs in git-fetch-pach (perhaps
> following git-pack-objects that implements --revs).

I don't think that will work, as stateless-rpc fetch-pack already uses
stdin to receive the list of advertised refs from the remote. Nor would
you want to have multiple invocations of fetch-pack, since that would
mean multiple http requests and multiple pack responses (which could not
delta between themselves).

And you can't condense the list in the general case. It is the set of
refs that we actually want to fetch. We could try passing just the
original refspecs (not the expansion) and letting fetch-pack try to do
the expansion, but in the worst case, you might really just have a
gigantic list of refs.

I think the only sane solution is to write the values to a temporary
file, and do something like:

  git fetch-pack --stateless-rpc --refs-from=$tmpfile

Even if you put the tmpfile in $GIT_DIR, I don't think this should run
afoul of any read-only repositories, since by definition you are
fetching into the repository (but you could also just put it in /tmp).

-Peff
