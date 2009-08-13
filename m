From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 22:31:37 -0400
Message-ID: <20090813023137.GA17358@coredump.intra.peff.net>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
 <20090812075833.GF15152@coredump.intra.peff.net>
 <7vab24ve97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 04:31:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQ6X-0002Q2-L8
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 04:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZHMCbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 22:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZHMCbj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 22:31:39 -0400
Received: from peff.net ([208.65.91.99]:44068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbZHMCbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 22:31:38 -0400
Received: (qmail 14825 invoked by uid 107); 13 Aug 2009 02:31:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 Aug 2009 22:31:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:31:37 -0400
Content-Disposition: inline
In-Reply-To: <7vab24ve97.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125765>

On Wed, Aug 12, 2009 at 03:49:56PM -0700, Junio C Hamano wrote:

> When doing a "pull --rebase", we check to make sure that the index and
> working tree are clean. The index-clean check compares the index against
> HEAD. The test erroneously reports dirtiness if we don't have a HEAD yet.
> 
> In such an "unborn branch" case, by definition, a non-empty index won't
> be based on whatever we are pulling down from the remote, and will lose
> the local change.  Just check if $GIT_DIR/index exists and error out.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks sane to me, but see below.

> +		# On an unborn branch
> +		if test -f "$GIT_DIR/index"
> +		then
> +			die "updating an unborn branch with changes added to the index"
> +		fi

I had a brief moment where I thought this might not actually be
sufficient. That is, can somebody create an unborn branch in an existing
repo (e.g., because they want an alternate project root) in such a way
that they have an index, but it is empty? In which case we should be
actually checking for index emptiness instead of existence.

I.e., I have done in the past (but not frequently):

  git symbolic-ref HEAD refs/heads/to-be-born

in an existing repository to create a new root. But I don't think we
really need to worry about that case:

  1. It is somewhat crazy and rare in the first place. Even more crazy
     and rare would be to "git pull --rebase" immediately afterwards.

  2. If you _did_ have an index, either:

     2a. You want to keep it, in which case your check is sane.

     2b. You want to start fresh, in which case your next step would be
         be "rm -f .git/index".

The only way this check would not be OK is is if you did something like:

  git symbolic-ref HEAD refs/heads/new-branch
  git ls-files | xargs git rm --cached
  git pull --rebase ...

which just seems crazy.

So I think I have convinced myself that what you have is fine, but I
just wanted a sanity check.

-Peff
