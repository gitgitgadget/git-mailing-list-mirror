From: Jeff King <peff@peff.net>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 06:35:16 -0500
Message-ID: <20080211113516.GB6344@coredump.intra.peff.net>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de> <20080211074817.GA18898@sigill.intra.peff.net> <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com> <20080211110816.GA6344@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWx2-0002Gk-Jd
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYBKLfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 06:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYBKLfV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:35:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3716 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbYBKLfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:35:20 -0500
Received: (qmail 8578 invoked by uid 111); 11 Feb 2008 11:35:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 11 Feb 2008 06:35:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 06:35:16 -0500
Content-Disposition: inline
In-Reply-To: <20080211110816.GA6344@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73519>

On Mon, Feb 11, 2008 at 06:08:16AM -0500, Jeff King wrote:

> The mega-commit I was playing with that caused Linus to suggest
> diff.renamelimit in the first place is 374 by 641 (src by dest) and
> completes in ~15 minutes. The case recently reported in "git-revert is a
> memory hog" is 3541 by 8043, and doesn't complete ever.  We limit to 100
> by 100 by default.

I tried putting together a simple test script to see how much processing
time was taken. It basically does rename detection on an NxN matrix.
Each file is about 21K (the average size of a file in the linux-2.6
repository).

The results are what you would expect from an O(n^2) algorithm:

   N   CPU seconds
  10          0.43
 100          0.44
 200          1.40
 400          4.87
 800         18.08
1000         27.82

So for average repositories, we could probably bump the default rename
limit by a factor of 10 for merges (though I think I would keep it under
400 or so for "git log"). Note that this conflicts with the
"mega-commit" I mentioned above; that repository has a much larger
average file size (around 1M). But I think it makes sense to set the
default based on more common repositories.

An alternative would be to set an alarm and just give up on rename
detection after N seconds (which is really what the user wants anyway).

My test script is below (it references the file 'sample', which is
actually a copy of arch/m68/Kconfig, which just happens to have a
size close to the repository mean).

-Peff

-- >8 --
#!/bin/sh

n=$1; shift

rm -rf repo
mkdir repo && cd repo
git init

mkdata() {
  mkdir $1
  for i in `seq 1 $2`; do
    (sed "s/^/$i /" <../sample
     echo tag: $1
    ) >$1/$i
  done
}

mkdata initial $n
git add .
git commit -m initial

mkdata new $n
git add .
rm -rf initial
git commit -a -m new

time git-diff-tree -M -l0 --summary HEAD^ HEAD
