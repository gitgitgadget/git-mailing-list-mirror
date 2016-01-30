From: Jeff King <peff@peff.net>
Subject: Re: fast-import fails in read-only tree
Date: Sat, 30 Jan 2016 00:13:40 -0500
Message-ID: <20160130051340.GA1677@sigill.intra.peff.net>
References: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20160129060802.GA23106@sigill.intra.peff.net>
 <jwv7fisxyhz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPNr6-0000AX-QI
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 06:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbcA3FNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 00:13:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:34745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbcA3FNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 00:13:43 -0500
Received: (qmail 13696 invoked by uid 102); 30 Jan 2016 05:13:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 00:13:43 -0500
Received: (qmail 6595 invoked by uid 107); 30 Jan 2016 05:14:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 00:14:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 00:13:40 -0500
Content-Disposition: inline
In-Reply-To: <jwv7fisxyhz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285100>

On Fri, Jan 29, 2016 at 09:28:44AM -0500, Stefan Monnier wrote:

> > The primary goal of fast-import is to write that packfile.  It kind of
> > sounds like you are using the wrong tool for the job.
> 
> Yes, I realize that.  But in some cases it's the best tool available.
> `fast-import' is very close to being a "generic access API" which can be
> used instead of something like libgit.  I think it'd be good to push it
> yet a bit closer.

I'm not sure I agree. Git tries to make its innards available via
flexible plumbing commands. If we're not succeeding, I think that should
be fixed, rather than trying to shoe-horn an unrelated command to do the
job, even if it would be less code.

> > Can you elaborate on what you are sending to fast-import (preferably
> > with a concrete example)?
> 
> I'm sending a stream of "progress <foo>; cat-blob <foo>", basically.
> 
> The concrete example is in [BuGit](https://gitlab.com/monnier/bugit),
> see for example https://gitlab.com/monnier/bugit/commit/3678dcb8830a9c79c6f3404d75d63e6dd07bfe4c

You can use custom cat-file formatting to output your "name" strings as
part of the same field. IOW, something like:

  git cat-file -p refs/heads/bugit-master:numbers |
  awk '{print $3 " " $4 }' |
  git cat-file --batch="%(rest)" |
  while read number; do
    read id; # assuming blob contents are single-line
    read _junk; # assumes blob ended in its own newline
    $fun "$id" "$number"
  done

That's from a fairly cursory reading of that bugit patch, though, so I
might be missing some requirement.

> Yes, I switched to using "cat-file --batch" instead, but it's less
> convenient (I can't intersperse ad-hoc info in the output, the way I can
> with "progress" in fast-import) and there are cases where the list of
> files I need to extract cannot be determined without first looking at
> some of those extracted files (I currently have been able to avoid
> this in BuGit, luckily).

I think the example above should handle the "intersperse" thing.

If you're really going to do a lot of interactive back-and-forth access
of objects, though, I think you want to set up pipes to cat-file. It's a
little tedious to allocate fifos, but something like:

  mkfifo in out
  (exec git cat-file --batch <in >out) &
  exec 8>in
  exec 9<out
  echo $sha >&8
  read mode type size <&9
  read content ;# or read $size, or read until newline
  echo $content >&8 ;# imagine content is another sha to look up
  ...read from &9, etc..

The fifos and numbered descriptors are annoying, but that's shell for
you. I suspect using "fast-import" wouldn't be much different.

One feature I do think would be useful (and almost implemented when I
added --batch-check=<format>) is a formatter for the object content,
with a pretty modifier. I.e., it would be nice to do:

  echo $some_tree |
  git cat-file --batch-check="%(objectsize:pretty) %(contents:pretty)"

to work as the rough equivalent of "git cat-file -p" (but here you could
feed multiple trees and get multiple answers).

-Peff
