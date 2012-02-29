From: Jeff King <peff@peff.net>
Subject: Re: git archive invocation using sha1 to specify commit
Date: Wed, 29 Feb 2012 03:53:06 -0500
Message-ID: <20120229085306.GD14181@sigill.intra.peff.net>
References: <CA+OUE96-mLc0RJZz0g0oBWxdZKeCMQ9xJbg6DjCacN119TFY+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Zdenek Crha <zdenek.crha@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:53:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fHe-0004Zs-UT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2B2IxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 03:53:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32839
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930Ab2B2IxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:53:09 -0500
Received: (qmail 20558 invoked by uid 107); 29 Feb 2012 08:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 03:53:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 03:53:06 -0500
Content-Disposition: inline
In-Reply-To: <CA+OUE96-mLc0RJZz0g0oBWxdZKeCMQ9xJbg6DjCacN119TFY+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191823>

On Wed, Feb 29, 2012 at 08:45:55AM +0100, Zdenek Crha wrote:

> I would like to ask a question about commit restriction added to git
> archive by commit (ee27ca4a: archive: don't let remote clients get
> unreachable commits, 2011-11-17) and following efforts to loosen them
> a bit.
> 
> In out company we are using git together with source indexing. We
> store a git command for retrieval of source code file that was used
> for building into pdb file(s). Currently, we are using an invocation
> of git archive with --remote parameter and commit sha1 to export
> exactly the source code that was used for build.
> 
> The above mentioned commit removed possibility to do that. I have read
> about efforts to loosen the restrictions,
> but I'm not sure whenever ability to export arbitrary sha1 will be
> allowed too. Can anybody clarify that for me please?

The plans for loosening are still up in the air, as we didn't have real
data on whether people were using this feature or not. I do have patches
ready that loosen the restriction based on the details of the name
lookup, which would allow things which started a traversal from a ref,
like "foo~5". But it would explicitly not allow an arbitrary sha1.

The only way to correctly handle an arbitrary sha1 is to actually do a
reachability analysis from the refs. That's what we do with upload-pack
(which handles regular fetch and clone requests). However, handling the
general case of fetching an arbitrary tree would mean we would have to
look inside every commit to see if it contains the tree. And that can
get a bit expensive. It sounds like you are just asking for a commit
sha1, so for your case we could get away with just handling sha1s of
commits, and only allowing trees that are referenced by commit (e.g.,
"HEAD~5:subdir") or have an exact ref pointing to them (e.g., like the
linux v2.6.11-tree tag).

Yet another option would be to add a config option on the server repo to
turn off this safety check for git-archive. That is simple to do, and
sounds like it would handle your use case, as you control the repo. One
downside is that it is the server admin who must turn on the config
option, whereas it is the clients of the repo who might want to make the
bare-sha1 request. In a company, the admins (usually) have to listen to
the clients, but that is not always the case.

-Peff
