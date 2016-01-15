From: Jeff King <peff@peff.net>
Subject: Re: How do I get the contents of a directory in fast-import
Date: Fri, 15 Jan 2016 17:39:22 -0500
Message-ID: <20160115223922.GB32081@sigill.intra.peff.net>
References: <jwvio3d7152.fsf-monnier+gmane.comp.version-control.git.user@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKD1l-0003VH-OR
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 23:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcAOWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 17:39:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:54757 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751957AbcAOWjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 17:39:25 -0500
Received: (qmail 16596 invoked by uid 102); 15 Jan 2016 22:39:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 17:39:24 -0500
Received: (qmail 25130 invoked by uid 107); 15 Jan 2016 22:39:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 17:39:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 17:39:22 -0500
Content-Disposition: inline
In-Reply-To: <jwvio3d7152.fsf-monnier+gmane.comp.version-control.git.user@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284226>

On Fri, Jan 01, 2016 at 10:54:00AM -0500, Stefan Monnier wrote:

> I have a program which tries to collect info from lots of branches and
> generate some table from that data into another branch.
> 
> For performance reasons, I'd like to do that from fast-import, and as
> long as I know the name of all the files I need to consult, everything
> is fine since I can use the "ls" and "cat-blob" commands of fast-import
> to get efficiently the data I need.
> 
> But I also need to look at some files whose names I don't know beforehand
> (i.e. all the files in some directories).  If I do "cat-blob" on those
> directories I get some binary "thing" which I don't understand.
> 
> So how do I get a directory listing from fast-inmport, i.e.
> like I can get with "git cat-file -p", but without having to fork
> a separate git process?

I'm not sure I understand your use case exactly, but is the directory
listing you want part of the newly-added objects from fast-import, or
does it already exist in the branches you are collecting from?

If the latter, I wonder if a separate "cat-file --batch" process could
give you what you need (it's a separate process, but you can start a
single process and make many queries of it; I assume your desire not to
add an extra process is to avoid the overhead).

But I think it won't pretty-print trees for you; it will give you the
raw tree data (which I imagine is what you are getting from cat-blob,
too).  I'm not sure that's actually documented anywhere (it was part of
the original revisions of git, and hasn't changed since). But it is
basically:

  tree = tree_entry*
  tree_entry = mode SP path NUL sha1
  mode = ascii mode, in octal (e.g., "100644")
  path = <any byte except NUL>*
  sha1 = <any byte>{20}
  SP = ascii space (0x20)
  NUL = 0-byte

So it is pretty simple to parse.

There may be a better way to do what you want with fast-import. I'm not
familiar enough with it to say.

-Peff
