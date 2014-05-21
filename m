From: Jeff King <peff@peff.net>
Subject: Re: Slight inconsistency between ref delete commands.
Date: Wed, 21 May 2014 12:49:41 -0400
Message-ID: <20140521164941.GB2040@sigill.intra.peff.net>
References: <871tvn5shp.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed May 21 18:49:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9i8-0002oj-1I
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 18:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaEUQto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 12:49:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:56610 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbaEUQtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 12:49:43 -0400
Received: (qmail 20528 invoked by uid 102); 21 May 2014 16:49:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 11:49:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 12:49:41 -0400
Content-Disposition: inline
In-Reply-To: <871tvn5shp.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249805>

On Wed, May 21, 2014 at 02:35:46PM +0400, Sergei Organov wrote:

> Was writing conversion script from CVS to git for my repo and noticed
> slight inconsistency in git-tag, git-branch, and git-update-ref behavior:
> 
> $ git --version
> git version 1.9.3
> $ git tag -d && echo success
> success

This makes sense to me. "tag -d" takes zero or more tags and deletes
them.

> $ git branch -d && echo success
> fatal: branch name required

Here I think "branch -d" is being overly picky. It should behave the
same as tag. I'd welcome a patch for that.

> $ git update-ref -d && echo success

Here we cannot do the same "zero or more" behavior, because of:

> usage: git update-ref [options] -d <refname> [<oldval>]

...we need to be able to take an optional "<oldval>" for each argument.

> Noticed when used xargs without -r switch, like this:
> 
> git for-each-ref --format="%(refname)" "refs/tags/*-merge" | xargs -n 1 git update-ref -d

I know this is a side note to the inconsistency you found, but it would
be nice to be able to do that with a single update-ref invocation. Not
only for simplicity, but also because it would be more efficient
(deleting a packed ref has to rewrite the whole packed-refs file; we can
get away with one rewrite if we know we are deleting multiple refs).

Recently-ish, update-ref learned a "--stdin" mode, which I think you
could use like:

  git for-each-ref --format='delete %(refname)' refs/tags/*-merge |
  git update-ref --stdin

-Peff
