From: Jeff King <peff@peff.net>
Subject: Re: Passing commit IDs to git-archive
Date: Mon, 12 Mar 2012 07:47:42 -0400
Message-ID: <20120312114742.GC12921@sigill.intra.peff.net>
References: <8c6d921d-9e8e-4caf-bc04-b1d2cfdd294f@mail>
 <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:47:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73jC-0000Xi-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab2CLLrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 07:47:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47623
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab2CLLrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 07:47:45 -0400
Received: (qmail 15224 invoked by uid 107); 12 Mar 2012 11:47:55 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 07:47:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 07:47:42 -0400
Content-Disposition: inline
In-Reply-To: <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192856>

On Fri, Mar 09, 2012 at 05:14:05PM -0500, Stephen Bash wrote:

> on Mac OS 10.6.8 (obviously this is local testing, the goal is to use
> ssh remotely).  After parsing the error "no such ref" I attempted the
> same operation using master as the tree-ish and archive worked as
> expected (either specifying the path separately or using the colon
> syntax to reference the tree directly).  Is there a reason git-archive
> requires a named ref rather than just a commit (or tree) ID?

Yes; generally git repositories do not allow clients to access arbitrary
sha1s. Instead, they require that the requested objects be accessible by
a ref.

git-archive was not properly enforcing this, and was changed recently to
allow only refs by name, as well as sub-trees of refs (e.g.,
HEAD:subdir/). That means we do disallow an arbitrary commit or tree
sha1, even if it is reachable from the advertised refs.

> would it be difficult to patch git-upload-archive to use the IDs?  I
> could use tags for the ref, but in my case would result in almost
> every commit being a tag which seems wasteful.

Doing it right is a bit expensive, because in the general case (somebody
requested a tree sha1), we would need to traverse every tree of every
commit to see if it is reachable.

We could potentially implement a more restricted set of rules, allowing
"<commit>:<subdir>" and checking that <commit> is reachable.  That would
disallow an arbitrary tree sha1, but I suspect it would cover the common
use case (i.e., you want to get the tree, or even a subtree, of a
particular revision).

-Peff
