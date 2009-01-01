From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any
	bundle
Date: Thu, 1 Jan 2009 14:21:54 -0500
Message-ID: <20090101192153.GA6536@coredump.intra.peff.net>
References: <20081219205100.GA26671@coredump.intra.peff.net> <87prj7mz50.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, gitster@pobox.com,
	mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 20:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIT8b-00064x-9n
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 20:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZAATWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZAATV7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 14:21:59 -0500
Received: from peff.net ([208.65.91.99]:1378 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZAATV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 14:21:59 -0500
Received: (qmail 21178 invoked by uid 111); 1 Jan 2009 19:21:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 01 Jan 2009 14:21:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jan 2009 14:21:54 -0500
Content-Disposition: inline
In-Reply-To: <87prj7mz50.fsf_-_@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104310>

On Thu, Jan 01, 2009 at 12:24:59PM +0800, jidanni@jidanni.org wrote:

> JK> AFAIK, there is no tool to try salvaging strings from an incomplete pack
> JK> (and you can't just run "strings" because the deltas are zlib
> JK> compressed). So if I were in the police forensics department, I think I
> JK> would read Documentation/technical/pack-format.txt and start hacking a
> JK> solution as quickly as possible.
> 
> Hogwash. Patch follows. Maybe even better methods are available.
> [...]
> +$ sed '/^PACK/,$!d' mybundle.bun > mybundle.pack
> +$ git unpack-objects < mybundle.pack
> +$ cd .git/objects
> +$ ls ??/*|tr -d /|git cat-file --batch-check
> +$ ls ??/*|tr -d /|git cat-file --batch

Sorry, no, but your method does not work in the case I described: a thin
pack with deltas. In that case, git unpack-objects cannot unpack the
object since it lacks the delta, and will skip it. For example:

  # create a bundle with a thin delta blob
  mkdir one && cd one && git init
  cp /usr/share/dict/words . && git add words && git commit -m one
  echo SECRET MESSAGE >>words && git add words && git commit -m two
  git bundle create ../mybundle.bun HEAD^..

  # now try to fetch from it
  mkdir ../two && cd ../two && git init
  git bundle unbundle ../mybundle.bun
  # produces:
  # error: Repository lacks these prerequisite commits:
  # error: b7d1a0ca98ca0e997d4222459d6fc1c9edae6a3f one

  # so try to recover
  sed '/^PACK/,$!d' ../mybundle.bun > mybundle.pack
  git unpack-objects < mybundle.pack
  # Unpacking objects: 100% (3/3), done.
  # fatal: unresolved deltas left after unpacking
  cd .git/objects
  # this will show just two objects: the commit and the tree
  ls ??/* | tr -d /
  # confirm that we don't have the blob or the string of interest
  ls ??/* | tr -d / | git cat-file --batch | grep SECRET

It is nice that unpack-objects continues at all thanks to the recent
improvements by Nicolas, so you may be able to get some of the data out.
But it just skips over any unresolvable deltas, since we can't make a
useful object from them. Maybe it would be worth adding an option to
dump the uncompressed deltas to a file or directory so you could run
"strings" on them to recover some of the data.

-Peff
