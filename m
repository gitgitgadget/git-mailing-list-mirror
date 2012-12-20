From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 22:13:27 -0500
Message-ID: <20121220031327.GB9917@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlWZy-0002sj-9V
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 04:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2LTDNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 22:13:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59004 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab2LTDNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 22:13:31 -0500
Received: (qmail 6230 invoked by uid 107); 20 Dec 2012 03:14:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 22:14:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 22:13:27 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211873>

On Thu, Dec 20, 2012 at 08:28:57AM +0700, Nguyen Thai Ngoc Duy wrote:

> > So I think this is a nice, simple approach for sites that want it, and
> > noglob magic can come later (and will not be any harder to implement as
> > a result of this patch).
> 
> Any chance to make use of nd/pathspec-wildcard? It changes the same
> code path in match_one. If you base on top of nd/pathspec-wildcard,
> all you have to do is assign nowildcard_len to len (i.e. no wildcard
> part).

I'd rather keep it separate for now. One, just because they really are
independent topics, and two, because I am actually back-porting it for
GitHub (we are fairly conservative about upgrading our backend git
versions, as most of the interesting stuff happens on the client side; I
cherry-pick critical patches with no regard to the release cycle).

And the resolution is pretty trivial, too. It looks like this:

diff --cc dir.c
index 5c0e5f6,03ff36b..81cb439
--- a/dir.c
+++ b/dir.c
@@@ -1456,14 -1433,10 +1460,18 @@@ int init_pathspec(struct pathspec *path
  
  		item->match = path;
  		item->len = strlen(path);
- 		item->nowildcard_len = simple_length(path);
 -		item->use_wildcard = !limit_pathspec_to_literal() &&
 -				     !no_wildcard(path);
 -		if (item->use_wildcard)
 -			pathspec->has_wildcard = 1;
 +		item->flags = 0;
- 		if (item->nowildcard_len < item->len) {
- 			pathspec->has_wildcard = 1;
- 			if (path[item->nowildcard_len] == '*' &&
- 			    no_wildcard(path + item->nowildcard_len + 1))
- 				item->flags |= PATHSPEC_ONESTAR;
++		if (limit_pathspec_to_literal())
++			item->nowildcard_len = item->len;
++		else {
++			item->nowildcard_len = simple_length(path);
++			if (item->nowildcard_len < item->len) {
++				pathspec->has_wildcard = 1;
++				if (path[item->nowildcard_len] == '*' &&
++				    no_wildcard(path + item->nowildcard_len + 1))
++					item->flags |= PATHSPEC_ONESTAR;
++			}
 +		}
  	}
  
  	qsort(pathspec->items, pathspec->nr,

Not re-indenting the conditional would make the diff more readable, but
I think the resulting code is simpler to read if all of the wildcard
stuff is inside the "else" block.

-Peff
