From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Tue, 24 Sep 2013 02:57:51 -0400
Message-ID: <20130924065751.GD5875@sigill.intra.peff.net>
References: <99F7DE7C-A8D7-4EDF-B9C5-8DB143BFDB53@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: phil.hord@gmail.com, "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:58:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMZL-0000ER-Hr
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab3IXG5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:57:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:53720 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3IXG5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:57:55 -0400
Received: (qmail 5121 invoked by uid 102); 24 Sep 2013 06:57:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 01:57:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 02:57:51 -0400
Content-Disposition: inline
In-Reply-To: <99F7DE7C-A8D7-4EDF-B9C5-8DB143BFDB53@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235278>

On Sun, Sep 22, 2013 at 12:15:21PM -0700, Jonathon Mah wrote:

> A few days ago I came across the same "surprising" output of git-grep,
> tried to adjust the code to print "git show"-able object names, and
> ran into similar subtleties. I just found this thread, and Jeff's code
> handles more cases than mine did (I didn't try Phil's initial patch),
> but I can add some more test cases with non-showable output (again
> related to git-grep's path scoping):
> 

If you haven't read the side thread starting at [1], there are some
arguments that git-grep is doing the right thing already.  I think there
are a few issues at play here:

> $ git grep -l cache HEAD:./ | head -1
> HEAD:./:.gitignore

As you show, using a colon separator from a tree-ish that contains a
partial path looks bad.  The downside of turning this into a slash,
though, is that you lose the information of the tree-ish. See [2].

> $ cd Documentation
> $ git grep -l cache HEAD | head -1
> HEAD:CodingGuidelines

Grepping from a subdirectory produces relative paths that look like real
tree:path specifications, but aren't. Showing the full path would
potentially be cluttering if you are in a deep directory.  These days we
have the "./" syntax, though, so we could perhaps output:

  HEAD:./CodingGuidelines

which is succinct but can be used to access the path in the tree (and
makes more clear to the user that we have only grepped in the current
subdirectory).

> $ git grep -l cache HEAD:Documentation/CodingGuidelines
> ../HEAD:Documentation/CodingGuidelines
> (woah!)

That one just seems nonsensical and buggy to me. We should not be
applying ".." at all to a blob spec like this.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/232892/focus=232980

[2] http://thread.gmane.org/gmane.comp.version-control.git/232892/focus=233004
