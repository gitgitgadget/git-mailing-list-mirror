From: Jeff King <peff@peff.net>
Subject: Re: how to determine version of binary
Date: Sun, 6 May 2012 08:43:42 -0400
Message-ID: <20120506124342.GC26194@sigill.intra.peff.net>
References: <jo2jtd$m6c$1@dough.gmane.org>
 <20120505092443.GB8172@sigill.intra.peff.net>
 <4FA552C5.7090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0oZ-00058a-PF
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab2EFMnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 08:43:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59616
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab2EFMno (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:43:44 -0400
Received: (qmail 10378 invoked by uid 107); 6 May 2012 12:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 08:44:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 08:43:42 -0400
Content-Disposition: inline
In-Reply-To: <4FA552C5.7090000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197178>

On Sat, May 05, 2012 at 11:18:13AM -0500, Neal Kreitzinger wrote:

> What about this recipe:
> 
> calculate sha1 of dirty deliverable (binary, html, etc)
> 
> grep git tree objects for that sha1
> 
> somehow determine which of the tree sha1's is newest.  Not sure how
> to do that.
> 
> grep commit objects for that tree sha1
>
> now you have the last commit containing that file so now you know the
> version of that file.

Your "not sure" step would be to walk the revision graph and look for
the tree in question. So really you would just walk and grep the trees.
If you know the filename (which you do in your instance), then it's not
even that expensive:

  git rev-list HEAD |
  while read commit; do
    if test "`git rev-parse $commit:path/to/file`" = $sha1; then
      echo "found it in $commit"
      break
    fi
  done

But note that that does not tell you the revision of the whole project.
It tells you one _possible_ version, because it is one that contains
that file.  If you remove the "break" there you can get the full set of
commits. And then you cross-reference that with the set of commits in
another file.  And then another, and so on, until you eventually have
narrowed it down to a single commit.

It's kind of slow, mostly because we have to invoke rev-parse over and
over. But I don't think there is a way to print the sha1 of some path
for each revision via the regular revision walker.

You could probably do better by finding trees that contain a particular
sha1, then finding trees that contain that tree, and so forth, until you
have a set of commits that contain those trees. And then you could do
that backwards walk for all of the files in parallel (i.e., only accept
a tree if it matches all of the deliverables you have).

-Peff
